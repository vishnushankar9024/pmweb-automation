<%@ Page Language="vb" meta:resourcekey="Page" Title="Get Past Rates1" AutoEventWireup="false" CodeBehind="CurrencyPastRates.aspx.vb" Inherits="Website.CurrencyPastRates" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .FontWhite a {
            color: #FFF !important;
        }

        .FontWhite:hover a {
            color: #000 !important;
        }

        .RadCalendar_Metro .rcRow td.rcSelected {
            background: #fff !important;
            border: #25a0da 1px solid;
        }

        .RadCalendar_Metro .rcRow .rcSelected a {
            color: #000 !important;
        }
    </style>
</head>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
</telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="AjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdpFrom">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lblNbrDownloadRequired" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdpTo">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lblNbrDownloadRequired" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" Value="Save"
                                            CommandName="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                           >
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent R1Col">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFrom" meta:resourcekey="lblFrom" runat="server" Text="From1"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <span runat="server" id="rmd_rdpFrom" style="display: block">
                                    <telerik:RadDatePicker ID="rdpFrom" runat="server" MinDate="1900-01-01" DateInput-EnabledStyle-HorizontalAlign="Right" AutoPostBack="true"
                                        MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="140px" Skin="Default">
                                        <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </span>
                                <asp:RequiredFieldValidator ID="rfvFrom" runat="server" ValidationGroup="Save" meta:resourcekey="rfvFrom" ControlToValidate="rdpFrom" ErrorMessage="Select a date11" Display="Dynamic" CssClass="Validator"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To1"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <span runat="server" id="rmd_rdpTo" style="display: block">
                                    <telerik:RadDatePicker ID="rdpTo" runat="server" MinDate="1900-01-01" DateInput-EnabledStyle-HorizontalAlign="Right" AutoPostBack="true"
                                        MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="140px" Skin="Default">
                                        <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </span>
                                <asp:RequiredFieldValidator ID="rfvTo" meta:resourcekey="rfvTo" runat="server" ValidationGroup="Save" ControlToValidate="rdpTo" ErrorMessage="Select a date11" Display="Dynamic" CssClass="Validator"></asp:RequiredFieldValidator>
                                <asp:CompareValidator meta:resourcekey="cmpFromToDates" ID="cmpFromToDates" runat="server" ControlToValidate="rdpTo" ControlToCompare="rdpFrom" Type="Date"
                                    CssClass="Validator" ErrorMessage="To date should be greater than From date11" Display="Dynamic" ValidationGroup="Save"
                                    ForeColor="" Operator="GreaterThanEqual" EnableClientScript="false"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:CheckBox runat="server" CssClass="mobile-switch" ID="chkUpdateExistingDateRecords" meta:resourcekey="chkUpdateExistingDateRecords" Text="Allow service to update existing date records11" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblNbrDownloadRequired" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblWishtoContinue" meta:resourcekey="lblWishtoContinue" runat="server" Text="From1"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDownloadLimitWarning" meta:resourcekey="lblDownloadLimitWarning" runat="server" Text="From1"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
