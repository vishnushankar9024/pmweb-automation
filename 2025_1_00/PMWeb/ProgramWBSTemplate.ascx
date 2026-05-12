<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProgramWBSTemplate.ascx.vb" Inherits="Website.ProgramWBSTemplate" %>
<asp:Label runat="server" ID="lblName"></asp:Label>
<asp:Panel runat="server" ID="pnlEditMode" Visible="false" DefaultButton="btnClickSave" >
<table style="width:330px" cellspacing="0" cellpadding="1">
<tr class="Toolbar">

<td style="width:110px">
<asp:Label runat="server" ID="lblCode" Text="Code*"></asp:Label>
</td>
<td style="width:220px">
<asp:Label runat="server" ID="lblDescription" Text="Description"></asp:Label>
</td>
<td align="right">
<asp:LinkButton runat="server" ID="btnSave" ValidationGroup="NodeSave" Text="Save"></asp:LinkButton>&nbsp;|&nbsp;
<asp:LinkButton runat="server" ID="btnCancel" Text="Cancel"></asp:LinkButton>
</td>
</tr>
<tr>
<td>
<asp:TextBox runat="server" Width="100px" ID="txtCode" MaxLength="50" TabIndex="1"></asp:TextBox>

</td>
<td colspan = "2">
<asp:TextBox runat="server" Width="215px" ID="txtDescription" MaxLength="500" TabIndex="2"></asp:TextBox>
</td>
</tr>
<tr>
<td colspan="2" >
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required." CssClass="Validator" Display="Dynamic" 
 ControlToValidate="txtCode" ValidationGroup="NodeSave"></asp:RequiredFieldValidator>
 <div>
 <asp:Label runat="server" ID="lblcodeunique" CssClass="Validator" Text="Code must be unique." Visible="false"></asp:Label>
 </div>
</td>
</tr> 
</table>

<asp:Button runat="server" CssClass="Hide" ValidationGroup="NodeSave" ID="btnClickSave" />

</asp:Panel>
<asp:HiddenField runat="server" ID="hdnId" />
<asp:HiddenField runat="server" ID="hdnParentId" />