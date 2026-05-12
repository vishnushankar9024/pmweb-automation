<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentCheckList.ascx.vb" Inherits="Website.DocumentCheckList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamLabors" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgWorkOrderTasks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgWorkOrderTasks" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSaveChecklistResource">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnSaveChecklistResource" />

            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSaveChecklistDate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnSaveChecklistDate" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="CheckListToolbar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="CheckListToolbar" />
                <telerik:AjaxUpdatedControl ControlID="rdgWorkOrderTasks" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblSubmitted" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table border="0" style="width: 100%;background-color: RGB(237,237,237);background-image: none;z-index: 999;" cellpadding="0" cellspacing="0">    <tr runat="server" id="trToolbar">
        <td colspan="2" class="ToolbarTd">
            <telerik:RadToolBar ID="CheckListToolbar" runat="server" AutoPostBack="true" Width="100px" CssClass="popup-toolbar">
                <Items>
                    <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" CssClass="ToolbarSave" meta:resourcekey="RadToolBarButton_Save"></telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>
<table id="tblPaddingForToolbar" runat="server" style="display:none">
    <tr>
        <td style="height: 25px"></td>
    </tr>
</table>
<div class="PMMainPage">
    <div class="row">
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSubmittedBy" Width="100%" runat="server" meta:resourcekey="lblSubmittedBy"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlResources" runat="server" Height="200px"
                            Width="100%" CloseDropDownOnBlur="true" meta:resourcekey="ddlResources"
                            NoWrap="False" AllowCustomText="true" EnableLoadOnDemand="True"
                            ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap labelWidth">
                        <asp:Label ID="lblSubmittedDate" Width="100%" runat="server" meta:resourcekey="lblSubmittedDate" Text="Submitted Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                          <span runat="server" id="rmd_dtpSubmittedDate" style="display: block">
                        <telerik:RadDatePicker ID="dtpSubmittedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                            Width="100%" EnableTyping="True">
                            <DateInput ID="DateInput5" runat="server">
                            </DateInput>
                        </telerik:RadDatePicker>
                              </span>
                    </td>
                </tr>

            </table>
        </div>
    </div>
</div>
<telerik:RadGrid ID="rdgWorkOrderTasks" runat="server" FilterType="HeaderContext" UseEditFormInMobile="true"
    AutoGenerateColumns="False" ShowStatusBar="False" setWidth="true" AppendMenus="true" Width="100%"
    Font-Size="8px" PageSize="15" ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" ClientSettings-Scrolling-AllowScroll="true"
    AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" AllowFilteringByColumn="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" Name="Master">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Task" UniqueName="TaskNumber" ItemStyle-HorizontalAlign="Right" DataField="TaskNumber"
                SortExpression="TaskNumber" Groupable="false" Reorderable="true">
                <ItemTemplate>
                    <span><%#Container.DataItem("TaskNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("TaskNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Completed" UniqueName="Completed" HeaderStyle-Width="50px"
                ItemStyle-Wrap="false" SortExpression="Completed" GroupByExpression="Completed [GridColumn_Completed] Group By Completed ASC"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" DataField="Completed">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Completed")) = CBool(1), "checked.png", "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbCompleted" OnClick='chkCheckListCompletedChecked(this, event);' Checked='<%# CBool(IIf(Eval("Completed") Is System.DBNull.Value, 0, Eval("Completed")))%>'
                        runat="server" class="mobile-switch" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Completed Date" DataField="CompletedDate" UniqueName="CompletedDate" SortExpression="CompletedDate" GroupByExpression="CompletedDate [GridColumn_CompletedDate] Group By CompletedDate">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("CompletedDate"))%> &nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpCompletedTaskDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" EnableTyping="True">
                        <DateInput ID="DateInput3" runat="server"></DateInput>
                        <Calendar ID="Calendar3" runat="server"></Calendar>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Task ID" UniqueName="TaskCode" SortExpression="TaskCode"
                GroupByExpression="TaskCode [GridColumn_TaskCode] Group By TaskCode" DataField="TaskCode">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("TaskCode") = String.Empty, "&nbsp;", Container.DataItem("TaskCode"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTaskCode" MaxLength="15" Width="100%" runat="server" Text='<%#Eval("TaskCode")%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="40px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTaskDescription" MaxLength="250" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="250px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Task Type" DataField="TaskType" UniqueName="TaskType" SortExpression="TaskType" GroupByExpression="TaskType [GridColumn_TaskType] Group By TaskType ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("TaskType") = String.Empty, "&nbsp;", Container.DataItem("TaskType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTaskType" runat="server" Width="100%" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Assigned To" DataField="AssignedTo" UniqueName="AssignedTo" SortExpression="AssignedTo" GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("AssignedTo") = String.Empty, "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlAssignedTaskTo" runat="server" Height="200px"
                        Width="100%" CloseDropDownOnBlur="true" meta:resourcekey="ddlResources"
                        NoWrap="False" AllowCustomText="true" EnableLoadOnDemand="True"
                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                        <CollapseAnimation Duration="200" Type="OutQuint" />
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="250px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Skills" SortExpression="SkillName" UniqueName="SkillName"
                GroupByExpression="SkillName [GridColumn_SkillName] Group By SkillName ASC" DataField="SkillName">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTaskSkills" runat="server" Height="250px" Filter="Contains" MarkFirstMatch="true"
                        AllowCustomText="True" Width="100%">
                        <ItemTemplate>
                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                <asp:CheckBox runat="server" ID="chkApplySkills" />
                                <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                <%#Eval("Skills")%>
                            </div>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="180px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <%--                                <span><asp:Button ID="btnHtmlNotes" runat="server" CssClass="SmallButton" OnClientClick="return OpenHtmlNotesPopup(this);"/></span>--%>
                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTaskNotes" runat="server" Text='<%# Eval("Notes") %>'
                        Width="100%" MaxLength="200" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Optional" UniqueName="Optional" HeaderStyle-Width="70px" ItemStyle-Wrap="false"
                SortExpression="Optional" GroupByExpression="Optional [GridColumn_Optional] Group By Optional ASC"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" DataField="Optional">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Optional")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkOptional" Checked='<%# CBool(IIf(Eval("Optional") Is System.DBNull.Value, 0, Eval("Optional")))%>' runat="server" class="mobile-switch" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 And (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    SecurityButtonType="AddEditMode_Edit"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add"
                    Visible='<%# rdgWorkOrderTasks.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count > 0 Or rdgWorkOrderTasks.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 And (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAddTasks" runat="server" CausesValidation="False" CommandName="AddTasks" CssClass="GridCmdAddTasks"
                    SecurityButtonType="ItemMode_Add" OnClientClick="javascript:return OpenTaskPopup();"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 And (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddTasks" runat="server" Text="Add Tasks" meta:resourcekey="lblAddTasks"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 And (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 And (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
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
        <DetailTables>
            <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="Top" AllowPaging="True"
                DataKeyNames="Id,TaskId" Width="100%" AllowSorting="true" EditMode="InPlace" Name="Steps" PageSize="10">
                <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="TaskId" MasterKeyField="Id" />
                </ParentTableRelation>
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepNumber %>" UniqueName="StepNumber" ItemStyle-HorizontalAlign="Right"
                        SortExpression="StepNumber"
                        Groupable="false" Reorderable="false">
                        <ItemTemplate>
                            <span><%#Container.DataItem("StepNumber").ToString%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span><%#Eval("StepNumber").ToString%></span>
                        </EditItemTemplate>
                        <HeaderStyle Width="50px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Completed %>" UniqueName="Completed" HeaderStyle-Width="60px"
                        ItemStyle-Wrap="false" SortExpression="Completed" GroupByExpression="Completed [GridColumn_Completed] Group By Completed ASC"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                        <ItemTemplate>
                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Completed")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                alt="" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chbStepCompleted" OnClick='chkCheckListStepCompletedChecked(this, event);' Checked='<%# CBool(IIf(Eval("Completed") Is System.DBNull.Value, 0, Eval("Completed")))%>'
                                runat="server" class="mobile-switch" />
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CompletedDate %>" UniqueName="CompletedDate" SortExpression="CompletedDate" GroupByExpression="CompletedDate [GridColumn_CompletedDate] Group By CompletedDate" Reorderable="false" Groupable="false">
                        <ItemTemplate>
                            <span><%#FormatDate(Container.DataItem("CompletedDate"))%> &nbsp;</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="dtpCompletedStepDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" EnableTyping="True">
                                <DateInput ID="DateInput4" runat="server"></DateInput>
                                <Calendar ID="Calendar4" runat="server"></Calendar>
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepId %>" UniqueName="StepId" SortExpression="StepId"
                        GroupByExpression="StepId [GridColumn_StepId] Group By StepId" Groupable="false" Reorderable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("StepId") = String.Empty, "&nbsp;", Container.DataItem("StepId"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStepId" MaxLength="15" Width="100%" runat="server" Text='<%#Eval("StepId")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="50px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" UniqueName="Description" SortExpression="Description"
                        GroupByExpression="Description [GridColumn_Description] Group By Description" Reorderable="false" Groupable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" MaxLength="250" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="250px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepType %>" UniqueName="StepType" SortExpression="StepType" GroupByExpression="StepType [GridColumn_StepType] Group By StepType ASC" Reorderable="false" Groupable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("StepType") = String.Empty, "&nbsp;", Container.DataItem("StepType"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlStepType" runat="server" Width="100%" AllowCustomText="true">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_AssignedTo %>" UniqueName="AssignedTo" SortExpression="AssignedTo" GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" Reorderable="false" Groupable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("AssignedTo") = String.Empty, "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlAssignedStepTo" runat="server" Height="200px"
                                Width="100%" CloseDropDownOnBlur="true" meta:resourcekey="ddlResources"
                                NoWrap="False" AllowCustomText="true" EnableLoadOnDemand="True"
                                ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="180px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_SkillName %>" SortExpression="SkillName" UniqueName="SkillName"
                        GroupByExpression="SkillName [GridColumn_SkillName] Group By SkillName ASC" Reorderable="false" Groupable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlSkills" runat="server" Height="250px"
                                AllowCustomText="True" Width="100%">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkApplySkills" />
                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                        <%#Eval("Skills")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="180px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Notes %>" SortExpression="Notes" Reorderable="false" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" Groupable="false">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>'
                                Width="100%" MaxLength="200" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="180px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Optional %>" UniqueName="Optional" HeaderStyle-Width="50px" ItemStyle-Wrap="false"
                        SortExpression="Optional" GroupByExpression="Optional [GridColumn_Optional] Group By Optional ASC"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                        <ItemTemplate>
                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Optional")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("Optional") Is System.DBNull.Value, 0, Eval("Optional")))%>' runat="server" class="mobile-switch" />
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <CommandItemTemplate>
                    <div style="padding: 2px">
                        &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        Visible='<%# HideShow(Container) %>' SecurityButtonType="ItemMode_Edit" meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="<%$ Resources:PMWeb, EditSelectedLines %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# HideShowUpdate(Container) %>' CssClass="GridCmdUpdateEdited"
                            meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                            <span class="Icon"></span>
                            <asp:Label ID="lblUpdate" runat="server" Text="<%$ Resources:PMWeb, UpdateEdited %>"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                            Visible='<%# HideShowSave(Container) %>' meta:resourcekey="btnSaveResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblSave" runat="server" Text="<%$ Resources:PMWeb, PerformInsert %>"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                            Visible='<%# Not HideShow(Container) %>' meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                            <span class="Icon"></span>
                            <asp:Label ID="lblCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                            Visible='<%# HideShow(Container) %>' SecurityButtonType="ItemMode_Add">
                            <span class="Icon"></span>
                            <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                            Visible='<%# HideShow(Container) %>' runat="server" CommandName="DeleteRows"
                            meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                            <span class="Icon"></span>
                            <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                        </asp:LinkButton>
                    </div>
                </CommandItemTemplate>
            </telerik:GridTableView>
        </DetailTables>
    </MasterTableView>
    <ClientSettings AllowColumnHide="true" AllowDragToGroup="true" AllowColumnsReorder="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
    </ClientSettings>
</telerik:RadGrid>

<asp:HiddenField runat="server" ID="hdnCheckListTodayDate" />
<asp:Button runat="server" ID="btnSaveChecklistResource" CssClass="Hide" />
<asp:Button runat="server" ID="btnSaveChecklistDate" CssClass="Hide" />