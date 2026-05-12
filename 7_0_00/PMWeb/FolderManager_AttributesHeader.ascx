<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FolderManager_AttributesHeader.ascx.vb" Inherits="Website.FolderManager_AttributesHeader" %>

<table class="colTable" id="tblHeaderAttributes" runat="server">
    <tr>
        <td>
            <asp:Repeater runat="server" ID="rptHeaderAttributes">
                <ItemTemplate>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblAttribute" runat="server" />
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtAttribute" Visible="false" MaxLength="4000" runat="server"></asp:TextBox>
                            <asp:CheckBox ID="chkAttribute" Visible="false" runat="server" />
                            <asp:TextBox ID="txtDate" MaxLength="100" Style="text-align: right" Visible="false" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                            <telerik:RadDatePicker ID="rdpAttribute" MinDate="01/01/1901" Visible="false"
                                MaxDate="12/31/2100" runat="server" Skin="Default">
                                <Calendar runat="server" Width="200px"></Calendar>
                                <ClientEvents OnDateSelected="dateSelected" />
                            </telerik:RadDatePicker>
                            <telerik:RadComboBox MarkFirstMatch="True" Filter="Contains" AllowCustomText="True"
                                sNoWrap="true" ID="ddlAttribute" runat="server" Width="100%" Height="400px" Visible="false" Skin="Default"
                                ShowMoreResultsBox="True" EnableVirtualScrolling="True">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="rfvMeasure" runat="server" ControlToValidate="" Enabled="false"
                                CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="csvMeasure" runat="server" ControlToValidate="ddlAttribute"
                                ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, INVALID_DATA%>">
                            </asp:CustomValidator>
                            <asp:Label ID="lblUnique" runat="server" Text="Should be unique in this folder" CssClass="Validator" Visible="False" meta:Resourcekey="lblUnique"></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
</table>
