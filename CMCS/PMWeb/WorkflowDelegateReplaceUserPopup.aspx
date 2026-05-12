<%@ Page Language="vb" meta:resourcekey="Page" Title="Delegate/Replace User" AutoEventWireup="false" CodeBehind="WorkflowDelegateReplaceUserPopup.aspx.vb" Inherits="Website.WorkflowDelegateReplaceUserPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link href="CSS/ControlsCSS/Grid.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="JS/workflow/roles.js"></script>
        <script type="text/javascript">
            var allowdropdownClose;
            var ExecuteFromPopup = false;
            $(document).ready(function () {
                ExecuteFromPopup = false;
                $("[id$=hddToolbalBtn]")[0].value = '';
            });

            function GetValueToReturn(combobox, eventArgs) {

                var hdnField = $("[id$=hddnIds]")[0];
                var context = eventArgs.get_context();

                context["Ids"] = hdnField.value;
            }

            function OnClientSelectedIndexChanging(combobox, eventArgs) {
                allowdropdownClose = false;
                eventArgs.set_cancel(true);
            }

            function OnClientDropDownClosing(combobox, eventArgs) {
                if (allowdropdownClose == false) {
                    eventArgs.set_cancel(true);
                }
                allowdropdownClose = true;
            }

            function OpenConfirmActivationPopup() {
                var location = window.parent.location.href.toLowerCase()
                var WorkflowDelegateReplace_OpenFromSetting;
                if (location.indexOf('workflow.aspx') >= 0)
                    WorkflowDelegateReplace_OpenFromSetting = false;
                else
                    WorkflowDelegateReplace_OpenFromSetting = true;
                var grid = $find("rdgDelegates");
                var ddlUser = $find("ddlUsers");
                var userId = ddlUser.get_value();
                var userName = ddlUser.get_text();
                var userDelegationId;
                var row = grid.MasterTableView.get_selectedItems();
                if (row.length == 0) return;
                userDelegationId = row[0].getDataKeyValue("Id");
                if (ExecuteFromPopup == true) return;
                var browserWidth = window.outerWidth;
                var browserHeight = window.outerHeight;
                var wnd = window.radopen("WorkflowDelegateActivationPopup.aspx?UserDelegationId=" + userDelegationId + "&UserId=" + userId + "&FromSettings=" + WorkflowDelegateReplace_OpenFromSetting);
                if (browserWidth < 1024) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(450, browserHeight * 0.55);
                    wnd.Center();
                }
                wnd.add_close(WindowClosed);
                if (grid) { GridToRebind = grid; }
                return false;
            }

            function ExecuteActivate() {
                ExecuteFromPopup = true;
                var ExecuteItem = $("[id$=hddbtnOk]")[0];
                ExecuteItem.click();
                return;
            }

            function OnRowSelecting(sender, eventArgs) {

                var rdgDelegates = $find($("[id$=rdgDelegates]")[0].id);
                var IsReplaced = $("#" + eventArgs.get_id())[0].getAttribute("IsReplaced")

                if (IsReplaced == 1) {
                    var hfSelectedItems = $("[id$=hfSelectedItems]")[0];
                    hfSelectedItems.value = 'Clear';
                    eventArgs.set_cancel(true);
                }
            }

            function NodeChecked(sender, eventArgs) {
                var ddlRolesClientId = sender.get_id().substring(0, sender.get_id().indexOf('ddlRoles')) + 'ddlRoles';
                var combo = $find(ddlRolesClientId);
                var node = eventArgs.get_node();
                var checked = node.get_checked();
                var hdnField = $("[id$=hddnIds]")[0];
                hdnField.value = "";

                if (checked == true) {
                    var tree = $find(node.get_treeView().get_id());
                    if (node.get_value() == "0") {
                        var allCheckedNodes = tree.get_checkedNodes();
                        var TotalChecked = allCheckedNodes.length
                        for (var i = TotalChecked - 1; i >= 0 ; i--) {
                            var CkeckedNode = allCheckedNodes[i];
                            if (CkeckedNode.get_value() != "0") {
                                CkeckedNode.set_checked(false);
                            }
                        }
                        //hdnField.value = "0";
                    }
                    else {
                        var AllNode = tree.findNodeByValue("0");
                        if (AllNode != null)
                            AllNode.set_checked(false);
                    }
                    //hdnField.value = hdnField.value + ',' + node.get_value();
                    var selectedCount = tree.get_checkedNodes()
                    if (selectedCount.length == 1) {
                        var SelectedNode = tree.get_checkedNodes()[0];
                        combo.set_text(SelectedNode.get_text());
                    }
                    else if (selectedCount.length > 1) {
                        combo.set_text($("input[id$=hdnRoleSelectedMsg]").val());
                    }
                    else
                        combo.set_text("");

                    //////////////Fill Hidden Field////////////////////////
                    var NodesChecked = tree.get_checkedNodes();
                    var NodesCheckedCount = NodesChecked.length
                    for (var i = NodesCheckedCount - 1; i >= 0 ; i--) {
                        var NodeChk = NodesChecked[i];
                        if (hdnField.value == "") {
                            hdnField.value = NodeChk.get_value();
                        }
                        else {
                            hdnField.value = hdnField.value + ',' + NodeChk.get_value();
                        }
                    }

                    return;
                }

                var rdvtree = $find(node.get_treeView().get_id());
                var CheckedCount = rdvtree.get_checkedNodes().length;
                if (CheckedCount == 0) {
                    combo.set_text("");
                    hdnField.value = "";
                }
                else if (CheckedCount == 1) {
                    var ChkNode = rdvtree.get_checkedNodes()[0];
                    var CheckedNodeValue = ChkNode.get_value();
                    if (CheckedNodeValue != "0") {
                        combo.set_text(ChkNode.get_text());
                    }
                    //hdnField.value = CheckedNodeValue;
                    //return;
                }
                //////////////Fill Hidden Field////////////////////////
                var rdvNodesChk = rdvtree.get_checkedNodes();
                for (var i = CheckedCount - 1; i >= 0 ; i--) {
                    var rdvNodeChk = rdvNodesChk[i];
                    if (hdnField.value == "") {
                        hdnField.value = rdvNodeChk.get_value();
                    }
                    else {
                        hdnField.value = hdnField.value + ',' + rdvNodeChk.get_value();
                    }
                }
            }


        </script>
    </telerik:RadCodeBlock>
