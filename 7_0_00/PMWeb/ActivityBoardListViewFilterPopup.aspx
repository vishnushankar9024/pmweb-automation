<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardListViewFilterPopup.aspx.vb" Inherits="Website.ActivityBoardListViewFilterPopup"
    meta:resourcekey="Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar NewStylePopupToolbar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage R24SidePadding TitleToolbarTop">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:TextBox ID="txtFilter" runat="server"></asp:TextBox>

                                <telerik:RadDatePicker ID="dtpFilter" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Visible="false">
                                    <DateInput ID="DateInput1" runat="server">
                                    </DateInput>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdbTextFilter" Enabled="true" AutoPostBack="false" runat="server" RepeatDirection="Vertical" CssClass="RadioCss RadioPadding">
                                    <asp:ListItem Text="No Filter" meta:resourcekey="rdbNoFilter" Value="NoFilter" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Contains" meta:resourcekey="rdbContaints" Value="Contains"></asp:ListItem>
                                    <asp:ListItem Text="Starts With" meta:resourcekey="rdbStartsWith" Value="StartsWith"></asp:ListItem>
                                    <asp:ListItem Text="Ends With" meta:resourcekey="rdbEndsWith" Value="EndsWith"></asp:ListItem>
                                    <asp:ListItem Text="Is Empty" meta:resourcekey="rdbIsEmpty" Value="IsEmpty"></asp:ListItem>
                                    <asp:ListItem Text="Is Not Empty" meta:resourcekey="rdbIsNotEmpty" Value="IsNotEmpty"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RadioButtonList ID="rdbDateFilter" Enabled="true" AutoPostBack="false" runat="server" RepeatDirection="Vertical" Visible="false" CssClass="RadioCss RadioPadding">
                                    <asp:ListItem Text="No Filter" meta:resourcekey="rdbNoFilter" Value="NoFilter" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Equals To" meta:resourcekey="rdbEqualsTo" Value="EqualsTo"></asp:ListItem>
                                    <asp:ListItem Text="Less Than" meta:resourcekey="rdbLessThan" Value="LessThan"></asp:ListItem>
                                    <asp:ListItem Text="Greater Than" meta:resourcekey="rdbGreaterThan" Value="GreaterThan"></asp:ListItem>
                                    <asp:ListItem Text="Is Null" meta:resourcekey="rdbIsNull" Value="IsNull"></asp:ListItem>
                                    <asp:ListItem Text="Is Not Null" meta:resourcekey="rdbIsNotNull" Value="IsNotNull"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
