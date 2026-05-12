<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkflowBusinessProcesses.ascx.vb"
    Inherits="Website.WorkflowBusinessProcesses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script language="javascript" type="text/javascript" src="JS/workflow/Templates.js"></script>
    <script language="javascript" type="text/javascript">
        var allowdropdownClose;
        function GetValueToReturn(combobox, eventArgs) {
            if (combobox.get_id().indexOf("ddlRoles") > 0) {
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnRoleIds';
            }
            else if (combobox.get_id().indexOf("ddlAssociate") > 0) {
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
            } else {
                return false;
            }
            var hdnField = $("[id$=" + hdn + "]")[0];
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

        function check(sender, ddl, resultId, ResultName) {
            var combo = $find(ddl);
            if (combo.get_id().indexOf("ddlRoles") > 0) {
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnRoleIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnRoleNames';
            }
            else if (combo.get_id().indexOf("ddlAssociate") > 0) {
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
            }
            else
                return false

            var hdnNames = $("[id$=" + hdn1 + "]")[0];
            var hdnField = $("[id$=" + hdn + "]")[0];
            var vlue = hdnField.value;
            if (sender.checked) {
                if (vlue.indexOf("-1") > -1 && resultId != "-1") {
                    hdnField.value = ""
                    hdnNames.value = "";
                    vlue = "";
                    var items = combo.get_items();
                    for (var i = 0; i < items.get_count() ; i++) {
                        var item = items.getItem(i);
                        if (item.get_value() == "-1") {
                            var checkbox = item.get_element().getElementsByTagName("input")[0];
                            checkbox.checked = false;
                            break;
                        }
                    }
                }
                if (hdnField.value == '')
                    hdnField.value = resultId;
                else
                    hdnField.value = vlue + ',' + resultId;
                if (hdnNames.value == '') {
                    hdnNames.value = ResultName;
                    combo.set_text(ResultName)
                }
                else
                    hdnNames.value = hdnNames.value + ',' + ResultName;
                combo.set_text(hdnNames.value)
                if (resultId == "-1") {
                    hdnField.value = resultId;
                    hdnNames.value = ResultName;
                    combo.set_text(ResultName)
                    var items = combo.get_items();
                    for (var i = 0; i < items.get_count() ; i++) {
                        var item = items.getItem(i);
                        if (item.get_value() != "-1") {
                            var checkbox = item.get_element().getElementsByTagName("input")[0];
                            checkbox.checked = false;
                        }
                    }
                }
            }
            else {
                var results = vlue.split(',');
                var resultNames = hdnNames.value.split(',');
                var i = 0;
                var newVal = '';
                var newNames = '';
                for (i = 0; i < results.length; i++) {
                    if (results[i] != resultId) {
                        if (newVal == '') {
                            newVal = results[i];
                        }
                        else {
                            newVal = newVal + ',' + results[i];
                        }
                    }
                }
                var find = 1
                for (i = 0; i < resultNames.length; i++) {
                    if (resultNames[i] != ResultName || find == 0) {
                        if (newNames == '') {
                            newNames = resultNames[i];
                        }
                        else {
                            newNames = newNames + ',' + resultNames[i];
                        }
                    }
                    else
                        find = 0;
                }
                hdnField.value = newVal;
                if (newNames != '') {
                    hdnNames.value = newNames;
                    combo.set_text(hdnNames.value)
                }
                else {
                    hdnNames.value = newNames;
                    combo.set_text(hdnNames.value)
                }
            }

        }

        function OpenDesigner() {
            var wnd = OpenWindowPOPUp('WorkflowDesigner.aspx?Source=WorkflowBusinessProcesses', 1030, 610, true);
            return false;
        }
        function OpenWindowPOPUp(URL, Width, Height, AddClose) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            if (AddClose == true) {
                wnd.add_close(CloseDesigner);
            }

            return false;
        }
        function CloseDesigner() {
            var btnRefreshId;
            btnRefreshId = $(window.document).find("a[id$=lbtRefresh]")[0];
            if (btnRefreshId) {
                eval(btnRefreshId.href.split(":")[1]);
            }
        }

        function DeleteSelectedTemplates() {
            var grid = $find("<%=rdtSteps.ClientID %>");
            if (grid.get_selectedItems().length > 0) {
                return ConfirmDelete();
            }
            return false;
        }

        function OpenPopupToRefreshTreeList(URL, Width, Height) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.add_close(RefreshTreeList);
            wnd.Center();
            return false;
        }
        function isMobileScreen() {
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }
        function StepIconClicked(argIsBranch, argStepId) {
            var grid = $find("<%=rdtSteps.ClientID %>");
            if (argIsBranch == true || argIsBranch == 'True') {
                var wnd = OpenPopupToRefreshTreeList('WorkflowDefineBranchStep.aspx?StepId=' + argStepId + '&Type=Template', 1150, 650);
                return false;
            } else {
                var wnd = OpenPopupToRefreshTreeList('WorkflowDefineRoleStep.aspx?StepId=' + argStepId + '&Type=Template', 950, 695);
                return false;
            }
        }

        $('#frameImage').ready(function () {
            //$('#loadingMessage').css('display', 'none');
        });
        $('#frameImage').load(function () {
            //$('#loadingMessage').css('display', 'none');
        });

        function OnTreeListDblClick(sender, eventArgs) {
            var brnchIndx = eventArgs._item._element.innerHTML.indexOf('BranchButton');
            var intStepId = eventArgs.get_item().get_dataKeyValue('Id');
            if (brnchIndx > 0) {
                StepIconClicked(true, intStepId);
            } else {
                StepIconClicked(false, intStepId);
            }
        }

        function OnTreeListCreated(sender, eventArgs) {
            document.getElementById('frameImage').src = document.getElementById('frameImage').src;
        }

        function OpenPOPUp(URL, Width, Height, Refresh, Type) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            if (Refresh == true) {
                if (Type = "Update") {
                    wnd.add_close(ReloadPage);
                }
                else if (Type = "Delete") {
                    wnd.add_close(RefreshPage);
                }
            }
            return false;
        }

        function ReloadPage() {
            var btn = $("[id$=btnReloadPage]")[0];
            btn.click();
        }

        function RefreshPage() {
            var btn = $("[id$=btnRefreshPage]")[0];
            btn.click();
        }

        function OpenReplaceBPMPopup() {
            OpenPOPUp("WorkflowReplaceBPMPopup.aspx?Type=Delete", 530, 230, true, "Delete");
            return false;
        }

        function OpenReplaceBPMPopupForUpdate() {
            OpenPOPUp("WorkflowReplaceBPMPopup.aspx?Type=Update", 530, 230, true, "Update");
            return false;
        }


        ////////////////////////////////////////////////////////////////////////////////////////

        function CheckParent(node) {
            var ParentNode = node.get_parent();
            var ParentNodeChilds = ParentNode.get_allNodes();
            var TotalChildNodes = ParentNodeChilds.length;
            ParentNode.set_checked(true);
            for (var i = TotalChildNodes - 1; i >= 0; i--) {
                var ChildNode = ParentNodeChilds[i];
                if (ChildNode.get_checkState() == 0) {
                    ParentNode.set_checked(false);
                    break;
                }
            }
        }

        function NodeChecked(sender, eventArgs) {
            var combo = $find("ctl00_CPH1_ucBusinessProcesses_ddlAssociate");
            var node = eventArgs.get_node();
            var checked = node.get_checked();
            var childNodes = node.get_nodes();

            if (checked == true) {
                var tree = $find(node.get_treeView().get_id());
                if (node.get_value() == "-1") {
                    var allCheckedNodes = tree.get_checkedNodes();
                    var TotalChecked = allCheckedNodes.length;
                    for (var i = TotalChecked - 1; i > 0; i--) {
                        var CkeckedNode = allCheckedNodes[i];
                        CkeckedNode.set_checked(false);
                    }
                }
                else {
                    var NoneNode = tree.findNodeByValue("-1");
                    if (NoneNode != null)
                        NoneNode.set_checked(false);
                }

                if (node.get_value().indexOf("M") == 0) {
                    UncheckAllChildren(childNodes);
                    var TotalChildNodes = node.get_allNodes().length;
                    for (var i = TotalChildNodes - 1; i >= 0; i--) {
                        var ChildNode = node.get_allNodes()[i];
                        ChildNode.set_checked(true);
                    }
                }

                if (node.get_value().indexOf("F") == 0) {
                    UncheckAllChildren(childNodes);
                    var TotalChildNodes = node.get_allNodes().length
                    for (var i = TotalChildNodes - 1; i >= 0; i--) {
                        var ChildNode = node.get_allNodes()[i];
                        ChildNode.set_checked(true);
                    }
                    var TempNode = node;
                    while (TempNode.get_parent()._type == null) {
                        CheckParent(TempNode);
                        TempNode = TempNode.get_parent();

                    }
                }

                if (node.get_value().indexOf("R") == 0) {
                    var TempNode = node;
                    while (TempNode.get_parent()._type == null) {
                        CheckParent(TempNode);
                        TempNode = TempNode.get_parent();
                    }
                }
                var selectedCount = tree.get_checkedNodes()
                if (selectedCount.length == 1) {
                    var SelectedNode = tree.get_checkedNodes()[0];
                    combo.set_text(SelectedNode.get_text());
                }
                else if (selectedCount.length > 1) {
                    combo.set_text($("input[id$=hdnSelectedMsg]").val());
                }
                else
                    combo.set_text("");
                return;
            }

            else {
                if (node.get_value().indexOf("M") == 0)
                    UncheckAllChildren(childNodes);

                if (node.get_value().indexOf("F") == 0) {
                    UncheckAllChildren(childNodes);
                    var TempNode = node;
                    while (TempNode.get_parent()._type == null) {
                        TempNode = TempNode.get_parent();
                        TempNode.set_checked(false);
                    }
                }

                if (node.get_value().indexOf("R") == 0) {
                    var ParentNode = node.get_parent()
                    var ParentNodeChecked = ParentNode.get_checkState()
                    if (ParentNode.get_value().indexOf("F") == 0) {
                        var customParentNode = ParentNode.get_parent();
                        var customParentNodeChecked = customParentNode.get_checkState()
                        if (customParentNodeChecked == 1)
                            customParentNode.set_checked(false);
                    }
                    if (ParentNodeChecked == 1)
                        ParentNode.set_checked(false);
                }

                var tree = $find(node.get_treeView().get_id());
                var selectedCount = tree.get_checkedNodes();
                if (selectedCount.length == 1) {
                    var SelectedNode = tree.get_checkedNodes()[0];
                    combo.set_text(SelectedNode.get_text());
                }
                else if (selectedCount.length > 1) {
                    combo.set_text($("input[id$=hdnSelectedMsg]").val());
                }
                else
                    combo.set_text("");
                return;
            }

            var rtvtree = $find(node.get_treeView().get_id());
            var AllCheckedCount = rtvtree.get_checkedNodes().length;
            if (AllCheckedCount == 0) {
                combo.set_text("");
            }
        }

        function UncheckAllChildren(nodes) {
            var i;
            for (i = 0; i < nodes.get_count() ; i++) {
                nodes.getNode(i).set_checked(false);

                if (nodes.getNode(i).get_nodes().get_count() > 0)
                    UncheckAllChildren(nodes.getNode(i).get_nodes());
            }
        }
        function ShowHidebtnTreeDropItemsBranchRules(sender, args) {
            if (sender.get_checkedNodes().length > 0) {
                $("[id$=btnTreeDropItemsBranchRules]").removeClass("Hide");
            }
            else
                $("[id$=btnTreeDropItemsBranchRules]").addClass("Hide");
        }

        ////////////////////////////////////////////////////////////////////////////////////////
    </script>
    <style type="text/css">
        .UpperCase{
            text-transform:uppercase !important;
        }
        .FloatRight {
            float: right !important;
        }

        .dropClue {
            background-repeat: no-repeat;
            text-align: left !important;
            margin: 10px;
        }

        .dropEnabled {
            background-image: url('Images/Global/AddLine.png');
        }

        .dropDisabled {
            background-image: url('Images/Global/SmallCancel.png');
        }

        .borderStyle {
            border: none !important;
        }

        .Overflow {
            overflow: auto;
        }

        .colortabs {
            background-color: #ffffff !important;
            color: #3598DB !important;
            padding: 0px !important;
            border-bottom: none;
            vertical-align: middle !important;
        }

        .RadTabStrip_Default .rtsLevel1 .rtsLink.colortabs {
            color: #3598DB !important;
        }

        .colortabs .rtsSelected .rtsOut {
            color: #F9AA33 !important;
        }

        .RadTabStrip_Default .rtsLevel1 .rtsLink.mainHomeTabs {
            font-size: 12px !important;
        }

        .FontStyle {
            font-size: 10px !important;
        }

        .mainHomeTabsROLES .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .rtsLevel1 .rtsLink.CssTabWorkflow {
            font-size: 12px !important;
        }

        .RadTabStrip_Default.WorkflowRoleCss li.rtsLI.rtsFirst, .RadTabStrip_Default.WorkflowRoleCss li.rtsLI.rtsLast {
            width: 49% !important;
        }

        .WorkflowRoleCss .rtsLevel.rtsLevel1 {
            width: 100% !important;
            padding-bottom: 5px;
            padding-top: 5px;
        }

        .RadTabStrip_Default.WorkflowRoleCss {
            border: 1px solid #999999 !important;
            border-bottom: none !important;
            width: calc(100% - 2px) !important;
        }

        .WorkflowRoleCss .rtsLevel1 .rtsLink .rtsIn table {
            width: 100% !important;
        }

        .StepsTreeStyle .rtlHeader {
            background-color: #999999 !important;
            color: #ffffff !important;
            background-image: none !important;
        }

        .RadTreeView.RdpRolesWidth {
            overflow: auto !important;
            height: 283px;
        }

        .RadTreeViewRoles .rtChk, .RadTreeViewRoles .rtChecked, .RadTreeViewRoles .rtUnchecked, .RadTreeViewRoles .rtIndeterminate {
            margin-left: -36px !important;
            margin-right: 10px !important;
        }

        .RadTreeViewRoles .trvCheck .rtSp, .RadTreeViewRoles .trvUnlocked .rtSp, .RadTreeViewRoles .trvLocked .rtSp {
            margin-right: 0px !important;
        }

        .RadTreeViewRoles .rtIn {
            margin-left: 8px !important;
        }

        .RadTreeViewRoles .trvFolderRoles .rtChk, .RadTreeViewRoles .trvFolderRoles .rtChecked, .RadTreeViewRoles .trvFolderRoles .rtUnchecked, .RadTreeViewRoles .trvFolderRoles .rtIndeterminate {
            margin-left: 0px !important;
        }

        .trvBranch .rtIn {
            margin-left: 0px !important;
        }

        .RadTreeViewBranchRules li.rtLI, .RadTreeViewRoles li.rtLI.rtFirst.rtLast {
            margin-left: 22px !important;
        }

        .RadTreeViewBranchRules .trvFolder .rtSp, .RadTreeViewBranchRules .trvPBSFolder .rtSp, .RadTreeViewRoles .trvFolder .rtSp, .RadTreeViewRoles .trvPBSFolder .rtSp {
            margin-right: -36px !important;
        }

        .RadTreeView .rtChk, .RadTreeView .rtChecked, .RadTreeView .rtUnchecked, .RadTreeView .rtIndeterminate {
            margin-bottom: 2px;
            margin-left: 0px;
        }

        .RadTreeViewBranchRules .rtUL .rtUL {
            padding-left: 0px !important;
        }

        .RadTreeViewBranchRules li.rtLI li.rtLI li.rtLI {
            margin-left: 0px !important;
        }
        .rgCommandRow a span {
            color:#666666 !important;
        }
    </style>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RamTemplates" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSuperUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSuperUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rtvRoles">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rtvRoles" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="WorkflowBusinessProcesses1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rtvBranchRules">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rtvBranchRules" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="WorkflowBusinessProcesses1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlAssociate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rtvBranchRules" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdtSteps">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="WorkflowBusinessProcesses1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="tdCommandBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="WorkflowBusinessProcesses1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lbtRefresh">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lbtRefresh" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lbtDelete">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtSteps" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lbtDelete" />
                <telerik:AjaxUpdatedControl ControlID="lblBranchMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="chkShowAllFolders">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="chkShowAllFolders" />
                <telerik:AjaxUpdatedControl ControlID="rtvBranchRules" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="mainToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbldetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                <telerik:AjaxUpdatedControl ControlID="ddlTemplate" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlTemplate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbldetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlTemplate" />
                <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRemoveSuperUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="spnSuperUsers" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnAddSuperUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="spnSuperUsers" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ToolBarWorkflowRoles SmallToolbar" style="background-color: RGB(237,237,237) !important; margin-top:68px">
    <tr>
        <td style="width: 10%; padding-left: 24px; min-width: 120px; color: #666666 !important;" class="HideOnMobileToolbar">
            <asp:Label ID="lblTemplate" runat="server" Text="Select Template" meta:resourcekey="lblTemplate" />
        </td>
        <td style="width: 240px !important;" class="ToolbarTd showOnIpad">
            <telerik:RadComboBox ID="ddlTemplate" runat="server" meta:resourcekey="ddlTemplate"
                Width="240px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                CausesValidation="False" Height="300px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                ShowMoreResultsBox="True" CheckForDirt="True" EnableLoadOnDemand="true"
                EnableVirtualScrolling="True" EmptyMessage="Select Template..." OnItemsRequested="ddl_ItemsRequested">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>
        <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true">
                <Items>
                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                        CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save" PostBack="true">
                    </telerik:RadToolBarButton>

                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                        <Buttons>
                            <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png" CommandName="New">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Copy" CommandName="Copy">
                            </telerik:RadToolBarButton>
                        </Buttons>
                    </telerik:RadToolBarSplitButton>

                    <%--<telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true"
                        CssClass="ToolbarNew" CommandName="New" AccessKey="n" CausesValidation="false">
                    </telerik:RadToolBarButton>--%>

                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                        CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                    </telerik:RadToolBarButton>
                    <%--<telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true"
                        CssClass="ToolbarCopy" CommandName="Copy" Value="CopyRecord">
                    </telerik:RadToolBarButton>--%>
                    <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CommandName="OpenDesigner"
                        CssClass="ToolbarOpenDesigner lnkCreateNext" Value="OpenDesigner" OuterCssClass="HideOnMobileToolbar" meta:resourcekey="UseVisualDesigner">
                    </telerik:RadToolBarButton>
                    <%--  <telerik:RadToolBarButton ID="btnCreateNext" PostBack="true" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="CreateNext"
                            meta:resourcekey="btnCreateNext" CommandName="CreateNext" Text="Create Next" ImageUrl="Images/ToolBar/PMWebW.gif" OnClientClick="DisablebtnCreateNext(this)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>--%>
                </Items>
            </telerik:RadToolBar>
        </td>
        <td style="width: 100%"></td>
    </tr>