</head>
<style>
    .RadTreeView.CheckBoxesTreeview label .rtChk {
        display: inline-block !important;
    }
    .col-12{
        padding: 10px 25px 25px;
    }
</style>
<body>
    <form id="form1" runat="server">
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgDelegates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDelegates" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlUsers">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDelegates" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0" id="tblToolbar" runat="server">
                        <tr>
                            <td valign="middle" style="padding-left: 24px; width: 160px; color: #666666;">
                                <asp:Label ID="lblUser" runat="server" meta:resourcekey="lblUser" Text="User"></asp:Label>
                            </td>
                            <td style="width: 240px !important; padding-left: 10px">
                                <telerik:RadComboBox ID="ddlUsers" runat="server" meta:resourcekey="ddlUsers" Skin="Default" Width="240px" AutoPostBack="True" NoWrap="True"
                                    AllowCustomText="True" CausesValidation="False" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" ShowMoreResultsBox="True"
                                    CheckForDirt="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                    EmptyMessage="Select User..." OnItemsRequested="ddl_ItemsRequested" OnClientTextChange="LOD_DropDownTextChange">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="70px">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarClose" CommandName="Exit" Value="Exit"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td style="width: 100%;"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMHeader">
            <div class="row">
                <div class="col-12" runat="server" id="divGrid">
                    <telerik:RadGrid ID="rdgDelegates" UseEditFormInMobile="true" GroupingEnabled="true" runat="server" AutoGenerateColumns="False" FilterType="HeaderContext"
                        EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" SetWidth="true" AppendMenus="true" FitPageHeightOffset="1" ClientSettings-Scrolling-AllowScroll="true"
                        AllowMultiRowEdit="false" AllowMultiRowSelection="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8"
                        PageSize="250" AllowPaging="true" ShowGroupPanel="True" AllowSorting="true" ShowStatusBar="true" ShowFooter="true"
                        AllowFilteringByColumn="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id,Action,ActivatedDate,DeactivatedDate,LevelId,AllRoles" CommandItemDisplay="Top"
                            ClientDataKeyNames="Id,Action,ActivatedDate,DeactivatedDate,LevelId,AllRoles"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                            EnableHeaderContextMenu="true" ShowGroupFooter="true">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Line #" Reorderable="false" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" DataField="LineNumber"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# Eval("LineNumber")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="30px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Level" ItemStyle-Wrap="True" HeaderText="Level"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Level"
                                    SortExpression="Level" GroupByExpression="Level [GridColumn_Level] Group By Level ASC">
                                    <ItemTemplate>
                                        <%# IIf(CStr(Eval("Level")) = String.Empty, "&nbsp;", Eval("Level"))%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlLevel" runat="server" Width="100%" DropDownWidth="300px" AutoPostBack="True" AllowCustomText="true" OnClientTextChange="ddlEntities_DropDownTextChange"
                                            CausesValidation="False" Skin="Default" Height="300px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" OnSelectedIndexChanged="ddllevel_SelectedIndexChanged" meta:resourcekey="ddlLevel">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <div>
                                                        <span class="Icon"></span>
                                                        <asp:Label runat="server" ID="lbLevellItem"></asp:Label>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="ddlLevel"
                                            CssClass="Validator" InitialValue="" ErrorMessage='<%# Me.GetLocalResourceObject("WarningMsg_LevelRequired") %>'
                                            ValidationGroup="Save" Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="AllRoles" ItemStyle-Wrap="false" HeaderText="Role"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="AllRoles"
                                    SortExpression="AllRoles" GroupByExpression="Level [GridColumn_AllRoles] Group By AllRoles ASC">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoles" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlRoles" EnableItemCaching="false" runat="server" Style="font-size: 11px" Width="100%"
                                            CloseDropDownOnBlur="true" DropDownWidth="300px" Height="280px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            AllowCustomText="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" DropDownCssClass="ddlTreeviewTemplate">
                                            <Items>
                                                <telerik:RadComboBoxItem />
                                            </Items>
                                            <ItemTemplate>
                                                <telerik:RadTreeView ID="rdvRoles" runat="server" CheckBoxes="true" EnableNodeTextHtmlEncoding="true"
                                                    Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeChecked="NodeChecked"
                                                    OnNodeExpand="rdvRoles_NodeExpand" OnNodeDataBound="rdvRoles_NodeDataBound" OnTemplateNeeded="rdvRoles_TemplateNeeded"
                                                    CssClass="CheckBoxesTreeview">
                                                </telerik:RadTreeView>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnIds" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="Action" ItemStyle-Wrap="false" HeaderText="Action"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="TranslatedAction"
                                    SortExpression="Action" GroupByExpression="Action [GridColumn_Action] Group By Action ASC">
                                    <ItemTemplate>
                                        <%# Me.PM.LanguagesInfo.GetUserDelegationsAction(Eval("Action"))%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlAction" Width="100%" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAction_SelectedIndexChanged"></telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Delegate" ItemStyle-Wrap="True" HeaderText="Delegate To/Replace With"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Delegate"
                                    SortExpression="Delegate" GroupByExpression="Delegate [GridColumn_Delegate] Group By Delegate ASC">
                                    <ItemTemplate>
                                        <%# IIf(Eval("Delegate") = String.Empty, "&nbsp;", Eval("Delegate"))%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlDelegates" runat="server" meta:resourcekey="ddlDelegates" Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True"
                                            AllowCustomText="True" CausesValidation="false" Height="200px" ShowMoreResultsBox="True"
                                            DropDownWidth="250px" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnSelectedIndexChanged="ddlDelegates_SelectedIndexChanged"
                                            EmptyMessage="Select Delegate..." OnItemsRequested="ddl_ItemsRequested" OnClientTextChange="LOD_DropDownTextChange">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvDelegates" runat="server" ControlToValidate="ddlDelegates"
                                            CssClass="Validator" InitialValue="" ErrorMessage='<%# Me.GetLocalResourceObject("WarningMsg_DelegateRequired") %>'
                                            ValidationGroup="Save" Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="ApplyToRecords" ItemStyle-Wrap="false" HeaderText="Apply To Records"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="TranslatedApplyToRecords"
                                    SortExpression="ApplyToRecords" GroupByExpression="ApplyToRecords [GridColumn_ApplyToRecords] Group By ApplyToRecords ASC">
                                    <ItemTemplate>
                                        <%# Me.PM.LanguagesInfo.GetUserDelegationsApplyToRecordsList(Eval("ApplyToRecords"))%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlApplyToRecords" runat="server" Width="100%"></telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="EndDate" ItemStyle-Wrap="false" HeaderText="End" DataField="EndDate"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="EndDate" GroupByExpression="EndDate [GridColumn_EndDate] Group By EndDate ASC">
                                    <ItemTemplate>
                                        <%# If(Eval("EndDate") Is DBNull.Value, "", FormatDate(Eval("EndDate")))%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="rdpEndDate" runat="server" MinDate="1900-01-01"
                                            MaxDate="2100-01-01" Width="100%" Skin="Default">
                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Notes" ItemStyle-Wrap="false" HeaderText="Notes"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="Notes"
                                    SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("Notes").ToString = String.Empty, "&nbsp;", Eval("Notes").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNotes" MaxLength="100" TextMode="MultiLine" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>&nbsp;
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ActivatedDate" ItemStyle-Wrap="false" HeaderText="ActivatedDate" DataField="ActivatedDate"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="ActivatedDate" GroupByExpression="ActivatedDate [GridColumn_ActivatedDate] Group By ActivatedDate ASC">
                                    <ItemTemplate>
                                        <span><%# If(Eval("ActivatedDate") Is DBNull.Value, "", FormatDate(Eval("ActivatedDate")))%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px" />
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="DeactivatedDate" ItemStyle-Wrap="false" HeaderText="DeactivatedDate" DataField="DeactivatedDate"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="DeactivatedDate" GroupByExpression="DeactivatedDate [GridColumn_DeactivatedDate] Group By DeactivatedDate ASC">
                                    <ItemTemplate>
                                        <span><%# If(Eval("DeactivatedDate") Is DBNull.Value, "", FormatDate(Eval("DeactivatedDate")))%></span>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        Visible='<%# rdgDelegates.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                        Visible='<%# rdgDelegates.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        Visible='<%# rdgDelegates.EditIndexes.Count > 0 Or rdgDelegates.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                        OnClientClick="javascript:return DeleteSelectedUserDelegations();"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnActivate" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode_Edit" CommandName="ActivateRow" CssClass="GridCmdSwitchActivateRow"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>' OnClientClick="javascript:return OpenConfirmActivationPopup();">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblActivateRow" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDeactivate" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode_Edit" CommandName="DeactivateRows" CssClass="GridCmdSwitchDeactivateRows"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeactivateSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdgDelegates.EditIndexes.Count = 0 And (Not rdgDelegates.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="lblSaveState" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        &nbsp;&nbsp;<asp:Label ID="lblLoadDefaultState" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            <ClientEvents OnRowSelecting="OnRowSelecting" OnRowSelected="rgdDelegates_RowSelected"></ClientEvents>
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            <Resizing AllowColumnResize="True"></Resizing>
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hfSelectedItems" Value="" />
        <asp:HiddenField runat="server" ID="hddToolbalBtn" />
        <asp:Button ID="hddbtnOk" CssClass="Hide" runat="server" />
        <asp:HiddenField runat="server" ID="hdnEmail" />
        <asp:HiddenField runat="server" ID="hdnOnScreen" />
        <asp:HiddenField runat="server" ID="hdnRoleSelectedMsg" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
