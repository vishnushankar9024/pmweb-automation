<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentMoves.ascx.vb" Inherits="Website.EquipmentMoves" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

   <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server"  Skin="Office2007"  >
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
<telerik:RadAjaxLoadingPanel ID="ldpEquipmentMove" runat="server" Skin="Office2007" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgEquipmentMoves" AllowMultiRowSelection="true" runat="server"
                  HeaderStyle-Font-Size="8" Width="100%" CssClass="WithoutTopBorder" UseEditFormInMobile ="true"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="15"  ClientSettings-Scrolling-AllowScroll="true" setwidth="true">
                   <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                  
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="200px" SortExpression="Name">
                            <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Name") Is DBNull.Value, "&nbsp;", Container.DataItem("Name"))%></span> 
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" Width="100%"  Text='<%# Eval("Name") %>'></asp:Label>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduled Move-in" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ScheduledMoveIn" UniqueName="ScheduledMoveIn">
                            <ItemTemplate>
                                <span> <%#FormatDate(Container.DataItem("ScheduledMoveIn"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtScheduledMoveIn" Text='<%#FormatDate(Eval("ScheduledMoveIn"))%>' Width="100%"
                                  onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn> 
                         <telerik:GridTemplateColumn HeaderText="Actual Move-in" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ActualMoveIn" UniqueName="ActualMoveIn">
                            <ItemTemplate>
                               <span>  <%# FormatDate(Container.DataItem("ActualMoveIn"))%>&nbsp;</span> 
                            </ItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtActualMoveIn"  Width="100%" Text='<%#FormatDate(Eval("ActualMoveIn"))%>'
                                  onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduled Move-out" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ScheduledMoveOut" UniqueName="ScheduledMoveOut">
                            <ItemTemplate>
                                <span> <%# FormatDate(Container.DataItem("ScheduledMoveOut"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtScheduledMoveOut"  Width="100%" Text='<%#FormatDate(Eval("ScheduledMoveOut"))%>'
                                onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Actual Move-out" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ActualMoveOut" UniqueName="ActualMoveOut">
                            <ItemTemplate>
                               <span>  <%#FormatDate(Container.DataItem("ActualMoveOut"))%>&nbsp;</span> 
                            </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtActualMoveOut"  Width="100%" Text='<%#FormatDate(Eval("ActualMoveOut"))%>'
                                  onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>    
                        <telerik:GridTemplateColumn HeaderText="Cost" HeaderStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="65px" SortExpression="Cost" UniqueName="Cost">
                            <ItemTemplate>
                                <asp:Label ID="lblCost" runat="server" Text=" "></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCost" MaxLength="15"  Width="100%" runat="server"  CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate> 
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Work Order" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="150px" SortExpression="WorkOrderDescription" UniqueName="WorkOrder">
                            <ItemTemplate>
                               <span>  <%# Container.DataItem("WorkOrderDescription").ToString%>&nbsp;</span> 
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlWorkOrders"  runat="server" Width="100%"
                                    Skin="Metro" CloseDropDownOnBlur="true" DropDownWidth="270px"  AllowCustomText="true" 
                                    NoWrap="true" CausesValidation="False" Height="300px"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" 
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="150px" SortExpression="Notes" UniqueName="Notes">
                            <ItemTemplate>
                                <span> <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span> 
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="50" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>                                       
                        <telerik:GridTemplateColumn HeaderText="Calendar" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                            SortExpression="Calendar" UniqueName="Calendar" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Calendar"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkCalendar" Checked='<%# Cbool(IIF(Eval("Calendar") is system.DBNULL.value, 0,Eval("Calendar")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Calendar Date" HeaderStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="CalendarDate" UniqueName="CalendarDate">
                            <ItemTemplate>
                                <span> <%#FormatDate(Container.DataItem("CalendarDate"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                
                                    <asp:TextBox ID="txtCalendarDate" Width="100%" Text='<%#FormatDate(Eval("CalendarDate"))%>'
                                        onclick="showDatePopup(this, event,true);" onfocus="showDatePopup(this, event,true);" onblur="parseDate(this, event)"
                                        runat="server"></asp:TextBox>
                                                          
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>            
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgEquipmentMoves.EditIndexes.Count = 0 AND (Not rdgEquipmentMoves.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1" SecurityButtonType="ItemMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                            &nbsp;&nbsp;
                            </asp:LinkButton> 
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="EstimateMarkup" CssClass="GridCmdUpdateEdited"
                                CommandName="UpdateEdited" Visible='<%# rdgEquipmentMoves.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1"  SecurityButtonType="AddEditMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                           &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave"  SecurityButtonType="AddEditMode_Add" runat="server" ValidationGroup="EstimateMarkup" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                Visible='<%# rdgEquipmentMoves.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                               &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" SecurityButtonType="AddEditMode" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgEquipmentMoves.EditIndexes.Count > 0 Or rdgEquipmentMoves.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                              &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnMoveOut"   SecurityButtonType="ItemMode_Add" runat="server" CausesValidation="False"  CssClass="MoveOutButton"
                                 OnClientClick="return OpenEquipmentMovePOPUp('EquipmentMovePopup.aspx',500, 500,true);"
                                Visible='<%# rdgEquipmentMoves.EditIndexes.Count = 0 AND (Not rdgEquipmentMoves.MasterTableView.IsItemInserted) %>'>
                               <span class="Icon"></span>
                                <asp:Label ID="lblMoveOut" runat="server" Text="Move"  meta:resourcekey="lblMoveOut" ></asp:Label>
                             &nbsp;&nbsp;
                            </asp:LinkButton>   
                            <asp:LinkButton ID="btnRefresh"     SecurityButtonType="ItemMode" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgEquipmentMoves.EditIndexes.Count = 0 AND (Not rdgEquipmentMoves.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
            </telerik:RadGrid>
</div>
        </div>
    </div>