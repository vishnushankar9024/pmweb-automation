<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MoveManagementDetails.ascx.vb" Inherits="Website.MoveManagementDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMoveManagementDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMoveManagementDetails" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="rdvAssets"/>
             <telerik:AjaxUpdatedControl ControlID="rdvTargetAssetTree"/>
                 <telerik:AjaxUpdatedControl ControlID="ddlProjects"/>
             <telerik:AjaxUpdatedControl ControlID="ddlSchedule"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>--%>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgMoveManagementDetails" runat="server"
                AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" SetWidth="true" AppendMenus="true"
                Font-Size="8px" PageSize="250" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None"
                AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true"
                EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">

                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" SortExpression="Company"
                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC" DataField="Company">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Company") = String.Empty Or Container.DataItem("Company") = "0", "&nbsp;", Container.DataItem("Company"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblCompany" Text='<%#Eval("Company")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Department" UniqueName="Department" SortExpression="Department"
                            GroupByExpression="Department [GridColumn_Department] Group By Department" DataField="Department">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Department") = String.Empty, "&nbsp;", Container.DataItem("Department"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblDepartment" Text='<%#Eval("Department")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Contact" UniqueName="Contact" SortExpression="Contact" DataField="Contact"
                            GroupByExpression="Contact [GridColumn_Contact] Group By Contact">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Contact") = String.Empty, "&nbsp;", Container.DataItem("Contact"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="LblContact" Text='<%#Eval("Contact")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Equipment" UniqueName="Equipment" SortExpression="Equipment"
                            GroupByExpression="Equipment [GridColumn_Equipment] Group By Equipment" DataField="Equipment">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="LblEquipment" Text='<%#Eval("Equipment")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="From Property" UniqueName="FromProperty" SortExpression="FromProperty"
                            GroupByExpression="FromProperty [GridColumn_FromProperty] Group By FromProperty" DataField="FromProperty">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FromProperty") = String.Empty, "&nbsp;", Container.DataItem("FromProperty"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblFromProperty" Text='<%#Eval("FromProperty")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="From Building" UniqueName="FromBuilding" SortExpression="FromBuilding"
                            GroupByExpression="FromBuilding [GridColumn_FromBuilding] Group By FromBuilding" DataField="FromBuilding">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FromBuilding") = String.Empty, "&nbsp;", Container.DataItem("FromBuilding"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="LblFromBuilding" Text='<%#Eval("FromBuilding")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="From Floor" UniqueName="FromFloor" SortExpression="FromFloor" DataField="FromFloor"
                            GroupByExpression="FromFloor [GridColumn_FromFloor] Group By FromFloor">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FromFloor") = String.Empty, "&nbsp;", Container.DataItem("FromFloor"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblFromFloor" Text='<%#Eval("FromFloor")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="From Space" UniqueName="FromSpace" SortExpression="FromSpace"
                            GroupByExpression="FromSpace [GridColumn_FromSpace] Group By FromSpace" DataField="FromSpace">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FromSpace") = String.Empty, "&nbsp;", Container.DataItem("FromSpace"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblFromSpace" Text='<%#Eval("FromSpace")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="To Property" UniqueName="ToProperty" SortExpression="ToProperty"
                            GroupByExpression="ToProperty [GridColumn_ToProperty] Group By ToProperty" DataField="ToProperty">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ToProperty") = String.Empty, "&nbsp;", Container.DataItem("ToProperty"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="Label3" Text='<%#Eval("ToProperty")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="To Building" UniqueName="ToBuilding" SortExpression="ToBuilding" DataField="ToBuilding"
                            GroupByExpression="ToBuilding [GridColumn_ToBuilding] Group By ToBuilding">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ToBuilding") = String.Empty, "&nbsp;", Container.DataItem("ToBuilding"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="Label4" Text='<%#Eval("ToBuilding")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="To Floor" UniqueName="ToFloor" SortExpression="ToFloor" DataField="ToFloor"
                            GroupByExpression="ToFloor [GridColumn_ToFloor] Group By ToFloor">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ToFloor") = String.Empty, "&nbsp;", Container.DataItem("ToFloor"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="Label5" Text='<%#Eval("ToFloor")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="To Space" UniqueName="ToSpace" SortExpression="ToSpace"
                            GroupByExpression="ToSpace [GridColumn_ToSpace] Group By ToSpace" DataField="ToSpace">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ToSpace") = String.Empty, "&nbsp;", Container.DataItem("ToSpace"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="Label6" Text='<%#Eval("ToSpace")%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskName") = "", "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ddlTasks_SelectedIndexChanged"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Schedule Start" SortExpression="ScheduleStart" UniqueName="ScheduleStart" DataField="ScheduleStart"
                            GroupByExpression="ScheduleStart [GridColumn_ScheduleStart] Group By ScheduleStart ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblScheduleStart" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScheduleStart"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Schedule Finish" SortExpression="ScheduleFinish" UniqueName="ScheduleFinish" DataField="ScheduleFinish"
                            GroupByExpression="ScheduleFinish [GridColumn_ScheduleFinish] Group By ScheduleFinish ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblScheduleFinish" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScheduleFinish"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Actual Start" SortExpression="ActualStart" UniqueName="ActualStart" DataField="ActualStart"
                            GroupByExpression="ActualStart [GridColumn_ActualStart] Group By ActualStart ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblActualStart" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtActualStart"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvActualStart" runat="server" ControlToValidate="txtActualStart"
                                        CssClass="Validator" InitialValue="" ErrorMessage="Required." meta:resourcekey="rfvActualStart"
                                        Display="Dynamic" ForeColor="" ValidationGroup="MoveOut"></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Actual Finish" SortExpression="ActualFinish" UniqueName="ActualFinish" DataField="ActualFinish"
                            GroupByExpression="ActualFinish [GridColumn_ActualFinish] Group By ActualFinish ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblActualFinish" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtActualFinish"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvActualFinish" runat="server" ControlToValidate="txtActualFinish"
                                        CssClass="Validator" InitialValue="" ErrorMessage="Required." meta:resourcekey="rfvActualFinish"
                                        Display="Dynamic" ForeColor="" ValidationGroup="MoveOut"></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost" UniqueName="Cost" ItemStyle-HorizontalAlign="Right" DataField="Cost"
                            SortExpression="Cost" GroupByExpression="Cost [GridColumn_Cost] Group By Cost ASC">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatNumber(Eval("Cost"))%>' runat="server" ID="lblCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCost" CssClass="PositiveDouble" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Cost"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Reason" DataField="Reason" SortExpression="Reason" UniqueName="Reason" GroupByExpression="Reason [GridColumn_Reason] Group By Reason ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Reason") = String.Empty, "&nbsp;", Container.DataItem("Reason"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReason" runat="server" Text='<%# Eval("Reason") %>'
                                    Width="100%" MaxLength="500"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnExecuteMoves" runat="server" CausesValidation="False" CommandName="ExecuteMove" CssClass="GridCmdExecuteMove"
                                SecurityButtonType="ItemMode_Add" 
                                Visible='<%# rdgMoveManagementDetails.EditIndexes.Count = 0 And (Not rdgMoveManagementDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblExecuteMoves" runat="server" Text="Execute Moves" meta:resourcekey="btnExecuteMoves"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgMoveManagementDetails.EditIndexes.Count = 0 And (Not rdgMoveManagementDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="MoveOut"
                                Visible='<%# rdgMoveManagementDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgMoveManagementDetails.EditIndexes.Count > 0 Or rdgMoveManagementDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgMoveManagementDetails.EditIndexes.Count = 0 And (Not rdgMoveManagementDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgMoveManagementDetails.EditIndexes.Count = 0 And (Not rdgMoveManagementDetails.MasterTableView.IsItemInserted) %>'
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
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
