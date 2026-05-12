<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetApPaymentLedger.ascx.vb" Inherits="Website.AssetApPaymentLedger" %>
 <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
        <telerik:AjaxSetting AjaxControlID="rdgAPPaymentLedger">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAPPaymentLedger" LoadingPanelID="ldpPM" />
<%--             <telerik:AjaxUpdatedControl ControlID="tblmain" />
             <telerik:AjaxUpdatedControl ControlID="tbldropdown" />--%>
             <telerik:AjaxUpdatedControl ControlID="lblHidenRows" />
            </UpdatedControls>
        </telerik:AjaxSetting>
   </ajaxsettings>
    </telerik:RadAjaxManagerProxy>

     <div class="PMHeader">
         <div class="row">
             <div class="col-12 ResponsiveMargin">
                     <telerik:RadGrid ID="rdgAPPaymentLedger"  runat="server"   AutoGenerateColumns="False" AllowPaging="True" PageSize="250" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"  Width="100%"
                 HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true" >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
            
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace" Width="100%">
  
                <Columns>
  
                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" UniqueName="RecordId"  ItemStyle-Wrap="false" HeaderText="ID" Groupable="true" Reorderable="true"
                                               SortExpression="RecordId" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC" > 
                        <ItemTemplate>
                            <a  runat="server" id="hypID"  href='<%#Eval("RecordUrl")%>'> <%# IIf(Eval("RecordId") = 0, "&nbsp;", Eval("RecordId"))%> </a>
                        </ItemTemplate>
                        <HeaderStyle Width="10%" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Program"  ItemStyle-Wrap="false" HeaderText="Program*" Groupable="true" Reorderable="true"
                                               SortExpression="ProgramName" GroupByExpression="Program [GridColumn_Program] Group By Program ASC" > 
                        <ItemTemplate> 
                            <span><%# IIf(CStr(Eval("Program")) = String.Empty, "&nbsp;", Eval("Program"))%></span>
                        </ItemTemplate>
                        <HeaderStyle  />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Location"  ItemStyle-Wrap="false" HeaderText="Location" Groupable="true" Reorderable="true"
                                               SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC" > 
                        <ItemTemplate> 
                            <span><%# IIf(CStr(Eval("Location")) = String.Empty, "&nbsp;", Eval("Location"))%></span>
                        </ItemTemplate>
                        <HeaderStyle  />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="Lease"  ItemStyle-Wrap="false" HeaderText="Lease" Groupable="true" Reorderable="true"
                                               SortExpression="Lease" GroupByExpression="Lease [GridColumn_Lease] Group By Lease ASC" > 
                        <ItemTemplate> 
                            <span><%# IIf(CStr(Eval("Lease")) = String.Empty, "&nbsp;", Eval("Lease"))%></span>
                        </ItemTemplate>
                        <HeaderStyle/>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="LinkedInvoice"  ItemStyle-Wrap="false" HeaderText="Linked A/R Invoice" Groupable="true" Reorderable="true"
                                               SortExpression="LinkedInvoice" GroupByExpression="LinkedInvoice [GridColumn_LinkedInvoice] Group By LinkedInvoice ASC" > 
                        <ItemTemplate> 
                            <span><%# IIf(CStr(Eval("LinkedInvoice")) = String.Empty, "&nbsp;", Eval("LinkedInvoice"))%></span>
                        </ItemTemplate>
                        <HeaderStyle />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="AppliedAmount"  ItemStyle-Wrap="false" HeaderText="Applied Amount" Groupable="true" Reorderable="true"
                                               SortExpression="AppliedAmount" GroupByExpression="AppliedAmount [GridColumn_AppliedAmount] Group By AppliedAmount ASC" > 
                        <ItemTemplate> 
                            <span><%# FormatCurrency(Eval("AppliedAmount"))%>&nbsp;</span>
                        </ItemTemplate>
                        <HeaderStyle />
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridTemplateColumn>
                     
                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" UniqueName="PaymentDate" DataField="PaymentDate"  ItemStyle-Wrap="false" HeaderText="Payment Date" Groupable="true" Reorderable="true"
                                               SortExpression="PaymentDate" GroupByExpression="PaymentDate [GridColumn_PaymentDate] Group By PaymentDate ASC" > 
                        <ItemTemplate> 
                            <span><%# If(Eval("PaymentDate") Is DBNull.Value, "&nbsp;", FormatDate(Eval("PaymentDate")))%>&nbsp;</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <HeaderStyle />
                    </telerik:GridTemplateColumn>

                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <ItemStyle Wrap="false" />
                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                         
                <CommandItemTemplate>
                    <div>
               
                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                                                    SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" Visible='<%# rdgAPPaymentLedger.EditIndexes.Count = 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDelete" runat="server" Text="Delete selected line"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                           &nbsp; 
                    </div>
                </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="true" />
                <Selecting AllowRowSelect="true" /></ClientSettings>
            </telerik:RadGrid>
             </div>
         </div>
     </div>
        
