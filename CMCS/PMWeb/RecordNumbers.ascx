<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RecordNumbers.ascx.vb" Inherits="Website.RecordNumbers" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
            <telerik:AjaxSetting AjaxControlID="rdgRecordNumbers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgRecordNumbers" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
        </ajaxsettings>
    </telerik:RadAjaxManagerProxy>
<div>
<telerik:RadGrid ID="rdgRecordNumbers" runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                            AutoGenerateColumns="False" ShowStatusBar="false" Width="100%" AllowPaging="true" PageSize="250" SetWidth="true" UseEditFormInMobile ="true" FitPageHeightOffset="1"
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
                                        
                                         <telerik:GridTemplateColumn   GroupByExpression="UniqueBy [GridColumn_UniqueBy] Group By UniqueBy ASC"
                                           DataField="UniqueBy"  AutoPostBackOnFilter="true" DataType="System.String" HeaderText="Unique By" SortExpression="UniqueBy" UniqueName="UniqueBy">
                                            <ItemTemplate>
                                                <%#Container.DataItem("UniqueBy")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlUniqueBy" runat="server"  
                                                    Width="100%">
                                                </telerik:RadComboBox>
                                                
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn> 
                                        
                                          <telerik:GridTemplateColumn  GroupByExpression="NextNumber [GridColumn_NextNumber] Group By NextNumber ASC"
                                           DataField="NextNumber"  AutoPostBackOnFilter="true" DataType="System.String" HeaderText="Next #" SortExpression="NextNumber" UniqueName="NextNumber">
                                            <ItemTemplate>
                                                <%#Container.DataItem("NextNumber")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                    <asp:TextBox ID="txtNextNumber"  runat="server" Width="100%" 
                        MaxLength="9" Text='<%#Eval("NextNumber")  %>'
                       ></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn> 
                       <telerik:GridTemplateColumn HeaderText="Auto Increment" DataField="AutoIncrement"  AutoPostBackOnFilter="true" DataType="System.Boolean"
                         UniqueName="AutoIncrement"   HeaderStyle-Width="120px"  ItemStyle-Wrap="false" 
SortExpression="AutoIncrement" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="AutoIncrement [GridColumn_AutoIncrement] Group By AutoIncrement ASC">
<ItemTemplate>
<img src="Images/Global/<%#CStr(IIF(Cbool(Eval("AutoIncrement"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
</ItemTemplate>
<EditItemTemplate>
<asp:CheckBox ID="chbShowNotification" Checked='<%# Cbool(IIF(Eval("AutoIncrement") is system.DBNULL.value, 0,Eval("AutoIncrement")))%>' runat="server" />
</EditItemTemplate>
</telerik:GridTemplateColumn>    
                                             
                                </Columns>             
                                <SortExpressions>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <div style="padding:2px">
                                 
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" CssClass="GridCmdEditRows"  Visible='<%# rdgRecordNumbers.EditIndexes.Count = 0 AND (Not rdgRecordNumbers.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span> 
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>                        
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"  Visible='<%# rdgRecordNumbers.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                           
                                    
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgRecordNumbers.EditIndexes.Count > 0 Or rdgRecordNumbers.MasterTableView.IsItemInserted %>'>
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