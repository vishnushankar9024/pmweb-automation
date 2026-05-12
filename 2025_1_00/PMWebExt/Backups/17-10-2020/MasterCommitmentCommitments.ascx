<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MasterCommitmentCommitments.ascx.vb" Inherits="Website.MasterCommitmentCommitments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
              <telerik:RadGrid Id="rdgCommitments" AllowMultiRowSelection="true" runat="server"  CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                         ShowGroupPanel="true"   HeaderStyle-Font-Size="8"  
                         AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                         PageSize="15">
                  
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage"  TableLayout="Fixed"  EnableHeaderContextMenu="true" ShowFooter ="true" ShowGroupFooter="true">
                            <Columns>
                            
                             
                             <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="CommitmentCode" SortExpression ="CommitmentCode" DataField="CommitmentCode"
                                 GroupByExpression="CommitmentCode [GridColumn_CommitmentCode] Group By CommitmentCode ASC">
                                 <ItemTemplate>
                                  <asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap" 
                            Text='<%#Eval("CommitmentCode").ToString%>'
                            NavigateUrl='<%#Eval("CommitmentUrl").ToString%>'></asp:HyperLink>
                                 </ItemTemplate>
                                 <HeaderStyle Width="40px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                              <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" SortExpression ="ProjectName"
                                GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC" DataField="ProjectName">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("ProjectName") = String.Empty, "&nbsp;", Eval("ProjectName"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                              <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression ="Description"
                                GroupByExpression="Description [GridColumn_Description] Group By Description ASC" DataField="Description">
                                 <ItemTemplate>
                                     <span><%#IIf(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                 </ItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                               <telerik:GridTemplateColumn HeaderText="Effective Date" UniqueName="EffectiveDate" SortExpression ="EffectiveDate" DataField="EffectiveDate"
                                GroupByExpression="EffectiveDate [GridColumn_EffectiveDate] Group By EffectiveDate ASC">
                                 <ItemTemplate>
                                         <span><%#If(Eval("EffectiveDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("EffectiveDate")))%></span>
                                 </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="60px"></HeaderStyle>
                             </telerik:GridTemplateColumn>
                             
                             <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status"
                                GroupByExpression="Status [GridColumn_Status] Group By Status ASC" SortExpression ="Status" DataField="Status">
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
                             
                               <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                                 GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC" DataField="Currency">
                                    <ItemTemplate>
                                        <span><%#Eval("Currency")%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            
                                 <telerik:GridTemplateColumn HeaderText="Original Value" UniqueName="OriginalCommitment" DataField ="OriginalCommitment"
                                Groupable="false" Reorderable="true" SortExpression ="OriginalCommitment">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("OriginalCommitment"), CurrencyId:=Eval("CurrencyId"))%></span>
                                </ItemTemplate>
                                 
                                <FooterStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                                
                            </telerik:GridTemplateColumn>
                            
                            
                                 <telerik:GridTemplateColumn HeaderText="Approved Changes" UniqueName="ApprovedChanges" DataField ="ApprovedChanges"
                                Groupable="false" Reorderable="true" SortExpression ="ApprovedChanges">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("ApprovedChanges"), CurrencyId:=Eval("CurrencyId"))%></span>
                                </ItemTemplate>
                                 
                                <FooterStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                                
                            </telerik:GridTemplateColumn>
                            
                            
                            
                                 <telerik:GridTemplateColumn HeaderText="Revised Value" UniqueName="Revised" DataField ="Revised"
                                Groupable="false" Reorderable="true" SortExpression ="Revised">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("Revised"), CurrencyId:=Eval("CurrencyId"))%></span>
                                </ItemTemplate>
                                 
                                <FooterStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                                
                            </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                             <SortExpressions>
                        <telerik:GridSortExpression FieldName="CommitmentCode" >
                        </telerik:GridSortExpression>
                        </SortExpressions> 
                            <CommandItemTemplate>
                            <div style="padding: 2px">
                                   <%-- <td style="padding-left:5px;">
                                        <b><asp:Label ID="lblDisplay" meta:Resourcekey="lblDisplay" Text="Display" runat="server"></asp:Label></b>
                                    </td>
                                    <td style="padding-left:5px;"> 
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
                                   
                                    </td>                  --%>      

                                      <asp:LinkButton ID="btnAddCommitment" SecurityButtonType="ItemMode_Add" OnClientClick="return GoToCommitment()" CssClass="GridCmdInitNewCommitment"
                                            runat="server" CausesValidation="False" CommandName="InitNewCommitment"
                                                 meta:resourcekey="btnAddResource1">
                                               <span class="Icon"></span>
                                                <asp:Label ID="lblAddCommitment" runat="server" Text="Add Commitment" meta:resourcekey="lblAddCommitment"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                          <asp:LinkButton ID="btnAddLink" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLinkCommitments"
                                              CommandName="LinkCommitments" runat="server" CausesValidation="False"
                                                 OnClientClick="return OpenPOPUp('CostManagementLinkCommitmentToMaster.aspx',960, 500,true);"
                                                Visible='<%# rdgCommitments.EditIndexes.Count = 0 AND (Not rdgCommitments.MasterTableView.IsItemInserted) %>'>
                                               <span class="Icon"></span>
                                                <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                 <asp:LinkButton ID="btnUnlinkCommitments"  CausesValidation="False" CssClass="GridCmdRemoveCommitmentLink"
                                      OnClientClick="javascript:return ConfirmUnlinkCommitments();"
                                SecurityButtonType="ItemMode_Edit"  Visible='<%# rdgCommitments.EditIndexes.Count = 0 AND (Not rdgCommitments.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="RemoveCommitmentLink" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                                      <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode" 
                                        Visible='<%# rdgCommitments.EditIndexes.Count = 0 AND (Not rdgCommitments.MasterTableView.IsItemInserted) %>' >
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                     &nbsp;&nbsp;
                                    </asp:LinkButton>
                              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
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
                         <ClientSettings EnableRowHoverStyle="False" AllowColumnsReorder="true" AllowDragToGroup="True" AllowRowsDragDrop="False">
                             <Selecting AllowRowSelect="False" EnableDragToSelectRows="true" />
                             <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                 AllowColumnResize="True" />
                         </ClientSettings>
                     </telerik:RadGrid>
        </div>
    </div>
</div>
    
  
