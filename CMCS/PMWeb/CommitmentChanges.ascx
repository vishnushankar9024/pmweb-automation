<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CommitmentChanges.ascx.vb" Inherits="Website.CommitmentChanges" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgChanges">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgChanges" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy> 
    
    <telerik:RadGrid Id="rdgChanges" AllowMultiRowSelection="false" runat="server" CssClass="WithoutTopBorder"
                         ShowGroupPanel="true"   HeaderStyle-Font-Size="8"   AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                         AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
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
                            NavigateUrl='<%# "~/CommitmentCO.aspx?Id=" & CStr(Container.DataItem("Id"))%>'></asp:HyperLink>
                                 </ItemTemplate>
                                 <HeaderStyle Width="40px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                             
                                <telerik:GridTemplateColumn HeaderText="CO Date" UniqueName="CODate" SortExpression ="CODate" DataField="CODate" 
                                GroupByExpression="CODate [GridColumn_CODate] Group By CODate ASC">
                                 <ItemTemplate>
                                         <span><%#If(Eval("CODate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("CODate")))%></span>
                                 </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="60px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                               <telerik:GridTemplateColumn HeaderText="Assigned To" UniqueName="AssignedTo" DataField="AssignedTo"
                                GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" SortExpression ="AssignedTo">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("AssignedTo") = String.Empty, "&nbsp;", Eval("AssignedTo"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                             <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                                GroupByExpression="Description [GridColumn_Description] Group By Description ASC" SortExpression ="Description">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                             
                               <telerik:GridTemplateColumn HeaderText="Effective Date" UniqueName="EffectiveDate" SortExpression ="EffectiveDate" DataField="EffectiveDate"
                                GroupByExpression="EffectiveDate [GridColumn_EffectiveDate] Group By EffectiveDate ASC">
                                 <ItemTemplate>
                                         <span><%#If(Eval("EffectiveDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("EffectiveDate")))%></span>
                                 </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="60px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                          
                            <telerik:GridTemplateColumn HeaderText="Post As" UniqueName="PostAs" SortExpression ="PostAs" DataField="PostAs"
                                GroupByExpression="PostAs [GridColumn_PostAs] Group By PostAs ASC">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("PostAs") = String.Empty, "&nbsp;", Eval("PostAs"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="60px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                            
                                 <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Totalchange" DataField ="Totalchange"
                                Groupable="false" Reorderable="true" SortExpression ="Totalchange">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("Totalchange"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                </ItemTemplate>
                                 
                                <FooterStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                                
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="Days" UniqueName="DaysPlusMinus" DataField="Days"
                                GroupByExpression="Days [GridColumn_Days] Group By Days ASC" SortExpression ="Days">
                                 <ItemTemplate>
                                     <span><%#FormatNumber(Eval("Days"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="40px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                             </telerik:GridTemplateColumn>
                             
                            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status" DataField="Status"
                                GroupByExpression="Status [GridColumn_Status] Group By Status ASC" SortExpression ="Status">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("Status") = String.Empty, "&nbsp;", Eval("Status"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                              <telerik:GridTemplateColumn HeaderText="Rev." UniqueName="RevisionNumber" DataField="RevisionNumber"
                                 GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC" SortExpression ="RevisionNumber">
                                 <ItemTemplate>
                                     <span><%#Eval("RevisionNumber").ToString%></span>&nbsp;
                                 </ItemTemplate>
                                 <HeaderStyle Width="30px"></HeaderStyle>
                                  <ItemStyle HorizontalAlign="Right"/>
                             </telerik:GridTemplateColumn>
                             
                             <telerik:GridTemplateColumn HeaderText="Date" UniqueName="RevisionDate" DataField="RevisionDate" 
                                GroupByExpression="RevisionDate [GridColumn_RevisionDate] Group By RevisionDate ASC" SortExpression ="RevisionDate">
                                 <ItemTemplate>
                                         <span><%#If(Eval("RevisionDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("RevisionDate")))%></span>
                                 </ItemTemplate>
                                 <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="70px"></HeaderStyle>
                             </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Change Converted" Visible="false" UniqueName="TotalChangeConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalChangeConverted"  DataField ="TotalChangeConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("TotalChangeConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalChangeTotalCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                             <SortExpressions>
                        <telerik:GridSortExpression FieldName="RecordNumber" >
                        </telerik:GridSortExpression>
                        </SortExpressions> 
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <b><asp:Label ID="lblDisplay" meta:Resourcekey="lblDisplay" Text="Display" runat="server"></asp:Label></b>
                                        <telerik:RadComboBox ID="ddlStatus" width="150px" DropDownWidth="150px" height="150px" runat="server"
                                        AllowCustomText="True"   >
                                            <itemtemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApply" 
                                                />
                                            <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply" 
                                                ></asp:Label>
                                                <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                            </itemtemplate>
                                        </telerik:RadComboBox>
                                      <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdgChanges.EditIndexes.Count = 0 AND (Not rdgChanges.MasterTableView.IsItemInserted) %>'>
                                      <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                     <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                        runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
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
