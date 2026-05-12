<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EstimateBidderDetails.ascx.vb" Inherits="Website.EstimateBidderDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgProcurementDetails" runat="server" SetWidth="true" AppendMenus="true"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                PageSize="10" AllowPaging="true" ShowFooter="true" CssClass="WithoutTopBorder"
                AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <HeaderContextMenu EnableViewState="false">
                </HeaderContextMenu>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true"
                    EditMode="InPlace" EnableHeaderContextMenu="false" GroupLoadMode="Client" ShowGroupFooter="true">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" UniqueName="LineNumber"
                            Reorderable="false" SortExpression="LineNumber">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber").ToString) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "("+Eval("AttachmentTotal").ToString()+")")%></span></EditItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project" Groupable="false" SortExpression="ProjectFullName"
                            UniqueName="ProjectFullName">
                            <ItemTemplate>
                                <span>&nbsp;<%# Eval("ProjectFullName").ToString%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn Visible="false" HeaderText="Bid Section" Groupable="false" SortExpression="BidSection"
                            UniqueName="BidSection">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblBidSection" Text='<%#IIf(Container.DataItem("BidSection") = String.Empty, "&nbsp;", Container.DataItem("BidSection"))%>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" SortExpression="Item" GroupByExpression="Item [GridColumn_Item] Group By Item ASC"
                            UniqueName="Item">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" Groupable="false" SortExpression="Description"
                            UniqueName="Description">
                            <ItemTemplate>
                                <span>&nbsp;<%#Eval("Description").ToString%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblCurrency" Text='<%#IIf(Eval("Currency") = String.Empty, "&nbsp;",Eval("Currency"))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Scope Of Work" Groupable="false" SortExpression="ScopeOfWork"
                            UniqueName="ScopeOfWork">
                            <ItemTemplate>

                                <asp:LinkButton runat="server" ID="imgReadText" CssClass="SearchButton" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText','lblText'))">
                        <span class="Icon"></span>
                                </asp:LinkButton>

                                <asp:Label runat="server" ID="lblText" Text='<%#IIf(Container.DataItem("ScopeOfWork") = String.Empty, "&nbsp;", Container.DataItem("ScopeOfWork"))%>'></asp:Label>

                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manufacturer" Groupable="false" UniqueName="Manufacturer" SortExpression="ManufacturerName">
                            <ItemTemplate>
                                <span>&nbsp;<%#Eval("ManufacturerName").ToString()%></span>
                            </ItemTemplate>


                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mfr. #" Groupable="false" SortExpression="MfrNumber" UniqueName="MfrNumber">
                            <ItemTemplate>
                                <span>&nbsp; <%#Eval("MfrNumber").ToString %>
                                </span>
                            </ItemTemplate>

                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" Groupable="false" SortExpression="UOM" UniqueName="UOM">
                            <ItemTemplate>
                                <span>&nbsp;<%#Eval("UOM").ToString%>
                                </span>
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Est. Quantity" Groupable="false" SortExpression=" EstimateQuantity"
                            UniqueName="EstimateQuantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("EstimateQuantity"))%>
                                </span>
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Bid Quantity" Groupable="false" SortExpression=" BidQuantity"
                            UniqueName="BidQuantity">
                            <ItemTemplate>
                                <asp:TextBox runat="server" Width="99%" CssClass="Double" ID="txtBidQuantity"
                                    Text='<%#FormatNumber(Container.DataItem("BidQuantity"))%>' />
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Price" Groupable="false" SortExpression="UnitPrice" UniqueName="UnitPrice">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtUnitPrice" CssClass="Currency" Width="99%" Text='<%#FormatCurrency(Container.DataItem("UnitPrice"),CurrencyId:=EVal("CurrencyId"))%>' />
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotal" Text="Total"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Amount" Groupable="false" SortExpression="TotalAmount" UniqueName="TotalAmount" DataField="TotalAmount" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtTotalAmount" CssClass="Currency" Width="99%" Text='<%#FormatCurrency(Container.DataItem("TotalAmount"),CurrencyId:=EVal("CurrencyId"))%>' />
                                <asp:HiddenField runat="server" ID="hdnLeveledTotal" Value='<%#Container.DataItem("LeveledAmount")%>' />

                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotalTolalAmount"></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />

                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Leveled Total" Groupable="false" SortExpression="LeveledTotal" DataField="LeveledTotal" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            UniqueName="LeveledTotal">
                            <ItemTemplate>
                                <div style="float: left">
                                    <asp:LinkButton ID="imgPopup" Style="cursor: pointer" meta:resourcekey="LevelingPopup" ToolTip="Leveling Popup" runat="server">
                  <span class="Icon"></span> 
                                    </asp:LinkButton>
                                </div>
                                <div style="float: right">
                                    <asp:Label runat="server" ID="lblLeveledTotal" Text='<%#FormatCurrency(Container.DataItem("LeveledTotal"),CurrencyId:=EVal("CurrencyId"))%>'></asp:Label>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotalBidAmount"></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Days" Groupable="false" SortExpression="Days"
                            UniqueName="Days">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtDays" CssClass="Integer" Width="99%" Text='<%#Container.DataItem("Days")%>' />
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="MWDBE Amount" Groupable="false" SortExpression="MWDBEAmount" UniqueName="MWDBEAmount">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtMWDBEAmount" CssClass="Currency" Width="99%" Text='<%#FormatCurrency(Container.DataItem("MWDBEAmount"),CurrencyId:=EVal("CurrencyId"))%>' />
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />

                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="MWDBE%" Groupable="false" SortExpression="MWDBE"
                            UniqueName="MWDBE">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtMWDBE" MinNumber="0" MaxNumber="100" CssClass="Percent" Width="99%" Text='<%#FormatPercent(Container.DataItem("MWDBE"))%>' />
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Phase" Groupable="false" SortExpression="Phase" UniqueName="Phase">
                            <ItemTemplate>
                                <span>&nbsp;<%#Eval("Phase").ToString%>
                                </span>
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </ItemTemplate>

                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </ItemTemplate>

                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </ItemTemplate>

                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </ItemTemplate>

                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" Groupable="false" SortExpression="Notes" UniqueName="Notes">
                            <ItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                        <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Amount Converted" Visible="false" Groupable="false" SortExpression="TotalAmountConverted" UniqueName="TotalAmountConverted" DataField="TotalAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="TextBox1" CssClass="Currency" Width="99%" Text='<%#FormatCurrency(Container.DataItem("TotalAmountConverted"),CurrencyId:=EVal("CurrencyId"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Leveled Total Converted" Visible="false" Groupable="false" SortExpression="LeveledTotalConverted" DataField="LeveledTotalConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            UniqueName="LeveledTotalConverted">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Label2" Text='<%#FormatCurrency(Container.DataItem("LeveledTotalConverted"),CurrencyId:=EVal("CurrencyId"))%>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalAmount" Visible="False" />

                    </Columns>

                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="BidderDetails" EnableValidation="true"
                    CommandsToValidate="SaveChanges" />
            </telerik:RadGrid>
            <asp:Button ID="btnRefreshGrid" runat="server" CssClass="Hide" />
        </div>
    </div>
</div>
