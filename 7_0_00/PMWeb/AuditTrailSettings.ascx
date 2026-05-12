<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AuditTrailSettings.ascx.vb" Inherits="Website.AuditTrailSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
            <telerik:AjaxSetting AjaxControlID="rdgAduditTrail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAduditTrail" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </ajaxsettings>
    </telerik:RadAjaxManagerProxy>
<div style="padding-top:41px">
<telerik:RadGrid ID="rdgAduditTrail" runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                            AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" SetWidth="true" AllowPaging="true" PageSize="250" FitPageHeightOffset="1"
                            AllowMultiRowEdit="True"  AllowFilteringByColumn="true" ShowGroupPanel="true" AllowMultiRowSelection="true" >
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"  />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage"  AllowSorting="true" EditMode="InPlace">
                                <Columns>
                                       <telerik:GridTemplateColumn HeaderText="Record Type"  Groupable="false" 
                                       DataField="RecordType" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="RecordType" UniqueName="RecordType">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%#Eval("RecordType")%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="180px" />
                                        </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Module" GroupByExpression="Module [GridColumn_Module] Group By Module ASC"
                                             DataField="Module" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="Module" UniqueName="Module">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Module") = String.Empty, "&nbsp;", Container.DataItem("Module"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%#Eval("Module")%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="180px" />
                                        </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Active" DataField="IsActive"  AutoPostBackOnFilter="true" DataType="System.Boolean"
                         UniqueName="IsActive"   HeaderStyle-Width="120px"  ItemStyle-Wrap="false" 
SortExpression="IsActive" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="IsActive [GridColumn_IsActive] Group By IsActive ASC">
<ItemTemplate>
<img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
</ItemTemplate>
<EditItemTemplate>
<asp:CheckBox ID="chbIsActive" Checked='<%# Cbool(IIF(Eval("IsActive") is system.DBNULL.value, 0,Eval("IsActive")))%>' runat="server" class="mobile-switch" />
</EditItemTemplate>
</telerik:GridTemplateColumn>    
                                           
                                </Columns>             
                                <SortExpressions>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <div style="padding:2px">
                               
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows"  CssClass="GridCmdEditRows" Visible='<%# rdgAduditTrail.EditIndexes.Count = 0 AND (Not rdgAduditTrail.MasterTableView.IsItemInserted) %>'>
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>                        
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited" Visible='<%# rdgAduditTrail.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                           
                                    
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll"  CssClass="GridCmdCancelAll" Visible='<%# rdgAduditTrail.EditIndexes.Count > 0 Or rdgAduditTrail.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                   
                                 
                                    
                          
                                    
                                </div>
                            </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                          <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                          AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                          <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="UpdateEdited" />
                        </telerik:RadGrid>
    </div>