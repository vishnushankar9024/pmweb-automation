<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BidderMatrix.ascx.vb" Inherits="Website.BidderMatrix" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgProcurementBidders" Width="100%" runat="server" AllowFilteringByColumn="true"
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AutoGenerateColumns="False" AllowPaging="True" PageSize="250"
                HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True"
                AllowSorting="true" CssClass="WithoutTopBorder" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                    <Columns>
                         <telerik:GridTemplateColumn HeaderStyle-Width="50px" ItemStyle-Wrap="false" HeaderText="Award" UniqueName="Award" Groupable="false" DataField="HasAward" DataType="System.Boolean">
                            <ItemTemplate>
                                <div class="<%# CStr(IIf(Eval("HasAward"), "AwardButton", "EmptyButton"))%>">
                                    <span class="Icon"></span>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="<%# CStr(IIf(Eval("HasAward"), "AwardButton", "EmptyButton"))%>">
                                    <span class="Icon"></span>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" DataField="CompanyName" ItemStyle-Wrap="false" HeaderText="Company" SortExpression="CompanyName" UniqueName="CompanyName" GroupByExpression="CompanyName [GridColumn_CompanyName] Group By CompanyName ASC">
                            <ItemTemplate>
                                <%#Eval("CompanyName").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("CompanyName").ToString%>&nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" DataField="IsNDAAccepted" DataType="System.Boolean" ItemStyle-Wrap="false" HeaderText="IsNDAAccepted" UniqueName="IsNDAAccepted" SortExpression="IsNDAAccepted" GroupByExpression="IsNDAAccepted [GridColumn_IsNDAAccepted] Group By IsNDAAccepted ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsNDAAccepted")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />

                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkNDAAccepted" Checked='<%# CBool(Eval("IsNDAAccepted"))%>' runat="server" class="mobile-switch" />

                            </EditItemTemplate>


                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" DataField="AcceptanceStatus" ItemStyle-Wrap="false" HeaderText="Invitation Status" SortExpression="AcceptanceStatus" UniqueName="AcceptanceStatus" GroupByExpression="AcceptanceStatus [GridColumn_AcceptanceStatus] Group By AcceptanceStatus ASC">
                            <ItemTemplate>
                                <%#Eval("AcceptanceStatus").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("AcceptanceStatus").ToString%>&nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="120"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" AllowFiltering="false" ItemStyle-Wrap="false" HeaderText="Best Bid" Groupable="false" UniqueName="BestBid" SortExpression="Id">
                            <ItemTemplate>
                                <a runat="server" id="hypbestbid" href='<%#GetUrlByObjectType(Library.PmEstimate.BidderInfo.OBJECT_TYPE, Eval("Id").ToString)%>'><%#Eval("Id").ToString%> </a>
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnBestBid" runat="server" Visible="false" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                </asp:LinkButton>


                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("Id").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="50px" ItemStyle-Wrap="false" DataField="RevisionNumber" HeaderText="Bid Rev." SortExpression="RevisionNumber" UniqueName="RevNumber" GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC">
                            <ItemTemplate>
                                <%#Eval("RevisionNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("RevisionNumber")%>&nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" DataField="BidStatus" ItemStyle-Wrap="false" HeaderText="Bid Status" SortExpression="BidStatus" UniqueName="BidStatus" GroupByExpression="BidStatus [GridColumn_BidStatus] Group By BidStatus ASC">
                            <ItemTemplate>
                                <%#Eval("BidStatus").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("BidStatus").ToString%>&nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" DataField="MatrixBidTotal" ItemStyle-Wrap="false" HeaderText="Bid Total" UniqueName="MatrixBidTotal" SortExpression="MatrixBidTotal" GroupByExpression="MatrixBidTotal [GridColumn_MatrixBidTotal] Group By MatrixBidTotal ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Eval("MatrixBidTotal"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBidTotal" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("MatrixBidTotal"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" DataField="MatrixLeveledTotal" ItemStyle-Wrap="false" HeaderText="Leveled Total" UniqueName="MatrixLeveledTotal" SortExpression="MatrixLeveledTotal" GroupByExpression="MatrixLeveledTotal [GridColumn_MatrixLeveledTotal] Group By MatrixLeveledTotal ASC">
                            <ItemTemplate>
                                <%#FormatCurrency(Eval("MatrixLeveledTotal"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLeveledTotal" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("MatrixLeveledTotal"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" AllowFiltering="false" ItemStyle-Wrap="false" UniqueName="MatrixDaysTotal" GroupByExpression="MatrixDaysTotal [GridColumn_MatrixDaysTotal] Group By MatrixDaysTotal ASC">
                            <HeaderTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" CommandArgument="MatrixDaysTotal" CommandName="Sort" ID="lnkDaysTotal" Text="Days total" meta:resourcekey="lnkDaysTotal"></asp:LinkButton>
                                            <asp:Button runat="server" ID="btnimgDaysTotal" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnOpendaystotal" OnClientClick="return OpenBidderDaysRecapPopup();" runat="server" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Eval("MatrixDaysTotal")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDaysTotal" runat="server" Text='<%#Eval("MatrixDaysTotal")%>' CssClass="PositiveInteger" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" ItemStyle-Wrap="false" DataField="MatrixMWDBE" UniqueName="MatrixMWDBE" GroupByExpression="MatrixMWDBE [GridColumn_MatrixMWDBE] Group By MatrixMWDBE ASC">
                            <HeaderTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" ID="lnkMWDBE" Text="MWDBE %" CommandArgument="MatrixMWDBE" CommandName="Sort" meta:resourcekey="lnkMWDBE"></asp:LinkButton>
                                            <asp:Button runat="server" ID="btnimgMWDBE" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnOpenMWDBE" runat="server" OnClientClick="return OpenBidderMWDBERecapPopup();" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#FormatPercent(Eval("MatrixMWDBE"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMWDBE" runat="server" Text='<%#FormatPercent(Eval("MatrixMWDBE")) %>' CssClass="Percent" MaxNumber="100" MinNumber="0" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" DataField="MatrixAcknowledged" UniqueName="MatrixAcknowledged" GroupByExpression="MatrixAcknowledged [GridColumn_MatrixAcknowledged] Group By MatrixAcknowledged ASC">
                            <HeaderTemplate>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" ID="lnkAcknowledged" CommandArgument="MatrixAcknowledged" CommandName="Sort" meta:resourcekey="lnkAcknowledged" Text="Acknowledged">
                                            </asp:LinkButton>
                                            <asp:Button runat="server" ID="btnimgAcknowledged" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnopenAcknowledge" OnClientClick="return OpenBidAcknowledgementRecapPopup();" runat="server" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#FormatPercent(Eval("MatrixAcknowledged"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAcknowledged" runat="server" Text='<%#FormatPercent(Eval("MatrixAcknowledged")) %>' CssClass="Percent" MaxNumber="100" MinNumber="0" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" DataField="MatrixScore" ItemStyle-Wrap="false" HeaderText="Score" SortExpression="MatrixScore" UniqueName="MatrixScore" GroupByExpression="MatrixScore [GridColumn_MatrixScore] Group By MatrixScore ASC">
                            <ItemTemplate>
                                <%#FormatNumber(Eval("MatrixScore"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScore" runat="server" Text='<%#FormatNumber(Eval("MatrixScore"))%>' CssClass="PositiveDouble" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="90px" DataField="COFee" ItemStyle-Wrap="false" HeaderText="CO Fee" SortExpression="COFee" UniqueName="COFee" GroupByExpression="COFee [GridColumn_COFee] Group By COFee ASC">
                            <ItemTemplate>
                                <%# FormatPercent(Eval("COFee"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCOFee" runat="server" Text='<%#FormatPercent(Eval("COFee")) %>' CssClass="Percent" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" DataField="AvailableToStart" HeaderText="Available To Start" SortExpression="AvailableToStart" UniqueName="AvailableToStart" GroupByExpression="AvailableToStart [GridColumn_AvailableToStart] Group By AvailableToStart ASC">
                            <ItemTemplate>
                                <%# If(Eval("AvailableToStart") Is DBNull.Value, "", FormatDate(Eval("AvailableToStart")))%>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpAvailableToStart" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>

                            <ItemStyle CssClass="Right" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" DataField="MatrixRating" ItemStyle-Wrap="false" HeaderText="Rating" SortExpression="MatrixRating" UniqueName="MatrixRating" GroupByExpression="MatrixRating [GridColumn_MatrixRating] Group By MatrixRating ASC">
                            <ItemTemplate>
                                <%#FormatNumber(Eval("MatrixRating"), 1)%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRating" runat="server" Precision="1" Text='<%#FormatNumber(Eval("MatrixRating"), 1) %>' CssClass="PositiveDouble" MaxNumber="5" MinNumber="0" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle CssClass="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" DataField="MatrixBidExpires" ItemStyle-Wrap="false" HeaderText="Bid Expires" SortExpression="MatrixBidExpires" UniqueName="MatrixBidExpires" GroupByExpression="MatrixBidExpires [GridColumn_MatrixBidExpires] Group By MatrixBidExpires ASC">
                            <ItemTemplate>
                                <%#If(Eval("MatrixBidExpires") Is DBNull.Value, "", FormatDate(Eval("MatrixBidExpires")))%>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpBidExpires" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>

                            <ItemStyle CssClass="Right" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" DataField="MatrixComments" HeaderText="Bidder Comments" SortExpression="MatrixComments" UniqueName="MatrixComments" GroupByExpression="MatrixComments [GridColumn_MatrixComments] Group By MatrixComments ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixComments").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBidderComments" runat="server" Text='<%#Eval("MatrixComments")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgBidderComments" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgBidderComments','txtBidderComments'))">
    					    <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" DataField="MatrixContact" ItemStyle-Wrap="false" HeaderText="Contact" UniqueName="MatrixContact" SortExpression="MatrixContact" GroupByExpression="MatrixContact [GridColumn_MatrixContact] Group By MatrixContact ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixContact").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtContact" MaxLength="100" runat="server" Text='<%# Eval("MatrixContact") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" DataField="MatrixPhone" ItemStyle-Wrap="false" HeaderText="Phone" UniqueName="MatrixPhone" SortExpression="MatrixPhone" GroupByExpression="MatrixPhone [GridColumn_MatrixPhone] Group By MatrixPhone ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixPhone").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#Eval("MatrixPhone") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" DataField="MatrixExt" ItemStyle-Wrap="false" HeaderText="Ext" UniqueName="MatrixExt" SortExpression="MatrixExt" GroupByExpression="MatrixExt [GridColumn_MatrixExt] Group By MatrixExt ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixExt").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExt" Width="100%" MaxLength="10" Text='<%# Eval("MatrixExt") %>' runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="160px" ItemStyle-Wrap="false" DataField="MatrixEmail" HeaderText="Email" UniqueName="MatrixEmail" SortExpression="MatrixEmail" GroupByExpression="MatrixEmail [GridColumn_MatrixEmail] Group By MatrixEmail ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixEmail").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("MatrixEmail") %>' Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RegularExpressionValidator ID="rfvEmail" CssClass="Validator" meta:resourcekey="rfvEmail"
                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        runat="server" ValidationGroup="Save" Display="Dynamic" ErrorMessage="example@domain.com">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" DataField="MatrixNotes" HeaderText="Notes" UniqueName="MatrixNotes" SortExpression="MatrixNotes" GroupByExpression="MatrixNotes [GridColumn_MatrixNotes] Group By MatrixNotes ASC">
                            <ItemTemplate>
                                <%#Eval("MatrixNotes").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("MatrixNotes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					     <span class="Icon"></span>
                                </asp:LinkButton>


                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" DataField="Inactive" DataType="System.Boolean" HeaderText="Inactive" UniqueName="Inactive" SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>' runat="server" class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgProcurementBidders.EditIndexes.Count = 0 %>' meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgProcurementBidders.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgProcurementBidders.EditIndexes.Count > 0 %>' meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddBidders" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" Width="90px"
                                CommandName="AddBidders" CssClass="GridCmdAddBidders" OnClientClick="return OpenMultipleCompaniesPopup();" Visible='<%# rdgProcurementBidders.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddBidders" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAward1" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit"
                                CommandName="Award" CssClass="GridCmdAward" Visible='<%# rdgProcurementBidders.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAward" runat="server" Text="Award"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return DeleteSelectedLines('rdgProcurementBidders');"
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" Visible='<%# rdgProcurementBidders.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgProcurementBidders.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:Label ID="lblDisplay" runat="server" meta:resourcekey="lblDisplay" Text="Display"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;   
                        <telerik:RadCombobox ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDisplay_OnSelectedIndexChanged">
                            <Items>
                             <telerik:RadComboBoxItem meta:Resourcekey="ListItemAll" Value="0" Text="-- All --" Selected="True"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemActiveBiddersOnly" Value="1" Text="Active Bidders Only"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemInactiveBiddersOnly" Value="2" Text="Inactive Bidders Only"></telerik:RadComboBoxItem>
                            </Items>
                   
                        </telerik:RadCombobox>
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
        </div>
    </div>
</div>


<asp:Button ID="btnRefreshBidder" runat="server" CssClass="Hide" />