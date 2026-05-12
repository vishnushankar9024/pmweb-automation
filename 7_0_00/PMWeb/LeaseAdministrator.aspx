<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="LeaseAdministrator.aspx.vb" Inherits="Website.LeaseAdministrator" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ScheduledCharges.ascx" TagName="ScheduledCharges" TagPrefix="uc1" %>
<%@ Register Src="LeaseAdministratorRecoveries.ascx" TagName="Recoveries" TagPrefix="uc2" %>
<%@ Register Src="LeaseAdministratorEscalations.ascx" TagName="Escalations" TagPrefix="uc3" %>
<%@ Register Src="LeaseAdministratorOverages.ascx" TagName="Overages" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Asset/LeaseAdmin.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function OpenRecoveryDetailPopup(Id, txtId, LeaseId) {
                var left = (screen.width - 380) / 2;
                var top = (screen.height - 425) / 2;
                var win = OpenPOPUp('RecoveryDetailsPopup.aspx?Id=' + Id + '&txtId=' + txtId + '&LeaseId=' + LeaseId, '',
                 'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=380,height=425,top=' + top + ',left=' + left);
                return false;
            }
            function OpenRecoveryDetailItemPopup(Id, RecordId, LeaseId) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();

                var wnd = window.radopen('RecoveryDetailsPopup.aspx?Id=' + Id + '&RecordId=' + RecordId + '&LeaseId=' + LeaseId);
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

            function click_handler(sender, args) {

                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {

                var HasMergeTemplate = '<%= PM.Asset.LeaseAdministratorInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Asset.LeaseAdministratorInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.LeaseAdministratorInfo.RecordNumber & " - " & PM.Asset.LeaseAdministratorInfo.Description)%>';
                var Description = '<%=JSEscape(PM.Asset.LeaseAdministratorInfo.Description)%>';
                var Id = '<%= PM.Asset.LeaseAdministratorInfo.Id%>';

                switch (Value) {

                    case 'ViewTemplates':

                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=LeaseAdministrator&Id=" +
                             '<%= PM.Asset.LeaseAdministratorInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.LeaseAdministratorInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;


                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LeaseAdministrator&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.LeaseAdministratorInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LeaseAdministrator&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.LeaseAdministratorInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=LeaseAdministrator&Id=" +
                                     '<%= PM.Asset.LeaseAdministratorInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Asset.LeaseAdministratorInfo.PropertyId%>' + "&EntityType=1", "Notification",
                                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'Post':
                        return OpenPOPUpToRedirect("LeaseAdministratorPostPopup.aspx", 500, 400, false);

                        break;

                    case 'New':
                        window.location = "LeaseAdministrator.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('LeaseAdministrator');
                        break;
                    default:
                        break;
                }
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                maintoolbarClick(args.get_item().get_value())
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


            function NodeChecked(sender, eventArgs) {
                var combo = $find("ctl00_CPH1_Recoveries1_ddlCostCodes");
                var node = eventArgs.get_node();
                var checked = node.get_checked();
                var childNodes = node.get_nodes();
                if (checked == true) {
                    UncheckAllChildren(childNodes);
                    UncheckAllParent(node);
                    var tree = $find(node.get_treeView().get_id());
                    if (node.get_value() == "-1") {
                        var allCheckedNodes = tree.get_checkedNodes();
                        var TotalChecked = allCheckedNodes.length
                        for (var i = TotalChecked - 1; i >= 0; i--) {
                            var CkeckedNode = allCheckedNodes[i];
                            if (CkeckedNode.get_value() != "-1") {
                                CkeckedNode.set_checked(false);

                            }

                        }



                    }
                    else {
                        var AllNode = tree.findNodeByValue("-1");
                        if (AllNode != null)
                            AllNode.set_checked(false);
                    }
                    var selectedCount = tree.get_checkedNodes()
                    if (selectedCount.length == 1) {

                        var SelectedNode = tree.get_checkedNodes()[0];
                        if (SelectedNode.get_value() == "-1")
                            combo.set_text(SelectedNode.get_text());
                        else
                            combo.set_text($("input[id$=hdnCostCodeSelectedMsg]").val());


                    }
                    else if (selectedCount.length > 1) {

                        combo.set_text($("input[id$=hdnCostCodeSelectedMsg]").val());
                    }
                    else
                        combo.set_text("");

                    return;
                }

                var rdvtree = $find(node.get_treeView().get_id());
                var AllCheckedCount = rdvtree.get_checkedNodes().length;
                if (AllCheckedCount == 0) {
                    combo.set_text("");

                }


            }
            function UncheckAllParent(node) {

                node = node.get_parent();
                while (node != null && node._element.id.toString().indexOf("ddlCostCodes") == -1) {
                    node.set_checked(false);
                    node = node.get_parent();
                }
            }
            function UncheckAllChildren(nodes) {
                var i;
                for (i = 0; i < nodes.get_count() ; i++) {
                    nodes.getNode(i).set_checked(false);

                    if (nodes.getNode(i).get_nodes().get_count() > 0)
                        UncheckAllChildren(nodes.getNode(i).get_nodes());

                }

            }




            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);

                var hdnNames = $("[id$=hddnNames]")[0];
                var hdnField = $("[id$=hddnIds]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    if (resultId == "0") {
                        $("#" + ddl + "_DropDown").find("input[type='checkbox']").each(function () {
                            if ($("#" + this.id)[0].parentNode.getAttribute("All") != "1") this.checked = false;

                        });
                        hdnField.value = resultId;
                        hdnNames.value = ResultName;
                        combo.set_text(hdnNames.value);

                        return;
                    }
                    if (resultId != "0" && vlue == "0") {
                        $("#" + ddl + "_DropDown").find("input[type='checkbox']").each(function () {
                            if ($("#" + this.id)[0].parentNode.getAttribute("All") == "1") {
                                this.checked = false;

                            }

                        });
                        hdnField.value = "";
                        hdnNames.value = "";
                        //combo.set_text(hdnNames.value);

                    }

                    if (hdnField.value == '')
                        hdnField.value = resultId;
                    else
                        hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)

                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId) {
                            if (newVal == '') {
                                newVal = results[i];
                            }
                            else {
                                newVal = newVal + ',' + results[i];
                            }
                        }
                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            if (newNames == '') {
                                newNames = resultNames[i];
                            }
                            else {
                                newNames = newNames + ',' + resultNames[i];
                            }
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }




            var allowdropdownClose;
            function GetValueToReturn(combobox, eventArgs) {

                var hdnField = $("[id$=hddnIds]")[0];
                var context = eventArgs.get_context();

                context["Ids"] = hdnField.value;
            }

            function OnClientSelectedIndexChanging(combobox, eventArgs) {
                allowdropdownClose = false;
                eventArgs.set_cancel(true);
            }

            function OnClientDropDownClosing(combobox, eventArgs) {
                if (allowdropdownClose == false) {
                    eventArgs.set_cancel(true);
                }
                allowdropdownClose = true;
            }


            function OnClientDropDownClosed(sender, args) {
                var btn = $("[id$=btnLocation]");
                btn.click();

            }

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>  
                 <telerik:AjaxSetting AjaxControlID="mlpLeaseAdministrator">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLeaseAdministrator" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <%--<telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLeaseAdministrator" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <%--<telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=207">
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
                <telerik:RadComboBox ID="ddlLeaseAdministrators" runat="server" AllowCustomText="true" meta:resourcekey="ddlLeaseAdministrators" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Height="400px" EmptyMessage="" Width="240px" AutoPostBack="False" NoWrap="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search"  ImageUrl="Images/ToolBar/lookup.png" Value="Search" NavigateUrl="SearchDocument.aspx?O=207"  CausesValidation="false"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>


                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                       <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">

                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>

                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>




                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports" Value="ViewReports"></telerik:RadToolBarButton>
                                <%--<telerik:RadToolBarButton PostBack="false" Width ="150px" ImageUrl="Images/ToolBar/PMWebW.gif"  CommandName="ViewPMWebReports"></telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates" Value="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#leaseadmin"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Post" Value="Post" CssClass="Post" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="UnPost" Value="UnPost" CssClass="UnPost" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('LeaseAdministrator');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('LeaseAdministrator');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png" PostBack="false"
                            CommandName="Post" AccessKey="p" ToolTip="Post" Value="Post" CausesValidation="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarActive">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpLeaseAdministrator" Skin="Default" CssClass="documentTabs"
        Width="100%" EnableViewState="True" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Scheduled Charges" Value="ScheduledCharges" Selected="True" />
            <telerik:RadTab Text="Recoveries" Value="Recoveries" />
            <telerik:RadTab Text="Overages" Value="Overages" />
            <telerik:RadTab Text="Escalations" Value="Escalations" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="NotificationLog" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpLeaseAdministrator" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" meta:Resourcekey="ddlProgram"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfv_Program" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue=""
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" Height="250px" runat="server"
                                            meta:resourcekey="ddlApprover" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            AllowCustomText="True" Width="100%" Skin="Default" EnableItemCaching="false" OnClientDropDownClosing="OnClientDropDownClosing"
                                            OnClientDropDownClosed="OnClientDropDownClosed" OnItemsRequested="ddl_ItemsRequested"
                                            OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">

                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chkApply" result='<%# DataBinder.Eval(Container, "Text")%>' />
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>

                                          <asp:RequiredFieldValidator ID="rfvProperties" meta:Resourcekey="rfv_Location" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue=""
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

                                        <asp:HiddenField runat="server" ID="hddnIds" />
                                        <asp:HiddenField runat="server" ID="hddnNames" />
                                        <br />
                                        <asp:Label ID="lblRequired" runat="server" Text="Locations are required." meta:resourcekey="lblRequired"
                                            Visible="false" CssClass="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBatchId" runat="server" meta:resourcekey="lblBatchId" Text="Batch ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBatchId" Width="100%" MaxLength="10" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" ControlToValidate="txtBatchId" runat="server" ErrorMessage="Reuired" Display="Dynamic" ValidationGroup="Save" CssClass="Validator" meta:resourcekey="rfv_Code"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false" Text="Batch ID must be unique by Location." meta:resourcekey="lblRecordNumberExist"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBatchDescription" runat="server" meta:resourcekey="lblBatchDescription" Text="Batch Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBatchDescription" MaxLength="500" runat="server" Width="100%"></asp:TextBox>
                                   

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBatchType" meta:resourcekey="lblBatchType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBatchTypes" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default" AllowCustomText="True"
                                            CloseDropDownOnBlur="true" Height="300px" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="true">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision  %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                        Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtRevision" runat="server" Width="100%" Style="text-align: right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBtachDate" meta:resourcekey="lblBtachDate" runat="server" Text="Batch Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpBatchDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpBatchDate" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput1" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceDate" meta:resourcekey="lblInvoiceDate" runat="server" Text="Invoice Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpInvoiceDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpInvoiceDate" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPostedDate" meta:resourcekey="lblPostedDate" runat="server" Text="Posted Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtPostedDate" style="display: block">
                                            <asp:TextBox ID="txtPostedDate" CssClass="Date" ReadOnly="true" runat="server" Width="100%" Style="text-align: right;"></asp:TextBox>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFilterByPostAs" meta:Resourcekey="lblFilterByPostAs" runat="server" Text="Filter by Post As"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFilterByPostAs" runat="server" AutoPostBack="true" Width="100%" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="color: #666666 !important; height: 24px;">
                                        <asp:Label ID="lblDeactivateExpireCharges" meta:Resourcekey="chkDeactivateExpireCharges" runat="server" Text="Deactivate Expiring Charges"></asp:Label>
                                        <div style="float: right;">
                                            <asp:CheckBox runat="server" ID="chkDeactivateExpireCharges" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right ">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblBatchRecap" runat="server" meta:resourcekey="lblBatchRecap" Text="Batch Recap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblScheduledTotal" meta:resourcekey="lblScheduledTotal" runat="server" Text="Scheduled Total"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtScheduledTotal" CssClass="Currency" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRecoveriesTotal" meta:resourcekey="lblRecoveriesTotal" runat="server" Text="Recoveries Total"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtRecoveriesTotal" CssClass="Currency" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEscalationsTotal" meta:resourcekey="lblEscalationsTotal" runat="server" Text="Escalations Total"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEscalationsTotal" CssClass="Currency" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOveragesTotal" meta:resourcekey="lblOveragesTotal" runat="server" Text="Overages Total"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtOveragesTotal" CssClass="Currency" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblGrandtotal" meta:resourcekey="lblGrandTotals" runat="server" Text="Grand Total"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGrandtotal" CssClass="Currency" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScheduledCharges" runat="server">
            <uc1:ScheduledCharges ID="ScheduledCharges1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRecoveries" runat="server">
            <uc2:Recoveries ID="Recoveries1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvOverages" runat="server">
            <uc4:Overages ID="Overages1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvEscalations" runat="server">
            <uc3:Escalations ID="Escalations1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc6:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc7:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
