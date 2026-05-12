<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementARPaymentLedger.ascx.vb" Inherits="Website.CostManagementARPaymentLedger" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgARPaymentLedger">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgARPaymentLedger" LoadingPanelID="ldpPM" />
                <%--             <telerik:AjaxUpdatedControl ControlID="tblmain" />
             <telerik:AjaxUpdatedControl ControlID="tbldropdown" />--%>
                <telerik:AjaxUpdatedControl ControlID="lblHidenRows" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgARPaymentLedger" runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="WithoutTopBorder" SetWidth="true" Width="100%" ClientSettings-Scrolling-AllowScroll="true"
                PageSize="250" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                    <Columns>

                        <telerik:GridTemplateColumn HeaderStyle-Width="10%" UniqueName="RecordId" ItemStyle-Wrap="false" HeaderText="ID" Groupable="true" Reorderable="true"
                            SortExpression="RecordId" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC">
                            <ItemTemplate>
                                <a runat="server" id="hypID" href='<%#Eval("RecordUrl")%>'><%# IIf(Eval("RecordId") = 0, "&nbsp;", Eval("RecordId"))%> </a>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Program" ItemStyle-Wrap="false" HeaderText="Program*" Groupable="true" Reorderable="true"
                            SortExpression="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Program")) = String.Empty, "&nbsp;", Eval("Program"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="ProjectFullName" ItemStyle-Wrap="false" HeaderText="Project" Groupable="true" Reorderable="true"
                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProjectFullName")) = String.Empty, "&nbsp;", Eval("ProjectFullName"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Commitment" ItemStyle-Wrap="false" HeaderText="Contract" Groupable="true" Reorderable="true"
                            SortExpression="Contract" GroupByExpression="Contract [GridColumn_Contract] Group By Contract ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Contract")) = String.Empty, "&nbsp;", Eval("Contract"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Requisition" ItemStyle-Wrap="false" HeaderText="Requisition" Groupable="true" Reorderable="true"
                            SortExpression="Requisition" GroupByExpression="Requisition [GridColumn_Requisition] Group By Requisition ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Requisition")) = String.Empty, "&nbsp;", Eval("Requisition"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="AppliedAmount" ItemStyle-Wrap="false" HeaderText="Applied Amount" Groupable="true" Reorderable="true"
                            SortExpression="AppliedAmount" GroupByExpression="AppliedAmount [GridColumn_AppliedAmount] Group By AppliedAmount ASC">
                            <ItemTemplate>
                                <span><%# FormatCurrency(Eval("AppliedAmount"), CurrencyId:=Eval("CurrencyId"))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="PaymentDate" DataField="PaymentDate" ItemStyle-Wrap="false" HeaderText="Payment Date" Groupable="true" Reorderable="true"
                            SortExpression="PaymentDate" GroupByExpression="PaymentDate [GridColumn_PaymentDate] Group By PaymentDate ASC">
                            <ItemTemplate>
                                <span><%# If(Eval("PaymentDate") Is DBNull.Value, "&nbsp;", FormatDate(Eval("PaymentDate")))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                    <CommandItemTemplate>
                        <div>

                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" Visible='<%# rdgARPaymentLedger.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp; 

                        <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion"
                            OnClientClick="return OpenPreviewConversion();" Style="float: none !important" CssClass="GridPreviewConversion"
                            SecurityButtonType="ItemMode"
                            Visible='<%# rdgARPaymentLedger.EditIndexes.Count = 0 And (Not rdgARPaymentLedger.MasterTableView.IsItemInserted)%>'
                            meta:resourcekey="btnRefreshResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="True" />
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
