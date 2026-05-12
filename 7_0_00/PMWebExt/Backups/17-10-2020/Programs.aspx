<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Programs.aspx.vb" Inherits="Website.Programs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ProgramProjects.ascx" TagName="ProgramProjects" TagPrefix="uc8" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="ProgramDetails.ascx" TagName="ProgramDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc4" %>
<%@ Register Src="ProjectProgramPaymentApplications.ascx" TagName="ProjectProgramPaymentApplications" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc6" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .upload-btn-wrapper { 
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 24px;  
            height: 24px;
            padding-right: 10px;
        }

            .upload-btn-wrapper input[type=file] {
                font-size: 100px;
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
            }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
        function treeToolbarClick(sender, args) {
            if (args.get_item().get_commandName() == 'ToggleSplitter') {
                ToggleTree(false);
            }
        }

        function ToggleTree(bool) {
            
            var pane = $find("ctl00_CPH1_ProgramProjects_rpPunchListDetails");
            if (bool)
                pane.set_visible(true);
            else
                pane.set_visible(false);
            var isRail = false;
            if ($("form.rail").length > 0)
                isRail = true;
            return false;

        }


        function OnClientCollapsed(sender, ags) {
            $("#ctl00_CPH1_ProgramProjects_Splitter").addClass("removeLeft");
            var isRail = false;
            if ($("form.rail").length > 0)
                isRail = true;
            fixSplitterSize(isRail)
        }
        function OnClientExpanded(sender, ags) {
            $("#ctl00_CPH1_ProgramProjects_Splitter").removeClass("removeLeft");
            var isRail = false;
            if ($("form.rail").length > 0)
                isRail = true;
            fixSplitterSize(isRail)
        }

        function AssetSplitterResized(sender, ags) {
            setTimeout(FloatDivs, 100);
        }

        function ClientResized(sender, ags) {
            setTimeout(FloatDivs, 100);
            var splitter = sender.get_parent();
            var pane1 = splitter._panes[0];
            var pane2 = splitter._panes[1];
            var pane1Td = pane1._element;
            pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 10);
        }
        var mainsplitter = null;
        function onResized(sender, ags) {
            //var NewWidth = sender._panes[1].get_width() - 20;
            //sender._panes[1].set_width(NewWidth);
            //return false;
            mainsplitter = sender;

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
                var NewWidth = sender.get_width() - 1
                sender.set_width(NewWidth);
                $(document).scrollLeft(1);
                if (NewWidth <= 100) break;
            }


        }

    </script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;

            function SetFocus() {

                var tree = $find("ctl00_CPH1_ProgramProjects_rdvLocations")
                var selectedNode = tree.findNodeByValue("-1");
                if (selectedNode != null) {
                    selectedNode.scrollIntoView();
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
                            case "AddProject":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAddProject").toLowerCase() == 'true' && nodes[0].get_value() > 0);
                                }
                                break;
                            case "AddChild":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' && nodes[0].get_value() != "-1");
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
                var tree = $find("ctl00_CPH1_ProgramProjects_rdvLocations")

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


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.ProgramInfo.HasReports%>';
                var HasMergeTemplate = '<%= PM.ProgramInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape( PM.ProgramInfo.ProgramNumber & " - " & PM.ProgramInfo.Name)%>';
                var Id = '<%= PM.ProgramInfo.Id%>';
                var Description = '<%=JSEscape(PM.ProgramInfo.Description)%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=PROGRAM&Id=" +
                                 Id + "&Description="
                                 + Description
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=0&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROGRAM&Id=" + Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=0&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'New':
                        window.location = "Programs.aspx";
                        break;

                    default:
                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function Upload() {

                var upload = document.querySelector('.Upload');
                upload.click();
                return false;
            }
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

        </script>
    </telerik:RadCodeBlock>
        <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
     <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpPrograms">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPrograms" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPrograms" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=148">
                                <div class="btnToolbarSearchDocument">
                                    &nbsp; 
                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                    &nbsp; 
                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlPrograms" runat="server" Height="400px" ShowMoreResultsBox="True"
                    meta:Resourcekey="ddlPrograms" Skin="Default" AllowCustomText="true" EnableLoadOnDemand="true"
                    EmptyMessage="Select Program..." Width="240px" AutoPostBack="false" NoWrap="true" EnableVirtualScrolling="True"
                    CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange" OnItemsRequested="ddl_ItemsRequested"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>


                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('PROGRAM');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>



    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpPrograms" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Projects" Value="Projects" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Payments" Value="Payments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpPrograms" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramId" meta:Resourcekey="lblProgramId" runat="server" Text="Program #*11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProgramID" MaxLength="15" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvProgramID" meta:resourcekey="rfvProgramsID" runat="server"
                                            ErrorMessage="Required" ControlToValidate="txtProgramID" ValidationGroup="Save"
                                            Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblProgramIdUnique" meta:Resourcekey="lblProgramIdUnique" CssClass="Validator"
                                            Visible="false" runat="server" Text="Program # nust be unique.">
                                        </asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" meta:Resourcekey="lblName" runat="server" Text="Name*11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtName" MaxLength="100" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" meta:resourcekey="rfvNames" runat="server"
                                            ErrorMessage="Required" ControlToValidate="txtName" ValidationGroup="Save"
                                            Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator><br />
                                        <asp:Label ID="lblProgramNameUnique" CssClass="Validator" meta:Resourcekey="lblProgramNameUnique"
                                            Visible="false" runat="server" Text="Name must be unique.">
                                        </asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server" Text="Description11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr valign="top">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblNotes" meta:Resourcekey="lblNotes" runat="server" Text="Notes11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" TextMode="MultiLine" Height="82px" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDirector" meta:Resourcekey="lblDirector" runat="server" Text="Director11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDirector" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramManager" meta:Resourcekey="lblProgramManager" runat="server" Text="Manager11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtManager" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramManager1" meta:Resourcekey="lblProgramManager1" runat="server" Text="Program Manager11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" OnItemsRequested="ddl_ItemsRequested"
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..." Height="250px"
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies" Style="font-size: 11px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramType" meta:Resourcekey="lblProgramType" runat="server" Text="Program Type11"></asp:Label>
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
                                        <asp:Label ID="lblProgramStatus" meta:Resourcekey="lblProgramStatus" runat="server" Text="Program Status11"></asp:Label>
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
                                        <asp:Label ID="lblEstimatedDuration" meta:Resourcekey="lblEstimatedDuration" runat="server" Text="Estimated Duration11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEstimatedDuration" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEstimatedCost" meta:Resourcekey="lblEstimatedCost" runat="server" Text="Estimated Cost11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEstimatedCost" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td style="vertical-align: top" class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblLogo" meta:Resourcekey="lblLogo" runat="server" Text="Upload Logo11"></asp:Label>
                                        </div>
                                        <div style="float: right;">

                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="LinkButton1" OnClientClick="return Upload()">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                        <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right">
                                            <asp:LinkButton CssClass="btnclearimage" Style="background-color: unset !important;" runat="server" ID="lblRemoveLogo">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>


                                    </td>
                                    <td class="controlWidth">
                                        <div>
                                            <asp:Image ID="imglogo" CssClass="UploadImage" runat="server" Style="height: 80px; width: 240px" />
                                        </div>
                                        <div style="display: none">
                                            <asp:FileUpload ID="FileToUpload" onchange="LoadImage(this)" runat="server" CssClass="Upload" />

                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblProject" meta:resourcekey="lblProjectDefault" runat="server" Text="Project11"></asp:Label>
                                </legend>
                                <table class="colTable">

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblClient" meta:resourcekey="lblClient" runat="server" Text="Client11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlClients" runat="server" Height="250px"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..." EnableVirtualScrolling="true"
                                                NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlClients" ShowMoreResultsBox="true"
                                                EnableLoadOnDemand="True" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblGC" meta:resourcekey="lblGC" runat="server" Text="GC11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlGCs" runat="server" Height="250px"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..." EnableLoadOnDemand="True"
                                                NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlGCs" EnableVirtualScrolling="true"
                                                ShowMoreResultsBox="true" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblArchitect" meta:resourcekey="lblArchitect" runat="server" Text="Architect11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlArchitects" runat="server" Height="250px"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..." EnableLoadOnDemand="True"
                                                NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlArchitects" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblManager" meta:resourcekey="lblManager" runat="server" Text="Manager11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtProjectManager" runat="server" MaxLength="100"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter1">
                                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="250px" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCity" meta:resourcekey="lblCity" runat="server" Text="City11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCity" MaxLength="50" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server" Text="State11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlStates" runat="server" Skin="Default"
                                                NoWrap="true" Height="350px" AllowCustomText="true" Filter="Contains">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCountries" Height="350px" AllowCustomText="true" Filter="Contains"
                                                runat="server" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectType" meta:Resourcekey="lblProjectType" runat="server" Text="Project Type11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlProjectTypes" runat="server" meta:Resourcekey="ddlTypes" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                EmptyMessage="Select Type..." Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectStatus" meta:Resourcekey="lblProjectStatus" runat="server" Text="Project Status11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlProjectStatuses" runat="server" meta:Resourcekey="ddlStatuses" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                EmptyMessage="Select Status..." Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetBudget" meta:Resourcekey="lblTargetBudget" runat="server" Text="Target Budget11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetBudget" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetRevenue" meta:Resourcekey="lblTargetRevenue" runat="server" Text="Target Revenue11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetRevenue" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetDuration" meta:Resourcekey="lblTargetDuration" runat="server" Text="Target Duration11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetDuration" CssClass="Double" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetDurationUOM" meta:Resourcekey="lblTargetDurationUOM" runat="server" Text="UOM11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlUOM" AllowCustomText="true" runat="server" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc6:AssetRotator ID="PMrot" runat="server" />
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvProjects" runat="server">
            <uc8:ProgramProjects ID="ProgramProjects" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc4:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc5:ProjectProgramPaymentApplications ID="ProjectProgramPaymentApplications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>

