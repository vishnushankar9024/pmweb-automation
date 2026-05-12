<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementPaymentBatchesDetails.ascx.vb" Inherits="Website.CostManagementPaymentBatchesDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPayments" GroupingEnabled="true" runat="server" AutoGenerateColumns="False" AllowFilteringByColumn="true"
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" HasPasteFromExcel="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                PageSize="20" AllowPaging="true" ShowGroupPanel="True" AllowSorting="true"
                ShowStatusBar="true" ShowFooter="true" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true" ShowGroupFooter="true">

                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" Reorderable="true" UniqueName="LineNumber" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProgramName" ItemStyle-Wrap="false" HeaderText="Program*"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="ProgramName" GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC" DataField="ProgramName">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProgramName")) = String.Empty, "&nbsp;", Eval("ProgramName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProgram" OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged" AllowCustomText="true"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>


                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectFullName" ItemStyle-Wrap="false" HeaderText="Project"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC" DataField="ProjectFullName">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProjectFullName")) = String.Empty, "&nbsp;", Eval("ProjectFullName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjects" runat="server" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged" AutoPostBack="True" CausesValidation="False"
                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                    NoWrap="true" Skin="Default" Width="100%" DropDownWidth="400px" ShowMoreResultsBox="True"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Commitment" ItemStyle-Wrap="false" HeaderText="Commitment"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Commitment"
                            SortExpression="Commitment" GroupByExpression="Commitment [GridColumn_Commitment] Group By Commitment ASC">
                            <ItemTemplate>
                                <a id="hypLinkedCommitment" href='<%#Eval("CommitmentPostBackUrl")%>'>
                                    <%# IIf(CStr(Eval("Commitment")) = String.Empty, "&nbsp;", Eval("Commitment"))%></a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCommitment" Filter="Contains" OnSelectedIndexChanged="ddlCommitment_SelectedIndexChanged" MarkFirstMatch="true" AllowCustomText="true"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                    EnableLoadOnDemand="true" OnItemsRequested="CommitmentsLoadRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="LinkedInvoice" ItemStyle-Wrap="false" HeaderText="Linked A/P Invoice"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="LinkedInvoice"
                            SortExpression="LinkedInvoice" GroupByExpression="LinkedInvoice [GridColumn_LinkedInvoice] Group By LinkedInvoice ASC">
                            <ItemTemplate>
                                <a id="hypLinkedInvoice" href='<%#Eval("LinkedInvoicePostBackUrl")%>'>
                                    <%# IIf(CStr(Eval("LinkedInvoice")) = String.Empty, "&nbsp;", Eval("LinkedInvoice"))%></a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLinkedAPInvoice" Filter="Contains" OnSelectedIndexChanged="ddlLinkedAPInvoice_SelectedIndexChanged" MarkFirstMatch="true" AllowCustomText="true"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" OnItemsRequested="InvoicesLoadRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="RecordNumber" ItemStyle-Wrap="false" HeaderText="ID"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="RecordNumber"
                            SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                            <ItemTemplate>
                                <a id="hypCode" href='<%#Eval("PostBackUrl")%>'>
                                    <%# IIf(CStr(Eval("RecordNumber")) = String.Empty, "&nbsp;", Eval("RecordNumber"))%></a>
                            </ItemTemplate>
                            <EditItemTemplate>

                                <asp:TextBox ID="txtCode" runat="server" MaxLength="30" Text='<%#Eval("RecordNumber")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Company" ItemStyle-Wrap="false" HeaderText="Company"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Company"
                            SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Company")) = String.Empty, "&nbsp;", Eval("Company"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%" DropDownWidth="320px"
                                    CloseDropDownOnBlur="true" EmptyMessage="Select Company..." NoWrap="False" OnItemsRequested="ddl_ItemsRequested"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" meta:resourcekey="ddlCompanies">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="InvoiceNumber" ItemStyle-Wrap="false" HeaderText="Invoice #" DataField="InvoiceNumber"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="InvoiceNumber" GroupByExpression="InvoiceNumber [GridColumn_InvoiceNumber] Group By InvoiceNumber ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("InvoiceNumber")) = String.Empty, "&nbsp;", Eval("InvoiceNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" Text='<%#Eval("InvoiceNumber")%>' MaxLength="300" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentMethod" ItemStyle-Wrap="false" HeaderText="Payment Method"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="PaymentMethod"
                            SortExpression="PaymentMethod" GroupByExpression="PaymentMethod [GridColumn_PaymentMethod] Group By PaymentMethod ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("PaymentMethod")) = String.Empty, "&nbsp;", Eval("PaymentMethod"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPaymentMethod" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="100%"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentNumber" ItemStyle-Wrap="false" HeaderText="Payment #"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="PaymentNumber"
                            SortExpression="PaymentNumber" GroupByExpression="PaymentNumber [GridColumn_PaymentNumber] Group By PaymentNumber ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("PaymentNumber")) = String.Empty, "&nbsp;", Eval("PaymentNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPaymentNumber" runat="server" Text='<%#Eval("PaymentNumber")%>' MaxLength="300" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentDate" ItemStyle-Wrap="false" HeaderText="Payment Date" DataField="PaymentDate"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="PaymentDate" GroupByExpression="PaymentDate [GridColumn_PaymentDate] Group By PaymentDate ASC">
                            <ItemTemplate>
                                <span><%# If(Eval("PaymentDate") Is DBNull.Value, "", FormatDate(Eval("PaymentDate")))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01"
                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                    <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                    <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Description" ItemStyle-Wrap="false" HeaderText="Description" DataField="Description"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtDescription" MaxLength="500" Width="100%" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="OpenBalance" ItemStyle-Wrap="false" HeaderText="Open Balance"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="OpenBalance"
                            SortExpression="OpenBalance" GroupByExpression="OpenBalance [GridColumn_OpenBalance] Group By OpenBalance ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("OpenBalance"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOpenBalance" CssClass="Currency" runat="server" Width="100%" Text='<%#FormatCurrency(Eval("OpenBalance"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentAmount" ItemStyle-Wrap="false" HeaderText="Payment Amount"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="PaymentAmount"
                            SortExpression="PaymentAmount" GroupByExpression="PaymentAmount [GridColumn_PaymentAmount] Group By PaymentAmount ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("PaymentAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPaymentAmount" CssClass="Currency" runat="server"  Width="100%" Text='<%#FormatCurrency(Eval("PaymentAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="CostCode" ItemStyle-Wrap="false" HeaderText="Cost Code"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" DropDownWidth="300px"
                                    EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                    NoWrap="True" AllowCustomText="false" Style="font-size: 11px" Height="250px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Period" ItemStyle-Wrap="false" HeaderText="Period" DataField="Period"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                    runat="server" AutoPostBack="False" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" OnItemsRequested="PeriodLoadRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Type" ItemStyle-Wrap="false" HeaderText="Type"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC" DataField="Type">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Type")) = String.Empty, "&nbsp;", Eval("Type"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Category" ItemStyle-Wrap="false" HeaderText="Category"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Category"
                            SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Category")) = String.Empty, "&nbsp;", Eval("Category"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Reference" ItemStyle-Wrap="false" HeaderText="Reference" DataField="Reference"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Reference" GroupByExpression="Reference [GridColumn_Reference] Group By Reference ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Reference")) = String.Empty, "&nbsp;", Eval("Reference"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReference" MaxLength="255" runat="server" Text='<%#Eval("Reference")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Status" ItemStyle-Wrap="false" HeaderText="Status"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Status"
                            SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Status")) = String.Empty, "&nbsp;", Eval("Status"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency" ItemStyle-Wrap="false"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                            Groupable="true" Reorderable="true" DataField="Currency">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px" AutoPostBack="True"
                                    Skin="Default" Height="250px" OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="RevisionNumber" ItemStyle-Wrap="false" HeaderText="Revision"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="RevisionNumber"
                            SortExpression="RevisionNumber" GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC">
                            <ItemTemplate>
                                <span><%# IIf(Eval("RevisionNumber").ToString = String.Empty, "&nbsp;", Eval("RevisionNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%" Text='<%#FormatNumber(Eval("RevisionNumber"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Notes" ItemStyle-Wrap="false" HeaderText="Notes"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Notes"
                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Notes")) = String.Empty, "&nbsp;", Eval("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
        <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="AppliedInFull" ItemStyle-Wrap="false" HeaderText="Applied In Full"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="AppliedInFull"
                            SortExpression="AppliedInFull" GroupByExpression="AppliedInFull [GridColumn_AppliedInFull] Group By AppliedInFull ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("AppliedInFull"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAppliedInFull" Checked='<%# Cbool(IIF(Eval("AppliedInFull") is system.DBNULL.value, 0,Eval("AppliedInFull")))%>' runat="server" CssClass="mobile-switch" />
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="center"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="OpenBalance" Visible="False" />

                        <telerik:GridTemplateColumn HeaderText="Open Balance Converted" Visible="false" UniqueName="OpenBalanceConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="OpenBalanceConverted" DataField="OpenBalanceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("OpenBalanceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblOpenBalanceConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Payment Amount Converted" Visible="false" UniqueName="PaymentAmountConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="PaymentAmountConverted" DataField="PaymentAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("PaymentAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblPaymentAmountConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                    </Columns>

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
            Visible='<%# rdgPayments.EditIndexes.Count = 0 AND (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
            <span class="Icon"></span>
            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>

                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgPayments.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                Visible='<%# rdgPayments.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgPayments.EditIndexes.Count > 0 Or rdgPayments.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 AND (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            

                            <asp:LinkButton ID="btnLink" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="LinkPayments" CssClass="GridCmdLinkPayments" OnClientClick="return OpenSelectAPPaymentsPopup();"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server" Text="Add line"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnUnlink" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="UnlinkPayments" CssClass="GridCmdUnlinkPayments" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label1" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnPayInvoices" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="PayInvoices" CssClass="GridCmdPayInvoices" OnClientClick="return OpenPayInvoicesPopup();"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnPayInvoices">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPayInvoices" runat="server" Text="Pay Invoices1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDeletePaymentBatchDetails();"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                meta:resourcekey="btnRefreshResource1" Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Copy To Excel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>                           

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true" AllowDragToGroup="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />