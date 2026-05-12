<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WBSTemplate.ascx.vb" Inherits="Website.WBSTemplate" %>
<asp:Label runat="server" ID="lblName"></asp:Label>
<style>
    .LinkBtnWbs{
        color:white !important;
    }
</style>
<asp:Panel runat="server" ID="pnlEditMode" Visible="false" DefaultButton="btnClickSave">
    <table style="width: 330px" cellspacing="0" cellpadding="1">
        <tr class="Toolbar">

            <td style="width: 110px">
                <asp:Label runat="server" meta:Resourcekey="lblCode" ID="lblCode" Text="Code*"></asp:Label>
            </td>
            <td style="width: 220px">
                <asp:Label runat="server" meta:Resourcekey="lblDescription" ID="lblDescription" Text="Description"></asp:Label>
            </td>
            <td align="right">
                <asp:LinkButton runat="server" ID="btnSave" meta:Resourcekey="btnSave" ValidationGroup="NodeSave" Text="Save" CssClass="LinkBtnWbs"></asp:LinkButton>&nbsp;|&nbsp;<asp:LinkButton runat="server" ID="btnCancel" meta:Resourcekey="btnCancel" Text="Cancel" CssClass="LinkBtnWbs"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <div class="NoWrap" style="background-color: White; border-width: 1px; padding-left: 1px; border-style: solid; border-color: #c4dbf9">
                    <asp:Label runat="server" ID="lblParentCode" Style="margin-right: -3px; color: black;"></asp:Label>
                    <asp:TextBox runat="server" Width="100px" ID="txtCode" Height="13px" MaxLength="50" TabIndex="1" Style="border: 0px; margin-left: 0px; padding-left: 0px; outline: none;"></asp:TextBox>
                </div>
            </td>
            <td colspan="2">
                <div class="NoWrap" style="background-color: White; border-width: 1px; padding-left: 1px; border-style: solid; border-color: #c4dbf9">
                    <asp:TextBox runat="server" Width="215px" Height="14px" ID="txtDescription" MaxLength="500" TabIndex="2" style="outline:none;border:none;"></asp:TextBox>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">

                <div>
                    <asp:Label runat="server" ID="lblcodeunique" meta:Resourcekey="lblcodeunique" CssClass="Validator" Text="Code must be unique." Visible="false"></asp:Label>
                </div>
                <asp:RequiredFieldValidator ID="rfvCode" meta:Resourcekey="rfvCode" runat="server" ErrorMessage="Required." CssClass="Validator" Display="Dynamic"
                    ControlToValidate="txtCode" ValidationGroup="NodeSave"></asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator ID="revCode" meta:resourceKey="revCode" CssClass="Validator" Display="Dynamic"
                    ControlToValidate="txtCode" ValidationExpression="^[^.-]+$"
                    runat="server" ErrorMessage="Incorrect Code Format" ValidationGroup="NodeSave">   </asp:RegularExpressionValidator>

            </td>

        </tr>

    </table>

    <asp:Button runat="server" CssClass="Hide" ValidationGroup="NodeSave" ID="btnClickSave" />

</asp:Panel>
<asp:HiddenField runat="server" ID="hdnId" />
<asp:HiddenField runat="server" ID="hdnParentId" />
<asp:HiddenField runat="server" ID="hdnType" />
