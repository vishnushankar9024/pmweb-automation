<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InitiativeRating.ascx.vb" Inherits="Website.InitiativeRating" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
.RadRating ul 
{
	width:100px;
	
}

</style>
<telerik:RadAjaxManagerProxy ID="RamEquipment" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRating">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRating" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="rdrating1" />
                <telerik:AjaxUpdatedControl ControlID="lblRating" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:radgrid id="rdgRating" runat="server"   
    autogeneratecolumns="False" headerstyle-font-size="8" showstatusbar="false" headerstyle-horizontalalign="Center"  UseEditFormInMobile ="true"
    allowmultirowedit="True" allowmultirowselection="True" width="100%" edititemstyle-horizontalalign="Center" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
    itemstyle-horizontalalign="Center" AllowSorting="True" 
    gridlines="None" PageSize="10"  AllowPaging="True" ShowGroupPanel="True">
       <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                EditMode="InPlace" TableLayout="Fixed">
                <Columns>                                    
                  
                <telerik:GridTemplateColumn HeaderText="Rating" UniqueName="Rating"   AllowFiltering="false"
                            SortExpression="Rating" GroupByExpression="Rating [GridColumn_Rating] Group By Rating ASC" DataField="Rating">
                    <ItemTemplate>
                  
                 
                    
                      <telerik:RadRating style =" padding-top :0px"  ID="rdratingRead" runat="server" ItemCount="5"
                         Value='<%#CDbl(Eval("Rating"))%>' Height ="10px" Precision="half" ReadOnly="true" Orientation="Horizontal"  Skin ="Default" />
                    
                         
                   
                  
                    </ItemTemplate>
                    <EditItemTemplate>
                       <telerik:RadRating style =" padding-top :0px; " width="100px" ID="rdratingEdit" runat="server" ItemCount="5" 
                         Value="3" SelectionMode="Continuous" Height ="10px" Skin ="Default" Precision="half" Orientation="Horizontal" />
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                    <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>   
               
                <telerik:GridTemplateColumn HeaderText="Date"  UniqueName="Date" DataField ="Date" 
                  SortExpression="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
                    <ItemTemplate>
                       <span><%#FormatDate(Eval("Date"))%>&nbsp;</span> &nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <EditItemTemplate>
                    <div>
                            <telerik:RadDatePicker ID="dtpDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                              <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False"
                                                    ViewSelectorText="x">
                                                </Calendar>
                                                <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" CausesValidation="True"
                                                    Height="13px" >
                                                </DateInput>
                                                <DatePopupButton CssClass="" HoverImageUrl="" ImageUrl="" />
                                            </telerik:RadDatePicker></div>
                                            <div>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueDate" CssClass="Validator"
                                                ValidationGroup="SaveRating"   ControlToValidate="dtpDate" Display="Dynamic"
                                                meta:resourcekey="rfvValueDate"></asp:RequiredFieldValidator></div>
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                    <HeaderStyle Wrap="false" Width="90px" HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>   
               
                <telerik:GridTemplateColumn HeaderText="User" UniqueName="User" 
                           SortExpression="User" GroupByExpression="User [GridColumn_User] Group By User ASC" DataField="User">
                    <ItemTemplate>
                       <%#Eval("User").ToString%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlUsers" dropdownwidth="200px" runat="server" AllowCustomText="true" Skin="Default"
                                  EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                               OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="100%">
                              </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                    <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>   
               
                <telerik:GridTemplateColumn HeaderText="Comments" UniqueName="Comments" DataField="Comments"
                           SortExpression="Comments" GroupByExpression="Comments [GridColumn_Comments] Group By Comments ASC" >
                    <ItemTemplate>
                       <%#Eval("Comments").ToString%>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                       <asp:TextBox ID="txtComments" Width="100%" Text='<%#bind("Comments") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                    <HeaderStyle Wrap="false" Width="420px" HorizontalAlign="Left" />
                </telerik:GridTemplateColumn>   
               
                <telerik:GridTemplateColumn HeaderText="Use" UniqueName="Use" 
                           SortExpression="Use" GroupByExpression="Use [GridColumn_Use] Group By Use ASC" DataField="Use">
                    <ItemTemplate>
                      <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Use"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />

                    </ItemTemplate>
                    <EditItemTemplate>
                       <asp:CheckBox ID="chbUse" runat="server" Checked='<%# Cbool(IIF(Eval("Use") is system.DBNULL.value, 0,Eval("Use")))%>' />
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                    <HeaderStyle Wrap="false" Width="50px" HorizontalAlign="Center" />
                </telerik:GridTemplateColumn>  
                  
                </Columns>
                
                
                <CommandItemTemplate>
                    <div style="padding: 2px">
                         
                             
                            
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"   CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgRating.EditIndexes.Count = 0 AND (Not rdgRating.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                  &nbsp;&nbsp; 
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"  ValidationGroup="SaveRating"
                                Visible='<%# rdgRating.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert"  CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" ValidationGroup="SaveRating"
                                Visible='<%# rdgRating.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgRating.EditIndexes.Count > 0 Or rdgRating.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgRating.EditIndexes.Count = 0 AND (Not rdgRating.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"  CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgRating.EditIndexes.Count = 0 AND (Not rdgRating.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefreshRating" runat="server" CausesValidation="False" CommandName="RebindGrid"   CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgRating.EditIndexes.Count = 0 AND (Not rdgRating.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                 &nbsp;&nbsp;
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
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowRowsDragDrop="false"
                                AllowDragToGroup="true">
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                </ClientSettings>
                </telerik:radgrid>
