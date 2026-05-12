<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementAPPaymentApplication.ascx.vb" Inherits="Website.CostManagementAPPaymentApplication" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAPPaymentApplication">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAPPaymentApplication" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblCurrency" />
                <telerik:AjaxUpdatedControl ControlID="tblRecap" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgAPPaymentApplication" Width="100%" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
       AutoGenerateColumns="False" ShowFooter="true" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
    AllowPaging="True" PageSize="20" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true"
    UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <GroupPanel Text="Group by"></GroupPanel>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace" ShowGroupFooter="true">

        <Columns>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="RecordNumber" ItemStyle-Wrap="false" HeaderText="ID" Groupable="true" Reorderable="true" AllowFiltering="false"
                SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                <ItemTemplate>
                    <a runat="server" id="hypID" href='<%#Eval("PostBackUrl")%>'><%# IIf(CStr(Eval("RecordNumber")) = String.Empty, "&nbsp;", Eval("RecordNumber"))%> </a>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtRecordNumber" MaxLength="30" runat="server" Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Status" ItemStyle-Wrap="false" HeaderText="Status" Groupable="true" Reorderable="true" DataField="Status"
                SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                <ItemTemplate>
                    <span><%# Eval("Status") & Eval("Steps")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Company" ItemStyle-Wrap="false" HeaderText="Company" Groupable="true" Reorderable="true" DataField="Company"
                SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Company")) = String.Empty, "&nbsp;", Eval("Company"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <div style="width: 100%; white-space: nowrap">
                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="85%" DropDownWidth="300px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" OnItemsRequested="ddl_ItemsRequested"
                            OnClientDropDownClosed="dllcompClientClosed" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            Style="font-size: 11px" Height="250px">
                        </telerik:RadComboBox>
                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')"
                             CssClass="SearchButton">
                   <span class="Icon"></span>
                  </asp:LinkButton>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                    </div>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Description" ItemStyle-Wrap="false" DataField="Description" HeaderText="Description" Groupable="true" Reorderable="true"
                SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="txtDescription" Width="100%" Text='<%# Eval("Description") %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" DataField="Currency" SortExpression="Currency" ItemStyle-Wrap="false"
                GroupByExpression="Currency [GridColumn_Currency] Group By Currency" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                Groupable="true" Reorderable="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="150px"
                        Skin="Default" Height="250px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="PaymentMethod" UniqueName="PaymentMethod" ItemStyle-Wrap="false" HeaderText="Payment Method" Groupable="true" Reorderable="true"
                SortExpression="PaymentMethod" GroupByExpression="PaymentMethod [GridColumn_PaymentMethod] Group By PaymentMethod ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("PaymentMethod")) = String.Empty, "&nbsp;", Eval("PaymentMethod"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPaymentMethod" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="100%"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="PaymentNumber" UniqueName="PaymentNumber" ItemStyle-Wrap="false" HeaderText="Payment #" Groupable="true" Reorderable="true"
                SortExpression="PaymentNumber" GroupByExpression="PaymentNumber [GridColumn_PaymentNumber] Group By PaymentNumber ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("PaymentNumber")) = String.Empty, "&nbsp;", Eval("PaymentNumber"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPaymentNumber" runat="server" MaxLength="50" Width="100%" Text='<%# Eval("PaymentNumber")%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentDate" ItemStyle-Wrap="false" HeaderText="Payment Date" Groupable="true" Reorderable="true" DataField="PaymentDate"
                SortExpression="PaymentDate" GroupByExpression="PaymentDate [GridColumn_PaymentDate] Group By PaymentDate ASC">
                <ItemTemplate>
                    <span><%# If(Eval("PaymentDate") Is DBNull.Value, "&nbsp;", FormatDate(Eval("PaymentDate")))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default">
                        <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                        <Calendar ID="Calendar3"  Skin="Default" runat="server"></Calendar>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="AppliedAmount" ItemStyle-Wrap="false" HeaderText="Payment Amount" Groupable="true" Reorderable="true"
                SortExpression="AppliedAmount" GroupByExpression="AppliedAmount [GridColumn_AppliedAmount] Group By AppliedAmount ASC"
                DataField="AppliedAmount" >
                <ItemTemplate>
                    <span><%# IIf(Eval("AppliedAmount") Is DBNull.Value, 0, FormatCurrency(Eval("AppliedAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId"))))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPaymentAmount" CssClass="Currency" runat="server" Width="100%" Text='<%# FormatCurrency(Eval("AppliedAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="CostCode" UniqueName="CostCode" ItemStyle-Wrap="false" HeaderText="Cost Code" Groupable="true" Reorderable="true"
                SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                <ItemTemplate>
                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                    </asp:HyperLink>
                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" DropDownWidth="300px"
                        EnableItemCaching="false" meta:Resourcekey="ddlCostCode"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." OnItemsRequested="ddl_ItemsRequested"
                        NoWrap="True" AllowCustomText="False" ValidationGroup="Save" Style="font-size: 11px" Height="250px"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="Period" UniqueName="Period" ItemStyle-Wrap="false" HeaderText="Period" Groupable="true" Reorderable="true"
                SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="300px"
                        EnableItemCaching="false" meta:Resourcekey="ddlPeriods"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." OnItemsRequested="ddl_ItemsRequested"
                        NoWrap="True" AllowCustomText="False" ValidationGroup="Save" Style="font-size: 11px" Height="250px"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="Type" UniqueName="Type" ItemStyle-Wrap="false" HeaderText="Type" Groupable="true" Reorderable="true"
                SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Type")) = String.Empty, "&nbsp;", Eval("Type"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="Category" UniqueName="Category" ItemStyle-Wrap="false" HeaderText="Category" Groupable="true" Reorderable="true"
                SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Category")) = String.Empty, "&nbsp;", Eval("Category"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="Reference" UniqueName="Reference" ItemStyle-Wrap="false" HeaderText="Reference" Groupable="true" Reorderable="true"
                SortExpression="Reference" GroupByExpression="Reference [GridColumn_Reference] Group By Reference ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Reference")) = String.Empty, "&nbsp;", Eval("Reference"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtReference" MaxLength="50" runat="server" Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" DataField="Notes" UniqueName="Notes" ItemStyle-Wrap="false" HeaderText="Notes" Groupable="true" Reorderable="true"
                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Notes")) = String.Empty, "&nbsp;", Eval("Notes"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Width="75%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>
                    <asp:LinkButton runat="server" ID="imgNotes"  OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" 
                        CssClass="SearchButton">
                   <span class="Icon"></span>
                  </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="70px" DataField="AppliedInFull" DataType="System.Boolean" ItemStyle-Wrap="false" HeaderText="Applied In Full" UniqueName="AppliedInFull" SortExpression="AppliedInFull" GroupByExpression="AppliedInFull [GridColumn_AppliedInFull] Group By AppliedInFull ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("AppliedInFull"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbAppliedInFull" runat="server" CssClass="mobile-switch" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Payment Amount Converted" UniqueName="AppliedAmountConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                ItemStyle-HorizontalAlign="Right" SortExpression="AppliedAmountConverted" DataField="AppliedAmountConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <asp:Label Text='<%#FormatCurrency(Eval("AppliedAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAppliedAmountConverted" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridBoundColumn Aggregate="SUM" DataField="AppliedAmount" Visible="False" />

        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />

        <CommandItemTemplate>
            <div style="padding:2px">
                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" CausesValidation="false"
                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgAPPaymentApplication.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode" Visible='<%#  rdgAPPaymentApplication.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add" Visible='<%#  (Not rdgAPPaymentApplication.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnApplyPayments" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="ApplyPayments" CssClass="GridCmdApplyPayments" OnClientClick="return OpenApplyAPPaymentsPopup();"
                    Visible='<%# rdgAPPaymentApplication.EditIndexes.Count = 0 AND (Not rdgAPPaymentApplication.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnApplyPayments">
                    <span class="Icon"></span>
                    <asp:Label ID="Label4" runat="server" meta:resourcekey="lblApplyPaymentsResource1" Text="Apply Payments"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%#  (Not rdgAPPaymentApplication.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1" SecurityButtonType="ItemMode">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
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
    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
        <Selecting AllowRowSelect="true" />
    </ClientSettings>
</telerik:RadGrid>