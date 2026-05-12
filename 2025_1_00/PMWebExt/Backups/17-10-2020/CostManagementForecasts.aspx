<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="CostManagementForecasts.aspx.vb" Inherits="Website.CostManagementForecasts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="ucNotes" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="UcAttachements" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="ucWorflow" %>
<%@ Register Src="~/CostManagementForecastdetails.ascx" TagName="ForecastDetails" TagPrefix="ucDetails" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc1" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc2" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Costs/forecast.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            var forceMoreMenuToClose = true;
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.ForecastInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=COSTMANAGEMENT_FORECAST&Id=" +
                                 '<%= PM.CostManagement.ForecastInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.ForecastInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function OpenChartPopup() {
                var HasChart = '<%= PM.CostManagement.ForecastInfo.Id%>';
                if (HasChart > 0) {
                    OpenSmallPOPUp("ForecastearnedValuePopup.aspx",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1', 920, 415, false);
                }
                return false;
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Forecast") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Forecast");
                    button.click();
                }
                if (args.get_item().get_value() == "Post") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Post");
                    button.click();
                }
                if (args.get_item().get_value() == "TakeSnapshot") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("TakeSnapshot");
                    button.click();
                }
                if (args.get_item().get_value() == "UnPost") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Post");
                    button.click();
                }
                if (args.get_item().get_value() == "DeleteSnapshot") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("TakeSnapshot");
                    button.click();
                }

                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.CostManagement.ForecastInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.ForecastInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.ForecastInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.ForecastInfo.Description)%>';
                var Id = '<%= PM.CostManagement.ForecastInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("COSTMANAGEMENT_FORECAST")%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENT_FORECAST&Id=" +
                            '<%= PM.CostManagement.ForecastInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ForecastInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=COSTMANAGEMENT_FORECAST&Id=" +
                 '<%= PM.CostManagement.ForecastInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ForecastInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=COSTMANAGEMENT_FORECAST&Id=" +
                '<%= PM.CostManagement.ForecastInfo.Id%>'
                + "&EntityId=" + '<%= PM.CostManagement.ForecastInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=COSTMANAGEMENT_FORECAST&Id=" +
                                    '<%= PM.CostManagement.ForecastInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ForecastInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);

                        }
                        break;



                    case 'New':
                        window.location = "CostManagementForecasts.aspx";
                        break;

                    default:
                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }

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
            <telerik:AjaxSetting AjaxControlID="mlpForecast">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpForecast" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpForecast" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chkIncludePendingBudget">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgForecastDetails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chkIncludePendingcost">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgForecastDetails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%-- <telerik:AjaxSetting AjaxControlID="txtYear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="chrtEarned" LoadingPanelID="ldpPM" />
               
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=72">
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
                <telerik:RadComboBox ID="ddlForecasts" runat="server" AllowCustomText="true" Skin="Default"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange"
                    Width="240px" AutoPostBack="false" NoWrap="true" CausesValidation="False"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                    OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                            Value="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" Value="AddButton"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" Visible="false"
                                    CommandName="CreateRevision" Value="Revision" SecurityButtonType="CreateRevision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" CssClass="ToolbarPrint HideOnMobileToolbar"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton PostBack="false" Value="MobileMenu" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Forecast" Value="Forecast" CssClass="Forecast" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Post" Value="Post" CssClass="Post" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="UnPost" Value="UnPost" CssClass="UnPost" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Take Snapshot" Value="TakeSnapshot" CssClass="SaveSnapshot" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Delete Snapshot" Value="DeleteSnapshot" CssClass="DeleteSnapshot" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('COSTMANAGEMENT_FORECAST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" CssClass="Help" onclick="helpClick();" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="Hide">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Forecast.png"
                            ToolTip="Forecast From Earned Value" CommandName="Forecast" Value="Forecast" CssClass="ToolbarForecast HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png"
                            CommandName="Post" AccessKey="p" ToolTip="Post" Value="Post" CausesValidation="false" CssClass="ToolbarActive HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Snapshot.png"
                            CommandName="TakeSnapshot" Value="TakeSnapshot" CausesValidation="false" CssClass="ToolbarTakeSnapshot HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpForecast" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Skin="Default" Width="100%">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header"></telerik:RadTab>
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklists" Value="Checklists"></telerik:RadTab>
            <telerik:RadTab Text="Clauses" Value="Clauses"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam"></telerik:RadTab>
            <telerik:RadTab Text="Notification" Value="NotificationLog"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpForecast" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <div class="PMMainPage">
                <div class="row JustifyContent R3Cols">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True"
                                        CausesValidation="False" CloseDropDownOnBlur="true"
                                        Height="300px" NoWrap="true" Skin="Default" EnableVirtualScrolling="True"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
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
                                    <asp:Label ID="lblRecordNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="10" Text=""></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber"
                                        Display="Dynamic" ValidationGroup="Save" runat="server" ForeColor="" CssClass="Validator"
                                        ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                        Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidth">
                                    <asp:Label ID="lblDescription" runat="server" Text="<%$Resources:CostManagement, Label_Description %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" ID="txtDescription" MaxLength="500" Text=""></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic" ValidationGroup="Save"
                                        ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidth">
                                    <asp:Label ID="lblPeriod" runat="server" meta:ResourceKey="lblToPeriod" Text="To this period"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
                                        Skin="Default" Height="300px" NoWrap="true" CausesValidation="false"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="trCurrency">
                                <td class="labelWidth">
                                    <div style="float: left">
                                        <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                    </div>
                                    <div style="float: right">
                                        <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                             <span class="Icon"></span>                                                              
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" meta:Resourcekey="ddlCurrencies"
                                        Style="font-size: 11px" Height="300px">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" MarkFirstMatch="true"
                                        Skin="Default">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                        CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                        ValidationGroup="Save" Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                        ClientValidationFunction="ValidateCombo" Display="Dynamic" Visible="false" ValidationGroup="Save"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference" runat="server"
                                        CssClass="Validator" Visible="false" Display="Dynamic" ValidationGroup="Save"
                                        ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder" width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                    CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                    ValidationGroup="Save" Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                    ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                    CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                </asp:CustomValidator>
                                            </td>
                                            <td width="50px" style="padding-left: 8px;">
                                                <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger" MaxLength="9"
                                                    Text=""></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                    runat="server" CssClass="Validator" Visible="false" Display="Dynamic" ValidationGroup="Save"
                                                    ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDate" meta:Resourcekey="lblDate" runat="server" Text="Date11"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadDatePicker ID="dtpDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                        SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)"
                                        EnableTyping="False" DatePopupButton-Visible="false">
                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Default" Skin="Default"
                                            ReadOnly="true" runat="server">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidthChkBox">
                                    <asp:Label ID="lblIncludePendingBudget" meta:Resourcekey="lblIncludePendingBudgetRecords" runat="server" Text="Include Pending Budget Records111"></asp:Label>
                                </td>
                                <td align="right" class="controlWidth">
                                    <asp:CheckBox ID="chkIncludePendingBudget" runat="server" CssClass="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidthChkBox">
                                    <asp:Label ID="lblIncludePendingCost" meta:Resourcekey="lblIncludePendingCostRecords" runat="server" Text="Include Pending Cost Records111"></asp:Label>
                                </td>
                                <td align="right" class="controlWidth">
                                    <asp:CheckBox ID="chkIncludePendingCost" CssClass="mobile-switch" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidthChkBox">
                                    <asp:Label ID="lblIncludePendingActualCost" meta:Resourcekey="lblIncludePendingActualCostRecords" runat="server" Text="Include Pending Actual Cost Records111"></asp:Label>
                                </td>
                                <td align="right" class="controlWidth">
                                    <asp:CheckBox ID="chkIncludePendingActualCost" CssClass="mobile-switch" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap labelWidth">
                                    <asp:LinkButton runat="server" CssClass="Link" ID="btnEarnedValuePopup" OnClientClick="return OpenChartPopup();">
                                        <asp:Label runat="server" ID="lblEarnedValueChart" style="text-decoration:underline" Text="" meta:resourcekey="lblEarnedValueChart"></asp:Label>
                                    </asp:LinkButton>
                                </td>
                                <td class="controlWidth"><span></span></td>
                            </tr>

                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <uc12:AssetRotator ID="PMrot" runat="server" />
                    </div>
                    <div class="col-4 col-4-right">
                        <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <ucDetails:ForecastDetails ID="forecastDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc2:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <ucNotes:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <UcAttachements:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <ucWorflow:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc1:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
