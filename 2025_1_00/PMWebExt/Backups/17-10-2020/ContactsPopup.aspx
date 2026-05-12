<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContactsPopup.aspx.vb" Inherits="Website.ContactsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ADD CONTACT</title>
     <script type="text/javascript">
        function CloseAndSave() {
            var btnSave = $(window.parent.document).find("[id$=btnSave]");
            CloseRadWnd();
            btnSave.click();
        }
    </script>
    <style type="text/css">
        .ToolbarSave .rtbIcon{
            background-position:192px 0 !important;
        }

        td.labelWidth{
            width:160px !important;
        }

        div.PMMainPage{
            padding-left:24px !important;
            padding-right:24px !important;
            margin-bottom:19px !important;
        }

    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

   
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
      <%--  <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpContacts" runat="server" Skin="Default" />--%>

        <%-- <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpContacts">--%>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">

                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save">
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
      
                                <div class="PMMainPage documentSinglePage">
                                    <div class="row">
                                        <div class="col-4 col-4-left">
                                            <table class="colTable" border="0">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblCompany" meta:resourcekey="lblCompany" runat="server" Text="Company"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                                            NoWrap="True" AllowCustomText="true"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested"
                                                            Style="font-size: 11px" Height="250px">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="rfvCompanies" runat="server" meta:resourcekey="rfvCompanies" ControlToValidate="ddlCompanies"
                                                            CssClass="Validator" ErrorMessage="Select Company" Display="Dynamic" ForeColor=""
                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblUsername" meta:resourcekey="lblUsername" runat="server" Text="Contact ID"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvUsername" meta:resourcekey="rfvUsername" runat="server" ControlToValidate="txtUserName" ValidationGroup="Save"
                                                            CssClass="Validator" ErrorMessage="Enter the User Name" Display="Dynamic"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="lblIDUnique" runat="server" Text="The ID must be unique" CssClass="Validator" Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblFirstName" meta:resourcekey="lblFirstName" runat="server" Text="First Name"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvFirstName" meta:resourcekey="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ValidationGroup="Save"
                                                            CssClass="Validator" ErrorMessage="Enter the First Name" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLastName" meta:resourcekey="lblLastName" runat="server" Text="Last Name"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblEmail" meta:resourcekey="lblEmail" runat="server" Text="Email"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="revEmail" CssClass="Validator" meta:resourcekey="revEmail" ControlToValidate="txtEmail"
                                                            ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"
                                                            runat="server" ValidationGroup="Save" ErrorMessage="example@domain.com"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td colspan="2" align="right" style="padding-right: 10px">
                                                        <asp:Button ID="btnSave" meta:resourcekey="btnSave" Text="Save" runat="server" ValidationGroup="Save" />&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" meta:resourcekey="btnCancel" Text="Cancel" runat="server" OnClientClick="CloseRadWnd();" />
                                                    </td>
                                                </tr>--%>
                                            </table>
                                        </div>
                                    </div>
                                </div>
         
        <%--</telerik:RadAjaxPanel>--%>
    </form>
</body>
</html>
