<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationCustomLinks.ascx.vb" Inherits="Website.ApplicationCustomLinks" %>

 <fieldset runat="server" id="fldTitle" style="width:855px;">
    <legend><asp:Label runat="server" ID="lblTitle"></asp:Label></legend>
    <table cellpadding="0" cellspacing="0" runat="server" id="tbl">
        <tr>
            <td style="height:30px;">
                <asp:HyperLink ID="hplCustomLink" runat="server" style="cursor:pointer; text-decoration:none;" Target="_blank" ></asp:HyperLink>
            </td>
        </tr>
    </table>
 </fieldset>
<div  id="S_10">
<table cellpadding="0" cellspacing="0" runat="server">
<tr>
    <td style="padding-top:10px;">
        <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
    </td>
</tr>
 </table>
</div>
 