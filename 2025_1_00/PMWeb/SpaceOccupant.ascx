<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SpaceOccupant.ascx.vb" Inherits="Website.SpaceOccupant" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamSpaceOccupant" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSpaceOccupants">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSpaceOccupants" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
   <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Office2007">
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
<telerik:RadAjaxLoadingPanel ID="ldpEquipmentMove" runat="server" Skin="Office2007" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgSpaceOccupants" AllowMultiRowSelection="true"   runat="server" CssClass="WithoutTopBorder" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                  HeaderStyle-Font-Size="8" Width="100%" UseEditFormInMobile="true"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="250" >
                  <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                
                    <Columns>
               <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="100px"
                HeaderStyle-Wrap="false" Groupable="true" 
                 Reorderable="false" UniqueName="Type" SortExpression="OccupentTypeName">
                <ItemTemplate>
                    <span><%#Container.DataItem("OccupentTypeName")%></span> &nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="True"
                        Skin="Metro" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True" 
                        CausesValidation="False"   OnClientSelectedIndexChanged="ResetCombos"
                         LoadingMessage="<%$ Resources:PMWeb, Loading %>"> 
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="220px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Occupant*" UniqueName="Occupant" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="260px" SortExpression="OccupantName">
                            <ItemTemplate>
                             <span>    <%#IIf(Container.DataItem("OccupantName") = String.Empty, "&nbsp;", Container.DataItem("OccupantName"))%></span> 
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlLOccupant"  runat="server"  DropDownWidth="350px"
                                    Skin="Metro" CloseDropDownOnBlur="true" Width="100%" AllowCustomText="true" 
                                    NoWrap="true" CausesValidation="False"  Height="300px"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientItemsRequesting="GetValueToReturn"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="# of Occupants"   Groupable="false"
            UniqueName="nbrOfOccupants" SortExpression="nbrOfOccupants">
                <ItemTemplate>
                    <span><%#Container.DataItem("nbrOfOccupants")%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtnbrOfOccupants" runat="server" Width="100%" CssClass="PositiveInteger"
                        MaxLength="9"  MinNumber="0" Text='<%#Eval("nbrOfOccupants") %>'
                       ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="85px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduled Move-in" HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ScheduledMoveIn" UniqueName="ScheduledMoveIn">
                            <ItemTemplate>
                              <span>   <%#FormatDate(Container.DataItem("ScheduledMoveIn"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtScheduledMoveIn" Width="100%" Text='<%#FormatDate(Eval("ScheduledMoveIn"))%>'
                                 onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Actual Move-in" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px"  SortExpression="ActualMoveIn" UniqueName="ActualMoveIn">
                            <ItemTemplate>
                                <span> <%#FormatDate(Container.DataItem("ActualMoveIn"))%>&nbsp;</span> 
                            </ItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtActualMoveIn" Width="100%" Text='<%#FormatDate(Eval("ActualMoveIn"))%>' 
                               onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduled Move-out" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ScheduledMoveOut" UniqueName="ScheduledMoveOut">
                            <ItemTemplate>
                              <span>   <%#FormatDate(Container.DataItem("ScheduledMoveOut"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtScheduledMoveOut" Width="100%" Text='<%#FormatDate(Eval("ScheduledMoveOut"))%>'
                                onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Actual Move-out" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="ActualMoveOut" UniqueName="ActualMoveOut">
                            <ItemTemplate>
                                <span> <%#FormatDate(Container.DataItem("ActualMoveOut"))%>&nbsp;</span> 
                            </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtActualMoveOut" Width="100%" text='<%#FormatDate(Eval("ActualMoveOut"))%>'
                                onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>    
                   
                        <telerik:GridTemplateColumn HeaderText="Work Order" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="150px" SortExpression="WorkOrderDescription" UniqueName="WorkOrder">
                            <ItemTemplate>
                              <span>   <%#IIf(Container.DataItem("WorkOrderDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("WorkOrderDescription").ToString)%></span> 
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlWorkOrders"  runat="server"  DropDownWidth="350px"
                                    Skin="Metro" CloseDropDownOnBlur="true" Width="100%" AllowCustomText="true" 
                                    NoWrap="true" CausesValidation="False"  Height="300px"
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
                                <asp:TextBox ID="txtNotes" MaxLength="300" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>                                       
                        <telerik:GridTemplateColumn HeaderText="Calendar" HeaderStyle-Width="75px" ItemStyle-Wrap="false"
                            SortExpression="Reminder" UniqueName="Calendar" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Reminder"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkReminder" Checked='<%# Cbool(IIF(Eval("Reminder") is system.DBNULL.value, 0,Eval("Reminder")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Calendar Date" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="90px" SortExpression="ReminderDate" UniqueName="ReminderDate">
                            <ItemTemplate>
                                <span> <%#FormatDate(Container.DataItem("ReminderDate"))%>&nbsp;</span> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtReminderDate" Text='<%#FormatDate(Eval("ReminderDate"))%>' Width="100%"
                                onclick="showDatePopup(this, event,true);" onfocus="showDatePopup(this, event,true);" onblur="parseDate(this, event);"
                                runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>            
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgSpaceOccupants.EditIndexes.Count = 0 AND (Not rdgSpaceOccupants.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="EstimateMarkup" SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSpaceOccupants.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgSpaceOccupants.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"  SecurityButtonType="AddEditMode"
                                Visible='<%# rdgSpaceOccupants.EditIndexes.Count > 0 Or rdgSpaceOccupants.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"  CommandName="InitNewRow" CssClass="GridCmdInitNewRow"  SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgSpaceOccupants.EditIndexes.Count = 0 AND (Not rdgSpaceOccupants.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add Line"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgSpaceOccupants.EditIndexes.Count = 0 AND (Not rdgSpaceOccupants.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"  meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                Visible='<%# rdgSpaceOccupants.EditIndexes.Count = 0 AND (Not rdgSpaceOccupants.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnMove" runat="server" CommandName="MoveOut"  SecurityButtonType="ItemMode_Edit" class="GridCmdMoveOut"
                              Visible='<%# rdgSpaceOccupants.EditIndexes.Count = 0 AND (Not rdgSpaceOccupants.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblMoveOut" runat="server" Text="Move-out Selected lines" meta:resourcekey="lblMoveOut"></asp:Label>
                            </asp:LinkButton>
                                <telerik:RadComboBox ID="ddlOccupantStatus" AutoPostBack="true" AllowCustomText="false" SecurityButtonType="ItemMode" 
                                runat="server"   CloseDropDownOnBlur="true" OnSelectedIndexChanged="ddlOccupantStatus_SelectedIndexChanged"
                                 NoWrap="true" ShowToggleImage="true">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                <Items>
                                    <telerik:RadComboBoxItem Text="All occupants" Value="ALL" Selected="true" meta:resourcekey="ddlOccupantStatus_ALL" />
                                    <telerik:RadComboBoxItem Text="Current occupants only" Value="CURRENT" meta:resourcekey="ddlOccupantStatus_CURRENT" />
                                    <telerik:RadComboBoxItem Text="Past occupants only" Value="PAST" meta:resourcekey="ddlOccupantStatus_PAST" />
                                </Items>
                            </telerik:RadComboBox>
                       </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                </ClientSettings>
            </telerik:RadGrid>
    </div>
        </div>
    </div>
 <telerik:RadAjaxPanel ID="occupantPanel" runat="server" Height="100%" Width="100%">
 </telerik:RadAjaxPanel>