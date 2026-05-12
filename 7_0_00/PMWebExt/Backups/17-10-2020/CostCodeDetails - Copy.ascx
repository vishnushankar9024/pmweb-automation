<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostCodeDetails.ascx.vb" Inherits="Website.CostCodeDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCostCodes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostCodes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgCostCodes" runat="server" SetWidth="true" AppendMenus="true" HasPasteFromExcel="true"
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                PageSize="20" AllowPaging="true" ShowFooter="false" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id, IsUsed" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="" DataField="Inactive" UniqueName="Inactive" HeaderStyle-Width="178px" ItemStyle-Wrap="false"
                            Groupable="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                            <HeaderTemplate>
                                <div style="text-align:center;">
                                    <asp:Label ID="lblInactive" runat="server" Text="Inactive"></asp:Label>                                        
                                    <div style="float:right;">
                                        <asp:CheckBox ID="chbAllInactive" runat="server" AutoPostBack="true" OnCheckedChanged="chbAllInactive_CheckedChanged" />
                                    </div>
                                </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbItemInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>' AutoPostBack="true" OnCheckedChanged="ChbItemInactiveChanged" runat="server" />
                                <%--<img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />--%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>' runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode" SortExpression="CostCode" Groupable="false">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("CostCode") Is DBNull.Value OrElse Container.DataItem("CostCode") = String.Empty, "&nbsp;", Eval("CostCode"))%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="168px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="CostCodeDescription" UniqueName="CostCodeDescription" GroupByExpression="CostCodeDescription [GridColumn_CostCodeDescription] Group By CostCodeDescription">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostCodeDescription") = String.Empty, "&nbsp;", Container.DataItem("CostCodeDescription"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%#Eval("CostCodeDescription")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="168px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" MaxLength="4000" TextMode="MultiLine" Height="14px" Text='<%#Eval("Notes")%>' Width="80%"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					<span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="168px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Account" UniqueName="Account" SortExpression="GLAccount" DataField="GLAccount" GroupByExpression="GLAccount [GridColumn_Account] Group By GLAccount">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("GLAccount") = String.Empty, "&nbsp;", Container.DataItem("GLAccount"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox MarkFirstMatch="False" Filter="Contains" AllowCustomText="True" ID="ddlGLAccount" runat="server" Width="100%" Height="200px" Skin="Default"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="168px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="CostCode"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgCostCodes.EditIndexes.Count = 0 AND (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCostCodes.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgCostCodes.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgCostCodes.EditIndexes.Count > 0 Or rdgCostCodes.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgCostCodes.EditIndexes.Count = 0 AND (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgCostCodes.EditIndexes.Count = 0 And (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgCostCodes.EditIndexes.Count = 0 AND (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCopyFromProject" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenBudgetCodePopUp();"
                                CommandName="CopyFromProject">
                                <asp:Label ID="lblCopyFromProject" runat="server" Text="Copy From Project" meta:resourcekey="lblCopyFromProject"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgCostCodes.EditIndexes.Count = 0 AND (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Export To Exel" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgCostCodes.EditIndexes.Count = 0 And (Not rdgCostCodes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false"
                    AllowDragToGroup="true" AllowRowsDragDrop="false">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />

            </telerik:RadGrid>
        </div>
    </div>
</div>

<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />