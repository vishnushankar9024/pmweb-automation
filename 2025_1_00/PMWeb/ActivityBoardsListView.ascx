<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardsListView.ascx.vb" Inherits="Website.ActivityBoardsListView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div class="ActivityBoardLV" id="ActivityBoardLV">
    <telerik:RadContextMenu ID="RadContextMenuLV" runat="server" OnClientItemClicking="LV_FireRadTreeListCommand">
        <Items>
            <telerik:RadMenuItem Text="Add Task" Value="AddTask" meta:resourcekey="MenuItem_AddTask" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Edit Column Name" Value="Edit" meta:resourcekey="MenuItem_Edit"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Add Column" Value="AddColumn" meta:resourcekey="MenuItem_AddColumn"></telerik:RadMenuItem>
            <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Delete Column" Value="Delete" meta:resourcekey="MenuItem_Delete"></telerik:RadMenuItem>
        </Items>
    </telerik:RadContextMenu>

    <telerik:RadContextMenu ID="RadContextMenu1" runat="server">
        <Items>
            <telerik:RadMenuItem Text="Add Column" Value="AddColumn" meta:resourcekey="MenuItem_AddColumn"></telerik:RadMenuItem>
        </Items>
    </telerik:RadContextMenu>

    <div class="Js-DropZone" id="dropZone" runat="server">
        <div class="PMMainPage" style="background-color:white;">
            <div class="row row-8-4-fit8">
                <div class="col-8" >
                    <telerik:RadTreeList ID="rdtActivityBoards" runat="server" AllowMultiItemEdit="True" setwidth="true" fitparentcontainer="true"
                        AllowRecursiveDelete="True" AutoGenerateColumns="False" EnableEmbeddedScripts="false" ExpandCollapseMode="Client"
                        AllowMultiItemSelection="True" AllowLoadOnDemand="false" ParentDataKeyNames="ColumnId" Width="100%"
                        ShowTreeLines="False" EditMode="InPlace" DataKeyNames="Id" CssClass="ABListView" HeaderStyle-HorizontalAlign="Left"
                        ClientDataKeyNames="Id">

                        <ClientSettings AllowItemsDragDrop="true" ClientEvents-OnItemDropped="LV_FindDropPosition">
                            <Selecting AllowItemSelection="True"></Selecting>
                            <Scrolling AllowScroll="True" ScrollHeight="800px" UseStaticHeaders="True" SaveScrollPosition="true" />
                            <ClientEvents OnItemDblClick="LV_OpenTasksPopup" OnItemContextMenu="LV_OpenListContextMenu" OnItemSelected="LV_UpdateRowCount" OnItemDeselected="LV_UpdateRowCount"></ClientEvents>
                        </ClientSettings>
                        <Columns>
                            <telerik:TreeListTemplateColumn Reorderable="false" UniqueName="lblTaskName" HeaderText="Task">
                                <ItemTemplate>
                                    <asp:LinkButton CssClass="chkDoneImg" src="Images/Workflow/wMinus.png" runat="server" ID="lbtChkDoneImg" Visible="false" OnClientClick="return false;">
                                    <span class="Icon"></span>
                                    </asp:LinkButton>

                                    <asp:Label runat="server" ID="lblTaskName" CssClass="lblTaskName" Style="font-size: 12px;"></asp:Label>

                                    <asp:LinkButton CssClass="ShowContextMenuButton" src="Images/Workflow/wMinus.png" runat="server" Visible="false" ID="lbtShowContextMenu" OnClientClick="return LV_OpenContextMenuFromButton(this, event);">
                                <span class="Icon"></span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTaskName" runat="server" Width="100%" AutoPostBack="false"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtNewTaskName" runat="server" Width="100%" PlaceHolder="New Task"></asp:TextBox>
                                </InsertItemTemplate>
                                <HeaderTemplate>
                                    <div style="float: left;">
                                        <asp:Label runat="server" ID="lblTaskHeader" meta:resourcekey="lblTaskHeader" Text="Task"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="FilterButton" src="Images/Workflow/wMinus.png" runat="server" ID="lbtFilterTask" OnClientClick="LV_OpenActivityBoardListViewFilterPopup('FilterTask'); return false;">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                <HeaderStyle Width="250px" />
                            </telerik:TreeListTemplateColumn>

                            <telerik:TreeListTemplateColumn ItemStyle-Wrap="false" UniqueName="AssignedTo">
                                <ItemTemplate>
                                    <div style="width: 30px; float: left;" class="userIconBox">
                                        <div id="divInitials" runat="server" class="initialsBox" visible="false">
                                            <asp:LinkButton runat="server" ID="lbtInitials" Style="text-decoration: solid;" OnClientClick="return false;"></asp:LinkButton>
                                        </div>

                                        <asp:ImageButton ID="imgUser" runat="server" Height="30px" Width="30px" CssClass="imgUserBox" Visible="false" OnClientClick="return false;" />

                                        <asp:LinkButton CssClass="AssignUserButton" src="Images/Workflow/wMinus.png" Visible="false" runat="server" ID="lbtAssignUser">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                    <div style="float: left; margin-top: 8px; margin-left: 8px;" class="FullNameDiv">
                                        <asp:Label runat="server" ID="lblFullName" Visible="false"></asp:Label>
                                    </div>
                                    <div style="clear: both;"></div>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <div style="float: left;">
                                        <asp:Label runat="server" ID="lblAssignedTo" meta:resourcekey="lblAssignedTo" Text="Assigned To"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="FilterButton" src="Images/Workflow/wMinus.png" runat="server" ID="lbtFilterAssignedTo" OnClientClick="LV_OpenActivityBoardListViewFilterPopup('FilterAssignedTo'); return false;">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </HeaderTemplate>
                                <ItemStyle Wrap="true"></ItemStyle>
                                <HeaderStyle Width="300px" />
                            </telerik:TreeListTemplateColumn>
                            <telerik:TreeListTemplateColumn ItemStyle-Wrap="false" UniqueName="Due">
                                <ItemTemplate>

                                    <asp:LinkButton runat="server" ID="lblDueDate" Visible="false" class="LVDueDate" OnClientClick="LV_OpenDatePicker(this,event,true);"></asp:LinkButton>

                                    <telerik:RadDatePicker ID="RadDatePickerDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" AutoPostBack="true"
                                        CssClass="DatePickerNoInput Hide" OnSelectedDateChanged="UpdateTasksDueDates">
                                        <DateInput ID="DateInput2" runat="server">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <div style="float: left;">
                                        <asp:Label runat="server" ID="lblDue" meta:resourcekey="lblDue" Text="Due"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="FilterButton" src="Images/Workflow/wMinus.png" runat="server" ID="lbtFilterDue" OnClientClick="LV_OpenActivityBoardListViewFilterPopup('FilterDue'); return false;">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                <HeaderStyle Width="300px" />
                            </telerik:TreeListTemplateColumn>
                            <telerik:TreeListEditCommandColumn UniqueName="EditCommandColumn" ButtonType="FontIconButton" Display="false"></telerik:TreeListEditCommandColumn>

                        </Columns>
                    </telerik:RadTreeList>
                    <div runat="server" id="NewColumnPane" style="float: left; width: 400px;" visible="false">
                        <div style="float: left; width: 50px;">
                            <asp:LinkButton CssClass="newColumnImg" runat="server" ID="lbtNewColumn" OnClientClick="return false;">
                            <span class="Icon"></span>
                            </asp:LinkButton>
                        </div>
                        <div style="float: right;">
                            <asp:TextBox runat="server" ID="txtNewColumnName" placeHolder="New Column" Width="350px"></asp:TextBox>
                        </div>
                        <div style="clear: both;"></div>
                    </div>
                </div>
                <div class="col-4" id="DetailsPane" style="overflow: auto; background: white; width: 399px; display: none;">
                    <div style="border: 1px solid #999999; margin-top: 24px; height: 370px; width: 300px; border-radius: 24px; text-align: center; color: #666666; font-size: 24px;">

                        <div style="margin-top: 24px;">
                            <asp:Label ID="lblTasksSelected" runat="server" Text="Tasks Selected"></asp:Label>

                        </div>


                        <table style="display: inline-block;" cellspacing="0" cellspadding="0" border="0">
                            <tr>
                                <td style="padding-top: 24px; padding-left: 40px;">
                                    <asp:LinkButton CssClass="assignedToImg" runat="server" ID="lbtAllSelectedAssign" OnClientClick="LV_OpenAssignUserToTaskPopupForSelected(); return false;">
                            <span class="Icon"></span>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 24px; padding-left: 40px;">
                                    <telerik:RadDatePicker ID="lbtAllSelectedDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" AutoPostBack="true"
                                        CssClass="DatePickerNoInput24">
                                        <DateInput ID="DateInput2" runat="server">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 48px;">
                                    <asp:LinkButton CssClass="lnkButtonBar" Style="width: 100px; padding: 0; vertical-align: middle;" ID="lbtAllMarkDone" meta:resourcekey="lbtAllMarkDone" runat="server" Text="Done">
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 24px;">
                                    <asp:LinkButton CssClass="lnkButtonBar" Style="width: 100px; padding: 0; vertical-align: middle;" ID="lbtAllMarkUndone" meta:resourcekey="lbtAllMarkUndone" runat="server" Text="Not Done">
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 48px; padding-left: 40px;">
                                    <asp:LinkButton CssClass="deleteImg" runat="server" ID="lbtAllSelectedDelete" OnClientClick="if (!ConfirmDelete()) return false;">
                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>



                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:LinkButton ID="btnRefreshListView" runat="server" CssClass="Hide"></asp:LinkButton>
    <asp:LinkButton ID="btnCancelAll" runat="server" CssClass="Hide"></asp:LinkButton>
    <asp:LinkButton ID="btnAddColumn" runat="server" CssClass="Hide"></asp:LinkButton>
    <asp:LinkButton ID="btnAddTask" runat="server" CssClass="Hide"></asp:LinkButton>
    <asp:LinkButton ID="btnUpdateColumnName" runat="server" CssClass="Hide"></asp:LinkButton>

    <asp:FileUpload ID="FileToUpload" runat="server" Width="180px" CssClass="Hide inputFile" />
    <asp:Button ID="btnUploadFile" runat="server" CssClass="Hide btnUpload"></asp:Button>
    <asp:HiddenField ID="hdnTaskId" runat="server" />

    <asp:HiddenField ID="hdnPos" runat="server" />
    <asp:HiddenField ID="hdnColId" runat="server" />
