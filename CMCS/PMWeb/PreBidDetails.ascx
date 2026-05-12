<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PreBidDetails.ascx.vb" Inherits="Website.PreBidDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPreBidDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPreBidDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPreBidDetails" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" UseEditFormInMobile="true"
                PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" AllowMultiRowEdit="True"
                AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by">
                </GroupPanel>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="True" ShowGroupFooter="true">
                    <Columns>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid" HeaderText="Include In Bid" Groupable="false" HeaderStyle-Width="80px" DataField="Select" DataType="System.Boolean">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" UniqueName="LineNumber" AllowFiltering="false"
                            Reorderable="true" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber").ToString) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
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
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Item" SortExpression="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC" DataField="ItemCode"
                            UniqueName="ItemCode">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" CssClass="Right" runat="server" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" Enabled='<%# Not rdgPreBidDetails.MasterTableView.IsItemInserted %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" DataField="Description"
                            UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" DropDownWidth="250px" Height="300px" runat="server" Skin="Default" Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Scope Of Work" SortExpression="ScopeOfWork" UniqueName="ScopeOfWork" DataField="ScopeOfWork"
                            GroupByExpression="ScopeOfWork [GridColumn_ScopeOfWork] Group By ScopeOfWork ASC">
                            <ItemTemplate>
                                <div>&nbsp;<%#Eval("ScopeOfWork").ToString%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScopeOfWork" runat="server" Text='<%#Eval("ScopeOfWork")%>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgScopeOfWork" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgScopeOfWork','txtScopeOfWork'))">
                    <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" ItemStyle-Wrap="false" DataField="UOM"
                            GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>

                                <span><%#Eval("UOM").ToString%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                                <asp:Label runat="server" ID="lblUOM" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" ItemStyle-Wrap="false" DataField="Quantity"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" MaxLength="15" runat="server" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'
                                    Width="100%" CssClass="Double" Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Est. Unit Cost" SortExpression="EstimatedUnitCost" ItemStyle-Wrap="false" DataField="EstimatedUnitCost"
                            UniqueName="EstimatedUnitCost" GroupByExpression="EstimatedUnitCost [GridColumn_EstimatedUnitCost] Group By EstimatedUnitCost">
                            <ItemTemplate>
                                <span>
                                    <asp:Label runat="server" ID="lblEstimatedUnitCost" Text='<%#FormatCurrency(Eval("EstimatedUnitCost"), CurrencyId:=Eval("CurrencyId"))%>'></asp:Label></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEstimatedUnitCost" MaxLength="15" runat="server" Text='<%#FormatCurrency(Eval("EstimatedUnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Estimated Total" SortExpression="EstimatedTotal" ItemStyle-Wrap="false"
                            UniqueName="EstimatedTotal" DataField="EstimatedTotal" GroupByExpression="EstimatedTotal [GridColumn_EstimatedTotal] Group By EstimatedTotal">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("EstimatedTotal"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEstimatedTotal" MaxLength="90" runat="server" Text='<%#FormatCurrency(Eval("EstimatedTotal"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotalEstTotal" Text=""></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC" DataField="CostType"
                            UniqueName="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" DataField="BidCategory" HeaderText="Bid Category" SortExpression="BidCategory" UniqueName="BidCategory" GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC">
                            <ItemTemplate>
                                <%#Eval("BidCategory").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlBidCategory" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName" DataField="PhaseName"
                            GroupByExpression="PhaseName [GridColumn_Phase] Group By PhaseName ASC"
                            UniqueName="Phase">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjectPhases" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
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

                        <telerik:GridTemplateColumn HeaderText="Bid Section" SortExpression="BidSection" UniqueName="BidSection" ItemStyle-Wrap="false" DataField="BidSection"
                            GroupByExpression="BidSection [GridColumn_BidSection] Group By BidSection ASC">
                            <ItemTemplate>
                                <span><%# Eval("BidSection").ToString%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlBidSection" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Bid Section..." DropDownWidth="200px"
                                    Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <div>&nbsp;<%#Eval("Notes").ToString%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Est. Line #" DataField="EstimateLineNumber"
                            UniqueName="EstimtateLineNumber" GroupByExpression="EstimateLineNumber [GridColumn_EstimtateLineNumber] Group By EstimateLineNumber ASC" SortExpression="EstimateLineNumber">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("EstimateLineNumber")) = "0", "&nbsp;", Eval("EstimateLineNumber").ToString)%></span>
                                <%--<span>&nbsp;
                        <%#Eval("EstimtateLineNumber").ToString %></span>--%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(CStr(Eval("EstimateLineNumber").ToString) = "0", "&nbsp;", Eval("EstimateLineNumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="ManufacturerName" SortExpression="ManufacturerName" DataField="ManufacturerName"
                            GroupByExpression="ManufacturerName [GridColumn_ManufacturerName] Group By ManufacturerName" ItemStyle-Wrap="false">
                            <ItemTemplate>

                                <span><%# IIf(Eval("ManufacturerName").ToString = "", "&nbsp;", Eval("ManufacturerName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Mfr. Number" SortExpression="MfrNumber" UniqueName="MfrNumber" DataField="MfrNumber"
                            GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber" ItemStyle-Wrap="false">
                            <ItemTemplate>

                                <span><%# IIf(Eval("MfrNumber").ToString = "", "&nbsp;", Eval("MfrNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" Width="100%" MaxLength="255" CssClass="PositiveInteger"
                                    runat="server" Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Estimated Total Converted" SortExpression="EstimatedTotalConverted" Visible="False" ItemStyle-Wrap="false"
                            UniqueName="EstimatedTotalConverted" DataField="EstimatedTotalConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="EstimatedTotalConverted [GridColumn_EstimatedTotalConverted] Group By EstimatedTotalConverted">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("EstimatedTotalConverted"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="EstimatedUnitCost" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle HorizontalAlign="Left" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 And (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLines"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 AND (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddItems" CssClass="GridCmdAddItems"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 And (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=PreBid', 910, 580, true,'rdgPreBidDetails');">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItems"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddEstimateItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddEstimateItems" CssClass="GridCmdAddEstimateItems"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 And (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateProcurementsPopup.aspx?SourceId=PreBid' , 880, 550, true,'rdgPreBidDetails');">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Add estimate items" meta:resourcekey="lblAddEstimateItems"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                CommandName="PerformInsert" Visible='<%# rdgPreBidDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" CssClass="GridCmdDeleteRows"
                                OnClientClick="javascript:return DeleteSelectedLines('rdgPreBidDetails');"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 And (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                CommandName="RebindGrid" Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 AND (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>

                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>

                            </asp:LinkButton>
                           

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgPreBidDetails.EditIndexes.Count = 0 AND (Not rdgPreBidDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                    <Resizing EnableRealTimeResize="true" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%-- <Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
                <ValidationSettings ValidationGroup="PreBidDetails" EnableValidation="true"
                    CommandsToValidate="SaveChanges" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
