<%@ Page meta:resourceKey="Page" Language="vb" AutoEventWireup="false" CodeBehind="LeaseAdministratorPostPopup.aspx.vb" Inherits="Website.LeaseAdministratorPostPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
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
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

     
                    <div class="PMMainPage">
                        <div class="row documentSinglePage">
                            <div class="col-4 col-4-left">
                                <table class="colTable" border="0" style="color:#666666">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Image ID="imgCaution" runat="server" ImageUrl="Images/Global/NoticeIcon.png" style="position:relative;top:3px;" Height="20px" Width="22px" />
                                            <asp:Label runat="server" ID="lblTransactionSaved" meta:resourceKey="lblTransactionSaved" Text="If you save, the following transactions will be created:"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <asp:Label runat="server" ID="lblChargesAndInvoices"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <asp:Label runat="server" ID="lblCostLedger"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <asp:Label runat="server" ID="lblExpiringCharges"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <asp:Label runat="server" ID="lblEscalation"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label runat="server" meta:resourceKey="lblProcessUndone" ID="lblProcessUndone" Text="This Process cannot be undone!"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
      

    </form>
</body>
</html>
