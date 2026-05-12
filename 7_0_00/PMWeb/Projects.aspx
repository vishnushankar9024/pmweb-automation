<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Projects.aspx.vb" Inherits="Website.Projects" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ProjectDetails.ascx" TagName="ProjectDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="ProjectLocations.ascx" TagName="ProjectLocations" TagPrefix="uc4" %>
<%@ Register Src="ProjectPhases.ascx" TagName="ProjectPhases" TagPrefix="uc5" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ProjectContacts.ascx" TagName="ProjectContacts" TagPrefix="uc8" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc9" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc10" %>
<%@ Register Src="WBS.ascx" TagName="WBS" TagPrefix="uc" %>
<%@ Register Src="ProjectProgramPaymentApplications.ascx" TagName="ProjectProgramPaymentApplications" TagPrefix="uc12" %>
<%@ Register Src="AssetRotator.ascx" TagName="ProjectRotator" TagPrefix="uc13" %>
<%@ Register Src="ProjectCompanies.ascx" TagName="ProjectCompanies" TagPrefix="uc14" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc15" %>
<%@ Register Src="ProjectUsers.ascx" TagName="ProjectUsers" TagPrefix="uc16" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc17" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            var Id = '<%=PM.ProjectInfo.Id%>';

            function Close() {
                __doPostBack('Enable');

            }

            function OpenGoogleProjectAddressesPicker() {
                var Id = '<%= PM.ProjectInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=PROJECT&ObjectId=" + Id + "&PickerSender=RecordAddress",
                         'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=600,top=' + top + ',left=' + left);
                }
                return false;
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                var Id = '<%= PM.ProjectInfo.Id%>';
                var HasReports = '<%= PM.ProjectInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape( PM.ProjectInfo.ProjectNumber & " - " & PM.ProjectInfo.ProjectName)%>';

                switch (Value) {

                    case 'CopyProject':
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var URL = 'CopyProjectPopup.aspx?Id=' + Id + "&RecordDescription=" + RecordDescription;

                        var wnd = window.radopen(URL);
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                            wnd.Center();
                        }
                        wnd.add_close(Close);
                        break;

                    case 'CopyWBS':
                        if (Id > 0) {
                            OpenCopyPopup();
                        }
                        break;

                    case 'LinkTasks':
                        var wnd = OpenPOPUp('LinkSchedulePopup.aspx?ProjectId=' + Id);

                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROJECT&Id=" + Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=0&EntityType=0",
                                        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;

                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROJECT&Id=" + Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=0&EntityType=0",
                                        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'New':
                        window.location = "Projects.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('PROJECT');
                        break;

                    default:

                        break;
                }
            }

            function OpenCopyPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('CopyWBSPopup.aspx?ObjectType=PROJECT');

                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(450, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(RedirectAfterClosed);
                return false;
             
            }



            function SetFocus() {

                var tree = $find("ctl00_CPH1_WBS1_rdvLocations")
                var selectedNode = tree.findNodeByValue("-1");
                if (selectedNode != null) {
                    selectedNode.scrollIntoView();
                }

            }
            function OnClientDropDownOpened() {
                var tree = $find($("[id$=rdvPBS]")[0].id);
                if (tree != null) {
                    var Node = tree.get_selectedNode();
                    if (Node != null) {
                        Node.scrollIntoView(false);
                    }
                }
            }

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
            }

            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find(treeNode.get_treeView().get_id());
                var nodes = tree.get_selectedNodes();
                if (nodes.length >= 1) {

                    for (var i = 0; i < menuItems.get_count() ; i++) {
                        var menuItem = menuItems.getItem(i);
                        switch (menuItem.get_value()) {
                            case "AddChild":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                                }
                                break;
                            case "Rename":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true' && nodes[0].get_value() > 0);
                                }
                                break;
                            case "DELETE":
                                var isProjectSelected = false;
                                var CanDelete = true;
                                for (var j = 0; j < nodes.length; j++) {
                                    if (nodes[j].get_value() == 0) {
                                        isProjectSelected = true;
                                        break;
                                    }
                                    if (nodes[j].get_attributes().getAttribute("CanDelete") == 'false') {
                                        CanDelete = false;
                                        break;
                                    }
                                }
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' && isProjectSelected == false && CanDelete == true)
                        }
                    }
                }
            }

            function OnClientNodeClicking(sender, eventArgs) {
                var tree = $find("ctl00_CPH1_WBS1_rdvLocations")

                //    var nodes = tree.get_allNodes();
                //    for (var i = 0; i < nodes.length; i++) {
                //        if (nodes[i].get_attributes().getAttribute("IsInEditMode") == "true")
                //            nodes[i].select();
                //    }

                var selectedNode = tree.findNodeByAttribute("IsInEditMode", "true");
                if (selectedNode != null) {

                    selectedNode.select();
                }
            }

            function OnClientDoubleClick(Sender, eventArgs) {

                var node = eventArgs.get_node();
                if (node.get_value() != "-1") {

                    var btnHiddenButton = $("[id$=btnRefreshDocumentGrid]");
                    var hf = $("[id$=hdnrefreshValue]")[0];
                    if (hf != null && btnHiddenButton != null) {
                        hf.value = node.get_value();
                        btnHiddenButton.click();
                    }
                }
            }

            function RefreshWBS() {
                var btnHiddenButton = $("[id$=btnRefreshWBS]");
                if (btnHiddenButton != null) {
                    btnHiddenButton.click();
                }
            }


            var EntityAccess_EntitiesId = "ctl00_CPH1_ProjectUsers1_rdvEntities";

            function EntityAccess_onUsersNodeDropping(sender, args) {
                if (droppedOnTarget(args, EntityAccess_EntitiesId)) return;
            }
            function droppedOnTarget(args, TreeId) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == TreeId) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function EntityAccess_onNodeDragging(sender, args) {
                var target = args.get_htmlElement();
                if (!target) return;
                var tree = isMouseOverTree(target, EntityAccess_EntitiesId)
                if (tree) {
                    tree.style.cursor = "hand";
                }
            }

            function isMouseOverTree(target, TreeId) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == TreeId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }

                return null;
            }

            function onNodeDropping(sender, args) {
                if (droppedOnBlank(sender, args)) return;
            }

            function droppedOnBlank(sender, args) {
                var dest = args.get_destNode();
                var target = args.get_htmlElement();
                if (!dest) {
                    return;
                }
                args.set_cancel(true);
            }

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
            }

            function onNodeDragging(sender, args) {
                var target = args.get_htmlElement();

                if (!target) return;

                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }

                var grid = isMouseOverGrid(target)
                if (grid) {
                    grid.style.cursor = "hand";
                }
            }


            function isMouseOverGrid(target) {

                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id != null && parentNode.id.indexOf($("[id$=rdgRoles]")[0].id + "_ctl00__") == 0) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }

                return null;
            }

            function droppedOnGrid(args) {
                var target = args.get_htmlElement();
                while (target) {
                    if (target.id != null && target.id.indexOf($("[id$=rdgRoles]")[0].id + "_ctl00__") == 0) {
                        args.set_htmlElement(target);
                        return;
                    }

                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function rtvUsers_onNodeDropping(sender, args) {
                if (droppedOnGrid(args)) return;
            }

            function Upload() {

                var upload = document.querySelector('.Upload');
                //upload.onclick = 'return false;'
                //upload.addEventListener('change', function (e) {
                //    if (e.target.files) {
                //        debugger;

                //        var reader = new FileReader();
                //        reader.onload = function (l) {
                //            var result = l.target.result;
                //            document.querySelector('.UploadImage').attributes.src = result;
                //        }
                //        reader.readAsDataURL(e.target.files[0]);

                //    }
                //    return false;
                //});
                upload.click();
                return false;
            }

            //$(document).ready(function () {
            //    $("#FileToUpload").change(function () {
            //        debugger;
            //        var uploadFile = $(this);
            //        //$("#txtFileName").val(uploadFile.val().replace(/^.*\\/, ""));
            //        var reader = new FileReader();
            //        reader.onloadend = function () {
            //            $("#imglogo").attr("src", reader.result);
            //        }

            //        var file = document.querySelector('input[type=file]').files[0]
            //        if (file) {
            //            reader.readAsDataURL(file);
            //        }

            //    });

            //})
            function LoadImage(FileUpload) {
                if (FileUpload.files) {
                    var btnlogo = document.querySelector(".UploadImage");
                    btnlogo.style.visibility = 'visible';
                    var btnclearimage = document.querySelector(".btnclearimage");
                    btnclearimage.style.visibility = 'visible';
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var result = e.target.result;
                        document.querySelector('.UploadImage').src = result;
                    }
                    reader.readAsDataURL(FileUpload.files[0]);

                }


                return false;
            }
            function fixSplitterSize(isRail) {
                if (mainsplitter == null) return;
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }


            }
            var mainsplitter = null;
            function onResized(sender, ags) {
                mainsplitter = $find(sender._element.id);
                var pane = mainsplitter._panes[0];
                if (getCookie('WBSStatus') === 'none') {
                    $("#ctl00_CPH1_WBS1_Splitter").addClass("removeLeft");
                    pane.set_visible(false);
                }
                else {
                    $("#ctl00_CPH1_WBS1_Splitter").removeClass("removeLeft");
                    pane.set_visible(true);
                }
            }
            function OnClientCollapsed(sender, ags) {
                var pane = mainsplitter._panes[0];
                $("#ctl00_CPH1_WBS1_Splitter").addClass("removeLeft");
                pane.set_visible(false);
                setTimeout(FloatDivs, 100);
                setCookie('WBSStatus', 'none', 60);
                ClientResized(sender, ags);
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_WBS1_Splitter").removeClass("removeLeft");
                setCookie('WBSStatus', 'inline', 60);
                var pane = mainsplitter._panes[0];
                pane.set_visible(true);
                ClientResized(sender, ags);
            }
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            }


            function OpenLinkAssetsPopup(ObjectType, Id) {
                var Id = '<%= PM.ProjectInfo.Id%>';
                var Description = '<%=JSEscape(PM.ProjectInfo.ProjectNumber & " - " & PM.ProjectInfo.ProjectName)%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkAssetsPopup.aspx?ObjectType=PROJECT&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkAssetsPopup);
                return false;
            }

            function CloseLinkAssetsPopup() {
                var btnRefreshHeader = $("[id$=btnRefreshHeader]");
                if (btnRefreshHeader) {
                    btnRefreshHeader.click();
                }
            }

            function onClientContextMenuShowingProjectUsers(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                var type = treeNode.get_attributes().getAttribute("UserSecurityType").toLowerCase();
                if (type == 'root' || type == 'sys' || type == 'prog') {
                    //sender.childNode();
                    if (type == 'root') {
                        setMenuItemsStateProjectUsers(args.get_menu(), treeNode);
                    }
                } else {
                    setMenuItemsStateProjectUsers(args.get_menu(), treeNode);
                }
            }

            function setMenuItemsStateProjectUsers(menu, treeNode) {
                var menuItems = menu.get_items()
                var tree = $find(treeNode.get_treeView().get_id());
                for (var i = 0; i < menuItems.get_count() ; i++) {
                    var menuItem = menuItems.getItem(i);
                    var UserSecurityType = treeNode.get_attributes().getAttribute("UserSecurityType").toLowerCase();
                    switch (menuItem.get_value()) {
                        case "RemoveAccess":
                            if (UserSecurityType == 'group') {
                                var group = ExistsUserSecurityType(treeNode, 'proj');
                            }
                            menuItem.set_visible(group || UserSecurityType == 'proj')
                            break;
                        case "GrantAccess":
                            if (UserSecurityType == 'group') {
                                var group = ExistsUserSecurityType(treeNode, 'user');
                            }
                            menuItem.set_visible(group || UserSecurityType == 'user')
                    }
                }

            }

            function ExistsUserSecurityType(node, type) {
                var childNodes = node.get_allNodes();
                for (var j = 0 ; j < childNodes.length; j++) {
                    var childNode = childNodes[j];
                    if (childNode.get_attributes().getAttribute("UserSecurityType").toLowerCase() == type) {
                        return true;
                    }
                }
                return false;
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
      <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
     <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProjects" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProjects" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpProjects" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />


    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=1">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlProjects" runat="server" Height="400px"
                    meta:Resourcekey="ddlProjects" Skin="Default" AllowCustomText="true"
                    EmptyMessage="Select Project..." Width="240px" AutoPostBack="False" NoWrap="true"
                    CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>


                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n"
                                    ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="CopyProject">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="CopyWBS">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <%--     <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Delete" NavigateUrl="SearchDocument.aspx?O=1" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/CopyRecord.png" CommandName="Copy"
                                        EnableDefaultButton="false" PostBack="false" Value="Copy">
                                        <Buttons>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/LinkSchedule.png" ToolTip="Link Schedule" Value="Link" CommandName="LinkTasks" SecurityButtonType="Edit" CssClass="ToolbarLinkTasks" OuterCssClass="HideOnMobileToolbar" PostBack="false"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar" ToolTip="Print" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                  <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>

                                <telerik:RadMenu runat="server" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem SecurityButtonType="Read" Text="Go To BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem SecurityButtonType="Read" Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem SecurityButtonType="Delete" Text="Link Schedule" Value="LinkTasks"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('PROJECT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('PROJECT');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit" 
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm#Projects" Value="help"></telerik:RadToolBarButton>
                        

                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1" runat="server" ScrollChildren="true" ScrollButtonsPosition="Left"
        MultiPageID="mlpProjects" Skin="Default" OnTabClick="tbsDocument_TabClick" Width="100%" CssClass="documentTabs">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <%--<telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Locations" Value="Locations" />
            <telerik:RadTab Text="Phases" Value="Phases" />
            <telerik:RadTab Text="WBS" Value="WBS" />
            <telerik:RadTab Text="Users" Value="ProjectUsers" />
            <telerik:RadTab Text="Companies" Value="Companies" />
            <telerik:RadTab Value="Contacts" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
        </Tabs>
    </telerik:RadTabStrip>

    <div id="trMplDetails" runat="server">
        <telerik:RadMultiPage ID="mlpProjects" runat="server" SelectedIndex="1" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
            <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%">
                    <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator" Style="margin: 5px"></asp:Label>
                    <div class="PMMainPage">
                        <div class="row JustifyContent R3Cols">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="btnGoToProgram" CssClass="Link" meta:Resourcekey="lblProgram" runat="server"></asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPrograms" runat="server" Height="300px" meta:Resourcekey="ddlPrograms"
                                                EmptyMessage="Select Program..." Skin="Default" AutoPostBack="true" AllowCustomText="true" Filter="Contains">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProject" meta:Resourcekey="lblProjectId" runat="server" Text="Project ID*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtProjectID" MaxLength="100" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvProjectID" meta:resourcekey="rfv_ProjectID" runat="server"
                                               ControlToValidate="txtProjectID" ValidationGroup="Save"
                                                Display="Dynamic" CssClass="Validator">
                                            </asp:RequiredFieldValidator><br />
                                            <asp:Label ID="lblProjectIdUnique" meta:Resourcekey="lblProjectIdUnique" CssClass="Validator" Visible="false" runat="server" Text="Project ID nust be unique."></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblName" meta:Resourcekey="lblName" runat="server" Text="Name*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtName" MaxLength="100" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvName" meta:resourcekey="rfv_Name" runat="server"
                                                ControlToValidate="txtName" ValidationGroup="Save"
                                                Display="Dynamic" CssClass="Validator">
                                            </asp:RequiredFieldValidator>
                                            <asp:Label ID="lblProjectNameUnique" CssClass="Validator" meta:Resourcekey="lblProjectNameUnique" Visible="false" runat="server" Text="Name nust be unique."></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="btnGoToProperty" CssClass="Link" meta:Resourcekey="lblProperty" runat="server"></asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlProperties" runat="server" Width="100%" meta:Resourcekey="ddlProperties"
                                                EmptyMessage="Select Property..." Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True"
                                                ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                            <asp:button id="btnRefreshHeader" runat="server" class="Hide"></asp:button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectStatus" meta:Resourcekey="lblProjectStatus" runat="server"
                                                Text="Project Status"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlStatuses" runat="server" meta:Resourcekey="ddlStatuses" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                EmptyMessage="Select Status..." Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectType" meta:Resourcekey="lblProjectType" runat="server" Text="Project Type"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlTypes" runat="server" meta:Resourcekey="ddlTypes" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                EmptyMessage="Select Type..." Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategory" Text="Category"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" MarkFirstMatch="True"
                                                Skin="Default" Width="100%" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStatusRevision" meta:Resourcekey="lblStatus" runat="server" Text="Status/Revision"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table id="tblStatus" runat="server" border="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" meta:Resourcekey="ddlStatus" Skin="Default">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 50px; padding-left: 8px; text-align: right">
                                                        <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRevisionDate" meta:Resourcekey="lblRevisionDate" runat="server" Text="Date"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpRevisionDate">
                                                <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)"
                                                    EnableTyping="False" DatePopupButton-Visible="false">
                                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Style="margin-top: -1px;" Skin="Default"
                                                        ReadOnly="true" runat="server">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:HyperLink runat="server" CssClass="Link" ID="hliTenantRequest" meta:Resourcekey="hliTenantRequest"
                                                                        Text="TenantRequest"></asp:HyperLink>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:TextBox runat="server" ReadOnly="true" ID="txtTenantRequest" Width="99%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="hplCurrency" Height="24px" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                                    <span class="Icon"></span>                                                              
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" Height="250px" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:Label ID="lblCurrencyError" meta:resourcekey="lblCurrencyError" CssClass="Validator" runat="server" Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPBS" meta:Resourcekey="lblPBS" runat="server" Text="PBS1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPBS" runat="server" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="False"
                                                CausesValidation="False" OnClientDropDownOpened="OnClientDropDownOpened" DropDownCssClass="ddlTreeviewTemplate">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="" />
                                                </Items>
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)">
                                                        <telerik:RadTreeView ID="rdvPBS" runat="server" Width="100%" Height="250px"
                                                            MultipleSelect="false" ShowLineImages="true" OnNodeClick="rdvPBS_NodeClick"
                                                            OnNodeDataBound="rdvPBS_NodeDataBound" OnNodeExpand="rdvPBS_NodeExpand">
                                                        </telerik:RadTreeView>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label ID="lblProgramWBS" meta:Resourcekey="lblProgramWBS" runat="server" Text="Program WBS"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgWBS">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage="Select Program WBS"
                                                NoWrap="True" AllowCustomText="true"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: px" Height="250px">
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetBudget" meta:Resourcekey="lblTargetBudget" runat="server" Text="Target Budget"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetBudget" MaxLength="15" CssClass="Double" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetRevenue" meta:Resourcekey="lblTargetRevenue" runat="server" Text="Target Revenue"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetRevenue" MaxLength="15" CssClass="Double" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetDuration" meta:Resourcekey="lblTargetDuration" runat="server" Text="Target Duration/UOM"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:TextBox ID="txtTargetDuration" CssClass="Double" runat="server" Width="99%" Style="padding-right: 3px"></asp:TextBox>
                                                    </td>
                                                    <%--  <td style="width: 10%;">
                                                                                <asp:Label ID="lblUOM" meta:Resourcekey="lblUOM" runat="server" Style="padding-left: 15%;" Text="UOM"></asp:Label>
                                                                            </td>--%>
                                                    <td style="width: 50%; padding-left: 8px;">
                                                        <telerik:RadComboBox AllowCustomText="true" ID="ddlUOM" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true"> </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetStart" meta:Resourcekey="lblTargetStart" runat="server" Text="Target Start"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpTargetStart">
                                                <telerik:RadDatePicker ID="dtpTargetStart" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)">
                                                    <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                    <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetFinish" meta:Resourcekey="lblTargetFinish" runat="server" Text="Target Finish"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpTargetFinish">
                                                <telerik:RadDatePicker ID="dtpTargetFinish" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)">
                                                    <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                    <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPercentComplete" meta:Resourcekey="lblPercentComplete" runat="server" Text="Percent Complete"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPercentComplete" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblScope" meta:Resourcekey="lblScope" runat="server" Text="Scope"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" TextMode="MultiLine" ID="txtScope" Height="82px" Style="box-sizing: border-box; width: 100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:HyperLink runat="server" CssClass="Link" ID="hliInitiativeID" meta:Resourcekey="hliInitiativeID" Text="Initiative ID"></asp:HyperLink>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ReadOnly="true" ID="txtInitiativeID"></asp:TextBox>

                                        </td>
                                        <%--   <td style="padding-left:20px;" >
                                                                    <asp:Label Visible ="false"  ID="lblAddOwner" meta:Resourcekey="lblAddOwner" runat="server" Text="Add Owner Budget to Cost"></asp:Label>                              
                        
                                                            </td>
                                                            <td style="padding-left: 5px;">
                                                            <asp:CheckBox Visible ="false" runat ="server" ID ="chkAddOwner" />
                                                            </td>--%>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAssets" runat="server" Text="Linked Assets"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedAsset" OnClientClick="return OpenLinkAssetsPopup();">
                                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div class="NoWrap">
                                                <asp:TextBox ID="txtLinkedAsset" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top;" class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server" Text="Upload Logo"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton CssClass="SearchButton" Style="cursor: pointer" runat="server" ID="btnUpload" OnClientClick="return Upload();">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>

                                            <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right;">
                                                <asp:Button ID="btnClearImage" runat="server" Style="background-color: unset !important" CssClass="btnclearimage" />
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div>
                                                <asp:Image ID="imglogo" ImageUrl="Images/Global/WhiteDot.gif" runat="server" CssClass="UploadImage" Style="height: 80px; width: 240px" />
                                            </div>
                                            <div style="display: none">
                                                <asp:FileUpload ID="FileToUpload" ClientIDMode="Static" onchange="LoadImage(this)" runat="server" Width="240px" CssClass="Upload" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-middle">
                                <fieldset id="fldsetAddress" runat="server">
                                    <legend>
                                        <asp:Label runat="server" ID="lblAddress" meta:resourcekey="lblAddress" Text="Address"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblAddress1" meta:resourcekey="lblAddress1" runat="server" Text="Address 1 "></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblAddress2" meta:resourcekey="lblAddress2" runat="server" Text="Address 2 "></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCity" meta:resourcekey="lblCity" runat="server" Text="City"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtCity" MaxLength="50" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server" Text="State"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 50%;">
                                                            <telerik:RadComboBox ID="ddlStates" runat="server" Width="100%" Skin="Default"
                                                                NoWrap="true" Height="350px" AllowCustomText="true" Filter="Contains">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td style="width: 50%; padding-left: 8px;">
                                                            <asp:TextBox ID="txtZip" MaxLength="50" Width="100%" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlCountries" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains"
                                                    runat="server" Skin="Default">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPhone" meta:resourcekey="lblPhone" runat="server" Text="Phone"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPhone" MaxLength="50" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblFax" meta:resourcekey="lblFax" runat="server" Text="Fax"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtFax" MaxLength="50" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset id="fldsetTags" runat="server">
                                    <legend>
                                        <asp:Label runat="server" ID="lblTags" meta:resourcekey="lblTags" Text="Tags"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton runat="server" ID="btnlatitude" CssClass="Link" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnlatitude" Text="Latitude"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtlatitude" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton runat="server" ID="btnLongitude" CssClass="Link" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnLongitude" Text="Longitude"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLongitude" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton runat="server" ID="btnElevation" CssClass="Link" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnElevation" Text="Elevation"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtElevation" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <div style="float: left;">
                                                    <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Geolocation"></asp:Label>
                                                </div>
                                                <div style="float: right;">
                                                    <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleProjectAddressesPicker();">
                                                                                                <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>

                                            </td>

                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset id="fldsetPersonnel" runat="server">
                                    <legend>
                                        <asp:Label runat="server" ID="lblPersonnel" meta:resourcekey="lblPersonnel" Text="Personnel"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="btnGoToClient" CssClass="Link" Text="Client" meta:Resourcekey="lblClient" runat="server"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlClients" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlClients" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="btnGoToGC" CssClass="Link" meta:Resourcekey="lblGC" Text="GC" runat="server"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlGCs" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlGCs" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="btnGoToArchitect" CssClass="Link" Text="Architecht" meta:Resourcekey="lblArchitect" runat="server"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlArchitects" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlArchitects" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblExecutive" meta:resourcekey="lblExecutive" runat="server" Text="Executive"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtExecutive" runat="server" MaxLength="100"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblManager" meta:resourcekey="lblManager" runat="server" Text="Manager"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtManager" runat="server" MaxLength="100"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblSuperintendent" meta:resourcekey="lblSuperintendent" runat="server" Text="Superintendent"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtSuperintendent" runat="server" MaxLength="100"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="btnGoToCommitmentCompany" CssClass="Link" Text="Commitment Company" meta:Resourcekey="lblCommitment" runat="server"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlCommitmentCompany" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCommitmentCompany" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="btnGoToOwner" Text="Owner" CssClass="Link" meta:Resourcekey="lblOwner" runat="server"></asp:LinkButton>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlOwner" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlOwner" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>
                            <div class="col-4 col-4-right">
                                <uc13:ProjectRotator ID="PMrot" runat="server" />
                                <uc17:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                            </div>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <%--<telerik:RadPageView ID="pvDetails" runat="server">
                                        <uc1:ProjectDetails ID="ProjectDetails" runat="server" />
                                    </telerik:RadPageView>--%>
            <telerik:RadPageView ID="pvSpec" runat="server">
                <uc7:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvLocations" runat="server">
                <uc4:ProjectLocations ID="ProjectLocations" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="PvPhases" runat="server">
                <uc5:ProjectPhases ID="ProjectPhases" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWBS" runat="server">
                <uc:WBS ID="WBS1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvProjectUsers" runat="server" Visible="False">
                <uc16:ProjectUsers ID="ProjectUsers1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvCompanies" runat="server">
                <uc14:ProjectCompanies ID="ProjectCompanies1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvContacts" runat="server">
                <uc8:ProjectContacts ID="ProjectContacts1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvChecklist" runat="server">
                <uc9:DocumentCheckList ID="DocumentCheckList1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvPayments" runat="server">
                <uc12:ProjectProgramPaymentApplications ID="ProjectProgramPaymentApplications1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvClauses" runat="server">
                <uc10:DocumentClauses ID="DocumentClauses1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotes" runat="server">
                <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvAttachments" runat="server">
                <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkflow" runat="server">
                <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                <uc15:DocumentTeam ID="DocumentTeam1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>


</asp:Content>