</table>
<table width="100%" border="0" runat="server" id="tbldetails">
    <tr>
        <td>
            <div class="PMMainPage JustifyContent">
                <div class="row WorkflowSinglePage" style="padding-right: unset">
                    <div class="col-4 col-4-left">
                        <table runat="server" id="tblTemplateInfo" class="colTable" border="0">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblMsg" runat="server" Visible="true" CssClass="Validator"></asp:Label>
                                    <asp:Label ID="lblTemplateId" runat="server" Text="Template Id" meta:resourcekey="lblTemplateIDName"></asp:Label>
                                </td>
                                <td class="controlWidth" style="width: 240px !important;">
                                    <asp:TextBox ID="txtTemplateId" runat="server" Width="100%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvTemplateId" runat="server" CssClass="Validator"
                                        Display="Dynamic" ForeColor="" ControlToValidate="txtTemplateId" ValidationGroup="Save"
                                        meta:resourcekey="rfvTemplateId">
                                    </asp:RequiredFieldValidator>
                                    <asp:Label ID="lblTemplateIdError" runat="server" Visible="false" meta:resourcekey="lblTemplateIdError"
                                        CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblTemplateName" Text="Template Name*" runat="server" meta:resourcekey="lblTemplateName"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtTemplateName" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvTemplateName" runat="server" CssClass="Validator"
                                        Display="Dynamic" ForeColor="" ControlToValidate="txtTemplateName" ValidationGroup="Save"
                                        meta:resourcekey="rfvTemplateName">
                                    </asp:RequiredFieldValidator>
                                    <asp:Label ID="lblTemplateNameError" runat="server" Visible="false" meta:resourcekey="lblTemplateNameError"
                                        CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" width="100%">
                                    <table class="colTable">
                                        <tr>
                                            <td width="95%" style="color: #666666;">
                                                <asp:Label ID="lblRecalculateDue" runat="server" Text="Recalculate Due Dates On Actions"
                                                    meta:resourcekey="lblRecalculateDue"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkRecalculateDue" runat="server" Style="float: right" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="95%" style="color: #666666;">
                                                <asp:Label ID="lblAllMustApproveEmail" runat="server" Text="Single All Must Approve Email"
                                                    meta:resourcekey="lblAllMustApproveEmail"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkAllMustApproveEmail" runat="server" Style="float: right" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAssociateWith" runat="server" Text="Associate With" meta:resourcekey="lblAssociateWith"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlAssociate" AllowCustomText="false" runat="server"
                                        Style="font-size: 11px" Width="100%" CloseDropDownOnBlur="true" DropDownCssClass="ddlTreeviewTemplate">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="" />
                                        </Items>
                                        <ItemTemplate>
                                            <telerik:RadTreeView ID="rtvAssociate" runat="server" CheckBoxes="true" Width="100%"
                                                OnNodeDataBound="rtv_NodeDataBound" Height="250px" MultipleSelect="false" ShowLineImages="false"
                                                OnClientNodeChecked="NodeChecked">
                                            </telerik:RadTreeView>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <%--<tr>
                    <td>
                        <asp:Label ID="lblBPMManagers" runat="server" Text="BPM Managers11" meta:resourcekey="lblBPMManagers"></asp:Label>
                    </td>
                    <td style="padding-left: 5px">
                        <telerik:RadComboBox ID="ddlBPMManagers" AllowCustomText="false" runat="server" Skin="Default"
                            Style="font-size: 11px" Width="238px" CloseDropDownOnBlur="true" DropDownWidth="238px">
                            <Items>
                                <telerik:RadComboBoxItem Text="" />
                            </Items>
                            <ItemTemplate>
                                <telerik:RadTreeView ID="rtvBPMManagers" Skin="Default" runat="server" CheckBoxes="true"
                                    OnNodeDataBound="rtv_NodeDataBound" Height="250px" MultipleSelect="false" ShowLineImages="false"
                                    OnClientNodeChecked="NodeChecked">
                                </telerik:RadTreeView>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </td>
                </tr>--%>
                            <%-- <tr>
                    <td colspan="2">
                        <asp:HyperLink ID="hplVisualDesigner" Text="Visual Workflow Designer" meta:resourcekey="hplVisualDesigner"
                            runat="server" onclick="return OpenDesigner();" Visible='<%# (PM.Workflow.TemplateInfo.Id > 0) %>'
                            CssClass="Link"></asp:HyperLink>
                    </td>
                </tr>--%>
                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset style="padding-right: 2px;">
                            <legend>
                                <asp:Label ID="lblSuperUsers" runat="server" Text="BPM Manager" CssClass="legend" meta:resourcekey="lblSuperUsers"></asp:Label>
                                <%--<span class="Icon" id="imgHelp" />--%>
                            </legend>
                            <table runat="server" id="tblSuperUsers" class="colTable">
                                <tr>
                                    <td style="vertical-align: top; float: left; padding-bottom: 5px;">
                                        <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton" OnClientClick="return OpenSelectUserPopup()">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="width: 100%; height: 112px; max-height: 112px; overflow: auto; float: left; border: 1px solid #666666;"
                                            class="scroll-pane" id="dvSuperUsers" runat="server">
                                            <span id="spnSuperUsers" runat="server" style="white-space: nowrap;"></span>
                                        </div>
                                        <%--<telerik:RadGrid ID="rdgSuperUsers" runat="server"  
                                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="310px" PageSize="3"
                                AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="true" ShowStatusBar="false"
                                ShowGroupPanel="false" GroupingEnabled="false">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" ShowPagerText="false" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_User %>" UniqueName="User">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("UserName") = String.Empty, "&nbsp;", Container.DataItem("UserName"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlFullName" runat="server" Width="300px" meta:resourcekey="ddlFullNameResource">
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="rfvFullName" Display="Dynamic" ControlToValidate="ddlFullName"
                                                    runat="server" ValueToCompare="0" CssClass="Validator" ForeColor="" Operator="GreaterThan"
                                                    meta:resourcekey="rfvFullName"></asp:CompareValidator>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="300px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" 
                                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgSuperUsers.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label1" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                                                SecurityButtonType="AddEditMode" Visible='<%# rdgSuperUsers.EditIndexes.Count > 0 Or rdgSuperUsers.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label2" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" 
                                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgSuperUsers.EditIndexes.Count = 0 AND (Not rdgSuperUsers.MasterTableView.IsItemInserted) AND (PM.Workflow.TemplateInfo.Id > 0) %>'
                                                meta:resourcekey="btnAddResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label3" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton4" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgSuperUsers.EditIndexes.Count = 0 AND (Not rdgSuperUsers.MasterTableView.IsItemInserted) AND (PM.Workflow.TemplateInfo.Id > 0) %>'
                                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label4" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                            </telerik:RadGrid>--%>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <%--<telerik:RadToolTip ID="rtlHelp" runat="server" RelativeTo="Element" Height="40px"
                            meta:resourcekey="rtlHelp" Text="Template's managers can edit document when workflow is finished (Approved, Rejected or Withdrawn)"
                            TargetControlID="imgHelp" IsClientID="true" Position="BottomCenter" EnableAriaSupport="true"
                            EnableShadow="true" HideEvent="LeaveToolTip">
                        </telerik:RadToolTip>--%>
                    </div>
                    <div class="col-4 col-4-right">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblOverdueAlert" runat="server" CssClass="legend" Text="Overdue Alert" meta:resourcekey="lblOverdueAlert"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important; height: 0px !important;"></td>
                                    <td class="controlWidth" style="width: 240px !important;"></td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <table class="colTable">
                                            <tr>
                                                <td width="95%" style="color: #666666;">
                                                    <asp:Label ID="lblAlertActive" runat="server" Text="Alert Active" meta:resourcekey="lblAlertActive"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkAlertActive" runat="server" class="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important;">
                                        <asp:Label ID="lblDays" runat="server" Text="days(+/-)" meta:resourcekey="lblDays"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="width: 240px !important;">
                                        <asp:TextBox ID="txtDays" runat="server" CssClass="Integer" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRoles" runat="server" Text="Role(s)" meta:resourcekey="lblRoles"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRoles" Height="250px" runat="server"
                                            meta:resourcekey="ddlRoles" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            AllowCustomText="True" Width="100%" EnableItemCaching="false"
                                            OnClientDropDownClosing="OnClientDropDownClosing" OnItemsRequested="ddl_ItemsRequested"
                                            OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnClientDropDownClosed="OnRolesClientDropDownClosed">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnRoleIds" />
                                        <asp:HiddenField runat="server" ID="hddnRoleNames" />
                                        <asp:Button runat="server" ID="btnRoles" CssClass="Hide" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <table class="colTable">
                                            <tr>
                                                <td width="95%" style="color: #666666;">
                                                    <asp:Label ID="lblEmail" runat="server" Text="Email" meta:resourcekey="lblEmail"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkEmail" runat="server" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="95%" style="color: #666666;">
                                                    <asp:Label ID="lblOnScreen" runat="server" Text="OnScreen" meta:resourcekey="lblOnScreen"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkOnScreen" runat="server" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="95%" style="color: #666666;">
                                                    <asp:Label ID="lblTextSMS" runat="server" Text="Text(SMS)" meta:resourcekey="lblTextSMS"
                                                        CssClass="Hide"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkTextSMS" runat="server" CssClass="Hide" class="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
                <div class="row row-8-4-fit8">
                    <div class="col-4">
                        <table class="colTable" style="width: 100%; height: 320px;">
                            <tr>
                                <td valign="top">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblRolesAPMRules" runat="server" CssClass="legend" Text="Roles & APM Rules" meta:resourcekey="lblRolesAPMRules"></asp:Label>
                                        </legend>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 13px; max-width: 400px; width: 100% !important; background-color: #EDEDED; border: 1px solid #999999; border-bottom: none;">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%" border="0">
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox runat="server" ID="txtUser" AutoPostBack="true" meta:resourcekey="txtUsers" Width="100%"></telerik:RadTextBox>
                                            </td>
                                            <td style="width: 30px; padding-left: 10px;">
                                                <asp:LinkButton runat="server" ID="LinkButton1" CssClass="LoopButton" Width="30px">
                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="max-width: 400px;">
                                    <telerik:RadTabStrip ID="rtsBranches" runat="server" MultiPageID="RadMultiPage1"
                                        SelectedIndex="0" ShowBaseLine="true" BorderWidth="0" CssClass="colortabs WorkflowRoleCss">
                                        <Tabs>
                                            <telerik:RadTab Text="Roles" Value="Roles" Height="26px">
                                                <TabTemplate>
                                                    <asp:Label runat="server" ID="lblRolesName" meta:Resourcekey="RadTab_Roles"></asp:Label>
                                                </TabTemplate>
                                            </telerik:RadTab>
                                            <telerik:RadTab IsSeparator="true" CssClass="SeperatorCssTabWorkflow" Visible="true" Enabled="false"
                                                ID="SeperatorTab" runat="server" OuterCssClass="SeperatorCssTabWorkflow">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Branch Rules" Value="BranchRules" Height="26px">
                                                <TabTemplate>
                                                    <asp:Label runat="server" ID="lblBranchRulesName" meta:Resourcekey="RadTab_BranchRules"></asp:Label>
                                                </TabTemplate>
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" CssClass="pageView">
                                        <telerik:RadPageView ID="RdpRoles" runat="server" BorderWidth="0" Style="width: 100%; height: 234px; border: 1px solid #999999; border-top: none;">
                                            <telerik:RadTreeView ID="rtvRoles" runat="server" EnableDragAndDrop="True" CssClass="RadTreeWhite RdpRolesWidth RadTreeViewRoles" Height="233px"
                                                MultipleSelect="true" OnClientNodeDropping="itemDropping" OnClientNodeDragging="itemDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                                OnNodeDrop="rtvRoles_NodeDrop" OnClientLoad="function(sender) {rtvRoles = sender;}" CheckBoxes="true" TriStateCheckBoxes="true">
                                            </telerik:RadTreeView>
                                            <asp:LinkButton runat="server" ID="btnTreeDropItems">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp;</div>
                                            </asp:LinkButton>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="rdpSeperator" runat="server"></telerik:RadPageView>
                                        <telerik:RadPageView ID="RdpBranchRules" runat="server" Style="width: 100%; height: 234px; border: 1px solid #999999; border-top: none;">
                                            <telerik:RadTreeView ID="rtvBranchRules" runat="server" EnableDragAndDrop="True" CssClass="RdpRolesWidth RadTreeViewBranchRules" Height="211px"
                                                OnClientNodeClicking="Validate_OnNodeClick" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                                                OnClientContextMenuShowing="onContextMenuShowing" CausesValidation="False" CheckBoxes="true" TriStateCheckBoxes="true"
                                                OnClientNodeDropping="itemDropping" OnClientNodeDragging="itemDragging" OnNodeDrop="rtvBranchRules_NodeDrop"
                                                OnClientLoad="function(sender) {rtvBranchRules = sender; }" OnClientNodeChecked="ShowHidebtnTreeDropItemsBranchRules">
                                                <ContextMenus>
                                                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" CssClass="trvContextMenu">
                                                        <Items>
                                                            <telerik:RadMenuItem Value="AddBranchRule" meta:Resourcekey="MenuItem_AddBranchRule"
                                                                Text="Add Branch Rule" EnableImageSprite="true" CssClass="MenuAdd">
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Value="EditBranchRule" meta:Resourcekey="MenuItem_EditBranchRule"
                                                                Text="Edit Branch Rule" EnableImageSprite="true" CssClass="MenuEdit">
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Value="DeleteBranchRule" meta:Resourcekey="MenuItem_DeleteBranchRule"
                                                                Text="Delete Branch Rule" EnableImageSprite="true" CssClass="MenuDelete">
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadTreeViewContextMenu>
                                                </ContextMenus>
                                            </telerik:RadTreeView>
                                            <asp:LinkButton runat="server" ID="btnTreeDropItemsBranchRules" CssClass="Hide">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">
                                                   &nbsp; 
                                                </div>
                                            </asp:LinkButton>
                                            <asp:CheckBox ID="chkShowAllFolders" runat="server" meta:Resourcekey="chkShowAllFolders"
                                                AutoPostBack="true" class="mobile-switch" />
                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-8">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblSteps" runat="server" CssClass="legend" Text="Steps" meta:resourcekey="lblSteps"></asp:Label>
                            </legend>
                            <table class="colTable" style="overflow: auto;margin-top:5px;" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBranchMessage" runat="server" meta:resourcekey="lblBranchMsg" CssClass="Validator"
                                            Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background: none !important;">
                                    <td style="padding: 0px;">
                                        <div style="background-color: RGB(237,237,237) !important; overflow: auto; width: calc(99% + 2px) !important">
                                            <table cellpadding="0" cellspacing="0" style="border-style: none none solid none; border-width: 1px; border-color: #C5C5C5; overflow: auto; width: 100%">
                                                <tr>
                                                    <td id="tdCommandBar" runat="server">
                                                        <div id="divCommandBar" runat="server" style="overflow: auto">
                                                            <table class="rgCommandRow" width="100%" style="border: 1px solid #828282; border-bottom: none !important;">
                                                                <tr>
                                                                    <td style="padding-left: 20px;width:76px;">
                                                                        <asp:LinkButton ID="lbtAddRole" runat="server" CausesValidation="False" OnClientClick="return StepIconClicked(false,0);"
                                                                            SecurityButtonType="ItemMode_Add" Visible="True" CssClass="GridCmdInitNewRow">
                                                                            <span class="Icon"></span>
                                                                            <asp:Label ID="lblAddRole" runat="server" meta:resourcekey="lblAddRole" Text="Add Role"></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td style="width:89px;padding-left: 15px;">
                                                                        <asp:LinkButton ID="lbtAddBranchRule" runat="server" CausesValidation="False" OnClientClick="return StepIconClicked(true,0);"
                                                                            SecurityButtonType="ItemMode_Add" Visible="True" CssClass="GridCmdInitNewRow">
                                                                            <span class="Icon"></span>
                                                                            <asp:Label ID="lblAddBranchRule" runat="server" meta:resourcekey="lblAddBranchRule"
                                                                                Text="Add Branch"></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td style="width:61px;padding-left: 15px;">
                                                                        <asp:LinkButton ID="lbtDelete" runat="server" CausesValidation="False" OnClientClick="Javascript:return DeleteSelectedTemplates()"
                                                                            SecurityButtonType="ItemMode_Delete" Visible="True" CssClass="GridCmdDeleteRows">
                                                                            <span class="Icon"></span>
                                                                            <asp:Label ID="lblDelete" runat="server" meta:resourcekey="lblDelete" Text="Delete"></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td style="padding-left: 15px;">
                                                                        <asp:LinkButton ID="lbtRefresh" runat="server" CausesValidation="False" CommandName="Refresh"
                                                                            SecurityButtonType="ItemMode" Visible="True" CssClass="GridCmdRebindGrid">
                                                                            <span class="Icon"></span>
                                                                            <asp:Label ID="lblRefresh" runat="server" meta:resourcekey="lblRefresh" Text="Refresh"></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="min-height: 298px; max-height: 298px; overflow: auto;">
                                            <telerik:RadTreeList ID="rdtSteps" runat="server" AllowMultiItemEdit="True" SetWidth="true" FitParentContainer="true"
                                                AllowRecursiveDelete="True" AutoGenerateColumns="False" EnableEmbeddedScripts="false" Height="296px"
                                                AllowMultiItemSelection="False" AllowLoadOnDemand="false" ParentDataKeyNames="ParentId" Width="99%" HeaderStyle-CssClass="UpperCase"
                                                ShowTreeLines="False" EditMode="InPlace" DataKeyNames="Id" CssClass="Overflow StepsTreeStyle" HeaderStyle-HorizontalAlign="Center"
                                                ClientDataKeyNames="Id">
                                                <ClientSettings AllowItemsDragDrop="true" Selecting-AllowItemSelection="true" ClientEvents-OnTreeListCreated="OnTreeListCreated"
                                                    ClientEvents-OnItemDblClick="OnTreeListDblClick">
                                                    <Selecting AllowItemSelection="True"></Selecting>
                                                    <Scrolling AllowScroll="false" ScrollHeight="253px" UseStaticHeaders="True" SaveScrollPosition="true" />
                                                    <ClientEvents></ClientEvents>
                                                </ClientSettings>
                                                <Columns>
                                                    <telerik:TreeListTemplateColumn UniqueName="StepNumber" HeaderText="Step #" HeaderStyle-Width="23px" 
                                                        meta:resourcekey="StepNumber">
                                                        <ItemTemplate>
                                                            <%#Eval("StepFullNumber")%>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="IsBranch" HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                                        meta:resourcekey="IsBranch">
                                                        <ItemTemplate>
                                                            <%--<a onclick="return StepIconClicked('<%#Eval("IsBranch")%>','<%#Eval("Id")%>');" class="<%#CStr(IIf(CBool(Eval("IsBranch")), "BranchButton", "CheckedInButton"))%>">
                                                    <span class="Icon"></span>
                                                </a>--%>
                                                            <asp:LinkButton ID="lbtType" runat="server" CausesValidation="False">
                                                    <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="Description" HeaderText="Description"
                                                        HeaderStyle-Width="250px" meta:resourcekey="Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="Level" HeaderText="Level"
                                                        HeaderStyle-Width="100px" meta:resourcekey="Level">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLevel" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="Action" HeaderText="Action" HeaderStyle-Width="80px"
                                                        meta:resourcekey="Action">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAction" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="ReturnTo" HeaderText="ReturnTo" HeaderStyle-Width="130px"
                                                        meta:resourcekey="ReturnTo">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReturnTo" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                    <telerik:TreeListTemplateColumn UniqueName="Delegate" HeaderText="Delegate" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                                                        meta:resourcekey="Delegate">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("CanDelegate")), "checked.png", "unchecked.png"))%>"
                                                                alt="" />
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>


                                                    <telerik:TreeListTemplateColumn UniqueName="UseDocuSign" HeaderText="DocuSign Step" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                                                        meta:resourcekey="DocuSign">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("UseDocuSign")), "checked.png", "unchecked.png"))%>"
                                                                alt="" />
                                                        </ItemTemplate>
                                                    </telerik:TreeListTemplateColumn>
                                                </Columns>
                                            </telerik:RadTreeList>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
                <div>
                    <div class="PMHeader">
                        <div class="col-12">
                            <fieldset style="margin-top: 10px;">
                                <legend>
                                    <asp:Label ID="lblVisualWorkflow" runat="server" Text="Visual Workflow" CssClass="legend" meta:resourcekey="lblVisualWorkflow"></asp:Label>
                                </legend>
                                <table class="colTable" style="overflow: auto">
                                    <tr>
                                        <td>
                                            <%--<div id="loadingMessage">
                                                <asp:Label ID="lblLoadingMessage" runat="server" meta:resourcekey="lblLoadingMessage"></asp:Label>
                                            </div>--%>
                                            <iframe id="frameImage" frameborder="0" src="WorkflowImageGenerator.aspx" width="100%" height="270px" style="padding: 0px; margin: 0px"></iframe>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>

<asp:Button ID="btnRefreshTree" runat="server" CssClass="Hide" />
<asp:Button ID="btnRefreshPage" runat="server" CssClass="Hide" />
<asp:Button ID="btnReloadPage" runat="server" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hdnSelectedMsg" />
<asp:Button ID="btnAddSuperUsers" runat="server" CssClass="Hide" />
<asp:Button ID="btnRemoveSuperUsers" runat="server" CssClass="Hide" />
<asp:HiddenField ID="hfdeletedSuperUsers" runat="server" Value="0" ValidateRequestMode="Disabled" />
