<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ManagerLayout.ascx.vb" Inherits="Website.ManagerLayout" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script language="javascript" type="text/javascript" src="JS/Portfolio/ManagerLayout.js"></script>

</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy134" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgManagerLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgManagerLayout" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgCalculatedFields">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCalculatedFields" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgAssignUserGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssignUserGroups" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="tvLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="tbsDocumentManager">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocumentManager" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="mlpList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocumentManager" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="mainToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManagerProxy>
<style>
    .PMHead .row {
        width: 100%;
        display: table;
        table-layout: fixed;
        box-sizing: border-box;
        /*padding-right:24px;*/
    }

    .PMHead {
        width: 100%;
    }


    .trvDocument .rtSp, .NoChildren > .rtSp {
        background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
        width: 16px !important;
        height: 22px !important;
        margin-left: -3px !important;
        margin-right: -14px !important;
        background-position: -272px 0px !important;
        background-repeat: no-repeat !important;
        margin-top: 2px !important;
    }

    .trvFolder > .rtSp, .trvScheduling > .rtSp, .trvPBSFolder > .rtSp, .trvEngineering > .rtSp, .trvCostManagement > .rtSp, .trvPBSFolder > .rtSp, .trvAsset > .rtSp, .trvPortfolioModule > .rtSp,
    .trvWorkflow > .rtSp, .HasChildren > .rtSp, .trvtoolbox > .rtSp, .trvPlanning > .rtSp {
        background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
        width: 16px;
        height: 22px;
        margin-left: -3px;
        margin-right: -14px;
        background-position: -1568px 0px;
        background-repeat: no-repeat;
        margin-top: 2px;
    }

    .rtUL .rtIn {
        margin-left: 16px;
    }


    @media screen and (min-width:1146px) {
        #ctl00_CPH1_ManagerLayout1_tbsDocumentManager .rtsScroll {
            left: 0 !important;
            width: 100% !important;
            min-width: 100% !important;
        }

        .ManagerPagePaddingTopOnMobile {
            padding-top: 0 !important;
        }

        .PMHead .row .col-1 {
            max-width: 10% !important;
            flex: 0 0 10%;
            display: inline-block;
            float: left;
            box-sizing: border-box;
            width: 10%;
        }



        .PMHead .row .col-11 {
            max-width: 90% !important;
            display: inline-block;
            float: left;
            box-sizing: border-box;
            width: 90%;
        }
    }

    .AssetExplorerVerticalSplitter {
        height: calc(100vh - 210px) !important;
    }

    .ToolBar {
        top: 71px !important;
    }

    @media screen and (max-width:843px) {

        .ToolBar {
            position: fixed !important;
            z-index: 100;
            margin-top: 80px;
        }

        .flyoutTreeList {
            margin-top: -19px !important;
            position: fixed !important;
            width: 85% !important;
            left: 0;
        }
    }

    .MultiPage {
        padding-top: 50px;
    }

    @media screen and (max-width: 1146px) and (min-width: 320px) {

        .ToolBar {
            top: 112px !important;
        }

        .MultiPage {
            padding-top: 51px !important;
        }

        .PMHead .row .col-1 {
            max-width: 0 0 100% !important;
            flex: 0 0 100%;
            display: inline-block;
            float: left;
            width: 100%;
            box-sizing: border-box;
        }

        .PMHead .row .col-11 {
            flex: 0 0 100%;
            max-width: 0 0 100% !important;
            display: inline-block;
            float: left;
            width: 100%;
            margin-top: 40px;
            box-sizing: border-box;
        }

        #ctl00_CPH1_ManagerLayout1_PvOptions .PMMainPage {
            margin-top: 41px;
        }
        /*#tableEntities {
                padding-top: 34px !important;
            }*/

        /*#ctl00_CPH1_ManagerLayout1_tbsDocumentManager {
            height: 32px !important;
        }*/



        #ctl00_CPH1_ManagerLayout1_tbsDocumentManager .rtsScroll {
            width: 100% !important;
        }
    }

    @media screen and (max-width:1146px) and (min-width:844px) {
        .GridsLayoutSplitter {
            height: calc(100vh - 193px) !important;
            margin-top: 50px;
        }

        .GridLayoutsLeftSplitterPane {
            height: calc(100vh - 193px) !important;
            background-color: #666666 !important;
        }

        #dvlayoutTree {
            height: calc(100vh - 193px) !important;
        }

        .ManagerLayoutsSplitterPane {
            height: calc(100vh - 193px) !important;
        }
    }

    @media screen and (max-width: 843px) and (min-width: 320px) {
        .RadTreeView {
            max-height: 100% !important;
        }

        .ToolBar {
            margin-top: 0px !important;
            top: 82px !important;
        }

        .PMMainPage {
            margin: 0 !important;
        }


        .HideOnTabletMobile {
            display: none;
        }

        .GridLayoutsLeftSplitterPane {
            margin-top: 130px !important;
            position: fixed;
            width: 60vw !important;
            top: 0;
            height: calc(100vh - 165px) !important;
            z-index: 3000;
            border: 1px solid #999;
            background-color: #666666 !important;
        }

        .GridsLayoutSplitter {
            position: fixed;
            left: calc(60vw);
            z-index: 3000;
            height: calc(100vh - 165px) !important;
        }

        .ManagerLayoutsSplitterPane {
            height: calc(100vh - 166px) !important;
            width: calc(100vw - 4px) !important;
        }

        #dvlayoutTree {
            height: calc(100vh - 167px) !important;
        }
    }

    .removeLeft {
        left: 0 !important;
    }


    @media screen and (min-width:1147px) {

        .ManagerLayoutsSplitterPane, .GridsLayoutSplitter {
            height: calc(100vh - 150px) !important;
        }

        .GridLayoutsLeftSplitterPane {
            height: calc(100vh - 150px) !important;
            background-color: #666666 !important;
        }
    }

    .RadSplitter {
        width: 100% !important;
    }
