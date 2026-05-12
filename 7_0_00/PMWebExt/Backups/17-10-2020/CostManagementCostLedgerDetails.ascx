<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementCostLedgerDetails.ascx.vb"
    Inherits="Website.CostManagementCostLedgerDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RDG">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="row">
    <div class="col-12">
        <telerik:RadGrid ID="RDG" runat="server"
            AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="25"
            ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
            AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace"
                EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="true" GroupLoadMode="Client">
                <Columns>

                    <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" UniqueName="Imported" Groupable="false">
                        <ItemTemplate>
                            <div class="<%# CStr(IIf(Eval("IsImported"), "SmallLink", IIf(Eval("ProfileCode") <> "", "CheckedInButton", "EmptyButton")))%>">
                                <span class="Icon"></span>
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        <HeaderStyle Width="25px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" UniqueName="History" Groupable="false">
                        <ItemTemplate>
                            <a onclick="OpenHistory('<%# Eval("Id")%>');" class="<%# CStr(IIf(Eval("HistoryCount") > 0, "HistoryButton", "EmptyButton"))%>">
                                <span class="Icon"></span>
                            </a>
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        <HeaderStyle Width="25px" />
                    </telerik:GridTemplateColumn>

                    <%--<telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemCode" SortExpression="ItemCode" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="ItemCode Item Group By ItemCode ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" runat="server" Text='<%# Eval("ItemCode") %>' Width="100%" 
                                   Enabled='<%# Not RDG.MasterTableView.IsItemInserted %>'
                                    ></asp:TextBox>
                            </EditItemTemplate> 
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>--%>

                    <telerik:GridTemplateColumn HeaderText="System ID" SortExpression="Id" UniqueName="Id"
                        GroupByExpression="Id [GridColumn_Id] Group By Id" DataField="Id" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap"
                                Text='<%#Eval("Id").ToString%>' NavigateUrl='<%#Eval("RecordPage") %>'></asp:HyperLink>
                            <%--<span><%# Container.DataItem("Id")%></span>--%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%# IIf(Eval("Id") Is DBNull.Value, "&nbsp;", Eval("Id"))%></span>&nbsp;
                        </EditItemTemplate>
                         <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
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
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="75px" />
                    </telerik:GridTemplateColumn>



                    <telerik:GridTemplateColumn HeaderText="Cost Code*" SortExpression="CostCode" UniqueName="CostCode"
                        GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                            </asp:HyperLink>
                            <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged" EnableItemCaching="true"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="False"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                Style="font-size: 11px" Height="250px">
                            </telerik:RadComboBox>
                            <div>
                                <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                    CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="csvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                    CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>">
                                </asp:CustomValidator>
                            </div>
                        </EditItemTemplate>
                        <HeaderStyle Width="150px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description"
                        GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="200px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Currency" SortExpression="Currency" UniqueName="Currency"
                        GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                Skin="Default" Height="250px">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="150px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="UOM" DataField="UOM" AutoPostBackOnFilter="true"
                        SortExpression="UOM" UniqueName="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"
                                Skin="Default" Height="250px" AllowCustomText="true">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Quantity" DataField="Quantity" DataType="System.Decimal" AutoPostBackOnFilter="true"
                        GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" UniqueName="Quantity"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                        <ItemTemplate>
                            <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="Double" Width="100%"
                                MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost"
                        DataField="UnitCost" DataType="System.Decimal" AutoPostBackOnFilter="true"
                        SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                        <ItemTemplate>
                            <span><%#FormatCurrency(Container.DataItem("UnitCost"),CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" MaxLength="15"
                                Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Total Amount" UniqueName="TotalAmount"
                        DataField="TotalAmount" DataType="System.Decimal" AutoPostBackOnFilter="true"
                        GroupByExpression="TotalAmount [GridColumn_TotalAmount] Group By TotalAmount ASC" SortExpression="TotalAmount"
                        Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                        <ItemTemplate>
                            <span>
                                <asp:Label Text='<%#FormatCurrency(Container.DataItem("TotalAmount"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTotalAmount" /></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTotalAmount" CssClass="Currency" runat="server" Width="100%"
                                MaxLength="15" Text='<%# FormatCurrency(Eval("TotalAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'>
                            </asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Worksheet Column*" SortExpression="WorksheetColumn" DataField="WorksheetColumn" AutoPostBackOnFilter="true"
                        UniqueName="WorksheetColumn" GroupByExpression="WorksheetColumn [GridColumn_WorksheetColumn] Group By WorksheetColumn ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("WorksheetColumn") = String.Empty, "&nbsp;", Container.DataItem("WorksheetColumn"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:radcombobox ID="ddlWorksheetColumns" Width="100%" AllowCustomText="true" runat="server" Filter="Contains" MarkFirstMatch="true"></telerik:radcombobox>
                            <div>
                                <asp:RequiredFieldValidator ID="rfvWorksheetColumns" runat="server" ControlToValidate="ddlWorksheetColumns"
                                    CssClass="Validator" InitialValue=""  meta:resourcekey="cmpWorksheetColumns" 
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmpWorksheetColumns" runat="server" ControlToValidate="ddlWorksheetColumns"
                                    ValueToCompare="0" CssClass="Validator" ErrorMessage="Enter a worksheet column" meta:resourcekey="cmpWorksheetColumns"
                                    Display="Dynamic" ForeColor="" Operator="GreaterThan" ValidationGroup="Save">
                                </asp:CompareValidator>
                            </div>
                        </EditItemTemplate>
                        <HeaderStyle Width="150px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Status" DataField="Status" AutoPostBackOnFilter="true"
                        UniqueName="Status" SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                        <ItemTemplate>
                            <span><%#CStr(Container.DataItem("Status"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox  ID="ddlStatus" Width="100%" runat="server"></telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period"
                        GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIf(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                Style="font-size: 11px" Height="250px">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="200px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes" AutoPostBackOnFilter="true"
                        SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                                MaxLength="500"></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="200px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Document" DataField="Document" AutoPostBackOnFilter="true"
                        UniqueName="Document" GroupByExpression="Document [GridColumn_Document] Group By Document ASC"
                        SortExpression="Document">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Document") = String.Empty, "&nbsp;", Container.DataItem("Document"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDocument" runat="server" Width="100%" Text='<%#IIf(Eval("Document") Is DBNull.Value, "", Eval("Document"))%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="200px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Document Type" DataField="DocumentType" AutoPostBackOnFilter="true"
                        UniqueName="DocumentType" GroupByExpression="DocumentType [GridColumn_DocumentType] Group By DocumentType ASC"
                        SortExpression="DocumentType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("DocumentType") = String.Empty, "&nbsp;", Container.DataItem("DocumentType"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDocumentType" runat="server" Width="100%" Text='<%#IIf(Eval("DocumentType") Is DBNull.Value, "", Eval("DocumentType"))%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="150px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Date" DataField="CreateDate" DataType="System.DateTime" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo"
                        UniqueName="Date" SortExpression="CreateDate" GroupByExpression="CreateDate [GridColumn_Date] Group By CreateDate ASC">
                        <ItemTemplate>
                            <span><%#FormatDate(Container.DataItem("CreateDate"))%>&nbsp;</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="rdpDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                <DateInput ID="DateInput1" Skin="Default" runat="server"></DateInput>
                                <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Req. Code" DataField="ReqCodeName" AutoPostBackOnFilter="true"
                        UniqueName="ReqCode" SortExpression="ReqCodeName" GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%#iif(Eval("ReqCodeName") is dbnull.value,string.empty,Eval("ReqCodeName")) %> &nbsp;</span>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Req. #" DataField="ReqNumber" AutoPostBackOnFilter="true"
                        UniqueName="ReqNumber" SortExpression="ReqNumber" GroupByExpression="ReqNumber [GridColumn_ReqNumber] Group By ReqNumber ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("ReqNumber") = String.Empty, "&nbsp;", Container.DataItem("ReqNumber"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%#IIf(Eval("ReqNumber") is dbnull.value , String.Empty, Eval("ReqNumber"))%> &nbsp;</span>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Profile ID" DataField="ProfileCode"
                        AutoPostBackOnFilter="true" UniqueName="ProfileCode" SortExpression="ProfileCode" GroupByExpression="ProfileCode [GridColumn_ProfileCode] Group By ProfileCode ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("ProfileCode") = String.Empty, "&nbsp;", Container.DataItem("ProfileCode"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%#IIf(Eval("ProfileCode") Is DBNull.Value, String.Empty, Eval("ProfileCode"))%> &nbsp;</span>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Import Date" DataField="IntegrationImportDate" DataType="System.DateTime" AutoPostBackOnFilter="true"
                        UniqueName="IntegrationImportDate" SortExpression="IntegrationImportDate" GroupByExpression="IntegrationImportDate [GridColumn_IntegrationImportDate] Group By IntegrationImportDate ASC">
                        <ItemTemplate>
                            <span><%#FormatDate(Container.DataItem("IntegrationImportDate"))%>&nbsp;</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <EditItemTemplate>
                            <span><%#FormatDate(Eval("IntegrationImportDate"))%>&nbsp;</span>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalAmount" Visible="False" />

                    <telerik:GridTemplateColumn HeaderText="LastUpdateDate" DataField="LastUpdateDate" CurrentFilterFunction="EqualTo"
                        AutoPostBackOnFilter="true" UniqueName="LastUpdateDate" SortExpression="LastUpdateDate" GroupByExpression="LastUpdateDate [GridColumn_LastUpdateDate] Group By LastUpdateDate ASC">
                        <ItemTemplate>
                            <span><%#FormatDate(Container.DataItem("LastUpdateDate"))%></span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="LastUpdateBy" DataField="LastUpdatedBy"
                        AutoPostBackOnFilter="true" UniqueName="LastUpdateBy" SortExpression="LastUpdatedBy" GroupByExpression="LastUpdatedBy [GridColumn_LastUpdateBy] Group By LastUpdatedBy ASC">
                        <ItemTemplate>
                            <span><%#Container.DataItem("LastUpdatedBy")%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Recovery Batch ID" SortExpression="RecoveryBatchId" UniqueName="RecoveryBatchId"
                        GroupByExpression="RecoveryBatchId [GridColumn_RecoveryBatchId] Group By RecoveryBatchId" DataField="RecoveryBatchId" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <span><%# IIf(Container.DataItem("RecoveryBatchId") Is DBNull.Value, "&nbsp;", Container.DataItem("RecoveryBatchId"))%></span>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%# IIf(Eval("RecoveryBatchId") Is DBNull.Value, "&nbsp;", Eval("RecoveryBatchId"))%></span>&nbsp;
                        </EditItemTemplate>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="false" UniqueName="UnitCostConverted" ItemStyle-HorizontalAlign="Right"
                        SortExpression="UnitCostConverted" DataField="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Total Amount Converted" Visible="false" UniqueName="TotalAmountConverted" ItemStyle-HorizontalAlign="Right"
                        SortExpression="TotalAmountConverted" DataField="TotalAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <asp:Label Text='<%#FormatCurrency(Eval("TotalAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalAmountConverted" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                <ItemStyle Wrap="false" />
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="WorksheetColumnId"></telerik:GridSortExpression>
                </SortExpressions>
                <CommandItemTemplate>
                    <div style="padding: 2px">
                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                            SecurityButtonType="ItemMode_Edit"
                            Visible='<%# RDG.EditIndexes.Count = 0 And (Not RDG.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                            SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save"
                            Visible='<%# RDG.EditIndexes.Count > 0 %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                            SecurityButtonType="AddEditMode_Add" ValidationGroup="Save"
                            Visible='<%# RDG.MasterTableView.IsItemInserted %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                            SecurityButtonType="AddEditMode"
                            Visible='<%# RDG.EditIndexes.Count > 0 Or RDG.MasterTableView.IsItemInserted %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnVoidLines" runat="server" CausesValidation="False" CommandName="VoidLines" CssClass="GridCmdVoidLines"
                            SecurityButtonType="ItemMode_Edit" Visible='<%# RDG.EditIndexes.Count = 0 AND (Not RDG.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblVoidLine" runat="server" Text="Void Lines"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                            SecurityButtonType="ItemMode_Add"
                            Visible='<%# RDG.EditIndexes.Count = 0 AND (Not RDG.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblAddLine" runat="server" Text="Add line"></asp:Label>
                            &nbsp;&nbsp; 
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                            SecurityButtonType="ItemMode_Delete" Visible='<%# RDG.EditIndexes.Count = 0 And (Not RDG.MasterTableView.IsItemInserted) %>'
                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                            SecurityButtonType="ItemMode"
                            Visible='<%# RDG.EditIndexes.Count = 0 AND (Not RDG.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>
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
            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                <%--<Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="370px" SaveScrollPosition="True" FrozenColumnsCount="1" />--%>
                <ClientEvents OnRowSelecting="RDG_OnRowSelecting" />
            </ClientSettings>
            <ValidationSettings EnableValidation="true" ValidationGroup="Save" CommandsToValidate="PerformInsert,UpdateEdited" />
        </telerik:RadGrid>
    </div>
</div>

