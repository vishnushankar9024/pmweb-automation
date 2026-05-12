<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsDetails.ascx.vb" Inherits="Website.VendorApprovalsDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>




<fieldset id="fldPrimary" runat="server">
    <legend>
        <asp:Label runat="server" ID="lblPrimary" meta:resourcekey="lblPrimary" Text="Primary (From Addresses Tab)"></asp:Label>
    </legend>
    <table class="colTable">
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblAddress" runat="server" meta:resourcekey="lblAddress" Text="Address"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtAddress" MaxLength="100" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth"></td>
            <td class="controlWidth">
                <asp:TextBox ID="txtAddressDetails" runat="server" MaxLength="500" Height="80px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhone" Text="Phone"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtPhone" MaxLength="50" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblExt" meta:resourcekey="lblExtension" runat="server" Text="Extension"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtExt" MaxLength="10" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblFax" runat="server" meta:resourcekey="lblFax" Text="Fax"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtFax" MaxLength="50" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblAltPhone" runat="server" meta:resourcekey="lblAltPhone" Text="Alt. Phone"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmail" Text="Email"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtEmail" MaxLength="100" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblWebsite" runat="server" meta:resourcekey="lblWebsite" Text="Website"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtWebsite" MaxLength="250" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</fieldset>



<%--  <td valign="Top">
            <asp:Panel runat="server" ID="pnlSpecification">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 700px; vertical-align: top;" valign="top">
                            <uc1:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>--%> 