</style>
<div class="PMHead HomePageManagerLayoutMargin" style="margin-top: 41px;">
    <div class="row">
        <div class="col-1">
            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocumentManager" ScrollChildren="true" ScrollButtonsPosition="Left"
                runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" EnableViewState="True">
                <Tabs>
                    <telerik:RadTab Value="DefineLayouts" Text="Define Layouts" meta:resourcekey="DefineLayouts" Selected="True"></telerik:RadTab>
                    <telerik:RadTab Text="Options" Value="Options" meta:resourcekey="Options"></telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
        </div>
        <div class="col-11">
            <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True">
                <telerik:RadPageView ID="pvDefineLayouts" runat="server" Selected="True" CssClass="MultiPage MultiPageForHomePage">

                    <table style="width: 100%;" cellspacing="0" cellpadding="0" border="0" class="ToolBar ManagerLayoutToolbarForHomePage">
                        <tr class="ManagerPageMarginTopOnMobile">
                            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar">
                                <telerik:RadComboBox ID="ddlLayout" runat="server" AllowCustomText="true" Skin="Default"
                                    Height="400px" EmptyMessage="-- Select --"
                                    Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" CheckForDirt="True"
                                    OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicking="OnClientButtonClicking">
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Edit" ValidationGroup="Save" ImageUrl="Images/ToolBar/Save.png"
                                            CommandName="Save" AccessKey="s" Value="Edit">
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                            CommandName="New" AccessKey="n" Value="Add" CausesValidation="false">
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                            CommandName="Delete" AccessKey="d" Value="Delete">
                                        </telerik:RadToolBarButton>
                                        <%--   <telerik:RadToolBarButton ImageUrl="Images/ToolBar/DeleteDoc.png" PostBack="false" CssClass="showOnTableAndMobile"
                                            CommandName="ToggleFlyoutTree" AccessKey="d" Value="ToggleFlyoutTree">
                                        </telerik:RadToolBarButton>--%>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td style="width: 100%"></td>
                        </tr>
                    </table>
                    <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">

                        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="GridLayoutsLeftSplitterPane" EnableEmbeddedBaseStylesheet="False" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
                            <div id="dvlayoutTree">
                                <telerik:RadTreeView ID="tvLayout" runat="server" EnableDragAndDrop="True" EnableNodeTextHtmlEncoding="true" CssClass="TreeWithDarkBackground WhitePlusMinus"
                                    OnClientLoad="onClientLayoutTreeLoad" OnClientNodeClicking="onClientNodeClicking" Style="box-sizing: border-box; padding-top: 24px; padding-left: 24px; height: inherit"
                                    CausesValidation="False" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                                    OnClientContextMenuShowing="onContextMenuShowing">
                                    <ContextMenus>
                                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                            <Items>
                                                <telerik:RadMenuItem Value="AddLayout" meta:Resourcekey="MenuItem_AddLayout" Text="Add Layout" EnableImageSprite="true" CssClass="MenuAdd"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="EditLayout" meta:Resourcekey="MenuItem_EditLayout" Text="Edit Layout" EnableImageSprite="true" CssClass="MenuEdit"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="DeleteLayout" meta:Resourcekey="MenuItem_DeleteLayout" Text="Delete Layout" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadTreeViewContextMenu>
                                    </ContextMenus>
                                </telerik:RadTreeView>
                            </div>
                        </telerik:RadPane>
                        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />
                        <telerik:RadPane ID="RadContentPane" CssClass="ManagerLayoutsSplitterPane" runat="server" Width="70%" Index="2" Skin="Default">
                            <div class="PMMainPage">
                                <div class="row row-8-4">
                                    <div class="col-8">
                                        <fieldset>
                                            <legend>
                                                <asp:Label ID="lblDefineLayouts" runat="server" Text="Define Layouts" meta:resourcekey="lblDefineLayouts"></asp:Label>
                                            </legend>
                                            <div class="col-4">
                                                <table class="colTable">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblLayoutName" runat="server" meta:resourcekey="lblLayoutName" Text="Layout Name" />
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtLayoutName" runat="server" />
                                                            <span id="divLayoutNameError">
                                                                <asp:RequiredFieldValidator ID="rfvLayoutName" ControlToValidate="txtLayoutName"
                                                                    runat="server" CssClass="Validator" Display="Dynamic"
                                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:WarningMsg_Required%>"></asp:RequiredFieldValidator>
                                                                <asp:Label ID="lblError" Text="Layout name must be unique." meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="False"></asp:Label>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblRecordType" runat="server" meta:resourcekey="lblRecordType" Text="Record Type" />
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlRecordType" Height="400px" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"
                                                                CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage="Select"
                                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                OnItemsRequested="ddl_ItemsRequested">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <telerik:RadGrid ID="rdgManagerLayout" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                                AutoGenerateColumns="False" ShowStatusBar="True" FitPageHeightOffset="24"
                                                Font-Size="8px" ShowGroupPanel="False" ClientSettings-Scrolling-AllowScroll="true"
                                                AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                                AllowSorting="False" GridLines="None" Width="100%" UseEditFormInMobile="true">

                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                                    UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                    EditMode="InPlace" EnableHeaderContextMenu="False">
                                                    <Columns>

                                                        <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chbShow" runat="server" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed"))) %>' />
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Order" Reorderable="false" SortExpression="Order" UniqueName="Order">
                                                            <ItemTemplate>
                                                                <span><%#Container.DataItem("Order").ToString%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#Eval("Order").ToString%>
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="right" />
                                                            <HeaderStyle Wrap="false" Width="74px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Column" UniqueName="Column">
                                                            <ItemTemplate>
                                                                <span><%#Container.DataItem("ColumnUniqueName").ToString%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#Eval("ColumnUniqueName").ToString%>
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                            <HeaderStyle Wrap="false" Width="160px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Width" UniqueName="Width">
                                                            <ItemTemplate>
                                                                <span style="text-align: left"><%#Container.DataItem("Width").ToString%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtWidth" CssClass="PositiveInteger" Width="100%" Text='<%#Bind("Width") %>' runat="server"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                                            <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="GroupBy" UniqueName="GroupBy">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(Eval("GroupBy") <> String.Empty, "checked.png", "unchecked.png"))%>" alt="" style="text-align: left" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chbGroupBy" runat="server" Checked='<%# CBool(IIf(Eval("GroupBy") <> String.Empty, 1, 0)) %>' />
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="SortBy" UniqueName="SortBy">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSortBy" Text='<%#CStr(IIf(Eval("SortBy") <> String.Empty, IIf(Eval("SortBy") = "[" + Eval("UniqueName") + "]$[Desc]|", "Desc", "Asc"), "None")) %>' runat="server" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox Style="left" Width="100%" Skin="Default" ID="ddlSortBy" runat="server">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Desc" Value="Desc" />
                                                                        <telerik:RadComboBoxItem Text="Asc" Value="Asc" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                            <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>

                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">
                                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                                CommandName="EditRows" Visible='<%# rdgManagerLayout.EditIndexes.Count = 0 And (Not rdgManagerLayout.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                                CommandName="UpdateEdited" Visible='<%# rdgManagerLayout.EditIndexes.Count > 0 %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                                CommandName="CancelAll" Visible='<%# rdgManagerLayout.EditIndexes.Count > 0 Or rdgManagerLayout.MasterTableView.IsItemInserted %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLoadDefaultState"
                                                                CausesValidation="False" Visible='<%# rdgManagerLayout.EditIndexes.Count = 0 %>' CommandName="LoadDefaultState">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="LabelLoadDefaultState" runat="server"></asp:Label>
                                                            </asp:LinkButton>
                                                            &nbsp;&nbsp;
                                                        </div>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder" AllowDragToGroup="False">
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False" AllowColumnResize="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </fieldset>
                                    </div>
                                    <div class="col-4">
                                        <fieldset>
                                            <legend>
                                                <asp:Label ID="lblAssignUserGroups" runat="server" Text="Assign To User Groups" meta:resourcekey="lblAssignUserGroups"></asp:Label>
                                            </legend>
                                            <telerik:RadGrid ID="rdgAssignUserGroups" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                                                PageSize="10" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                                AllowSorting="true" UseEditFormInMobile="true">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                    EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText='<%$Resources: GridColumn_Show %>' UniqueName="Show">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkShow" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="UserGroup" UniqueName="UserGroup">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("UserGroup") = String.Empty, "&nbsp;", Container.DataItem("UserGroup"))%>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#IIf(Container.DataItem("UserGroup") = String.Empty, "&nbsp;", Container.DataItem("UserGroup"))%>
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                            <HeaderStyle Wrap="false" Width="170px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="IsDefault" UniqueName="IsDefault">
                                                            <ItemTemplate>
                                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")), "checked.png", "unchecked.png"))%>" alt="" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkDefault" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDefault") Is System.DBNull.Value, 0, Eval("IsDefault")))%>' runat="server" />
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="70px" HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>

                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">

                                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                                CommandName="EditRows" Visible='<%# rdgAssignUserGroups.EditIndexes.Count = 0 And (Not rdgAssignUserGroups.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblEditSelectedGroupLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                                CommandName="UpdateEdited" Visible='<%# rdgAssignUserGroups.EditIndexes.Count > 0 %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblUpdateGroupRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                                CommandName="CancelAll" Visible='<%# rdgAssignUserGroups.EditIndexes.Count > 0 Or rdgAssignUserGroups.MasterTableView.IsItemInserted %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblCancelGroup" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                                CommandName="RebindGrid" Visible='<%# rdgAssignUserGroups.EditIndexes.Count = 0 And (Not rdgAssignUserGroups.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                        </div>
                                                    </CommandItemTemplate>

                                                    <SortExpressions>
                                                        <telerik:GridSortExpression FieldName="Group"></telerik:GridSortExpression>
                                                    </SortExpressions>
                                                    <CommandItemStyle HorizontalAlign="Left" />

                                                </MasterTableView>
                                                <ClientSettings EnableRowHoverStyle="true">
                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </telerik:RadPane>
                    </telerik:RadSplitter>
                </telerik:RadPageView>
                <telerik:RadPageView ID="PvOptions" runat="server">
                    <div class="PMMainPage">
                        <div class="row">
                            <div class="col-4 col-4-left">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblCalculatedFields" runat="server" Text="Calculated Fields" meta:resourcekey="lblCalculatedFields"></asp:Label></legend>
                                    <telerik:RadGrid ID="rdgCalculatedFields" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                        AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" FitPageHeightOffset="48"
                                        PageSize="60" AllowPaging="true" Width="100%" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                        AllowSorting="true" GridLines="None">
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" EditMode="InPlace" TableLayout="Fixed">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Record Type" HeaderStyle-Width="178px" UniqueName="RecordType">
                                                    <ItemTemplate>
                                                        <%#Eval("RecordType").ToString%>&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Calculate Calculated Fields in Manager Pages" UniqueName="CalculateCalculatedFields">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkCalculateCalculatedFields" AutoPostBack="true" OnCheckedChanged="chkCalculatedFields_OnChekedChanged" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder" AllowDragToGroup="False">
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False" AllowColumnResize="True" />
                                        </ClientSettings>
                                        <PagerStyle ShowPagerText="false" AlwaysVisible="true" />
                                    </telerik:RadGrid>
                                </fieldset>
                            </div>
                            <div class="col-4 col-4-right" style="padding-top: 5px;">
                                <asp:Label ID="lblCalculatedFieldsInfo" runat="server" Text="Some Manager Pages contain ..." meta:resourcekey="lblCalculatedFieldsInfo"></asp:Label>
                            </div>
                        </div>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
    </div>
</div>




