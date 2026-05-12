<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetApPaymentbatcheDetail.ascx.vb" Inherits="Website.AssetApPaymentbatcheDetail" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPayments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPayments" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblCost" />
                <telerik:AjaxUpdatedControl ControlID="fldMemoFields"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPayments" GroupingEnabled="true" runat="server" AutoGenerateColumns="False" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8"
                PageSize="250" AllowPaging="true" ShowGroupPanel="True" AllowSorting="true" ShowStatusBar="False" ShowFooter="true" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true" ShowGroupFooter="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #1" Groupable="false" Reorderable="true" UniqueName="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal" AllowFiltering="true"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProgramName" ItemStyle-Wrap="false" HeaderText="Program1*" DataField="ProgramName"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="ProgramName" GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProgramName")) = String.Empty, "&nbsp;", Eval("ProgramName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProgram" OnSelectedIndexChanged="ddlProgram_SelectedIndexChanged" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>


                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="LocationName" ItemStyle-Wrap="false" HeaderText="Location1" DataField="LocationName"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="LocationName" GroupByExpression="LocationName [GridColumn_LocationName] Group By LocationName ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("LocationName")) = String.Empty, "&nbsp;", Eval("LocationName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLocations" runat="server" OnSelectedIndexChanged="ddlLocations_SelectedIndexChanged" AutoPostBack="True" CausesValidation="False"
                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Location..." Height="300px" meta:resourcekey="ddlLocations"
                                    NoWrap="true" Skin="Default" Width="100%" DropDownWidth="400px" ShowMoreResultsBox="True"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Lease" ItemStyle-Wrap="false" HeaderText="Lease1" DataField="Lease"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Lease" GroupByExpression="Lease [GridColumn_Lease] Group By Lease ASC">
                            <ItemTemplate>
                                <a id="hypLease" href='<%#Eval("LeasePostBackUrl")%>'>
                                    <span><%# IIf(CStr(Eval("Lease")) = String.Empty, "&nbsp;", Eval("Lease"))%></span> </a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLease" Filter="Contains" OnSelectedIndexChanged="ddlLease_SelectedIndexChanged" MarkFirstMatch="true" AllowCustomText="true"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                    Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                    EnableLoadOnDemand="true" OnItemsRequested="LeaseLoadRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="LinkedInvoice" ItemStyle-Wrap="false" HeaderText="Linked A/P Invoice1" DataField="LinkedInvoice"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="RecordNumber" ItemStyle-Wrap="false" HeaderText="ID1" DataField="RecordNumber"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Company" ItemStyle-Wrap="false" HeaderText="Company1" DataField="Company"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="InvoiceNumber" ItemStyle-Wrap="false" HeaderText="Invoice #1" DataField="InvoiceNumber"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentMethod" ItemStyle-Wrap="false" HeaderText="Payment Method1" DataField="PaymentMethod"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="PaymentMethod" GroupByExpression="PaymentMethod [GridColumn_PaymentMethod] Group By PaymentMethod ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("PaymentMethod")) = String.Empty, "&nbsp;", Eval("PaymentMethod"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPaymentMethod" Height="200px" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="100%"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentNumber" ItemStyle-Wrap="false" HeaderText="Payment #1" DataField="PaymentNumber"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="PaymentNumber" GroupByExpression="PaymentNumber [GridColumn_PaymentNumber] Group By PaymentNumber ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("PaymentNumber")) = String.Empty, "&nbsp;", Eval("PaymentNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPaymentNumber" runat="server" Text='<%#Eval("PaymentNumber")%>' MaxLength="300" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentDate" DataField="PaymentDate" ItemStyle-Wrap="false" HeaderText="Payment Date1"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Description" ItemStyle-Wrap="false" HeaderText="Description1" DataField="Description"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="OpenBalance" ItemStyle-Wrap="false" HeaderText="Open Balance1"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="OpenBalance" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            SortExpression="OpenBalance" GroupByExpression="OpenBalance [GridColumn_OpenBalance] Group By OpenBalance ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("OpenBalance"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOpenBalance" CssClass="Currency" runat="server" Width="100%" Text='<%#FormatCurrency(Eval("OpenBalance")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="PaymentAmount" ItemStyle-Wrap="false" HeaderText="Payment Amount1"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="PaymentAmount" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            SortExpression="PaymentAmount" GroupByExpression="PaymentAmount [GridColumn_PaymentAmount] Group By PaymentAmount ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("PaymentAmount"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPaymentAmount" CssClass="Currency" runat="server" MinNumber="0" Width="100%" Text='<%#FormatCurrency(Eval("PaymentAmount")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="CostCode" ItemStyle-Wrap="false" HeaderText="Cost Code1" DataField="CostCode"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    EnableItemCaching="false" MarkFirstMatch="true" OnItemsRequested="ddl_ItemsRequested"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                    NoWrap="True" AllowCustomText="true" Style="font-size: 11px" Height="250px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Period" ItemStyle-Wrap="false" HeaderText="Period1" DataField="Period"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Type" ItemStyle-Wrap="false" HeaderText="Type1" DataField="Type"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Type")) = String.Empty, "&nbsp;", Eval("Type"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" Height="200px" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Category" ItemStyle-Wrap="false" HeaderText="Category1" DataField="Category"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Category")) = String.Empty, "&nbsp;", Eval("Category"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Height="200px" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Reference" ItemStyle-Wrap="false" HeaderText="Reference1" DataField="Reference"
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Status" ItemStyle-Wrap="false" HeaderText="Status1" DataField="Status"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Status")) = String.Empty, "&nbsp;", Eval("Status"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="RevisionNumber" ItemStyle-Wrap="false" HeaderText="Revision1" DataField="RevisionNumber"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="RevisionNumber" GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC">
                            <ItemTemplate>
                                <span><%# IIf(Eval("RevisionNumber").ToString = String.Empty, "&nbsp;", Eval("RevisionNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%" Text='<%#FormatNumber(Eval("RevisionNumber"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Notes" ItemStyle-Wrap="false" HeaderText="Notes1" DataField="Notes"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Notes")) = String.Empty, "&nbsp;", Eval("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                                    <span class="Icon"></span>
                                </asp:LinkButton>


                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="AppliedInFull" ItemStyle-Wrap="false" HeaderText="Applied In Full1" DataField="AppliedInFull" DataType="System.Boolean"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                            SortExpression="AppliedInFull" GroupByExpression="AppliedInFull [GridColumn_AppliedInFull] Group By AppliedInFull ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("AppliedInFull"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAppliedInFull" Checked='<%# Cbool(IIF(Eval("AppliedInFull") is system.DBNULL.value, 0,Eval("AppliedInFull")))%>' runat="server" class="mobile-switch" />
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="OpenBalance" Visible="False" />


                    </Columns>

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
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
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        
                            <asp:LinkButton ID="btnLink" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdLinkPayments" CommandName="LinkPayments" OnClientClick="return OpenSelectAssetAPPaymentsPopup();"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server" Text="Add line"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUnlink" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgPayments.EditIndexes.Count = 0 And (Not rdgPayments.MasterTableView.IsItemInserted) %>' CssClass="GridCmdUnlinkPayments"
                                runat="server" CommandName="UnlinkPayments" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label1" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPayInvoices" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="PayInvoices" OnClientClick="return OpenAssetPayAPInvoicesPopup();" CssClass="GridCmdPayInvoices"
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
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" AllowDragToGroup="true" AllowColumnsReorder="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
