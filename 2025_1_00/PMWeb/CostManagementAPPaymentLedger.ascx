<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementAPPaymentLedger.ascx.vb" Inherits="Website.CostManagementAPPaymentLedger" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAPPaymentLedger">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAPPaymentLedger" LoadingPanelID="ldpPM" />
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
            <telerik:RadGrid ID="rdgAPPaymentLedger" runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="WithoutTopBorder" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                PageSize="250" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true" Width="100%">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace" Width="100%">

                    <Columns>

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" UniqueName="RecordId" ItemStyle-Wrap="false" HeaderText="ID" Groupable="true" Reorderable="true"
                            SortExpression="RecordId" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC">
                            <ItemTemplate>
                                <a runat="server" id="hypID" href='<%#Eval("RecordUrl")%>'><%# IIf(Eval("RecordId") = 0, "&nbsp;", Eval("RecordId"))%> </a>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle  HorizontalAlign="Right"/>
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

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Commitment" ItemStyle-Wrap="false" HeaderText="A/P Contract" Groupable="true" Reorderable="true"
                            SortExpression="Commitment" GroupByExpression="Commitment [GridColumn_Commitment] Group By Commitment ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Commitment")) = String.Empty, "&nbsp;", Eval("Commitment"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="LinkedInvoice" ItemStyle-Wrap="false" HeaderText="Linked A/P Invoice" Groupable="true" Reorderable="true"
                            SortExpression="LinkedInvoice" GroupByExpression="LinkedInvoice [GridColumn_LinkedInvoice] Group By LinkedInvoice ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("LinkedInvoice")) = String.Empty, "&nbsp;", Eval("LinkedInvoice"))%></span>
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
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" Visible='<%# rdgAPPaymentLedger.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;

                         <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion"
                             OnClientClick="return OpenPreviewConversion();" Style="float: none !important" CssClass="GridPreviewConversion"
                             SecurityButtonType="ItemMode"
                             Visible='<%# rdgAPPaymentLedger.EditIndexes.Count = 0 And (Not rdgAPPaymentLedger.MasterTableView.IsItemInserted)%>'
                             meta:resourcekey="btnRefreshResource1">
                             <span class="Icon"></span>
                             <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                             &nbsp;&nbsp;
                         </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="true" />
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
