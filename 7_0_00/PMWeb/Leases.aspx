<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Leases.aspx.vb" Inherits="Website.Leases" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="LeaseAbstract.ascx" TagName="LeaseAbstract" TagPrefix="uc1" %>
<%--<%@ Register Src="LeasesDetails.ascx" TagName="LeaseDetails" TagPrefix="uc7" %>--%>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc8" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc9" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc10" %>
<%@ Register Src="LeaseCharges.ascx" TagName="LeaseCharges" TagPrefix="uc11" %>
<%@ Register Src="LeaseLedger.ascx" TagName="LeaseLedger" TagPrefix="uc12" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc13" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc14" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Asset/Leases.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">

            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                }
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function Ledger_OnRowSelecting(sender, eventArgs) {
                var CanSelectRow = $("#" + eventArgs.get_id())[0].getAttribute("CanSelectRow")
                if (CanSelectRow == "false")
                    eventArgs.set_cancel(true);
            }



            function OpenGoogleLeaseAddressesPicker() {
                var Id = '<%= PM.Asset.LeaseInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=LEASE&ObjectId=" + Id + "&PickerSender=RecordAddress", 920, 415, false);
                }
                return false;
            }

            function OpenLinkAssetsPopup() {
                var Description = '<%= PM.Asset.LeaseInfo.LeaseDescription%>';
                var Id = '<%= PM.Asset.LeaseInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkAssetsPopup.aspx?ObjectType=LEASE&RecordId=' + Id + '&Description=' + Description);
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

            function OpenSubLeasePopup() {
                var Description = '<%= PM.Asset.LeaseInfo.LeaseDescription%>';
                var Id = '<%= PM.Asset.LeaseInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('SubLeasePopup.aspx?ObjectType=LEASE&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseSubLeasePopup);
                return false;
            }

            function CloseSubLeasePopup() {
                var btnRefreshHeader = $("[id$=btnRefreshSubLease]");
                if (btnRefreshHeader) {
                    btnRefreshHeader.click();
                }
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Asset.LeaseInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.LeaseInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.LeaseInfo.Description)%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("LEASE")%>';
                var HasReports = '<%= PM.Asset.LeaseInfo.HasReports%>';
                var Id = '<%= PM.Asset.LeaseInfo.Id%>';
                switch (Value) {
                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=LEASE&Id=" + Id
                                + "&EntityId=" + '<%=PM.Asset.LeaseInfo.PropertyId%>' + "&EntityType=1", 400, 150, false);
                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LEASE&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.LeaseInfo.PropertyId%>' + "&EntityType=1", 400, 150, false);
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LEASE&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.LeaseInfo.PropertyId%>' + "&EntityType=1", 400, 150, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=LEASE&Id=" +
                                    '<%= PM.Asset.LeaseInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.LeaseInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        OpenPOPUp("Notification.aspx?ObjectType=LEASE&Id=" +
                               '<%= PM.Asset.LeaseInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.LeaseInfo.PropertyId%>' + "&EntityType=1", 400, 150, false);
                        break;

                    case 'New':
                        window.location = "Leases.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('LEASE');
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function VisualCalculator(Gross, Rentable, Usable) {
                var CommonArea = 0;
                if (Rentable == 0) {
                    CommonArea = CPrct(0);
                }
                else {
                    CommonArea = CPrct(((Rentable - Usable) / Rentable) * 100);
                }
                $("input[id$=txtRentable]").val(FPrec(Rentable));

                $("input[id$=txtCommonArea]").val(CommonArea);
                $("input[id$=txtUsable]").val(FPrec(Usable));

                CalculateSnapShot();
            }
            function StopSelectLeaseAjax() {
                return false;
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpLeases">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLeases" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLeases" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <asp:HiddenField ID="hdfIsNewRecord" runat="server" />

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=67">
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
            <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlLeases" runat="server" AllowCustomText="true"
                    meta:resourcekey="ddlLeases" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Height="400px"
                    EmptyMessage="Select Lease..." Width="100%" AutoPostBack="False" NoWrap="true"
                    CausesValidation="False" ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" 
                                        AccessKey="n" PostBack="false" ToolTip="New (Alt+n)" CausesValidation="false">
                                        </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s"
                            ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy"  ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete"
                            AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
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
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('LEASE');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('LEASE');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CausesValidation="false"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#pmwleases"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpLeases" CssClass="documentTabs"
        Skin="Default" Width="100%" EnableViewState="True" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <%--<telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Abstract" Value="Abstract" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Charges" Value="Charges" />
            <telerik:RadTab Text="Ledger" Value="LeaseLedger" />
            <telerik:RadTab Text="Checklists" Value="Checklists" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpLeases" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true" BorderColor="LightBlue" BorderWidth="0">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <div class="PMMainPage">
                <div class="row JustifyContent R3Cols">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location*"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                        AllowCustomText="true" Width="100%" NoWrap="true" Height="300px"
                                        CausesValidation="False" AutoPostBack="true"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                        CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Location" 
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                     ClientValidationFunction="ValidateCombo"
                                        ValidationGroup="Save" Display="Dynamic" CssClass="Validator" meta:resourcekey="rfv_Location">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblParentlease" meta:resourcekey="lblParentlease" runat="server" Text="Parent Lease"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgLease" CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlParentLease" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                        AllowCustomText="true" Width="100%" NoWrap="true" Height="300px"
                                        CausesValidation="False" AutoPostBack="False"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeaseId" runat="server" meta:resourcekey="lblLeaseId" Text="Lease ID*"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeaseId" Width="100%" MaxLength="10" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCode" ControlToValidate="txtLeaseId" runat="server"
                                        Display="Dynamic" ValidationGroup="Save"
                                        CssClass="Validator" meta:resourcekey="rfv_Code"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                        Text="Lease ID must be unique by Location." meta:resourcekey="lblRecordNumberAlreadyExist"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeaseDescription" runat="server" meta:resourcekey="lblLeaseDescription" Text="Description"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeaseDescription" Width="100%" MaxLength="500" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeaseType" meta:resourcekey="lblLeaseType" runat="server" Text="Lease Type"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlLeaseTypes" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="True"
                                        Skin="Default" CloseDropDownOnBlur="true" Height="300px" Width="100%" NoWrap="true" CausesValidation="False"
                                        TabIndex="2">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPostType" meta:resourcekey="lblPostType" runat="server" Text="Post As"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPostType" runat="server" Skin="Default"
                                        CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLinkedUsable" meta:resourcekey="lblLinkedUsable" runat="server" Text="Linked Usable"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLinkedUsable" Width="100%" CssClass="Double" MaxLength="10" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLinkedRentable" meta:resourcekey="lblLinkedRentable" runat="server" Text="Rentable"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLinkedRentable" CssClass="Double" Width="100%" MaxLength="10" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <%--<td style="padding-left: 5px; text-align: right">
                                                            <span id="Span2" runat="server"><%= IIf(Me.PM.Asset.LeaseInfo.PropertyUOM = String.Empty, "&nbsp;", Me.PM.Asset.LeaseInfo.PropertyUOM)%></span>
                                                        </td>--%>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblLandLord" runat="server" meta:resourcekey="lblLandLord" Text="Landlord"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField1'),this.id.replace('imgfilter1','ddlLandlord'),'Companies')">
                                                                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlLandlord" runat="server" Height="200px" Skin="Default" Width="100%" CloseDropDownOnBlur="true"
                                        meta:resourcekey="ddlLandlord" NoWrap="False" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblTenant" meta:resourcekey="lblTenant" runat="server" Text="Tenant"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgfilter2" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter2','HiddenField2'),this.id.replace('imgfilter2','ddlTenant'),'Companies')">
                                                                <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlTenant" runat="server" Height="200px" Skin="Default" Width="100%" CloseDropDownOnBlur="true"
                                        meta:resourcekey="ddlTenant" NoWrap="False" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblAgent" meta:resourcekey="lblAgent" runat="server" Text="Agent"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgfilter3" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter3','HiddenField3'),this.id.replace('imgfilter3','ddlAgent'),'Companies')">
                                                                <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlAgent" runat="server" Height="200px" Skin="Default" Width="100%" CloseDropDownOnBlur="true"
                                        meta:resourcekey="ddlAgent" NoWrap="False" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                    <asp:HiddenField ID="HiddenField3" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatusRevision" meta:resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" CloseDropDownOnBlur="true" Style="width: 182px !important" NoWrap="true" CausesValidation="False" TabIndex="2">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td style="width: 50px; padding-left: 8px;">
                                                <asp:TextBox ID="txtRevision" ReadOnly="true" runat="server" Width="100%" Style="text-align: right;"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
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
                                        <asp:Button ID="btnRefreshHeader" runat="server" class="Hide"></asp:Button>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <div class="NoWrap">
                                        <asp:TextBox ID="txtLinkedAsset" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblSubLease" meta:resourcekey="lblSubLease" runat="server" Text="Sub-Leases"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtSubLease" OnClientClick="return OpenSubLeasePopup();">
                                                                                             <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:Button ID="btnRefreshSubLease" runat="server" class="Hide"></asp:Button>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <div class="NoWrap">
                                        <asp:TextBox ID="txtSubLease" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>               
                        </table>
                        <fieldset runat="server" id="fldsetAddress">
                            <legend>
                                <asp:Label ID="lblAddress" CssClass="legend" meta:resourcekey="lblAddress" runat="server" Text="ADDRESS"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address 2"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Width="100%" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity" Text="City"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Width="100%" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblStateZip" meta:resourcekey="lblStateZip" Text="State / Zip"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStates" runat="server" Width="116px" Skin="Default"
                                                        Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="text-align: right; padding-left: 8px;">
                                                    <asp:TextBox ID="txtZip" runat="server" Width="116px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblCountry" meta:resourcekey="lblCountry" Text="Country"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountries" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                            Width="100%" Height="400px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="LblPhone" meta:resourcekey="LblPhone" Text="Phone"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Width="100%" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="LblFax" meta:resourcekey="LblFax" Text="Fax"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Width="100%" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblGeolocation" meta:resourcekey="lblGeolocation" Text="Geolocation"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleLeaseAddressesPicker();" CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtPMbarcode">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBarcode" runat="Server" Width="100%" Style="vertical-align: middle;" MaxLength="255"></asp:TextBox>
                                        <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblSnapshot" runat="server" CssClass="legend" Text="SNAPSHOT" meta:resourcekey="lblSnapshot"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMonthyRent" meta:resourcekey="lblMonthyRent" runat="server" Text="Rent/Month"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtMonthlyRent" CssClass="Currency" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblYearlyRent" meta:resourcekey="lblYearlyRent" runat="server" Text="Rent/Year"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtYearlyRent" CssClass="Currency" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocUOM" meta:resourcekey="lblLocUOM" runat="server" Text="Location UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLocUOM" runat="server" Width="100%" MaxLength="15" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <%--<td colspan="2" style="width:100%;">
                                                            <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblRentable" meta:resourcekey="lblRentable" runat="server" Text="Rentable"></asp:Label>
                                                                    </td>
                                                                    <td rowspan="2" style="width:30px;">
                                                                        <asp:LinkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                                                            align="left" class="SearchButton">
                                                                                <span class="Icon"></span>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <asp:TextBox ID="txtRentable" CssClass="Double" runat="server" Width="99%" MaxLength="15"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblUsable" meta:resourcekey="lblUsable" runat="server" Text="Usable"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <asp:TextBox ID="txtUsable" CssClass="Double" runat="server" Width="99%" MaxLength="15"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>--%>

                                    <td class="labelWidth" rowspan="2">
                                        <table class="colTable">
                                            <tr>
                                                <td>
                                                    <div style="float: left;">
                                                        <asp:Label ID="lblRentable" meta:resourcekey="lblRentable" runat="server" Text="Rentable"></asp:Label>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="float: right;">
                                                        <asp:LinkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                                            align="left" class="SearchButton">
                                                                                <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 0;">
                                                    <asp:Label ID="lblUsable" meta:resourcekey="lblUsable" runat="server" Text="Usable"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRentable" CssClass="Double" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtUsable" CssClass="Double" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommonArea" meta:resourcekey="lblCommonArea" runat="server" Text="Common Area %"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCommonArea" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRentAreaMonth" meta:resourcekey="lblRentAreaMonth" runat="server" Text="Rent/Area/Month"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRentAreaMonth" CssClass="Currency" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRentAreaYear" meta:resourcekey="lblRentAreaYear" runat="server" Text="Rent/Area/Year"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRentAreaYear" CssClass="Currency" runat="server" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLeaseStart" meta:resourcekey="lblLeaseStart" runat="server" Text="Lease Start"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpLeaseStart" style="display: block">
                                            <telerik:RadDatePicker ID="dtpLeaseStart" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput2" Skin="Default" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLeaseFinish" meta:resourcekey="lblLeaseFinish" runat="server" Text="Lease Finish"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpFinish" style="display: block">
                                            <telerik:RadDatePicker ID="dtpFinish" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput3" Skin="Default" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <uc10:AssetRotator ID="PMrot" runat="server" />
                        <uc14:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvDetails" runat="server">
                                    <uc7:LeaseDetails ID="LeaseDetails" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvAbstract" runat="server">
            <uc1:LeaseAbstract ID="LeaseAbstract" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc8:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCharges" runat="server">
            <uc11:LeaseCharges ID="LeaseCharges1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvLedger" runat="server">
            <uc12:LeaseLedger ID="LeaseLedger" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc9:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server" Visible="False">
            <uc6:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc13:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
