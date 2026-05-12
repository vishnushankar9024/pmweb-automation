<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TenantInvoiceDetails.ascx.vb" Inherits="Website.TenantInvoiceDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgTenantInvoiceDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgTenantInvoiceDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldInvoiceRecap" />
            </UpdatedControls>

        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgTenantInvoiceDetails" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" UseEditFormInMobile="true"
                Font-Size="8px" PageSize="250" ShowFooter="true" AllowPaging="True" ShowGroupPanel="true"
                AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="true" GroupLoadMode="Client">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" AllowFiltering="false"
                            SortExpression="LineNumber"
                            Groupable="false" Reorderable="true" DataField="LineNumber">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
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
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "("+Eval("AttachmentTotal").ToString()+")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Item" SortExpression="ItemCode" DataField="ItemCode"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("ItemCode") = "0" OrElse Container.DataItem("ItemCode") = "", "&nbsp;", Container.DataItem("ItemCode").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblItemCode" Text='<%#IIf(FormatItemCode(Eval("ItemCode")) = 0, "&nbsp;", Eval("ItemCode").ToString)%>' Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM"
                            GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" DataField="UOM">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <span>
                                    <%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <%--                            <FooterTemplate>
                                <asp:Label ID="lblTotalQuantity" runat="server"></asp:Label>
                            </FooterTemplate>--%>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                            SortExpression="UnitCost" DataField="UnitCost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField="ExtCost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"))%>' runat="server" ID="lblExtCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            DataField="Adjustment1" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"))%>' runat="server" ID="lblAdjustment1" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAdjustment1" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Adjustment1"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>

                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            DataField="Tax" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTax" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Tax"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            DataField="Adjustment2" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAdjustment2" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Adjustment2"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UnitPrice" GroupByExpression="UnitPrice [GridColumn_UnitPrice] Group By UnitPrice ASC" UniqueName="UnitPrice" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitPrice" DataField="UnitPrice" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("UnitPrice"))%>' runat="server" ID="lblUnitprice" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitPrice" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("UnitPrice"))%>'></asp:TextBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Price" GroupByExpression="Price [GridColumn_Price] Group By Price ASC" UniqueName="Price" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Price" DataField="Price" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Price"))%>' runat="server" ID="lblprice" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPrice" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Price"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode"
                            UniqueName="CostCodeId" DataField="CostCode" GroupByExpression="CostCode [GridColumn_CostCodeId] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCodeWithDescription")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCodeWithDescription") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="False" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostTypeId] Group By CostType ASC"
                            UniqueName="CostTypeId" DataField="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Charge Type" SortExpression="ChargeType" GroupByExpression="ChargeType [GridColumn_ChargeTypeId] Group By ChargeType ASC"
                            UniqueName="ChargeTypeId" DataField="ChargeType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ChargeType") = String.Empty, "&nbsp;", Container.DataItem("ChargeType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlChargeType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15"
                            DataField="Notes">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />

                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count = 0 And (Not rdgTenantInvoiceDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgTenantInvoiceDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count > 0 Or rdgTenantInvoiceDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count = 0 And (Not rdgTenantInvoiceDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=TenantInvoice', 910, 580, true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count = 0 And (Not rdgTenantInvoiceDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count = 0 And (Not rdgTenantInvoiceDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgTenantInvoiceDetails.EditIndexes.Count = 0 And (Not rdgTenantInvoiceDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
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
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
