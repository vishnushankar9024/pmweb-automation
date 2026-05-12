<%@ Page Language="vb" Title="Issue" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="LinkSearchToIssue.aspx.vb" Inherits="Website.LinkSearchToIssue" %>

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
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" ValidationGroup="Issues"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage R1Col">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSelectIssue" runat="server" Text=" Select Issue" meta:resourcekey="lblSelectIssue"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlIssues" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                    EmptyMessage="Select Issue..." Width="100%" AutoPostBack="false" NoWrap="true" meta:resourcekey="ddlIssues"
                                    CausesValidation="False" Height="180px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
 
    </form>
</body>
</html>
