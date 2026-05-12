<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseLedger.ascx.vb" Inherits="Website.LeaseLedger" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <ajaxsettings>  
            <telerik:AjaxSetting AjaxControlID="rdgLeaseLedger" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLeaseLedger" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="ddlPostType" />
                </UpdatedControls> 
              
            </telerik:AjaxSetting>
      </ajaxsettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadGrid ID="rdgLeaseLedger"  runat="server"   AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true"    UseEditFormInMobile ="true"
    CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                ShowGroupPanel="True" AllowMultiRowEdit="True" PageSize="20" AllowPaging="true" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>  
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id,TransactionSource" CommandItemDisplay="Top"   
                                    InsertItemDisplay="Top" ShowGroupFooter ="False" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                                    EnableHeaderContextMenu="true" ShowFooter = "true">
                                    <Columns>    
                                        <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date" HeaderStyle-Width="120px" GroupByExpression="Date [GridColumn_Date] Group By Date ASC" SortExpression="Date"
                                            DataField="Date" Reorderable="true" ItemStyle-HorizontalAlign="Right"  Groupable="true" AllowFiltering="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%#FormatDate(Container.DataItem("Date"))%>&nbsp;</span>  
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker ID="dtpDate"  AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                    <DateInput ID="DateInput2"  Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                                </telerik:RadDatePicker>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Transaction Source" UniqueName="TransactionSource" DataField="TransactionTrans"
                                            SortExpression="TransactionTrans" GroupByExpression="TransactionTrans [GridColumn_TransactionSource] Group By TransactionTrans ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                <span><%#Eval("TransactionTrans").ToString%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <%# Eval("TransactionTrans")%>&nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                                            SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                <asp:Label ID="lblType" runat ="server" Text='<%# Eval("Type").ToString%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <%# Eval("Type")%>&nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" ItemStyle-Wrap="false" HeaderText="Invoice" UniqueName="Invoice" DataField="Invoice"
                                            SortExpression="Invoice" GroupByExpression="Invoice [GridColumn_Invoice] Group By Invoice ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                    <span><%#Eval("Invoice").ToString%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtInvoice" MaxLength="500" runat="server" Text='<%# Eval("Invoice") %>' Width="100%" ></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="ID" ItemStyle-Wrap="false" UniqueName="ID" DataField="ID"
                                            SortExpression="ID" GroupByExpression="ID [GridColumn_ID] Group By ID ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                <a id="hypCode"  href='<%#Eval("PostBackUrl")%>'> <%# IIf(CStr(Eval("RecordNumber")) = String.Empty, "&nbsp;", Eval("RecordNumber"))%></a>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                               <span><%# IIf(Eval("RecordNumber").ToString = String.Empty, "&nbsp;", Eval("RecordNumber").ToString)%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                <span><%#Eval("Description").ToString%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Amount" ItemStyle-Wrap="false" UniqueName="Amount" DataField="Amount"
                                            FooterAggregateFormatString="{0:F6}" Aggregate="Sum" SortExpression="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC" ItemStyle-HorizontalAlign="Right"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%# FormatCurrency(Eval("Amount"))%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Amount"))%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Balance" ItemStyle-Wrap="false" UniqueName="Balance" DataField="Balance"
                                            SortExpression="Balance" GroupByExpression="Balance [GridColumn_Balance] Group By Balance ASC" ItemStyle-HorizontalAlign="Right"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                              <span><%# FormatCurrency(Eval("Balance"))%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                   <span><%# FormatCurrency(Eval("Balance"))%>&nbsp;</span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DateDue" HeaderStyle-Width="120px" SortExpression="DateDue"
                                            GroupByExpression="DateDue [GridColumn_DateDue] Group By DateDue ASC" DataField="DateDue"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" ItemStyle-HorizontalAlign="Right" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%#FormatDate(Container.DataItem("DateDue"))%>&nbsp;</span> 
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker ID="dtpDueDate"  AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                    <DateInput ID="DateInput2"  Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                                </telerik:RadDatePicker>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Days Overdue" UniqueName="DaysOverdue" DataField="DaysOverdue"
                                            HeaderStyle-Width="120px" SortExpression="DaysOverdue" GroupByExpression="DaysOverdue [GridColumn_DaysOverdue] Group By DaysOverdue ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("DaysOverdue") < 0, 0, Container.DataItem("DaysOverdue"))%>&nbsp;</span> 
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblDaysOverdue" runat ="server"  Width="100%" ></asp:Label>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false"  HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                                            SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                                </asp:HyperLink>
                                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" 
                                                    EnableItemCaching="false"  OnItemsRequested="ddl_ItemsRequested"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Cost Period" UniqueName="CostPeriod" DataField="CostPeriod"
                                            SortExpression="CostPeriod" GroupByExpression="CostPeriod [GridColumn_CostPeriod] Group By CostPeriod ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate> 
                                                    <span><%# Eval("CostPeriod").ToString%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                 <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="100px" 
                                                    EnableItemCaching="false"  OnItemsRequested="ddl_ItemsRequested"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%#Eval("Notes").ToString%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                                               
                                           <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                                 </EditItemTemplate>
                                            <HeaderStyle Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Workflow Status" ItemStyle-Wrap="false" UniqueName="Status" DataField="Status"
                                            SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                                            Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <span><%#Eval("Status").ToString%>&nbsp;</span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                &nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="System ID" ItemStyle-Wrap="false" UniqueName="SystemID" DataField="Id" SortExpression="Id"
                                            GroupByExpression="Id [GridColumn_SystemID] Group By Id ASC"
                                            Groupable="false" Reorderable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                                            <ItemTemplate> 
                                                <span><%# Eval("Id").ToString%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%# Eval("Id").ToString%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Batch ID" ItemStyle-Wrap="false" UniqueName="BatchID" DataField="BatchID" Groupable="false"
                                            GroupByExpression="BatchID [GridColumn_BatchID] Group By BatchID ASC"
                                            Reorderable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                                            <ItemTemplate> 
                                             <a  href='<%#Eval("BatchPostBackUrl")%>'><%# IIf(CStr(Eval("BatchCode")) = String.Empty, "&nbsp;", Eval("BatchCode"))%></a>
                                            </ItemTemplate>
                                            <EditItemTemplate>&nbsp;</EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                <CommandItemTemplate>
                                    <div style="padding:2px">
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count = 0 AND (Not rdgLeaseLedger.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="ChargeSave" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>                               
                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="ChargeSave" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert"  CssClass="GridCmdPerformInsert" 
                                                        Visible='<%# rdgLeaseLedger.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll"  CssClass="GridCmdCancelAll" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count > 0 Or rdgLeaseLedger.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>                            
                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count = 0 AND (Not rdgLeaseLedger.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count = 0 AND (Not rdgLeaseLedger.MasterTableView.IsItemInserted) %>'
                                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid" 
                                                        Visible='<%# rdgLeaseLedger.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>                      
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
                                    </div>
                                </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="true"  Resizing-AllowColumnResize="true" AllowColumnsReorder="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                <ClientEvents OnRowSelecting="Ledger_OnRowSelecting" />
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                </telerik:RadGrid>