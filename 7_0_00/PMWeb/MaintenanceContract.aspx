<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="MaintenanceContract.aspx.vb" Inherits="Website.MaintenanceContract" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="MaintenanceContractDetails.ascx" TagName="MaintenanceContractDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc7" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function IntegerOnly(sender, eventArgs) {
                var c = eventArgs.get_keyCode();
                if (c == 46)
                    eventArgs.set_cancel(true);
            }

            function rdvBillToNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlBillTo]")[0].id);
                var node = args.get_node();

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_text(strText);
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.set_text(strText);
                comboBox.set_value(strValue);
                comboBox.commitChanges();

            }

            function rdvContactNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlContact]")[0].id);
                var node = args.get_node();

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_text(strText);
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.set_text(strText);
                comboBox.set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
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
                var Id = '<%=PM.Asset.MaintenanceContractInfo.Id%>';
                var HasMergeTemplate = '<%= PM.Asset.MaintenanceContractInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.MaintenanceContractInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.MaintenanceContractInfo.Description)%>';
                var HasReports = '<%= PM.Asset.MaintenanceContractInfo.HasReports%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=MAINTENANCECONTRACT&Id=" +
                                    '<%= PM.Asset.MaintenanceContractInfo.Id%>' + "&Description="
                            + '<%=JSEscape(PM.Asset.MaintenanceContractInfo.Description)%>'
                            + "&RecordDescription=" + '<%=JSEscape(PM.Asset.MaintenanceContractInfo.RecordDescription)%>'
                            + "&EntityId=0" + "&EntityType=2", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        window.open("Notification.aspx?ObjectType=MAINTENANCECONTRACT&Id=" +
                         '<%= PM.Asset.MaintenanceContractInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0" + "&EntityType=1", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;


                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=MAINTENANCECONTRACT&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0" + "&EntityType=1",
                                    'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=MAINTENANCECONTRACT&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0" + "&EntityType=1",
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
                    case 'New':
                        window.location = "MaintenanceContract.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('MAINTENANCECONTRACT');
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpMaintContract">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMaintContract" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMaintContract" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls> 
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=71">
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
                <telerik:RadComboBox ID="ddlMaintContracts" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" OnClientTextChange="LOD_DropDownTextChange"
                    AutoPostBack="False" NoWrap="true" CausesValidation="False" Height="400px" Width="240px" OnItemsRequested="ddl_ItemsRequested"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s"></telerik:RadToolBarButton>


                           <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" Value="Delete"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('MAINTENANCECONTRACT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('MAINTENANCECONTRACT');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
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



    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpMaintContract" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpMaintContract" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" meta:resourcekey="lblId" runat="server" Text="ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" Width="100%" MaxLength="10" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="txtCode"
                                            CssClass="Validator" meta:resourcekey="rfvIDs" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="200" ID="txtDescription" Width="100%" Text=""></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Skin="Default" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillTo" meta:resourcekey="lblBillTo" runat="server" Text="Bill to*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBillTo" AllowCustomText="true" runat="server" Width="100%" ShowToggleImage="true"
                                            Skin="Default" CloseDropDownOnBlur="true" NoWrap="true" DropDownCssClass="ddlTreeviewTemplate">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            <Items>
                                                <telerik:RadComboBoxItem Text="" />
                                            </Items>
                                            <ItemTemplate>
                                                <telerik:RadTreeView ID="rdvBillTo" Skin="Default" runat="server"
                                                    Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvBillToNodeClicking"
                                                    OnNodeDataBound="rdvBillTo_NodeDataBound" OnNodeExpand="rdvBillTo_NodeExpand">
                                                </telerik:RadTreeView>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator meta:resourcekey="rfvBillToo" ID="rfvBillTo" runat="server"
                                            ControlToValidate="ddlBillTo" CssClass="Validator" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillToAdresse" meta:resourcekey="lblBillToAdresse" runat="server" Text="Bill to Address"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBilltoAddress" MaxLength="700" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblContact" meta:resourcekey="lblContact" runat="server" Text="Contact"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlContact" AllowCustomText="true" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Width="100%" NoWrap="true" ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            <Items>
                                                <telerik:RadComboBoxItem Text="" />
                                            </Items>
                                            <ItemTemplate>
                                                <telerik:RadTreeView ID="rdvContact" Skin="Default" runat="server" OnNodeExpand="rdvContact_NodeExpand"
                                                    Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvContactNodeClicking"
                                                    OnNodeDataBound="rdvContact_NodeDataBound">
                                                </telerik:RadTreeView>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" valign="top">
                                        <asp:Label ID="lblOverview" meta:resourcekey="lblOverview" runat="server" Text="Overview11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOverview" MaxLength="500" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStart" meta:resourcekey="lblStart" runat="server" Text="Start11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpStart" style="display: block">
                                            <telerik:RadDatePicker ID="dtpStart" Skin="Default" runat="server" SharedCalendarID="" MinDate="01-01-1900">
                                                <DateInput ID="DateInput1" runat="server" />
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEnd" meta:resourcekey="lblEnd" runat="server" Text="End11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpEnd" style="display: block">
                                            <telerik:RadDatePicker ID="dtpEnd" Skin="Default" runat="server" SharedCalendarID="" MinDate="01-01-1900">
                                                <DateInput ID="DateInput2" runat="server" />
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblValue" meta:resourcekey="lblValue" runat="server" Text="Value11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtValue" MaxLength="15" runat="server" CssClass="Currency" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBilling" meta:resourcekey="lblBilling" runat="server" Text="Billing11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBilling" runat="server" Width="100%" Skin="Default" AllowCustomText="True" Height="100px" Filter="Contains" MarkFirstMatch="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                            <fieldset>
                                <legend class="legend">
                                    <asp:Label ID="lblLinkedWorkOrder" runat="server" meta:resourcekey="lblLinkedWorkOrder" Text="Linked Work Orders11"></asp:Label>
                                </legend>
                                <telerik:RadGrid ID="rdgLinkedWorkOrders" runat="server" HeaderStyle-Font-Size="8" AllowSorting="true"
                                    Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true" ShowStatusBar="true">

                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace">

                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderText="WO ID" UniqueName="WOID" HeaderStyle-Width="10%" SortExpression="Id" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hliId" runat="server" Text='<%# Eval("Id").ToString%>' NavigateUrl='<%# "WorkOrders.aspx?Id=" & CStr(Eval("Id"))%>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Scheduled" UniqueName="Scheduled" HeaderStyle-Width="10%" SortExpression="Scheduled">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblScheduled" Text="&nbsp;" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Assigned To" HeaderStyle-Width="20%" UniqueName="AssignedTo" SortExpression="AssignedTo">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("AssignedTo") = String.Empty, "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                        </Columns>

                                        <CommandItemTemplate>

                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                    SecurityButtonType="ItemMode_Add" Visible="true" meta:resourcekey="btnAddResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                    SecurityButtonType="ItemMode_Delete" Visible="true" runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    Visible="true" SecurityButtonType="ItemMode">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                </asp:LinkButton>
                                            </div>

                                        </CommandItemTemplate>

                                    </MasterTableView>

                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings Resizing-AllowColumnResize="true">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc5:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc7:documentteam id="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
