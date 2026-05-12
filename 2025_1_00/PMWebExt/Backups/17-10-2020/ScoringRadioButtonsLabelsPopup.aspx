<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ScoringRadioButtonsLabelsPopup.aspx.vb" Inherits="Website.ScoringRadioButtonsLabelsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function SaveRadioButtonsLabels(Options) {
                $(window.parent.document)[0].getElementById(querySt('hdnOptions')).value = Options;
                $(window.parent.document)[0].getElementById(querySt('txtOptions')).value = ReplaceAllString(Options, '$$', ';');
                return false;
            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }


        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rdgLabels" runat="server" AllowMultiRowEdit="true"
                                                AllowMultiRowSelection="True" AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8"
                                                ShowStatusBar="True" Width="100%">
                                                <HeaderStyle Font-Size="8pt" />
                                                <ClientSettings Selecting-AllowRowSelect="true" AllowRowsDragDrop="true" ClientEvents-OnRowDblClick="RowDblClick">
                                                    <Selecting AllowRowSelect="True" />
                                                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                                </ClientSettings>
                                                <MasterTableView CommandItemDisplay="Top" CssClass="MaxWidth" DataKeyNames="Id" EditMode="InPlace">
                                                    <CommandItemStyle />
                                                    <CommandItemTemplate>
                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                            SecurityButtonType="ItemMode_Edit" Visible="<%# rdgLabels.EditIndexes.Count = 0 And (Not rdgLabels.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblEditSelected" Text="Edit Selected Lines"></asp:Label>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                            SecurityButtonType="ItemMode_Add" Visible="<%# rdgLabels.EditIndexes.Count = 0 And (Not rdgLabels.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblAdd" Text="Add Line"></asp:Label>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                            SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                            Visible="<%# rdgLabels.EditIndexes.Count = 0 And (Not rdgLabels.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblDelete"></asp:Label>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" meta:resourcekey="btnSaveResource1" ValidationGroup="SaveRow"
                                                            Visible="<%# rdgLabels.MasterTableView.IsItemInserted %>" CausesValidation="true">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblSave"></asp:Label>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="PerformUpdate" CssClass="GridCmdPerformUpdate" Visible="<%# rdgLabels.EditIndexes.Count > 0 %>" ValidationGroup="SaveRow" CausesValidation="true">
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="" runat="server" ID="lblUpdate"></asp:Label>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                            Visible="<%# rdgLabels.EditIndexes.Count > 0 OrElse rdgLabels.MasterTableView.IsItemInserted %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblCancel" Text="Cancel"></asp:Label>
                                                        </asp:LinkButton>
                                                    </CommandItemTemplate>
                                                    <Columns>
                                                        <telerik:GridTemplateColumn UniqueName="Label" HeaderText="Label"
                                                            ItemStyle-Width="120px" HeaderStyle-Width="120px">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLabel" runat="server" Text='<%#Eval("Label")%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtLabel" MaxLength="500" runat="server" Text='<%#Eval("Label")%>'
                                                                    Width="98%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
