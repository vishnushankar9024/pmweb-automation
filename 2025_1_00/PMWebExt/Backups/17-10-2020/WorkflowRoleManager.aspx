<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="WorkflowRoleManager.aspx.vb" Inherits="Website.WorkflowRoleManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <link href="CSS/MainCss.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock runat="server" ID="c1">
        <script type="text/javascript" language="javascript">
            var canDrop = false;
            var rdvUsers;
            var rdvPermissions;

            function itemDragging(sender, args) {
                var isChild;
                var dropClue;
                var target = args.get_htmlElement();
                if (!target) return;
                if (sender == rdvUsers || sender == rdvPermissions) { dropClue = sender._draggingClue; args._node.set_allowDrop(false); }
                dropClue.className = "dropClue dropDisabled";
                canDrop = false;
                var grid = isMouseOverTreeLists(target);
                if (grid) {
                    dropClue.className = "dropClue dropEnabled";
                    canDrop = true;
                }

                return false;

                if (sender == rdvUsers) {
                    dropClue = sender._draggingClue;
                    if (!args._node.get_allowDrop()) //trying to drag a parent item onto its own child
                    {
                        dropClue.className = "dropClue dropDisabled";
                        return;
                    }
                } else {
                    dropClue = $telerik.findElement(args.get_draggedContainer(), "DropClue");
                    args.set_dropClueVisible(true);  //drop clue is always visible
                    if (!args.get_canDrop()) //trying to drag a parent item onto its own child
                    {
                        dropClue.className = "dropClue dropDisabled";
                        return;
                    }
                }
            }

            function isMouseOverTreeLists(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id != null && (parentNode.id.indexOf("rdtRoles") > 0 || parentNode.id.indexOf("rdtRolesByEntity") > 0)) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }
                return null;
            }

            function itemDropping(sender, args) {

                if (!canDrop) { args.set_cancel(true); return false; }
                if (droppedOnTreeLists(args)) return false;
            }

            function droppedOnTreeLists(args) {
                var target = args.get_htmlElement();
                while (target) {
                    if (target.id != null && (target.id.indexOf("rdtRoles") > 0 || target.id.indexOf("rdtRolesByEntity") > 0)) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }
            function ToggleAssetMenu() {
                var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
                var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>')
                var form = $('form')[0]
                var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    //tdAssetExplorerBar.style.left = "290px";
                    tdAssetExplorerBar.className = ' MobileAssetExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'inline', 60);
                    form.className = form.className + ' AssetExplorerVisible';
                    ResizeAllGrids();
                } else {
                    tdAssetMenu.style.display = 'none';
                    //tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.className = 'MobileAssetExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'none', 60);
                    form.className = form.className.replace(' AssetExplorerVisible', '');
                    ResizeAllGrids();
                }
                return false;
            }

            function afterClientCheck(tree, eventArgs) {
                var node = eventArgs.get_node();
                if (node.get_checked()) {
                    for (var i = 0; i < tree.get_allNodes().length; i++) {
                        if (tree.get_allNodes()[i] != node)
                            tree.get_allNodes()[i].set_checked(false);
                    }
                }
                if (tree.get_checkedNodes().length > 0) {
                    $("[id$=btnTreeDropItems]").removeClass("Hide");
                }
                else
                    $("[id$=btnTreeDropItems]").addClass("Hide");
            }
            function ShowHidebtnTreeDropPermissions(sender, args) {
                if (sender.get_checkedNodes().length > 0) {
                    $("[id$=btnTreeDropPermissions]").removeClass("Hide");
                }
                else
                    $("[id$=btnTreeDropPermissions]").addClass("Hide");
            }

        </script>
        <style type="text/css">
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

            .widthtabs {
                width: 200px !important;
            }



            .colortabs {
                background-color: #ffffff !important;
                color: #3598DB !important;
                padding: 0px !important;
                border-bottom: none;
                font-size: 10pt;
            }

            .RadTabStrip_Office2007 .rtsLevel1 .rtsLink.colortabs {
                color: #3598DB !important;
            }

            .colortabs .rtsSelected .rtsOut {
                color: #F9AA33 !important;
            }

            .RadTabStrip .rtsLevel1 .rtsTxt {
                font-size: 12pt !important;
            }

            .borderstyle .rtsLevel.rtsLevel1 {
                padding-bottom: 5px;
                padding-top: 5px;
                border-bottom: 1px solid #999999;
                height: 26px;
                width: 100% !important;
            }

            .rdtRoleManager {
                background-color: #999999;
                border-color: #C5C5C5;
                color: #000000;
            }

                .rdtRoleManager .rtlHeader {
                    background-color: #999999 !important;
                    color: #ffffff !important;
                    background-image: none !important;
                }

                    .rdtRoleManager .rtlHeader a {
                        color: #ffffff !important;
                    }

            .RadTreeList_Office2007 .rtlHeader {
                background: none;
                background-color: #999999;
            }

                .RadTreeList_Office2007 .rtlHeader th {
                    border: 1px solid #C5C5C5;
                }

                .RadTreeList_Office2007 .rtlHeader a {
                    color: #FFFFFF;
                    text-transform: uppercase;
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

            .AssetExplorerBar {
                background-color: #666666 !important;
                border-color: #666666 !important;
                background-image: none !important;
            }

            div#ctl00_CPH1_rdtRolesByEntity {
                border-left: none !important;
            }

            div.PropertyIcon {
                background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
                background-repeat: no-repeat !important;
                background-position: -1504px 1px !important;
                text-align: center;
                height: 16px !important;
                width: 16px !important;
            }

            @media screen and (min-width:320px) and (max-width:843px) {
                div#ctl00_CPH1_rdvUsers {
                    height: calc(100vh - 175px) !important;
                }

                .MenuWidth.MobileAssetTree {
                    width: 400px !important;
                    background-color: #ffffff !important;
                }

                #ctl00_CPH1_tdAssetExplorerBar.MobileAssetExplorerBar {
                    left: 400px !important;
                }

                .RightTd {
                    width: calc(100vw - 1px) !important;
                }

                .MobileAssetExplorerBarClosed {
                    height: calc(100vh - 35px) !important;
                }

                .MobileAssetExplorerBar {
                    height: calc(100vh - 35px) !important;
                }

                .PMMainPage {
                    padding: 0 !important;
                }

                div#ctl00_CPH1_rdvUsers {
                    height: calc(100vh - 194px) !important;
                }

                div#ctl00_CPH1_rdvPermissions {
                    height: calc(100vh - 175px) !important;
                }
            }


            .RadTreeViewUsers .trvUser .rtUnchecked, .RadTreeViewUsers .trvUser .rtChecked {
                margin-left: -36px !important;
            }

            .RadTreeViewUsers .trvUser .rtSp {
                margin-right: 0px !important;
            }

            .RadTreeViewUsers .rtUL {
                margin-left: 22px !important;
            }

            .rtvGuest .trvPorgramProject .rtIn {
                margin-left: 36px !important;
            }

            .RadTreeViewPermissions.rtvGuest .trvUserGroup .rtSp, .RadTreeViewPermissions.rtvGuest .trvUser .rtSp, .RadTreeViewPermissions.rtvGuest .trvProject .rtSp, .rtvGuest .trvPBSProject .rtSp,
            .RadTreeViewPermissions.rtvGuest .trvPortfolio .rtSp, .RadTreeViewPermissions.rtvGuest .trvPBSPortfolio .rtSp, .RadTreeViewPermissions.RO .trvPorgramProject .rtSp,
            .RadTreeViewPermissions.rtvGuest .trvPorgramLocation .rtSp, .RadTreeViewPermissions.rtvGuest .trvProperty .rtSp {
                margin-right: -13px !important;
            }

            .RadTreeViewPermissions .trvUserGroup .rtSp, .RadTreeViewPermissions .trvUser .rtSp, .RadTreeViewPermissions .trvProject .rtSp, .RadTreeViewPermissions .trvPBSProject .rtSp,
            .RadTreeViewPermissions .trvPortfolio .rtSp, .RadTreeViewPermissions .trvPBSPortfolio .rtSp, .RadTreeViewPermissions .trvPorgramProject .rtSp,
            .RadTreeViewPermissions .trvPorgramLocation .rtSp, .RadTreeViewPermissions .trvProperty .rtSp {
                margin-right: -36px !important;
            }

            .RadTreeViewPermissions .rtUL {
                margin-left: 27px;
            }

                .RadTreeViewPermissions .rtUL .rtUL, .RadTreeViewPermissions .rtUL .rtUL .rtUL {
                    margin-left: 0px;
                }

            input#ctl00_CPH1_rdtRolesByEntity_ctl03_InsertButton_EditCommandColumnByEntity {
                background-image: url(CSS/Images/ResponsiveIcons/16white.png);
                background-position: -336px 0px;
                display: inline-block;
                width: 16px;
                height: 16px;
            }
             input#ctl00_CPH1_rdtRolesByEntity_ctl03_CancelButton_EditCommandColumnByEntity{
           background-image: url(CSS/Images/ResponsiveIcons/16white.png);
                background-position: -208px 0px;
                display: inline-block;
                width: 16px;
                height: 16px;
             }
     input[type="button"]:hover, input[type="submit"]:hover {
    background-color: transparent !important;
}
     .RadTreeList_Default .rtlREdit {
    background-color: #c5c5c5 !important;
}
        .RadTreeList_Default .rtlRSel {
    background: #C5C5C5!important;
    color: #fff;
}

