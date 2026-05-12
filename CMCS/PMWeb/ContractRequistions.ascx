<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ContractRequistions.ascx.vb" Inherits="Website.ContractRequistions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInvoices">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInvoices" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy> 
    
    <telerik:RadGrid Id="rdgInvoices" AllowMultiRowSelection="false" runat="server"  CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                         ShowGroupPanel="true"   HeaderStyle-Font-Size="8"  
                         AutoGenerateColumns="False"     AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                         PageSize="250">
           
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage"  TableLayout="Fixed" EnableHeaderContextMenu="true" ShowFooter ="true" ShowGroupFooter="true">
                            <Columns>
                               
                            
                             
                             <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="RecordNumber" SortExpression ="RecordNumber" AllowFiltering="false"
                                 GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                                 <ItemTemplate>
                                  <asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap" 
                            Text='<%#Eval("RecordNumber").ToString%>'
                            NavigateUrl='<%# "~/Requisitions.aspx?Id=" & CStr(Container.DataItem("Id"))%>'></asp:HyperLink>
                                 </ItemTemplate>
                                 <HeaderStyle Width="150px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                              <telerik:GridTemplateColumn HeaderText="Invoice #" UniqueName="Number" SortExpression ="Number" DataField="Number"
                                 GroupByExpression="Number [GridColumn_Number] Group By Number ASC">
                                 <ItemTemplate>
                                     <span><%#Eval("Number").ToString%></span>&nbsp;
                                 </ItemTemplate>
                                 <HeaderStyle Width="150px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                             <telerik:GridTemplateColumn HeaderText="Cost Period" UniqueName="Period" SortExpression ="Period" DataField="Period"
                                GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("Period") = String.Empty, "&nbsp;", Eval("Period"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="170px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                                <telerik:GridTemplateColumn HeaderText="Invoice Date" UniqueName="InvoiceDate" SortExpression ="InvoiceDate" DataField ="InvoiceDate"
                                GroupByExpression="InvoiceDate [GridColumn_InvoiceDate] Group By InvoiceDate ASC">
                                 <ItemTemplate>
                                         <span><%#If(Eval("InvoiceDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("InvoiceDate")))%></span>
                                 </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="170px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                               <telerik:GridTemplateColumn HeaderText="Invoice Due" UniqueName="DueDate" SortExpression ="DueDate" DataField="DueDate"
                                GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate ASC">
                                 <ItemTemplate>
                                         <span><%#If(Eval("DueDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("DueDate")))%></span>
                                 </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="170px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                          
   <%--                         <telerik:GridTemplateColumn HeaderText="Invoice Type" UniqueName="InvoiceType" SortExpression ="InvoiceType"
                                GroupByExpression="InvoiceType [GridColumn_InvoiceType] Group By InvoiceType ASC">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("InvoiceType") = String.Empty, "&nbsp;", Eval("InvoiceType"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                             </telerik:GridTemplateColumn>--%>
                             
                            
                                 <telerik:GridTemplateColumn HeaderText="Total This Invoice" UniqueName="TotalThisInvoice" DataField ="TotalThisInvoice"  Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                Groupable="false" Reorderable="true" SortExpression ="TotalThisInvoice">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("TotalThisInvoice"))%></span>
                                </ItemTemplate>
                                 
                                <FooterStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="170px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                                
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status" DataField="Status"
                                GroupByExpression="Status [GridColumn_Status] Group By Status ASC" SortExpression ="Status">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("Status") = String.Empty, "&nbsp;", Eval("Status"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                              <telerik:GridTemplateColumn HeaderText="Rev." UniqueName="RevisionNumber" DataField="RevisionNumber"
                                 GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC" SortExpression ="RevisionNumber">
                                 <ItemTemplate>
                                     <span><%#Eval("RevisionNumber").ToString%></span>&nbsp;
                                 </ItemTemplate>
                                 <HeaderStyle Width="150px"></HeaderStyle>
                                  <ItemStyle HorizontalAlign="Right"/>
                             </telerik:GridTemplateColumn>
                             
                             <telerik:GridTemplateColumn HeaderText="Date" UniqueName="RevisionDate" DataField="RevisionDate"
                                GroupByExpression="RevisionDate [GridColumn_RevisionDate] Group By RevisionDate ASC" SortExpression ="RevisionDate">
                                 <ItemTemplate>
                                         <span><%#If(Eval("RevisionDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("RevisionDate")))%></span>
                                 </ItemTemplate>
                                 <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="150px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                               <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalThisInvoice" Visible="False" />
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                             <SortExpressions>
                        <telerik:GridSortExpression FieldName="Number" >
                        </telerik:GridSortExpression>
                        </SortExpressions> 
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <b>
                                        <asp:Label ID="lblDisplay" meta:Resourcekey="lblDisplay" Text="Display" runat="server"></asp:Label></b>
                                    <telerik:RadComboBox ID="ddlStatus" Width="150px" DropDownWidth="150px" Height="150px" runat="server" Filter="Contains" MarkFirstMatch="true"
                                        AllowCustomText="True">
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <asp:CheckBox runat="server" ID="chkApply" />
                                                <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply"></asp:Label>
                                                <%#DataBinder.Eval(Container, "Text")%>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdgInvoices.EditIndexes.Count = 0 AND (Not rdgInvoices.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
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
                         <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                         <ClientSettings EnableRowHoverStyle="False" AllowColumnsReorder ="true" AllowDragToGroup="True" AllowRowsDragDrop="False">
                             <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                             <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                 AllowColumnResize="True" />
                         </ClientSettings>
                     </telerik:RadGrid>
