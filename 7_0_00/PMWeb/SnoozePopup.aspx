<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SnoozePopup.aspx.vb" Inherits="Website.SnoozePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function pageLoad() {


            $('input[id$=txtSlotInterval]').change(function (sender) {
                var SlotInterv = CDbl($("input[id$=txtSlotInterval]").val());
                if (SlotInterv < 1) {
                    $("input[id$=txtSlotInterval]").val(1)
                }

            });
        }
        function CloseAndSave() {
            var btnSave = $(window.parent.document).find("[id$=btnSnooze]");
            btnSave.click();
            CloseRadWnd();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar"
                                    Width="220px">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="true">
        
                        <div class="PMMainPage">
                            <div class="row JustifyContent" style="padding-top:74px !important">
                                <div class="col-4 col-4-left">
                                    <table class="colTable" border="0">
                                        <tr runat="server" id="trsnoozeBy">
                                            <td class="labelWidth">
                                                <asp:RadioButton ID="rdbSnoozeBy" AutoPostBack="true" meta:resourcekey="rdbSnoozeBy"
                                                    Text=" Snooze By" runat="server" GroupName="Snooze" CssClass="RadioCss" />
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 50%;">
                                                            <asp:TextBox ID="txtSlotInterval" MaxLength="4" MinimumValue="1" runat="server" CssClass="PositiveInteger" Width="90%">
                                                            </asp:TextBox>
                                                        </td>
                                                        <td style="width: 50%;">
                                                            <telerik:RadComboBox ID="ddlTimeSystem" runat="server" AutoPostBack="false" CausesValidation="False"
                                                                CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="Days" Value="Days" meta:resourcekey="ItemValue_Days" />
                                                                    <telerik:RadComboBoxItem Text="Months" Value="Months" meta:resourcekey="ItemValue_Months" />
                                                                    <telerik:RadComboBoxItem Text="Weeks" Value="Weeks" meta:resourcekey="ItemValue_Weeks" />
                                                                    <telerik:RadComboBoxItem Text="Years" Value="Years" meta:resourcekey="ItemValue_Years" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:RadioButton ID="rdbSnoozeTo" AutoPostBack="true" CssClass="RadioCss" meta:resourcekey="rdbSnoozeTo"
                                                    Text=" Snooze To" runat="server" GroupName="Snooze" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadDatePicker ID="dtpSnoozeToDate" runat="server"
                                                    Skin="Default" Width="100%" AutoPostBack="true">
                                                    <Calendar ID="Calendar1" Skin="Default" runat="server" UseColumnHeadersAsSelectors="False"
                                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                    </Calendar>
                                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label runat="server" ID="lblDateInPast" meta:resourcekey="lblDateInPast" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
           
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
