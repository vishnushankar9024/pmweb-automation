<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostMiscellaneousInvoiceDetails.ascx.vb"
    Inherits="Website.CostMiscellaneousInvoiceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadAjaxLoadingPanel ID="ldpMiscellaneousInvoices" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<%--<table style="table-layout:fixed;"  cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>--%>

<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgMiscellaneousInvoices" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile="true"
                HasPasteFromExcel="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="true" GroupLoadMode="Client">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right"
                            SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                            Groupable="false" Reorderable="true" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
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
                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectName" ItemStyle-Wrap="false" HeaderText="Project"
                            SortExpression="ProjectName" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC" DataField="ProjectName">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProjectName")) = String.Empty, "&nbsp;", Eval("ProjectName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                    CloseDropDownOnBlur="true" Height="300px" meta:resourcekey="ddlProjects"
                                    NoWrap="true" Skin="Default" Width="100%" DropDownWidth="250px" ShowMoreResultsBox="True" OnClientSelectedIndexChanged="ResetCombos"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged">
                                </telerik:RadComboBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Project Required."
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Item" DataField="ItemCode" SortExpression="ItemCode" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC">
                            <ItemTemplate>
                                <span><%#IIf(Eval("ItemCode") = String.Empty, "&nbsp;", Eval("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" runat="server" MaxLength="50" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" Enabled='<%# Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px"
                                    Skin="Default" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="False"
                                    AllowCustomText="true" Style="font-size: 11px" Height="150px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity"
                            DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                            SortExpression="UnitCost" DataField="UnitCost">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField="ExtCost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">

                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField="Tax" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC"
                            DataField="TotalCost">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Code*" DataField="CostCode" SortExpression="CostCode" UniqueName="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"
                                    EnableItemCaching="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="False" AutoPostBack="true" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes" meta:Resourcekey="rfvRequired"
                                        CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                        Display="Dynamic" Enabled="false" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>">
                                    </asp:CustomValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" DataField="CostType" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                            UniqueName="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded"
                            GroupByExpression="Funded [GridColumn_Funded] Group By Funded" DataField="Funded" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("Funded"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                <asp:LinkButton ID="btnGenerateFunding" CssClass="FilledDetails" Text="" runat="server" OnClientClick="return OpenFundingCostCodePopup(this);">
                            <span class="Icon"></span>
                                </asp:LinkButton>

                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFunded" runat="server"
                                    Text='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="80%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Funding Source" UniqueName="FundingSource" DataField="FundingCode" SortExpression="FundingCode"
                            GroupByExpression="FundingCode [GridColumn_FundingSource] Group By FundingCode ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FundingCodeId") = -1, "&nbsp;", IIF(Container.DataItem("FundingCodeId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingCode")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlFundingCodes" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="true" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase" DataField="Phase"
                            HeaderStyle-Width="150px" SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" Height="200px" CloseDropDownOnBlur="true" DropDownWidth="200px" OnClientItemsRequesting="GetValueToReturn"
                                    Width="100%" NoWrap="true" CausesValidation="False" EnableLoadOnDemand="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetValueToReturn"
                                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                <span class="Icon"></span>
                                    </asp:LinkButton>

                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Location" DataField="LocationName" UniqueName="Location" SortExpression="LocationName"
                            GroupByExpression="LocationName [GridColumn_Location] Group By LocationName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("LocationName") = String.Empty, "&nbsp;", Container.DataItem("LocationName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLocations" runat="server" DropDownWidth="300px" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" OnClientItemsRequesting="GetValueToReturn"
                                    NoWrap="true" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" Style="font-size: 11px" Height="250px" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" DataField="Notes">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                    <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn Visible="false" HeaderText="Cost Ledger ID"
                            SortExpression="CostLedgerId" UniqueName="CostLedgerId" DataField="CostLedgerId"
                            GroupByExpression="CostLedgerId [GridColumn_CostLedgerId] Group By CostLedgerId ASC">
                            <ItemTemplate>
                            </ItemTemplate>
                            <EditItemTemplate></EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Req. Code" DataField="ReqCodeName" SortExpression="ReqCodeName" UniqueName="ReqCode"
                            GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlReqCodes" runat="server" AllowCustomText="False"
                                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" DropDownWidth="300px" AutoPostBack="false" NoWrap="true"
                                    Height="250px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" />
                                    </Items>
                                    <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server" AutoPostBack="false"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvReqNodeClicking"
                                            OnNodeDataBound="rdvReqCode_NodeDataBound" OnNodeExpand="rdvReqCode_NodeExpand">
                                        </telerik:RadTreeView>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manufacturer" DataField="ManufacturerName" UniqueName="Manufacturer" SortExpression="ManufacturerName"
                            GroupByExpression="ManufacturerName [GridColumn_Manufacturer] Group By ManufacturerName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ManufacturerId") = -1 Or Container.DataItem("ManufacturerId") = 0, "&nbsp;", Container.DataItem("ManufacturerName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="85%" DropDownWidth="300px" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed" OnClientItemsRequesting="GetValueToReturn"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton">
                        <span class="Icon"></span>
                                    </asp:LinkButton>

                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Mfr. Number" SortExpression="MfrNumber" UniqueName="MfrNumber"
                            GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber" DataField="MfrNumber">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("MfrNumber") = String.Empty, "&nbsp;", Container.DataItem("MfrNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" Width="100%" MaxLength="255"
                                    runat="server" Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" DataField="Field1" AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" AllowFiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field7" DataField="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" UniqueName="UnitCostConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="ExtCostConverted" DataField="UnitCostConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" UniqueName="ExtCostConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="ExtCostConverted" DataField="ExtCostConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax Converted" UniqueName="TaxConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="TaxConverted" DataField="TaxConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" UniqueName="Adjustment1Converted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="Adjustment1Converted" DataField="Adjustment1Converted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment1Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="Adjustment2Converted" DataField="Adjustment2Converted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment2Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost Converted" UniqueName="TotalCostConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" SortExpression="TotalCostConverted" DataField="TotalCostConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("TotalCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" ValidationGroup="Save"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" ValidationGroup="Save"
                                Visible='<%# rdgMiscellaneousInvoices.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count > 0 Or rdgMiscellaneousInvoices.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=MiscellaneousInvoices', 910, 580, true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted)%>' ToolTip="Export to Excel">
                                <span class="Icon"></span>
                                <asp:Label ID="Label12" Text="Export To Exel" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgMiscellaneousInvoices.EditIndexes.Count = 0 And (Not rdgMiscellaneousInvoices.MasterTableView.IsItemInserted)%>'
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
                </MasterTableView><ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true"
                    Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
<%--</td>
    </tr>
</table>--%>

<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />