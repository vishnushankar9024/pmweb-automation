<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ForecastearnedValuePopup.aspx.vb" Inherits="Website.ForecastearnedValuePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style>
    .RefreshButton .Icon {
        background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png') !important;
        width: 16px !important;
        display: inline-block !important;
        height: 16px !important;
        vertical-align: middle !important;
        background-repeat: no-repeat !important;
        background-position: -640px 0px !important;
    }

    img {
        width: 100%;
    }
</style>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">

            <asp:Panel runat="server" ID="pnlChart">
                <div class="PMMainPage PMPopupMainPage">
                    <div class="row">
                        <div class="col-4">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblEarnedValue" runat="server" meta:resourcekey="lblEarnedValue" Text="Earned Value"></asp:Label>
                                </legend>
                                <table class="TableNoSpacingNoBorder">
                                    <tr>
                                        <td style="width: 15%">
                                            <asp:Label ID="lblYear" meta:ResourceKey="lblYear" runat="server" Text="Year"></asp:Label>
                                        </td>
                                        <td style="width: 30%" align="left">
                                            <asp:TextBox runat="server" MinNumber="1989" MaxNumber="2100" CssClass="PositiveInteger"
                                                ID="txtYear" Style="text-align: right;"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 30%; padding-left: 5px">
                                            <asp:CheckBox ID="chkIncludeOtherPeriods" meta:ResourceKey="chkIncludeOtherPeriods"
                                                runat="server" Text="Show all months" />
                                        </td>
                                        <td align="left">
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="RefreshButton">
                                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="width: 100%; padding-top: 20px;">
                                            <telerik:RadChart ID="chrtEarned" runat="server" Style="height: auto" AutoLayout="True"
                                                AutoTextWrap="True" CreateImageMap="False" IntelligentLabelsEnabled="True" UseSession="False"
                                                PlotArea-YAxis-Appearance-MinorGridLines-Visible="false" Legend-Appearance-Dimensions-Width="500px"
                                                Skin="LightBlue" Legend-Appearance-Visible="true" Legend-Appearance-Position-AlignedPosition="Right"
                                                Legend-Appearance-Location="OutsidePlotArea ">
                                            </telerik:RadChart>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>

                        </div>
                    </div>
                </div>
            </asp:Panel>
        </telerik:RadAjaxPanel>
    </form>
</body>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript">
        $(document).ready(function (n) {
            $(document).keypress(function (e) {
                kc = e.keyCode ? e.keyCode : e.which;
                if (kc == 13) {
                    document.getElementById('btnRefresh').click();
                }
            });
        });
    </script>
</telerik:RadCodeBlock>
</html>
