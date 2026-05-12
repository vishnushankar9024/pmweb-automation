<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="CostWorksheetPopup.aspx.vb" Inherits="Website.CostWorksheetPopup" %>

<%@ Register Src="~/CostWorksheetDetails.ascx" TagName="CostWorksheetDetails" TagPrefix="uc1" %>
<script src="JS/Costs/CostWorksheet.js" type="text/javascript"></script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        table {
            font-size: 12px !important;
        }
         /*@media screen and (max-width: 839px) and (min-width: 320px) {
            .PMMainPage > .row .col-4-middle{
                padding-left:0px !important;
            }
        }*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
          <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
              <ClientEvents OnRequestStart="RequestStart" />
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" />
        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth" style="width:160px !important">
                                <asp:Label ID="lblProject" runat="server" meta:ResourceKey="lblProject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox ID="txtProjects" runat="server" Width="100%" Skin="Default" Enabled="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblWorksheet" meta:Resourcekey="lblWorksheet" runat="server" Text="Worksheet"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlWorksheets" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    Skin="Default" Width="100%" AutoPostBack="true" NoWrap="True" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    OnSelectedIndexChanged="ddlWorksheets_SelectedIndexChanged">
                                    <%--EmptyMessage="Select worksheet..." >--%>
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth" style="width:160px !important">
                                <asp:Label ID="lblPeriodsFrom" meta:ResourceKey="lblPeriodsFrom" runat="server" Text="Periods from"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlPeriodFrom" runat="server" Width="100%" AutoPostBack="true"
                                    Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    OnSelectedIndexChanged="ddlPeriodFrom_SelectedIndexChanged">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblCurrency"  meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" meta:Resourcekey="ddlCurrencies" Height="300px"
                                    Width="100%" AutoPostBack="true" OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth" style="width:160px !important">
                                <asp:Label ID="lblToDate" meta:Resourcekey="lblToDate" runat="server" Text="to"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlPeriodTo" runat="server" Width="100%" AutoPostBack="true"
                                    Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    OnSelectedIndexChanged="ddlPeriodTo_SelectedIndexChanged">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProjectDefault" meta:ResourceKey="lblProjectDefault"
                                    runat="server" Text="Project Default"></asp:Label><br />
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkProjectDefault" runat="server" Enabled="false" CssClass="mobile-switch" Width="100%" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
      
                    <uc1:CostWorksheetDetails ID="ucCostWorksheetDetails" runat="server" />
  
    </form>
</body>
</html>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCostWS">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostWS" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



