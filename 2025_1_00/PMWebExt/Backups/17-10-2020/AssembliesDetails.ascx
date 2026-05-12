<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssembliesDetails.ascx.vb"
    Inherits="Website.AssembliesDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Panel ID="pnlAssemblyDetails" runat="server">
    <div class="PMHeader">
        <div class="row">
            <div class="col-12 ResponsiveMargin">
                <telerik:RadGrid ID="rdgAssemblyDetails" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                    Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" PageSize="15" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                    AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True"
                    GridLines="None" UseEditFormInMobile="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                    <ClientSettings>
                        <Resizing AllowColumnResize="True" />
                    </ClientSettings>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CommandItemDisplay="Top" EnableHeaderContextMenu="true" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Item" DataField="ItemId" ItemStyle-HorizontalAlign="Right"
                                SortExpression="ItemId" UniqueName="ItemId" Groupable="false">
                                <EditItemTemplate>
                                    <%# Container.DataItem("ItemId").ToString %>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Container.DataItem("ItemId").ToString %>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Description" DataField="Description"
                                SortExpression="Description" UniqueName="Description" Groupable="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" runat="server" MaxLength="200" Text='<%# Container.DataItem("Description") %>' Width="99%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <span><%# Container.DataItem("Description") %></span>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Default Cost" Groupable="false" SortExpression="DefaultCost" DataField="DefaultCost" UniqueName="DefaultCost">
                                <EditItemTemplate>
                                    <%#FormatNumber(CDbl(Container.DataItem("DefaultCost")))%>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#FormatNumber(CDbl(Container.DataItem("DefaultCost")))%>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="UOM" DataField="UOM"
                                SortExpression="UOM" UniqueName="UOM" Groupable="false">
                                <EditItemTemplate>
                                    <%# IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM")) %>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM")) %>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Quantity" DataField="FixedQuantity"
                                SortExpression="FixedQuantity" UniqueName="Quantity" Groupable="false">
                                <EditItemTemplate>
                                    <table>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>

                                    <div style="float: left">
                                        <telerik:RadComboBox ID="ddlVariables" runat="server"></telerik:RadComboBox>
                                    </div>
                                    <div style="float: left">
                                        <asp:TextBox ID="txtFixedQuantity" runat="server" CssClass="PositiveInteger" MaxLength="9" Width="50px"
                                            Text='<%# Container.DataItem("FixedQuantity") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblQuantity" runat="server" CssClass="Right"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                                <ItemStyle Wrap="False" HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes"
                                SortExpression="Notes" UniqueName="Notes" Groupable="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Container.DataItem("Notes") %>' Width="99%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes")) %></span>
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                UpdateImageUrl="Update.gif">
                            </EditColumn>
                        </EditFormSettings>
                        <CommandItemTemplate>
                            <div style="padding: 2px">

                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible="<%# rdgAssemblyDetails.EditIndexes.Count = 0 And (Not rdgAssemblyDetails.MasterTableView.IsItemInserted) %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                </asp:LinkButton>

                                <asp:LinkButton ID="hplAddItems" runat="server" CausesValidation="false" CommandName="AddItems" CssClass="GridCmdAddItems"
                                    OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Assembly', 910, 600, true);"
                                    SecurityButtonType="ItemMode_Add" Visible="<%# rdgAssemblyDetails.EditIndexes.Count = 0 And (Not rdgAssemblyDetails.MasterTableView.IsItemInserted) %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                    OnClientClick="return ConfirmDelete()" SecurityButtonType="ItemMode_Delete" Visible="<%# rdgAssemblyDetails.EditIndexes.Count = 0 And (Not rdgAssemblyDetails.MasterTableView.IsItemInserted) %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible="<%# rdgAssemblyDetails.EditIndexes.Count = 0 And (Not rdgAssemblyDetails.MasterTableView.IsItemInserted) %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible="<%# rdgAssemblyDetails.EditIndexes.Count > 0 %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible="<%# rdgAssemblyDetails.EditIndexes.Count > 0 Or rdgAssemblyDetails.MasterTableView.IsItemInserted %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                </asp:LinkButton>
                                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                    EnableShadows="true" CausesValidation="false"
                                    Visible="true">
                                </telerik:RadMenu>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt" />
                    <ClientSettings>
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                    </ClientSettings>

                </telerik:RadGrid>
            </div>
        </div>
    </div>


</asp:Panel>
