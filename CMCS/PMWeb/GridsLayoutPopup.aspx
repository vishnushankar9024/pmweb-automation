<%@ Page Language="vb" meta:resourcekey="GridsLayoutPopup" AutoEventWireup="false" CodeBehind="GridsLayoutPopup.aspx.vb" Inherits="Website.GridsLayoutPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Layout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        .NewStylePopupToolbar.FolderMangerEditFoldertblToolbar .rtbOuter {
            background-color: #ededed !important;
        }

        .FolderMangerEditFoldermainToolbar .ToolbarNew .rtbChoiceArrow {
            display: none;
        }

        .ToolBar.NewStylePopupToolbar.FolderMangerEditFoldertblToolbar {
            top: 0px !important;
            background-color: RGB(237,237,237) !important;
        }

        div.TitleToolbarTop.FolderManagerEditFolderPMMainPage {
            margin-top: 50px !important;
        }

        .layoutWidth {
            width: 160px;
            padding-left: 20px;
        }

        .RadToolBar_Metro .rtbOuter {
            border: none !important;
        }

        .labelWidth span {
            display: block !important;
        }

        .PositiveInteger .rcbInput {
            text-align: right !important;
            padding-right: 3px !important;
        }

        .RadGrid .R808width, .PMMainPage > .row > .col-8 {
            max-width: 670px !important;
        }

        @media screen and (min-width:1125px) and (max-width:1273px) {
            .col-8.R24Top {
                padding-top: 0px !important;
            }

            .col-8.R0Gutter {
                padding-left: 8px !important;
            }
        }


        #ddlPageSize_DropDown li.rcbItem, #ddlPageSize_DropDown li.rcbHovered,
        #ddlFreezeColumns_DropDown li.rcbItem, #ddlFreezeColumns_DropDown li.rcbHovered {
            text-align: right;
        }
    </style>

    <script type="text/javascript">
        function click_handler(sender, args) {
            var comandName = args.get_item().get_commandName();
            if (comandName == "Delete") {
                if (!confirm(WarningMsg_ConfirmDeleteLayout)) {
                    args.set_cancel(true);
                    return false;
                }
                args.set_cancel(false);
                return true;
            }
        }
    </script>

