<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="OrgChartDetails.ascx.vb" Inherits="Website.OrgChartDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxProxyManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnResourcesDropped">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnResourcesDropped" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="hdnResourcesIds" />
                <telerik:AjaxUpdatedControl ControlID="RadOrgChart1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdgResources" />
                <telerik:AjaxUpdatedControl ControlID="rptRecap" />
                <telerik:AjaxUpdatedControl ControlID="txtTotal" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshOrgChart">
            <UpdatedControls>
                <%--<telerik:AjaxUpdatedControl ControlID="btnRefreshOrgChart" LoadingPanelID="ldpPM" />--%>
                <%--<telerik:AjaxUpdatedControl ControlID="RadOrgChart1" LoadingPanelID="ldpPM" />--%>
                <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpPM" />
                <%--<telerik:AjaxUpdatedControl ControlID="RadToolBarButton"/>--%>
                <telerik:AjaxUpdatedControl ControlID="rptRecap" />
                <telerik:AjaxUpdatedControl ControlID="txtTotal" />
                <telerik:AjaxUpdatedControl ControlID="DivCreateGroup" />
                <telerik:AjaxUpdatedControl ControlID="DetailDiv" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadContextMenu1">
            <UpdatedControls>
                <%--<telerik:AjaxUpdatedControl ControlID="RadContextMenu1" LoadingPanelID="ldpPM" />--%>
                <telerik:AjaxUpdatedControl ControlID="rptRecap" />
                <telerik:AjaxUpdatedControl ControlID="txtTotal" />
                <telerik:AjaxUpdatedControl ControlID="DivCreateGroup" />
                <telerik:AjaxUpdatedControl ControlID="DetailDiv" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="DetailDiv">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadToolBarButton">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rptRecap" />
                <telerik:AjaxUpdatedControl ControlID="txtTotal" />
                <telerik:AjaxUpdatedControl ControlID="DetailDiv" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="DivCreateGroup" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadOrgChart1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadOrgChart1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rptRecap" />
                <telerik:AjaxUpdatedControl ControlID="RadSearchBox1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<%--<telerik:RadCodeBlock runat="server">
    <script type="text/javascript">
        var forceMoreMenuToClose = true;

        function MoreMenuClicked(sender, args) {

            if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                sender.close(true);
            if (args.get_item().get_value() == "DeleteGroups") {
                var mainToolBar = $find("<%= RadToolBarButton.ClientID%>");
                var button = mainToolBar.findButtonByCommandName("DeleteGroups");
                button.click();
            }
            if (args.get_item().get_value() == "DeleteResources") {
                var mainToolBar = $find("<%=RadToolBarButton.ClientID%>");
                var button = mainToolBar.findButtonByCommandName("DeleteResources");
                button.click();
            }
            //maintoolbarClick(args.get_item().get_value())
        }

        function MoreMenuOpening(sender, args) {

            if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

        }

        function MoreMenuClosing(sender, args) {

            if (forceMoreMenuToClose) {
                //forceradmenuToClose = false;
                return;
            }
            args.set_cancel(true);
        }
    </script>
