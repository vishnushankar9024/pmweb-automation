<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostWorksheetColumns.ascx.vb" Inherits="Website.CostWorksheetColumns" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCostWorksheetColumns">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostWorksheetColumns" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgCostWorksheetColumns" runat="server" SetWidth="true" AppendMenus="true" 
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                PageSize="250" AllowPaging="true" ShowFooter="False" ShowGroupPanel="False" Width="100%" ClientSettings-Scrolling-AllowScroll="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="False"
                GroupingEnabled="false" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Column #" UniqueName="ColumnNumber">
                            <ItemTemplate>
                                <%#IIf(CStr(Eval("ColumnNumber")) = String.Empty, "&nbsp;", Eval("ColumnNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>

                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="System Field*" UniqueName="SystemField">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SystemField") = String.Empty, "&nbsp;", Container.DataItem("SystemField"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlSystemFields" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" DropDownCssClass="ddlTreeviewTemplate"
                                    NoWrap="True" Style="font-size: 11px"
                                    OnClientLoad="ddlSystemFields_OnLoad"
                                    OnClientDropDownOpened="ddlSystemFields_OnClientDropDownOpenedHandler">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" />
                                        <%--<telerik:RadComboBoxItem Text='<%# PM.LanguagesInfo.DASHSELECT %>' Value="0" runat="server"/>--%>
                                    </Items>
                                    <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvSystemFields" Skin="Default" runat="server" Width="100%"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false"
                                            OnClientLoad="rdvSystemFields_OnLoad"
                                            OnNodeDataBound="rdvSystemFields_NodeDataBound">
                                        </telerik:RadTreeView>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <div>
                                    <asp:CustomValidator runat="server" ID="cvSystemField" CssClass="Validator"
                                        ClientValidationFunction="CheckSystemField" meta:resourcekey="cvSystemFieldRequired" ErrorMessage="Enter a system field" Display="Dynamic" ValidationGroup="CostWorksheetColumns" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Column Name*" UniqueName="ColumnName">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ColumnName") = String.Empty, "&nbsp;", Container.DataItem("ColumnName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtColumnName" runat="server" MaxLength="100"
                                    Text='<%#Eval("ColumnName")%>' Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvColumnName"
                                        runat="server" ControlToValidate="txtColumnName" CssClass="Validator"
                                        ErrorMessage="Enter the column name" meta:resourcekey="rfvColumnNameRequired" Display="Dynamic" ValidationGroup="CostWorksheetColumns">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Calculation" UniqueName="Calculation">
                            <ItemTemplate>
                                <asp:Label ID="lblCalculationText" runat="server"></asp:Label>&nbsp;                               
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCalculation" runat="server" TextMode="MultiLine" Rows="3" Height="51px" onkeypress="return IsNumber(event)"
                                    Width="80%" Style="display: inline;" MaxLength="1000"></asp:TextBox>

                                  <asp:LinkButton runat="server" ID="btnGenerateCalculation" CssClass="SearchButton" OnClientClick="return openCalculationPopup(this.id)">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                                <%--<asp:RequiredFieldValidator ID="rfvCalculation" 
                                    runat="server" ControlToValidate="txtCalculation" CssClass="Validator" 
                                    ErrorMessage="Enter the calculation" Display="Dynamic" ValidationGroup="CostWorksheetColumns">
                                </asp:RequiredFieldValidator>--%>
                                <div>
                                    <asp:CustomValidator runat="server" ID="cvCalculation" ControlToValidate="txtCalculation" CssClass="Validator"
                                        OnServerValidate="cvCalculation_ServerValidate" ValidationGroup="CostWorksheetColumns" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Symbol" UniqueName="Symbol">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SymbolId") = 0, "&nbsp;", Container.DataItem("Symbol"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlSymbols" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="False" Style="font-size: 11px" Height="250px"
                                    OnClientLoad="ddlSymbols_Load">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvSymbols" runat="server" ControlToValidate="ddlSymbols"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources: WarningMsg_SymbolRequired%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="CostWorksheetColumns"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvSymbols" runat="server" ControlToValidate="ddlSymbols"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="CostWorksheetColumns" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources: WarningMsg_SymbolRequired%>">
                                    </asp:CustomValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Alias" UniqueName="Alias">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("HeaderAlias") = String.Empty, "&nbsp;", Container.DataItem("HeaderAlias"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAlias" runat="server" Text='<%#Eval("HeaderAlias")%>'
                                    Width="100%" MaxLength="100"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Column Size" UniqueName="ColumnSize">
                            <ItemTemplate>
                                <%#CStr(Container.DataItem("ColumnSize"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtColumnSize" runat="server" Text='<%#Eval("ColumnSize")%>'
                                    Width="100%" CssClass="PositiveInteger" MaxLength="3"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvColumnSize"
                                        runat="server" ControlToValidate="txtColumnSize" CssClass="Validator"
                                        ErrorMessage="Enter the column size" meta:resourcekey="rfvColumnSizeRequired" Display="Dynamic" ValidationGroup="CostWorksheetColumns">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="Visible">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Visible")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkVisible" CssClass="mobile-switch" Checked='<%# CBool(IIf(Eval("Visible") Is System.DBNull.Value, 1, Eval("Visible")))%>' runat="server" Enabled='<%# If(Eval("SystemField") IsNot System.DBNull.Value AndAlso Eval("SystemField") = "Cost Code", False, True)%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tooltip" UniqueName="Tooltip">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Tooltip") = String.Empty, "&nbsp;", Container.DataItem("Tooltip"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTooltip" runat="server" Text='<%#Eval("Tooltip")%>'
                                    Width="100%" MaxLength="100"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>'
                                    Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <ItemStyle Wrap="false" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="ColumnNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count = 0 AND (Not rdgCostWorksheetColumns.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelected" runat="server" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="CostWorksheetColumns"
                                SecurityButtonType="AddEditMode_Edit" OnClientClick="return CheckValidation();"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateEdited" runat="server" Text="Update records"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="CostWorksheetColumns"
                                SecurityButtonType="AddEditMode_Add" OnClientClick="return CheckValidation();"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgCostWorksheetColumns.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count > 0 Or rdgCostWorksheetColumns.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count = 0 AND (Not rdgCostWorksheetColumns.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count = 0 And (Not rdgCostWorksheetColumns.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgCostWorksheetColumns.EditIndexes.Count = 0 AND (Not rdgCostWorksheetColumns.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>

                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" ClientEvents-OnRowDblClick="RowDblClick"
                    AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
                <%--<ValidationSettings ValidationGroup="CostWorksheetColumns" EnableValidation="true" CommandsToValidate="SaveChanges" />--%>
            </telerik:RadGrid>
        </div>
    </div>
</div>