</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:radajaxloadingpanel id="ldpPM" runat="server" backgroundposition="Center" skin="Default" />
        <telerik:radajaxmanager id="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgLayoutGrid">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLayoutGrid" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="txtShownColumnsWidth" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAssignUserGroups">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssignUserGroups" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:radajaxmanager>
        <div id="ProfileTitle" class="ProfileTitle" runat="server" visible="false">
            <asp:Label runat="server" ID="TitleUser"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar" runat="server" id="tblToolbar">
            <tr>
                <td class="layoutWidth" id="Layout" runat="server">
                    <asp:Label ID="lblLayout" runat="server" Text="Layout" meta:ResourceKey="lblLayout"></asp:Label>
                </td>
                <td class="ToolbarTd HideOnMobileToolbar showOnIpad" style="width: 240px;">
                    <telerik:radcombobox meta:resourcekey="ddlCustomLayouts" id="ddlCustomLayouts" runat="server" autopostback="true" datatextfield="LayoutName" datavaluefield="Id"
                        skin="Default" closedropdownonblur="true" allowcustomtext="true" filter="Contains" width="240px"
                        nowrap="true" causesvalidation="False"
                        checkfordirt="True">
                    </telerik:radcombobox>
                </td>
                <td class="ToolbarTd">
                    <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="True" width="100%" onclientbuttonclicking="click_handler">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" ValidationGroup="Save" ImageUrl="Images/ToolBar/Save.png"
                                CommandName="Save" AccessKey="s" Value="Edit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton Height="50px" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                                <Buttons>
                                    <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" AccessKey="n" Value="Add" CausesValidation="false">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png"  ValidationGroup="Save">
                                    </telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                CommandName="Delete" AccessKey="d" Value="Delete">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:radtoolbar>
                </td>
                <td></td>
            </tr>
        </table>

        <div id="PMMainPage" class="PMMainPage PMPopupMainPage" style="margin-bottom: 0px;" runat="server">
            <div class="row row-8-4">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblLayoutName" Text="Layout Name*" meta:resourcekey="lblLayoutName" />
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtLayoutName" />
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtLayoutName"
                                    CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                    ValidationGroup="Save">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblRecordType" meta:resourcekey="lblRecordType" Text="Record Type" />
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtRecordType" ReadOnly="true" Enabled="false" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblGrid" meta:resourcekey="lblGrid" Text="Grid" />
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" Enabled="false" ID="txtGrid" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblFreezeColumns" meta:resourcekey="lblFreezeColumns" Text="Freeze Columns" />
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox runat="server" ID="chkFreezeColumns" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblFreezeColumnNumber" meta:resourcekey="lblFreezeColumnNumber" Text="Freeze Column Number" /></td>
                            <td class="controlWidth">
                                <telerik:radcombobox runat="server" id="ddlFreezeColumns" cssclass="PositiveInteger"></telerik:radcombobox>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblGridWidth" meta:resourcekey="lblGridWidth" Text="Grid Width" />
                            </td>

                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtGridWidth" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblShownColumnsWidth" meta:resourcekey="lblShownColumnsWidth" Text="Shown Columns Width" />
                            </td>

                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtShownColumnsWidth" Enabled="false" CssClass="PositiveInteger" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblFreezeHeader" meta:resourcekey="lblFreezeHeader" Text="Freeze Header" />
                            </td>

                            <td class="controlWidth">
                                <asp:CheckBox runat="server" ID="chkFreezeHeader" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblGridHeight" meta:resourcekey="lblGridHeight" Text="Grid Height" />
                            </td>

                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtGridHeight" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblPageSize" meta:resourcekey="lblSize" Text="Page Size" />
                            </td>

                            <td class="controlWidth">
                                <telerik:radcombobox id="ddlPageSize" runat="server" cssclass="PositiveInteger">
                                </telerik:radcombobox>
                            </td>

                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblVirtualScrolling" meta:resourcekey="lblVirtualScrolling" Text="Virtual Scrolling" />
                            </td>

                            <td class="controlWidth">
                                <asp:CheckBox runat="server" ID="chkVirtualScrolling" />
                            </td>
                        </tr>
                        <tr id="DocumentManager_GroupPermissions" runat="server">
                            <td>
                                <fieldset id="AssignUserGroups" style="margin-top: 7px; width: 400px !important">
                                    <legend>
                                        <asp:Label runat="server" ID="lblAssignUserGroups" meta:Resourcekey="lblAssignUserGroups"></asp:Label>
                                    </legend>
                                    <table style="width: 100%">
                                        <tr>
                                            <td colspan="2">
                                                <telerik:radgrid id="rdgAssignUserGroups" runat="server" setwidth="true" fitparentcontainer="true"
                                                    headerstyle-font-size="8" width="400px" autogeneratecolumns="False" allowmultirowedit="true"
                                                    allowmultirowselection="true" allowsorting="true" showstatusbar="False" allowpaging="true">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" EditMode="InPlace" Width="100%">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show" HeaderStyle-Width="50px">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />
                                                            </ItemTemplate>
                                                             <EditItemTemplate>
                                                                <asp:CheckBox ID="chkShow" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" onClick="rdgAssignUserGroups_CheckboxCheckedChanged(this);" />
                                                             </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="User Group" UniqueName="UserGroup" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                               <%#IIf(Container.DataItem("UserGroup") = String.Empty, "&nbsp;", Container.DataItem("UserGroup"))%>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#IIf(Container.DataItem("UserGroup") = String.Empty, "&nbsp;", Container.DataItem("UserGroup"))%>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                         <telerik:GridTemplateColumn HeaderText="IsDefault" UniqueName="IsDefault" HeaderStyle-Width="50px">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")), "checked.png", "unchecked.png"))%>" alt="" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkDefault" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDefault") Is System.DBNull.Value, 0, Eval("IsDefault")))%>' runat="server" onClick="rdgAssignUserGroups_CheckboxCheckedChanged(this);" />
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">
                                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                                CommandName="EditRows" Visible='<%# rdgAssignUserGroups.EditIndexes.Count = 0 And (Not rdgAssignUserGroups.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblEditSelectedGroupLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnUpdateSelected" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                                CommandName="UpdateEdited" Visible='<%# rdgAssignUserGroups.EditIndexes.Count > 0 %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblUpdateGroupRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancelAll" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                                CommandName="CancelAll" Visible='<%# rdgAssignUserGroups.EditIndexes.Count > 0 Or rdgAssignUserGroups.MasterTableView.IsItemInserted %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblCancelGroup" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                        </div>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                     <ClientSettings AllowRowsDragDrop="true" ClientEvents-OnRowDblClick="RowDblClick">
                                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                     </ClientSettings>
                                            </telerik:radgrid>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-8">
                    <telerik:radgrid runat="server" id="rdgLayoutGrid" autogeneratecolumns="False" showstatusbar="True" setwidth="true" appendmenus="true" fitparentcontainer="true" style="max-width: 645px;" allowpaging="true"
                        font-size="8px" showgrouppanel="False" allowmultirowedit="True"  PageSize="250" allowmultirowselection="True" allowsorting="False" gridlines="None" useeditforminmobile="true" fitpageheightoffset="24">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            CommandItemDisplay="Top" TableLayout="Fixed"
                            UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="False">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Show" ItemStyle-Wrap="false" UniqueName="IsDisplayed" DataField="IsDisplayed"
                                    SortExpression="IsDisplayed" Groupable="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkIsDisplayed" runat="server" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed"))) %>' />
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="center"></ItemStyle>
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Order" ItemStyle-Wrap="false" UniqueName="Order" DataField="Order"
                                    SortExpression="Order">
                                    <ItemTemplate>
                                        <span><%#Eval("Order").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("Order").ToString%>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Column" ItemStyle-Wrap="false" UniqueName="UniqueName" DataField="UniqueName"
                                    SortExpression="UniqueName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblColumnUniqueName" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblEditColumnUniqueName" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="250px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Width" ItemStyle-Wrap="false" UniqueName="Width" DataField="Width"
                                    SortExpression="Width">
                                    <ItemTemplate>
                                        <span><%#Eval("Width").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWidth" CssClass="PositiveInteger" Width="100%" Text='<%#Bind("Width") %>' runat="server" MaxLength="5"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Group By" ItemStyle-Wrap="false" UniqueName="GroupExpression" DataField="GroupExpression"
                                    SortExpression="GroupExpression">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGroupBy" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox Width="100%" Skin="Default" ID="ddlGroupBy" runat="server">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="None" Value="None" />
                                                <telerik:RadComboBoxItem Text="Desc" Value="Desc" />
                                                <telerik:RadComboBoxItem Text="Asc" Value="Asc" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Sort By" ItemStyle-Wrap="false" UniqueName="SortExpression" DataField="SortExpression"
                                    SortExpression="SortExpression">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSortBy" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox Width="100%"  Skin="Default" ID="ddlSortBy" runat="server">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Desc" Value="Desc" />
                                                <telerik:RadComboBoxItem Text="Asc" Value="Asc" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                        CommandName="EditRows" Visible='<%# rdgLayoutGrid.EditIndexes.Count = 0 And (Not rdgLayoutGrid.MasterTableView.IsItemInserted)%>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                        CommandName="UpdateEdited" Visible='<%# rdgLayoutGrid.EditIndexes.Count > 0%>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                        CommandName="CancelAll" Visible='<%# rdgLayoutGrid.EditIndexes.Count > 0 Or rdgLayoutGrid.MasterTableView.IsItemInserted%>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLoadDefaultState"
                                        CausesValidation="False" Visible='<%# rdgLayoutGrid.EditIndexes.Count = 0%>' CommandName="LoadDefaultState">
                                        <span class="Icon"></span>
                                        <asp:Label ID="LabelLoadDefaultState" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowRowsDragDrop="true" ClientEvents-OnRowDblClick="RowDblClick">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:radgrid>
                </div>
            </div>
        </div>



    </form>
</body>
</html>
