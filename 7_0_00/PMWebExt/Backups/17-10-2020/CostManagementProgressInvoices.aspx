<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementProgressInvoices.aspx.vb" Inherits="Website.CostManagementProgressInvoices" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementProgressInvoiceDetails.ascx" TagName="CostManagementProgressInvoiceDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="CostManagementAPPaymentApplication.ascx" TagName="APPaymentApplication" TagPrefix="uc11" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc13" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Costs/ProgressInvoices.js" type="text/javascript"></script>


    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.ProgressInvoiceInfo.ProjectId %>';
            var forceMoreMenuToClose = true;
            function SubmitWorkflowError(errorMsg, url) {
                alert("'" + errorMsg + "'");
                window.location = url;
            }

            function OpenProductionPopup() {
                OpenPOPUp("ProductionPopup.aspx?Source=PROGRESSINVOICES", 700, 500, true);
            }

            function CommitmentRedirect() {
                var ddlCommitmentValue = $find("<%= ddlCommitments.ClientID %>").get_value();
                if (parseInt(ddlCommitmentValue)) {
                    window.location.href = 'ContractsCommitments.aspx?ID=' + ddlCommitmentValue + '&ModuleId=3&PageId=106';
                }
                return false;
            }
            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(str.indexOf('_') + 1);

                if (DetailId != '0') {
                    OpenPOPUp("UnitRecap.aspx?Source=PROGRESSINVOICES&DetailId=" +
            DetailId, 740, 500, true);

                }

                try {
                    event.preventDefault();
                }
                catch (err) {

                }
                try {
                    event.returnValue = false;
                }
                catch (err)
                { }


                return false;

            }

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.ProgressInvoiceInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=PROGRESSINVOICES&Id=" +
                                 '<%= PM.CostManagement.ProgressInvoiceInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.ProgressInvoiceInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.CostManagement.ProgressInvoiceInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.ProgressInvoiceInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.ProgressInvoiceInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.ProgressInvoiceInfo.Description)%>';
                var Id = '<%= PM.CostManagement.ProgressInvoiceInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("PROGRESSINVOICES")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=PROGRESSINVOICES&Id=" +
                                    '<%= PM.CostManagement.ProgressInvoiceInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ProgressInvoiceInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROGRESSINVOICES&Id=" +
                                    '<%= PM.CostManagement.ProgressInvoiceInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ProgressInvoiceInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=PROGRESSINVOICES&Id=" +
                               '<%= PM.CostManagement.ProgressInvoiceInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ProgressInvoiceInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=PROGRESSINVOICES&Id=" + Id
                        + "&EntityId=" + '<%=PM.CostManagement.ProgressInvoiceInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                    case 'New':
                        window.location = "CostManagementProgressInvoices.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function OpenOverbillingStatePopup() {
                OpenPOPUp('OverbillingStatePopup.aspx?Source=ProgressInvoice', 1045, 515, false);
                //var wnd = window.radopen('OverbillingStatePopup.aspx?Source=ProgressInvoice');
                //wnd.setSize(800, 500);
                //wnd.Center();
                //return false;
            }

            function DisablebtnCreateNext(me) {
                if (Page_ClientValidate('Save')) {
                    me.setAttribute('disabled', 'disabled');
                    DisablePanelAjax();
                }
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "CreateNext") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("CreateNext");
                        button.click();
                    }
                    if (args.get_item().get_value() == "Void") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Void");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
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
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpContactInvoices">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpContactInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpContactInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar LargeToolBar">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=80">
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
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlProgressInvoice" runat="server" Filter="Contains" MarkFirstMatch="true" AutoPostBack="false"
                    Skin="Default" CloseDropDownOnBlur="true" Width="240px" NoWrap="true"
                    Height="260px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                    <Items>
                        <telerik:RadComboBoxItem Text="" />
                    </Items>
                    <ItemTemplate>
                        <div id="div1">
                            <telerik:RadTreeView ID="rdvProgressInvoice" Skin="Default" runat="server"
                                Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="MainTree_NodeClicking"
                                OnNodeDataBound="rdvProgressInvoice_NodeDataBound" OnNodeExpand="rdvProgressInvoice_NodeExpand">
                            </telerik:RadTreeView>
                        </div>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 100%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar"
                    runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save"></telerik:RadToolBarButton>


                        <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/Global/AddLine.png"
                            CommandName="New">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" Visible="false"
                            CommandName="CreateRevision" SecurityButtonType="Add">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ID="btnCreateNext" PostBack="true" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="CreateNext"
                            meta:resourcekey="btnCreateNext" CommandName="CreateNext" Text="Create Next" ImageUrl="Images/ToolBar/PMWebW.gif" OnClientClick="DisablebtnCreateNext(this)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d"
                            ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Void.png" CommandName="Void" AccessKey="v" ToolTip="Void (Alt+v)"
                            Value="Void" CausesValidation="false" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
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
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Void" Value="Void" CssClass="Void"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Create Next" Value="CreateNext" CssClass="CreateNext"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('PROGRESSINVOICES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" Visible="false" ImageUrl="Images/ToolBar/Revision.png"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="true" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#ProgressInvoices"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpContactInvoices" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Skin="Default" Width="100%" EnableViewState="true">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpContactInvoices" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true" BorderWidth="0">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr id="trVoid" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVoid" meta:resourcekey="lblVoid" runat="server" Text="Void"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:Image ID="imgVoid" runat="server" ImageUrl="Images/Global/checked.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True"
                                            Skin="Default" CausesValidation="false"
                                            NoWrap="true" Width="100%" Height="300px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:LinkButton ID="lbtCommitment" CssClass="Link" runat="server" Text="<%$Resources:CostManagement, Label_Commitment %>" OnClientClick="return CommitmentRedirect();"></asp:LinkButton>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCommitments" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            EmptyMessage="<%$Resources:CostManagement, WarningMsg_SelectCommitments %>" Width="100%"
                                            AllowCustomText="true" Height="400px" AutoPostBack="True" NoWrap="true"
                                            CausesValidation="False" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitments" runat="server" ControlToValidate="ddlCommitments"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_SelectCommitments%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <%--<asp:RequiredFieldValidator ID="rfvCommitments2" runat="server" ControlToValidate="ddlCommitments"
                                                                    CssClass="Validator" InitialValue="<%$ Resources:PMWeb, DASHSELECT%>" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_SelectCommitments%>" 
                                                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                                        <asp:CustomValidator ID="csvCommitments" runat="server" ControlToValidate="ddlCommitments"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_SelectCommitments%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" Text="<%$Resources:CostManagement, Label_Company %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCompany" MaxLength="100" Text="" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" MaxLength="500"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" meta:resourcekey="lblReference" Text="Reference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtReference" MaxLength="255"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" Height="18px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoicenumber" runat="server" meta:resourcekey="lblInvoicenumber" Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtInvoiceNumber" CssClass="Right" ReadOnly="true" MaxLength="9" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblChangeEventNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="20" runat="server" ValidationGroup="Save"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save" Display="Dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger" MaxLength="9" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="100%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2">
                                        <fieldset runat="server" id="fldOnlineInvoice">
                                            <legend>
                                                <asp:Label ID="lblOnlineInvoice" meta:resourcekey="lblOnlineInvoice" CssClass="legend" runat="server" Text="ONLINE INVOICE"></asp:Label>
                                            </legend>
                                            <table class="colTable">
                                                <tr style="width: 100%;">
                                                    <td class="labelWidth">
                                                        <asp:Label ID="Label2" meta:resourcekey="lblInvoiceDate" runat="server" Text="Invoice Date"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <span runat="server" id="rmd_dtpInvoiceDate" style="display: block">
                                                            <telerik:RadDatePicker ID="dtpInvoiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                Width="100%" Skin="Default" EnableTyping="True" AutoPostBack="true">
                                                                <DateInput ID="DateInput4" Skin="Default"
                                                                    runat="server">
                                                                </DateInput>
                                                            </telerik:RadDatePicker>
                                                        </span>
                                                        <asp:RequiredFieldValidator ID="rfvDate" ControlToValidate="dtpInvoiceDate"
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblBillingTerms" runat="server" meta:ResourceKey="lblBillingTerms" Text="Billing Terms"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" Skin="Default" AutoPostBack="true" MarkFirstMatch="true" Filter="Contains" AllowCustomText="True" Width="100%"></telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="rfvBillingTerm" runat="server" ControlToValidate="ddlBillingTerms"
                                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                        <asp:CustomValidator ID="csvBillingTerm" runat="server" ControlToValidate="ddlBillingTerms" ValidateEmptyText="true"
                                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                        </asp:CustomValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="Label3" meta:resourcekey="lblInvoiceDue" runat="server" Text="Invoice Due"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <span runat="server" id="rmd_dtpInvoiceDue" style="display: block">
                                                            <telerik:RadDatePicker ID="dtpInvoiceDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                Width="100%" Skin="Default" EnableTyping="True">
                                                                <DateInput ID="DateInput5" Skin="Default"
                                                                    runat="server">
                                                                </DateInput>
                                                            </telerik:RadDatePicker>
                                                        </span>
                                                        <asp:RequiredFieldValidator ID="rfvDueDate" ControlToValidate="dtpInvoiceDue"
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblInvoiceType" meta:resourcekey="lblInvoiceType" runat="server" Text="Invoice Type"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlInvoiceType" Width="100%" Height="300px" runat="server" Skin="Default"
                                                            Style="font-size: 11px" AllowCustomText="true" MarkFirstMatch="true" Filter="Contains">
                                                        </telerik:RadComboBox>
                                                        <asp:CompareValidator ID="cmvInvoiceType" runat="server" Visible="false"
                                                            ControlToValidate="ddlInvoiceType" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                            ForeColor="" Operator="GreaterThan" ValidationGroup="Save" ValueToCompare="0"></asp:CompareValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblContact" meta:resourcekey="lblContact" runat="server" Text="Contact"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContact" MaxLength="500" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvContact" ControlToValidate="txtContact"
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblComment" meta:resourcekey="lblComment" runat="server" Text="Comments"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtComment" MaxLength="2000" Style="width: 100%; box-sizing: border-box" TextMode="MultiLine" Height="82px" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvComment" ControlToValidate="txtComment" Display="Dynamic"
                                                            runat="server" CssClass="Validator" Visible="false"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPrint" meta:resourcekey="lblPrint" runat="server" Text="Print Lien Waiver"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton runat="server" ID="btnPrint" OnClientClick="return OpenReport();">
                                                                                            <div class="btnPrint">&nbsp; <%--class="btnPrint" btnToolbarSearchDocument --%>
                                                                                             </div>
                                                                    </asp:LinkButton>
                                                                </td>
                                                                <td style="width: 100%; text-align: center;">
                                                                    <asp:Label ID="lblSigned" Style="color: #666666;" meta:resourcekey="lblSigned" runat="server" Text="Signed Waiver Attached"></asp:Label>
                                                                </td>
                                                                <td style="float: right;">
                                                                    <asp:CheckBox ID="chkSigned" runat="server" Text="" CssClass="mobile-switch" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <%-- <tr>
                                                                <td class="labelWidth"></td>
                                                                <td class="controlWidth">
                                                                    <asp:Button
                                                                        ID="btnSubmit" meta:resourcekey="btnSubmit" OnClientClick="DisablePanelAjax()" ValidationGroup="Save" runat="server" Text="Submit" />
                                                                </td>
                                                            </tr>--%>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostPeriod" meta:resourcekey="lblCostPeriod" runat="server" Text="Cost Period"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostPeriod" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPeriod" runat="server" ControlToValidate="ddlCostPeriod"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPeriod" runat="server" ControlToValidate="ddlCostPeriod"
                                            ClientValidationFunction="ValidateCostPeriodddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaidInFull" meta:resourcekey="lblPaidInFull" runat="server" Text="Paid In Full"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="float: left;">
                                        <asp:CheckBox ID="chkPaidInFull" runat="server" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                            <fieldset runat="server" id="fldContractSnapshot">
                                <legend>
                                    <%--<asp:Label ID="lblContractSnapshot" meta:resourcekey="lblContractSnapshot" CssClass="legend" runat="server" Text="Contract Snapsho"></asp:Label>--%>
                                    <asp:Label ID="lblRecap" meta:resourcekey="lblRecap" CssClass="legend" runat="server" Text="Recap"></asp:Label>
                                </legend>
                                <table class="colTable" style="color: #666666 !important;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOriginalContract" meta:resourcekey="lblOriginalValue" runat="server" Text="Original Contract"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOriginalValue" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblApprovedChanges" meta:resourcekey="lblApprovedChange" runat="server" Text="Approved Change Orders"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtApprovedChanges" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRevisedContract" meta:resourcekey="lblRevisedValue" runat="server" Text="Revised Contract"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRevisedContract" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="line-height: 24px;">
                                        <td>
                                            <div style="float: left;">
                                                <asp:Label ID="lblInvoiced" meta:resourcekey="lblInvoicedVal" runat="server" Text="Total Invoiced"></asp:Label>
                                            </div>
                                            <div runat="server" id="overbilled" style="float: right; margin-right: 5px;">
                                                <asp:LinkButton runat="server" ID="imgOverbilled" OnClientClick="return OpenOverbillingStatePopup();" CausesValidation="False" CssClass="Warning"
                                                    TabIndex="-1" Visible="false"> 
                                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInvoiced" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRetained" runat="server" meta:resourcekey="lblRetainedVal" Text="Total Retained"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRetained" ReadOnly="true" runat="server" CssClass="Currency"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblEarnedLessRetainage" meta:resourcekey="lblEarnedLessRetainage" runat="server" Text="Earned Less Retainage"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEarnedLessRetainage" ReadOnly="true" runat="server" CssClass="Currency"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLessPriorInvoices" meta:resourcekey="lblLessPriorInvoices" runat="server" Text="Less Prior Invoices"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLessPriorInvoices" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTotalThisInvoice" meta:resourcekey="lblCurrentPaymentDue" runat="server" Text="Current Payment Due"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalThisInvoice" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblUnappliedPaymentsAvailable" meta:resourcekey="lblUnappliedPaymentsAvailable" runat="server" Text="Unapplied Payments Available"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUnappliedPaymentsAvailable" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPaymentsApplied" meta:resourcekey="lblPaymentsApplied" runat="server" Text="Payments Applied"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPaymentsApplied" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOpenBalance" meta:resourcekey="lblOpenBalance" runat="server" Text="Open Balance"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOpenBalance" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblBalanceToInvoice" meta:resourcekey="lblBalanceToFinish" runat="server" Text="Bal. To Finish(incl. Retainage)"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBalanceToInvoice" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc13:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc1:CostManagementProgressInvoiceDetails ID="CID" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1"
                runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc11:APPaymentApplication ID="APPaymentApplication1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc5:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc12:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <asp:Button runat="server" ID="btnReloadWorkflowDoc" CssClass="Hide" />
    <script type="text/javascript">
        var div1 = document.getElementById("div1");
        div1.onclick = StopPropagation;
    </script>
</asp:Content>