.RadTreeList_Default .rtlUpdate {
    background-image: url(CSS/Images/ResponsiveIcons/16White.png);
    background-position: -336px 0px;
    display: inline-block;
    width: 16px;
    height: 16px;
}
.RadTreeList .rtlCancel {
    background-image: url(CSS/Images/ResponsiveIcons/16white.png);
    background-position: -208px 0px;
    display: inline-block;
    width: 16px;
    height: 16px;
}          


            @media screen and (min-width:844px) {
                .RoleManagerTable {
                    width: calc(100vw - 201px);
                    height: calc(100vh - 60px);
                }
            }
        </style>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdtRoles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdtRoles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdvUsers" />
                    <telerik:AjaxUpdatedControl ControlID="rdvPermissions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdtRolesByEntity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdtRolesByEntity" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdvUsers" />
                    <telerik:AjaxUpdatedControl ControlID="rdvPermissions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdvUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdtRoles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdtRolesByEntity" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdvUsers" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdvPermissions">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdtRoles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdtRolesByEntity" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdvPermissions" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="txtUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdvPermissions" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdvUsers" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="txtUsers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpRoleManager" runat="server" Skin="Default" />
    <table class="TableNoSpacingNoBorder RoleManagerTable">
        <tr>
            <td valign="top" id="tdAssetMenu" runat="server" class="MenuWidth MobileAssetTree">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left ">

                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblUsers" runat="server" Text="Users" CssClass="legend" meta:resourcekey="lblUsers"></asp:Label>
                                </legend>
                                <table class="TableNoSpacingNoBorder" style="width: 100%; table-layout: fixed">
                                    <tr>
                                        <td style="padding: 13px; max-width: 400px; width: 100% !important; background-color: #EDEDED; border: 1px solid #999999; border-bottom: none;">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%" border="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox runat="server" ID="txtUser" AutoPostBack="true" meta:resourcekey="txtUsers" Width="100%"></telerik:RadTextBox>
                                                    </td>
                                                    <td style="width: 30px; padding-left: 10px;">
                                                        <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="LoopButton" Width="30px">
                                                    <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="max-width: 400px; border: 1px solid #999999">
                                            <telerik:RadTabStrip ID="rtsUsers" runat="server" Skin="Vista" MultiPageID="RadMultiPage1"
                                                SelectedIndex="0" ShowBaseLine="true" BorderWidth="0" BorderStyle="Solid" BorderColor="#999999" Width="100%" CssClass="colortabs mainHomeTabsROLES WorkflowRoleCss borderstyle">
                                                <Tabs>
                                                    <telerik:RadTab Text="By User11" Value="ByUser" Height="26px" CssClass="colortabs FontStyle mainHomeTabsROLES CssTabWorkflow">
                                                        <TabTemplate>
                                                            <asp:Label runat="server" ID="lblByUser" meta:Resourcekey="RadTab_ByUser" Text="By User11"></asp:Label>
                                                        </TabTemplate>
                                                    </telerik:RadTab>
                                                    <telerik:RadTab IsSeparator="true" CssClass="SeperatorCssTabWorkflow" Visible="true" Enabled="false"
                                                        ID="SeperatorTab" runat="server" OuterCssClass="SeperatorCssTabWorkflow">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab Text="By Permissions11" Value="ByPermissions" Height="26px" CssClass="colortabs FontStyle mainHomeTabsROLES CssTabWorkflow">
                                                        <TabTemplate>
                                                            <asp:Label runat="server" ID="lblByPermissions" meta:Resourcekey="RadTab_ByPermissions" Text="By Permissions11"></asp:Label>
                                                        </TabTemplate>
                                                    </telerik:RadTab>
                                                </Tabs>
                                            </telerik:RadTabStrip>
                                            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" CssClass="pageView" Width="100%" BorderWidth="0" BorderStyle="Solid" BorderColor="#999999">
                                                <telerik:RadPageView ID="RdpByUser" runat="server" BorderWidth="0">
                                                    <div id="pnlByUser" style="overflow: auto;">
                                                        <telerik:RadTreeView ID="rdvUsers" runat="server" Skin="Default" MultipleSelect="false" EnableDragAndDrop="True"
                                                            Style="padding-left: 5px; height: calc(100vh - 230px)"
                                                            OnClientNodeDropping="itemDropping" OnClientNodeDragging="itemDragging" OnClientLoad="function(sender) {rdvUsers = sender;}"
                                                            CheckBoxes="true" TriStateCheckBoxes="true" CssClass="RadTreeViewUsers" OnClientNodeChecked="afterClientCheck">
                                                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                                            <ExpandAnimation Duration="100"></ExpandAnimation>
                                                            <NodeTemplate>
                                                                <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                                            </NodeTemplate>
                                                        </telerik:RadTreeView>
                                                        <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                                    <div class="btnTreeDropItems">&nbsp;</div>
                                                        </asp:LinkButton>
                                                    </div>
                                                </telerik:RadPageView>
                                                <telerik:RadPageView ID="rdpSeperator" runat="server"></telerik:RadPageView>
                                                <telerik:RadPageView ID="RdpByPermissions" runat="server">
                                                    <div id="pnlByPermissions" style="overflow: auto;">
                                                        <telerik:RadTreeView ID="rdvPermissions" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true"
                                                            OnClientNodeDropping="itemDropping" OnClientNodeDragging="itemDragging" Style="height: calc(100vh - 214px)" Width="100%"
                                                            OnClientLoad="function(sender) {rdvPermissions = sender;}" OnClientNodeChecked="ShowHidebtnTreeDropPermissions"
                                                            CheckBoxes="true" TriStateCheckBoxes="true" CssClass="RadTreeViewPermissions">
                                                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                                            <ExpandAnimation Duration="100"></ExpandAnimation>
                                                            <NodeTemplate>
                                                                <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                                            </NodeTemplate>
                                                        </telerik:RadTreeView>
                                                        <asp:LinkButton runat="server" ID="btnTreeDropPermissions" CssClass="Hide">
                                                    <div class="btnTreeDropItems">&nbsp;</div>
                                                        </asp:LinkButton>
                                                    </div>
                                                </telerik:RadPageView>
                                            </telerik:RadMultiPage>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>

                        </div>
                    </div>
                </div>
            </td>
            <td id="tdAssetExplorerBar" runat="server" class="MobileAssetExplorerBar" style="border: 1px solid gray; background-color: #ffffff !important">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="ToggleAssetMenu();" />
            </td>
            <td valign="top" class="RightTd">
                <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                    <tr class="ToolBar ToolbarPositionOnMobile">
                        <td class="ToolbarTd" style="min-width: 120px; color: #666666;">
                            <asp:Label ID="lblSelectLevel" runat="server" Text="Select Level" meta:resourcekey="lblSelectLevel"></asp:Label>
                        </td>
                        <td style="width: 240px !important;">
                            <telerik:RadComboBox ID="ddlEntities" runat="server" Width="240px" AutoPostBack="True" AllowCustomText="true"
                                CausesValidation="False" Skin="Default" Height="350px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Select Level...">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                <ItemTemplate>
                                    <span class="Icon"></span>
                                    <span runat="server" id="lblText"></span>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 100%;"></td>
                        <%-- <td >
                               < asp:LinkButton ID="lbtDelete" runat="server" CausesValidation="False"
                                    SecurityButtonType="ItemMode_Delete" Visible="True"  CssClass="TreeListDeleteRole">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDelete" runat="server" meta:resourcekey="lblDelete" Text="Delete"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>--%>
                    </tr>
                </table>
                <div class="PMHeader" style="margin-top: 50px;">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadTreeList ID="rdtRoles" runat="server" AllowMultiItemEdit="True" CssClass="rdtRoleManager"
                                AllowRecursiveDelete="True" AutoGenerateColumns="False" AllowSorting="true" EnableEmbeddedScripts="false"
                                AllowMultiItemSelection="True" AllowLoadOnDemand="True" ParentDataKeyNames="ParentId"
                                ShowTreeLines="False" EditMode="InPlace" BackColor="#F1EFEC" DataKeyNames="Id"
                                ClientDataKeyNames="Id" Width="100%">
                                <ClientSettings AllowItemsDragDrop="false">
                                    <Selecting AllowItemSelection="True"></Selecting>
                                    <Scrolling AllowScroll="False" ScrollHeight="253px" UseStaticHeaders="false" />
                                </ClientSettings>
                                <Columns>
                                    <telerik:TreeListEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" HeaderStyle-Width="80px"></telerik:TreeListEditCommandColumn>

                                    <telerik:TreeListTemplateColumn UniqueName="DeleteRole" HeaderText="" HeaderStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtDeleteRole" runat="server" CausesValidation="False" CommandName="DeleteRole">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            &nbsp;
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:TreeListTemplateColumn>

                                    <telerik:TreeListTemplateColumn UniqueName="ImgType" HeaderText="" HeaderStyle-Width="50px">
                                        <ItemTemplate>
                                            <div class="<%#CStr(IIf(Eval("Type") = "SYS", "SystemIcon", IIf(Eval("Type") = "PROG", "ProgramIcon", IIf(Eval("Type") = "PROJ", "ProjectIcon", IIf(Eval("Type") = "LOCPROG", "LocProgramIcon", IIf(Eval("Type") = "LOC", "PropertyIcon", ""))))))%>">
                                                <span class="Icon"></span>
                                            </div>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div style="position: relative; top: -12px;" class="<%#CStr(IIf(Eval("Type") = "SYS", "SystemIcon", IIf(Eval("Type") = "PROG", "ProgramIcon", IIf(Eval("Type") = "PROJ", "ProjectIcon", IIf(Eval("Type") = "LOCPROG", "LocProgramIcon", IIf(Eval("Type") = "LOC", "PropertyIcon", ""))))))%>">
                                                <span class="Icon"></span>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:TreeListTemplateColumn>
                                    <telerik:TreeListTemplateColumn UniqueName="EntityName" HeaderText="Entity11"
                                        HeaderStyle-Width="250px" meta:resourcekey="Entity">
                                        <ItemTemplate>
                                            <span><%# IIf(CStr(Eval("EntityName")) = String.Empty, "&nbsp;", Eval("EntityName"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEntity" runat="server" Width="100%"></asp:TextBox>
                                            <asp:Label ID="lblUniqueRole" runat="server" CssClass="Validator" Text="Role name must be unique.11" meta:resourcekey="lblUniqueRole"></asp:Label>
                                            <asp:RequiredFieldValidator ID="rfvEntity" runat="server" ControlToValidate="txtEntity"
                                                CssClass="Validator" ErrorMessage="<br/>Role Name is Required" Display="Dynamic"
                                                ForeColor="" Operator="NotEqual" meta:resourcekey="rfvEntity">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </telerik:TreeListTemplateColumn>
                                    <telerik:TreeListTemplateColumn UniqueName="AssignedUser" HeaderText="User11" HeaderStyle-Width="300px"
                                        meta:resourcekey="User">
                                        <ItemTemplate>
                                            <span><%# IIf(CStr(Eval("AssignedUser")) = String.Empty, "&nbsp;", Eval("AssignedUser"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlUsers" runat="server" AutoPostBack="false" Type="OutQuint"
                                                Skin="Default" Width="100%" Height="300px" NoWrap="true" CausesValidation="false"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" meta:resourcekey="ddlUsers">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvUsers" runat="server" ControlToValidate="ddlUsers"
                                                CssClass="Validator" InitialValue="" ErrorMessage="User is required" meta:resourcekey="rfvUsers"
                                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvUsers" runat="server" ControlToValidate="ddlUsers"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" meta:resourcekey="csvUsers"
                                                CssClass="Validator" ErrorMessage="User is required">
                                            </asp:CustomValidator>
                                        </EditItemTemplate>
                                    </telerik:TreeListTemplateColumn>
                                    <telerik:TreeListTemplateColumn UniqueName="IsLocked" HeaderText="Locked11" HeaderStyle-Width="90px"
                                        meta:resourcekey="IsLocked">
                                        <ItemTemplate>
                                            <span>
                                                <asp:Image ID="imgIsLocked" runat="server" /></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chkLocked" runat="server" class="mobile-switch" />
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:TreeListTemplateColumn>
                                </Columns>
                            </telerik:RadTreeList>
                        </div>
                    </div>
                    <div class="row">
                        <telerik:RadTreeList ID="rdtRolesByEntity" runat="server" AllowMultiItemEdit="True"
                            AllowRecursiveDelete="True" AutoGenerateColumns="False" AllowSorting="true" EnableEmbeddedScripts="false"
                            AllowMultiItemSelection="True" AllowLoadOnDemand="False" ParentDataKeyNames="ParentId" CssClass="rdtRoleManager"
                            ShowTreeLines="False" EditMode="InPlace" BackColor="#C5C5C5" BorderColor="#666666" BorderWidth="1" DataKeyNames="Id" SetWidth="true" FitParentContainer="true"
                            ClientDataKeyNames="Id" Width="100%">
                            <ClientSettings AllowItemsDragDrop="false">
                                <Selecting AllowItemSelection="True"></Selecting>
                                <Scrolling AllowScroll="true" ScrollHeight="260px" UseStaticHeaders="false" />
                            </ClientSettings>
                            <Columns>
                                <telerik:TreeListEditCommandColumn UniqueName="EditCommandColumnByEntity" ButtonType="ImageButton" HeaderStyle-Width="80px"></telerik:TreeListEditCommandColumn>

                                <telerik:TreeListTemplateColumn UniqueName="DeleteRoleByEntity" HeaderText="" HeaderStyle-Width="50px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtDeleteRoleByEntity" runat="server" CausesValidation="False" CommandName="DeleteRoleByEntity">
                                                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        &nbsp;
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:TreeListTemplateColumn>

                                <telerik:TreeListTemplateColumn UniqueName="ImgTypeByEntity" HeaderText="" HeaderStyle-Width="50px">
                                    <ItemTemplate>
                                        <div class="<%#CStr(IIf(Eval("Type") = "SYS", "SystemIcon", IIf(Eval("Type") = "PROG", "ProgramIcon", IIf(Eval("Type") = "PROJ", "ProjectIcon", IIf(Eval("Type") = "LOCPROG", "LocProgramIcon", IIf(Eval("Type") = "LOC", "PropertyIcon", ""))))))%>">
                                            <span class="Icon"></span>
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="position: relative; top: -12px;" class="<%#CStr(IIf(Eval("Type") = "SYS", "SystemIcon", IIf(Eval("Type") = "PROG", "ProgramIcon", IIf(Eval("Type") = "PROJ", "ProjectIcon", IIf(Eval("Type") = "LOCPROG", "LocProgramIcon", IIf(Eval("Type") = "LOC", "PropertyIcon", ""))))))%>">
                                            <span class="Icon"></span>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:TreeListTemplateColumn>
                                <telerik:TreeListTemplateColumn UniqueName="EntityNameByEntity" HeaderText="Entity11"
                                    HeaderStyle-Width="250px" meta:resourcekey="Entity">
                                    <ItemTemplate>
                                        <span><%# IIf(CStr(Eval("EntityName")) = String.Empty, "&nbsp;", Eval("EntityName"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEntityName" runat="server" Width="100%"></asp:TextBox>
                                        <asp:Label ID="lblUniqueRoleByEntity" runat="server" CssClass="Validator" Text="Role name must be unique.11" meta:resourcekey="lblUniqueRole"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvEntityName" runat="server" ControlToValidate="txtEntityName"
                                            CssClass="Validator" ErrorMessage="<br/>Role Name is Required" Display="Dynamic"
                                            ForeColor="" Operator="NotEqual" meta:resourcekey="rfvEntity">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </telerik:TreeListTemplateColumn>
                                <telerik:TreeListTemplateColumn UniqueName="AssignedUserByEntity" HeaderText="User11" HeaderStyle-Width="300px"
                                    meta:resourcekey="User">
                                    <ItemTemplate>
                                        <span><%# IIf(CStr(Eval("AssignedUser")) = String.Empty, "&nbsp;", Eval("AssignedUser"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlUsersByEntity" runat="server" AutoPostBack="false" Type="OutQuint"
                                            Skin="Default" Width="100%" Height="300px" NoWrap="true" CausesValidation="false"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" meta:resourcekey="ddlUsers">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvUsersByEntity" runat="server" ControlToValidate="ddlUsersByEntity"
                                            CssClass="Validator" InitialValue="" ErrorMessage="User is required" meta:resourcekey="rfvUsers"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvUsersByEntity" runat="server" ControlToValidate="ddlUsersByEntity"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" meta:resourcekey="csvUsers"
                                            CssClass="Validator" ErrorMessage="User is required">
                                        </asp:CustomValidator>
                                    </EditItemTemplate>
                                </telerik:TreeListTemplateColumn>
                                <telerik:TreeListTemplateColumn UniqueName="IsEntityLocked" HeaderText="Locked11" HeaderStyle-Width="90px"
                                    meta:resourcekey="IsLocked">
                                    <ItemTemplate>
                                        <span>
                                            <asp:Image ID="imgIsEntityLocked" runat="server" /></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkEntityLocked" runat="server" class="mobile-switch" />
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:TreeListTemplateColumn>
                            </Columns>
                        </telerik:RadTreeList>
                    </div>
                </div>
            </td>
        </tr>
    </table>






    <%--<table width="100%" cellpadding="0" border="0" cellspacing="0">
        <tr>
            <td valign="top" id="tdAssetMenu" runat="server" class="MenuWidth MobileAssetTree" style="background-color: #ffffff !important;"></td>
            <td id="tdAssetExplorerBar" runat="server" class="AssetExplorerBar MobileAssetExplorerBar">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="return ToggleAssetMenu();" />
            </td>
            <td valign="top"></td>
        </tr>
    </table>--%>
</asp:Content>
