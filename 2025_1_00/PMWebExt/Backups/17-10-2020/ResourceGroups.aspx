<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ResourceGroups.aspx.vb" Inherits="Website.ResourceGroups" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>
        
      </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr>
        <td>
           <table style="width: 100%;" cellpadding="3" cellspacing="0" >
            <tr class="ToolBar">
                <td style="width: 100px"><b><asp:Label ID="lblResourceGroups" meta:Resourcekey="lblResourceGroups" runat="server" Text="Resource Groups"></asp:Label></b></td>
                <td>              
              
                </td>
             </tr>
            </table>
        </td>
    </tr>
     <tr>
        <td style="height:8px">
            <table width="100%" id="tblMain" runat="server" cellpadding="0" cellspacing="0" >               
                <tr>
                    <td >
                        <telerik:RadGrid ID="rdgGroups" runat="server"   HeaderStyle-Font-Size="8"
                            AutoGenerateColumns="False" ShowStatusBar="true" Width="100%"
                            AllowMultiRowEdit="True" AllowMultiRowSelection="true" ShowGroupPanel="True" >
                            <PagerStyle Mode="NextPrevAndNumeric" />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                       <telerik:GridTemplateColumn HeaderText="ID" Groupable="false" UniqueName="ID">
                                            <ItemTemplate>
                                                <%#Container.DataItem("Id")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                               &nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="30px" />
                                        </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Description" SortExpression="GroupName" UniqueName="Description"
                            GroupByExpression="GroupName [GridColumn_Description] Group By GroupName ASC" >
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("GroupName") = String.Empty, "&nbsp;", Container.DataItem("GroupName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("GroupName") %>' Width="100%"
                                    MaxLength="100"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription" Display="Dynamic"
                                    runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn HeaderText="Classification" SortExpression="Classification" UniqueName="Classification"
                            GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Classification") = "", "&nbsp;", Container.DataItem("Classification"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%"    meta:resourcekey="ddlResourceClasses"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                    NoWrap="True"  EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" 
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="180px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Pay Type" SortExpression="PayType" UniqueName="PayType"
                            GroupByExpression="PayType [GridColumn_PayType] Group By PayType ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("PayType") = "", "&nbsp;", Container.DataItem("PayType"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlResourcePayTypes" runat="server" Width="100%"  meta:resourcekey="ddlResourcePayTypes"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" 
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                                    MaxLength="500"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                                </Columns>             
                                <SortExpressions>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <div style="padding:2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" CssClass="GridCmdEditRows"  Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>                        
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgGroups.EditIndexes.Count > 0 %>'>
                                       <span class="Icon"></span>
                                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Add"
                                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgGroups.MasterTableView.IsItemInserted %>'>
                                      <span class="Icon"></span>
                                        <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgGroups.EditIndexes.Count > 0 Or rdgGroups.MasterTableView.IsItemInserted %>'>
                                       <span class="Icon"></span>
                                        <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                   
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" 
                                        SecurityButtonType="ItemMode_Add"
                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                       <span class="Icon"></span>
                                       <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                        SecurityButtonType="ItemMode_Delete"
                                        Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;</asp:LinkButton>
                                       
                                    
                                     <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                         Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>   
                                     </asp:LinkButton>
                                   
                          
                                    
                                </div>
                            </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="true">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</asp:Content>
