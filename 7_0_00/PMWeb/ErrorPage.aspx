<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ErrorPage.aspx.vb" Inherits="Website.ErrorPage" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
     <table style="width:100%; height:400px">
        <tr style="vertical-align:middle; text-align:center">
            <td><asp:Label ID="lblMessage" runat="server" Text="The system could not process your request.<br>Check with your system administrator or verify your security settings." Font-Bold="true"
             ForeColor="" CssClass="Validator" ></asp:Label></td>
        </tr>
    </table>
</asp:Content>
