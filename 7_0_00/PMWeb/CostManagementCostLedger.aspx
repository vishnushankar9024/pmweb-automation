<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CostManagementCostLedger.aspx.vb"
    MasterPageFile="~/PmMaster.Master" Inherits="Website.CostManagementCostLedger" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="CostManagementCostLedgerDetails.ascx" TagName="CostLedgerDetails" TagPrefix="uc2" %>
<%@ Register Src="CostLedgerHistory.ascx" TagName="CostLedgerHistory" TagPrefix="uc7" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Costs/CostLedger.js" type="text/javascript"></script>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpCostLedger">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCostLedger" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCostLedger" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCostLedger" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="ddlProjects" />
                    <telerik:AjaxUpdatedControl ControlID="ddlCurrencies" />
                    <telerik:AjaxUpdatedControl ControlID="hplCurrency" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            function OpenHistory(RecordId) {
                var left = (screen.width - 600) / 2;
                var top = (screen.height - 300) / 2;
                OpenPOPUp('CostLedgerRecordHistory.aspx?Id=' + RecordId, 920, 415, false);
                return false;

            }

        </script>

        <script language="javascript" type="text/javascript">
            function click_handler(sender, args) {
          ;

                switch (args.get_item().get_commandName()) {
                    case 'ViewReports':
                        var ddlProjectValue = $find("<%= ddlProjects.ClientID %>").get_value();
                       
                        if (parseInt(ddlProjectValue))
                  
                        {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTLEDGER&Id=" +
                                ddlProjectValue
                                + "&EntityId=" + ddlProjectValue + "&EntityType=0", 890, 430, false);
                        }
                            break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'Print':
                        var ddlProjectValue = $find("<%= ddlProjects.ClientID %>").get_value();

                        if (parseInt(ddlProjectValue))
                      
                        {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTLEDGER&Id=" +
                                ddlProjectValue
                                + "&EntityId=" + ddlProjectValue + "&EntityType=0", 890, 430, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    default:
                        break;
                }
            }

            function sldDate_Changed(sender, args) {
                var hdnDateFormat = $("[id$=hdnDateFormat]");
                var dtFrom = new Date();
                dtFrom.setDate(dtFrom.getDate() + sender.get_selectionStart());
                var dtTo = new Date();
                dtTo.setDate(dtTo.getDate() + sender.get_selectionEnd());

                $('#lblFromDate').html(dtFrom.format(hdnDateFormat[0].value));
                $('#lblToDate').html(dtTo.format(hdnDateFormat[0].value));
            }



        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td style="width: 240px;" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="false" 
                    Width="100%" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" EnableItemCaching="false"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Save.png" CommandName="Save" Value="Save"
                            PostBack="true" AccessKey="s" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#CostLedger"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1"
        runat="server" MultiPageID="mlpCostLedger" Skin="Default" OnTabClick="tbsDocument_TabClick" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        EnableViewState="True" CausesValidation="False" Width="100%">
        <Tabs>
            <telerik:RadTab Text="Details" Value="Details" Selected="True" />
            <telerik:RadTab Text="History1" Value="History" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpCostLedger" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%">
            <div class="PMMainPage">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnCurrency">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" meta:Resourcekey="ddlCurrencies" Height="250px" Width="100%">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <uc2:CostLedgerDetails ID="CLD1" runat="server" />
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvHistory" runat="server"
            Width="100%">
            <uc7:CostLedgerHistory ID="CH1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:HiddenField runat="server" ID="hdnDateFormat"></asp:HiddenField>
</asp:Content>
