<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Currencies.aspx.vb" Inherits="Website.Currencies" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCurrency">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCurrency" LoadingPanelID="ldpCurrenc" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpCurrenc" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Office2007" />

    <telerik:RadGrid ID="rdgCurrency" Width="99%" runat="server" EnableEmbeddedSkins="False"
                        Skin="PM" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                        AllowSorting="True" GridLines="None">
        <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                            UseAllDataFields="True" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                            EnableHeaderContextMenu="True">
            <Columns>
                <telerik:GridTemplateColumn  HeaderText="Currency Name">
                    <EditItemTemplate>
                    <asp:TextBox runat="server" ID="txtCurrencyName" Width="99%" Text='<%# Eval("Name") %>' MaxLength="100" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CurrencyName" runat="server" ControlToValidate="txtCurrencyName"  ErrorMessage="Required"
                                            CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="txtCurrencyName"  Text='<%# Eval("Name") %>' ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn SortExpression="Code" HeaderText="Code">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCode" runat="server" Width="99%" MaxLength="10" Text='<%# Eval("Code") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"   ErrorMessage="Required"
                                            CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Label runat="server" ID="lblCode"  Text='<%#Container.DataItem("Code")%>' />
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn  SortExpression="Symbol" UniqueName="Symbol"
                                    HeaderText="Currency Symbol">
                    <EditItemTemplate>
                       <asp:TextBox ID="txtSymbol" Width="99%" runat="server" MaxLength="10" Text='<%# Eval("Symbol") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSymbol" runat="server" ControlToValidate="txtSymbol" ErrorMessage="Required"
                                            CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblSymbol" Text='<%# Eval("Symbol") %>' ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn  SortExpression="SymbolPosition" UniqueName="SymbolPosition"
                                    HeaderText="Symbol Position">
                    <EditItemTemplate>
                        <asp:RadioButton ID="rdoLTR" runat="server" GroupName="SymbolPosition" Checked='<%# If(Eval("SymbolPosition") is System.DBNull.Value, True, If(Eval("SymbolPosition") = "LEFT", True, False)) %>'
                                            Text="LEFT" />
                        <asp:RadioButton ID="rdoRTL" runat="server" GroupName="SymbolPosition" Checked='<%# If(Eval("SymbolPosition") is System.DBNull.Value, False, If(Eval("SymbolPosition") = "RIGHT", True, False)) %>'
                                            Text="RIGHT" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <%#Container.DataItem("SymbolPosition")%>
                    </ItemTemplate>
                    <HeaderStyle Width="15%" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn  SortExpression="Rate" HeaderText="Rate"
                                    UniqueName="Rate">
                    <EditItemTemplate>
                       <asp:TextBox ID="txtRate" Width="99%"  CssClass="PositiveDouble" runat="server" MaxLength="50" precision="16" Text='<%# Eval("Rate") %>'></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfvRate" runat="server" ControlToValidate="txtRate" ErrorMessage="Required"
                                            CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblRate"  Text='<%# Eval("Rate") %>' ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="10%" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn  SortExpression="IsDefault" HeaderText="Default"
                                    UniqueName="TemplateColumn4">
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkDefault" runat="server" Checked='<%# IIf(Eval("IsDefault") is system.DBNULL.value, False, Eval("IsDefault")) %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <img src='Images/Global/<%# CStr(IIF(Eval("IsDefault"),"checked.gif" , "unchecked.gif")) %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="10%" />
                    <ItemStyle HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                    UpdateImageUrl="Update.gif">
                </EditColumn>
            </EditFormSettings>
            <CommandItemTemplate>
                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                        Visible="<%# rdgCurrency.EditIndexes.Count = 0 AND (Not rdgCurrency.MasterTableView.IsItemInserted) %>">
                    <img src="Images/Global/EditLine.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDeleteSelected" runat="server" CausesValidation="False"  OnClientClick="Javascript:return confirm('Are you sure you want to delete this Currency?')"
                                        CommandName="DeleteRows" Visible="<%# rdgCurrency.EditIndexes.Count = 0 AND (Not rdgCurrency.MasterTableView.IsItemInserted) %>">
                    <img src="Images/Global/DeleteLine.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited"
                                        Visible="<%# rdgCurrency.EditIndexes.Count > 0 %>">
                    <img alt="" src="Images/Global/save.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert"
                                        Visible="<%# rdgCurrency.MasterTableView.IsItemInserted %>">
                    <img alt="" src="Images/Global/save.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                        Visible="<%# rdgCurrency.EditIndexes.Count > 0 Or rdgCurrency.MasterTableView.IsItemInserted %>">
                    <img alt="" src="Images/Global/cancel.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow"
                                        Visible="<%# rdgCurrency.EditIndexes.Count = 0 AND (Not rdgCurrency.MasterTableView.IsItemInserted) %>">
                    <img alt="" src="Images/Global/AddLine.gif" style="border: 0px; vertical-align: middle;" />
                    <asp:Label ID="lblAddLine" runat="server" Text="Add New Currency"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <HeaderStyle Font-Size="8pt"></HeaderStyle>
        <FilterMenu Skin="Office2007" EnableTheming="True" EnableEmbeddedSkins="False">
            <CollapseAnimation Type="OutQuint" Duration="200">
            </CollapseAnimation>
        </FilterMenu>
        <HeaderContextMenu EnableEmbeddedSkins="False">
        </HeaderContextMenu>
        <ClientSettings AllowColumnHide="False" Selecting-AllowRowSelect="True" AllowColumnsReorder="False"
                            AllowDragToGroup="False" Resizing-AllowColumnResize="False">
            <Resizing AllowColumnResize="False">
            </Resizing>
            <Selecting AllowRowSelect="True">
            </Selecting>
        </ClientSettings>
    </telerik:RadGrid>

</asp:Content>

