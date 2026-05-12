<%@ Page Language="vb" Title="Actual Dates" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="OccupantMoveDates.aspx.vb" Inherits="Website.OccupantMoveDates" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                         <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"
                                            ValidationGroup="Move">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"
                                            ValidationGroup="Move">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblActualStart" meta:resourcekey="lblActualStart" runat="server" Text="Actual Start*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="dtpActualStart" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="120px" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput5" Skin="Default" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="rfvActualStart" runat="server" ControlToValidate="dtpActualStart"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<br/>Required."
                                                Display="Dynamic" ForeColor="" ValidationGroup="Move"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblActualFinish" meta:resourcekey="lblActualFinish" runat="server"
                                                Text="Actual Finish*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="dtpActualFinish" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="120px" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput1" Skin="Default" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="rfvActualfinish" runat="server" ControlToValidate="dtpActualFinish"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<br/>Required."
                                                Display="Dynamic" ForeColor="" ValidationGroup="Move"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