</telerik:RadCodeBlock>--%>
<style type="text/css">
    /*div#ctl00_divContentHolder{
        margin-top:0px !important;
    }*/
    @media screen and (min-width:844px) {
        .ResponsiveMarginOrg {
            margin-top: 0;
        }
    }

    .ResponsiveMarginOrg {
        margin-top: 24px;
    }

    div#ctl00_CPH1_OrgChartDetails1_RadSearchBox1 {
        margin-top: 10px;
    }

    .rocItemList {
        max-height: 200px;
        overflow-y: auto;
        overflow-x: hidden;
    }

    .rocItemText {
        float: left;
        margin: 10px;
    }

    .NotEmptySub > div .rocNodeFields > div:nth-child(2) {
        float: right;
        margin-top: -10px;
        margin-bottom: 15px;
    }

    .EmptySub > div .rocNodeFields > div:nth-child(2) {
        float: right;
        margin-top: -15px;
        margin-bottom: 5px;
    }

    .rocItemWrap {
        margin: 0 !important;
        /*display:block !important;*/
    }

    .RadOrgChart_Default .rocGroup {
        display: inline-block;
        position: relative;
        padding: 4px !important;
        vertical-align: top;
        text-align: left;
    }
    /*.RadOrgChart_Web20 .rocGroup
        {
            border-radius: 10px;
            background: #f5f5f5 !important;
        }*/
    .rocItemList {
        background: white !important;
    }

    .RadOrgChart_Default .rocItem, .RadOrgChart_Default .rocItemTemplate {
        margin-left: 0 !important;
        /*height: 35px !important;*/
        border: 0px solid !important;
        padding: 0 !important;
        background: inherit;
    }

        .RadOrgChart_Default .rocItem.rocEmptyItem, .RadOrgChart_Default .rocItemTemplate.rocEmptyItem {
            height: 15px !important;
        }

    .dropClue {
        position: absolute;
        z-index: 100000;
        display: none;
        width: 5px;
        height: 5px;
        background-repeat: no-repeat;
        overflow: hidden;
        background: red;
    }

    .noDropClue {
        position: absolute;
        z-index: 100000;
        display: none;
        width: 5px;
        height: 5px;
        background-repeat: no-repeat;
        overflow: hidden;
        background: black;
    }

    .RadGrid.GridDraggedRows {
        margin-top: 2px !important;
    }
    /*.AutoHeight{
            height:auto !important;
        }*/
    /*.OrgChartPane {
            height:auto !important;
            overflow:visible !important;
        }*/

    .drawing-viewer-UnDockrdLeftPane {
        width: 10px !important;
    }

    .rspPaneTabContainer {
        margin-top: 280px;
    }

    .ResourceItemSeleted {
        background-color: #f99631;
    }

    .RadOrgChart .rocExpandArrow, .RadOrgChart .rocCollapseArrow {
        position: absolute;
        left: 50%;
        bottom: -32px !important;
        margin-left: -7px !important;
    }

    .RadOrgChart_Web20 .rocItem, .RadOrgChart_Web20 .rocItemTemplate {
        color: #000 !important;
    }

    .RadOrgChart .rocCollapsedNode .rocGroup:after, .RadOrgChart .rocCollapsedNode .rocItem:after, .RadOrgChart .rocCollapsedNode .rocItemTemplate:after {
        display: block !important;
    }

    .drawing-viewer-rdsplitter {
        position: relative;
    }

    .RadOrgChart.ImageOrgChart .rocItem.rocNoOwnImage {
        margin-left: 4em !important;
    }

    .RadOrgChart.ImageOrgChart .rocImage {
        float: left;
        position: static;
        /*height:2.8em;*/
        max-height: 72px;
    }

    .RadOrgChart.ImageOrgChart .rocItem {
        position: relative;
        display: block;
        margin: 0.5em;
        height: 3em !important;
    }

    .RadOrgChart.ImageOrgChart .rocItemText {
        max-width: 11em;
        margin: 0;
        margin-left: 1em;
    }

    .RadOrgChart .rocItemText {
        max-height: 11em;
    }
    button.rsbButton.rsbButtonSearch {
        background-color: RGB(237,237,237);
        border: none !important;
        margin-left:10px;
    }
    /*div#ctl00_ctl00_CPH1_OrgChartDetails1_rdgResourcesPanel{
        margin-top:60px;
    }*/
    div#ctl00_CPH1_OrgChartDetails1_rdgResources_GridData{
        height:425px !important;
    }
    input#ctl00_CPH1_OrgChartDetails1_RadSearchBox1_Input{
        width:240px !important;
    }
</style>
<div id="DetailDiv" class="ResponsiveMarginOrg" runat="server">

    <table class="ToolBar" style="width: 100%; position: static !important" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" style="vertical-align: middle; width: 100px;" class="ToolbarTd">
                <telerik:RadToolBar ID="RadToolBarButton" runat="server" AutoPostBack="true" OnClientButtonClicked="OpenAddGroupPopup">
                    <Items>
                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarNew" CommandName="AddGroup" PostBack="false"
                            CausesValidation="false" meta:resourcekey="RadToolBarButton_AddGroup" Visible="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton CommandName="DeleteGroups" EnableImageSprite="true" CssClass="ToolbarDelete" ToolTip="Delete All Groups"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarClear" CausesValidation="false" CommandName="DeleteResources" ToolTip="Clear All Resources"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Delete Groups" Value="DeleteGroups" CssClass="Delete" EnableImageSprite="true"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Delete Resources" Value="DeleteResources" CssClass="Clear" EnableImageSprite="true"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td valign="middle" style="vertical-align: middle; float: left; min-width: 200px; width:286px;" class="ToolbarTd">
                <telerik:RadSearchBox ID="RadSearchBox1" RenderMode="Lightweight" runat="server" DataTextField="Name" Width="286px" DataValueField="HierarchicalIndex" OnClientSearch="onOrgChartClientSearch"></telerik:RadSearchBox>
            </td>
        </tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="600px" Width="100%" CssClass="drawing-viewer-rdsplitter DocumentSplitterOrgChart" BackColor="White" EnableImageSprites="true">
                    <telerik:RadPane ID="LeftPane" runat="server" Width="10px" Scrolling="none">
                        <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true">
                            <telerik:RadSlidingPane ID="RadSlidingPane1" Width="300px" Style="position: relative; left: 4px; top: 37px;" Title="Pane1" runat="server" OnClientBeforeExpand="OnOrgChartClientBeforeExpand" OnClientCollapsed="OnOrgChartClientCollapsed"
                                MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true" OnClientDocked="UpdatePanelSettings" OnClientResized="UpdatePanelSettings" OnClientUndocked="UpdatePanelSettings">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rdgResources" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                ShowFooter="false" AllowPaging="false" ShowGroupPanel="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" Width="580px"
                                                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true" FilterType="HeaderContext">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                    EditMode="InPlace" EnableHeaderContextMenu="true">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Resource" UniqueName="Resource" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="Resource" GroupByExpression="Resource [GridColumn_Resource] Group By Resource ASC"
                                                            Groupable="true" Reorderable="true" DataField="Resource">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Resource").ToString = String.Empty, "&nbsp;", Container.DataItem("Resource"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Title" UniqueName="Title" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="Title" GroupByExpression="Title [GridColumn_Title] Group By Title ASC"
                                                            Groupable="true" Reorderable="true" DataField="Title">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Resource Group(s)" UniqueName="ResourceGroups" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="ResourceGroups" GroupByExpression="ResourceGroups [GridColumn_ResourceGroups] Group By ResourceGroups ASC"
                                                            Groupable="true" Reorderable="true" DataField="ResourceGroups">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("ResourceGroups").ToString = String.Empty, "&nbsp;", Container.DataItem("ResourceGroups"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Classification" UniqueName="Classification" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="Classification" GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC"
                                                            Groupable="true" Reorderable="true" DataField="Classification">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Classification").ToString = String.Empty, "&nbsp;", Container.DataItem("Classification"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="company" UniqueName="company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="company" GroupByExpression="company [GridColumn_company] Group By company ASC"
                                                            Groupable="true" Reorderable="true" DataField="company">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("company").ToString = String.Empty, "&nbsp;", Container.DataItem("company"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Region" UniqueName="Region" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="Region" GroupByExpression="Region [GridColumn_Region] Group By Region ASC"
                                                            Groupable="true" Reorderable="true" DataField="Region">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Region").ToString = String.Empty, "&nbsp;", Container.DataItem("Region"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="EmploymentStatus" UniqueName="EmploymentStatus" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="EmploymentStatus" GroupByExpression="EmploymentStatus [GridColumn_EmploymentStatus] Group By EmploymentStatus ASC"
                                                            Groupable="true" Reorderable="true" DataField="EmploymentStatus">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("EmploymentStatus").ToString = String.Empty, "&nbsp;", Container.DataItem("EmploymentStatus"))%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                            SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC"
                                                            Groupable="true" Reorderable="true" DataField="Type">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Type").ToString = "LAB", "Labor", "Equipment")%> </span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <ItemStyle Wrap="false" />
                                                    <HeaderStyle Wrap="false" HorizontalAlign="right" />
                                                    <CommandItemTemplate>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode"
                                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible="true">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
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
                                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                                        AllowColumnResize="True" />
                                                    <Selecting AllowRowSelect="true" />
                                                    <ClientEvents OnRowDropping="OnResourceRowDropping" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadSlidingPane>
                        </telerik:RadSlidingZone>
                    </telerik:RadPane>
                    <telerik:RadPane ID="OrgChartPane" runat="server" Width="70%" CssClass="OrgChartPane">
                        <div class="foo">
                            <telerik:RadOrgChart ID="RadOrgChart1" runat="server" RenderMode="Lightweight" Height="585px" EnableDrillDown="true" EnableDragAndDrop="true" Skin="Default" DisableDefaultImage="true" EnableCollapsing="true" GroupColumnCount="1">
                                <RenderedFields>
                                    <NodeFields>
                                        <telerik:OrgChartRenderedField DataField="Title" />
                                        <telerik:OrgChartRenderedField DataField="ResourceCount" />
                                        <telerik:OrgChartRenderedField DataField="SubTitle" />
                                    </NodeFields>
                                    <ItemFields>
                                    </ItemFields>
                                </RenderedFields>
                            </telerik:RadOrgChart>
                        </div>
                    </telerik:RadPane>
                </telerik:RadSplitter>
                <telerik:RadContextMenu runat="server" ID="RadContextMenu1" CssClass="CustomContextMenu" OnClientItemClicking="RadContextMenu_ClientItemClicking">
                    <Items>
                        <telerik:RadMenuItem Text="Add Group" CssClass="MenuAdd" EnableImageSprite="true" Value="AddGroup" />
                        <telerik:RadMenuItem Text="Edit Group" CssClass="MenuEdit" EnableImageSprite="true" Value="EditGroup" />
                        <telerik:RadMenuItem Text="Delete Group" CssClass="OrgMenuDelete" EnableImageSprite="true" Value="DeleteGroup" />
                        <telerik:RadMenuItem Text="Add Resource" CssClass="MenuAdd" EnableImageSprite="true" Value="AddResource" />
                        <telerik:RadMenuItem Text="Edit Resource" CssClass="MenuEdit" EnableImageSprite="true" Value="EditResource" />
                        <telerik:RadMenuItem Text="Select ALL" CssClass="MenuSelected" EnableImageSprite="true" Value="SelectAllResources" />
                        <telerik:RadMenuItem Text="Delete Selected Resource(s)" EnableImageSprite="true" CssClass="OrgMenuDelete" Value="DeleteSelectedResources" />
                    </Items>
                </telerik:RadContextMenu>
            </td>
        </tr>
    </table>
</div>
<div class="PMHeader">
    <div class="row">
        <div class="col-2 ResponsiveMargin"></div>
        <div class="col-8">
            <table class="colTable">
                <tr>
                    <td style="text-align: center;">
                        <div id="DivCreateGroup" runat="server" style="text-align: center; color: #fff; background-color: #71b641; font-size: 36px; cursor: pointer;" onclick="OpenAddFirstGroupPopup()">
                            <asp:Label ID="lblCreateGroup" runat="server" Text="Click to Create a Group1" meta:resourcekey="lblCreateGroup"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-2"></div>
    </div>
</div>
<asp:HiddenField runat="server" ID="hdnResourcesIds" Value="0"></asp:HiddenField>
<asp:Button runat="server" ID="btnResourcesDropped" CssClass="Hide" />
<asp:Button runat="server" ID="btnRefreshOrgChart" CssClass="Hide" />