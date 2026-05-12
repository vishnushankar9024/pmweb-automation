<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="GridsLayout.ascx.vb" Inherits="Website.GridsLayout" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<telerik:RadAjaxPanel runat="server" ID="pnlajax" LoadingPanelID="ldpPM">--%>
<telerik:RadCodeBlock runat="server">
    <style type="text/css">
        
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

        .trvFolder > .rtSp, .trvPBSFolder > .rtSp, .trvEngineering > .rtSp, .trvCostManagement > .rtSp, .trvPBSFolder > .rtSp, .trvAsset > .rtSp, .trvPortfolioModule > .rtSp,
        .trvScheduling > .rtSp, .trvWorkflow > .rtSp, .HasChildren > .rtSp, .trvtoolbox > .rtSp, .trvPlanning > .rtSp, div.trvDocument > .rtSp, .rtTop .rtSp {
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
                
 /*       .AssetExplorerVerticalSplitter {
            padding-top: 89px;
        }*/

        .removeLeft {
            left: 0 !important;
        }
/*
        @media screen and (max-width: 843px) and (min-width: 320px) {

            .GridLayoutsLeftSplitterPane {
                margin-top: 151px !important;
                position: fixed;
                width: 60vw !important;
                top: 0;
                height: calc(100vh - 121px) !important;
                z-index: 996;
                border: 1px solid #999;
            }

            .GridsLayoutSplitter {
                position: fixed;
                left: calc(60vw);
                z-index: 3000;
                height: calc(100vh - 127px) !important;
            }

            .GridLayoutsSplitterPane {
                height: calc(100vh - 127px) !important;
                width: calc(100vw - 3px) !important;
            }
        }
          
        @media screen and (min-width:844px) {

            .GridLayoutsSplitterPane, .GridsLayoutSplitter,  .GridLayoutsLeftSplitterPane {
                height: calc(100vh - 181px) !important;
            }

        }*/
        .RDSplitter, .RDLeftPane, .RDRightPane {
            height: calc(var(--Content-height) - 51px - 38px) !important;
        }
    </style>
</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy134" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLayout" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtShownColWidth" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgAssignUserGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssignUserGroups" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <%--<telerik:AjaxSetting AjaxControlID="rtvLayouts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblLayouts" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="ddlLayout"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="pnlToolBar"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblLayouts" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="ddlLayout"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="pnlToolBar"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="RadSplitter1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>--%>
        <%-- <telerik:AjaxSetting AjaxControlID="mainToolBar">
            <UpdatedControls>
                <%--<telerik:AjaxUpdatedControl ControlID="tblLayouts" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="ddlLayout"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="RadSplitter1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>--%>
    </AjaxSettings>

</telerik:RadAjaxManagerProxy>
<table style="width: 100% !important;  border-bottom: 1px solid #666666;" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
    <tr>

        <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar">
            <telerik:RadComboBox ID="ddlLayout" runat="server" AllowCustomText="true" Skin="Default" min-width="150px"
                Height="400px"
                Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" CheckForDirt="True"
                OnItemsRequested="ddl_ItemsRequested">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>
        <td class="ToolbarTd">
            <asp:Panel ID="pnlToolBar" runat="server">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True" OnClientButtonClicking="Layout_onClientButtonClicking">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Add" CssClass="ToolbarNew" EnableImageSprite="true"
                            CommandName="New" Value="Add" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ValidationGroup="Save" CssClass="ToolbarSave" EnableImageSprite="true"
                            CommandName="Save" Value="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" CssClass="ToolbarDelete" EnableImageSprite="true"
                            CommandName="Delete" Value="Delete">
                        </telerik:RadToolBarButton>
                        <%-- <telerik:RadToolBarButton ImageUrl="Images/ToolBar/DeleteDoc.png" PostBack="false" CssClass="showOnTableAndMobile"
                                CommandName="ToggleFlyoutTree" AccessKey="d" Value="ToggleFlyoutTree">
                            </telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </asp:Panel>
        </td>
        <td style="width: 100%" class="HideOnMobileToolbar"></td>
    </tr>
</table>

<telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="RDSplitter" SplitBarsSize="" >

    <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="RDLeftPane" EnableEmbeddedBaseStylesheet="False" >
        <div id="dvlayoutTree">
            <telerik:RadTreeView ID="rtvLayouts" EnableNodeTextHtmlEncoding="true" runat="server" MultipleSelect="false" Skin="Default" CssClass="TreeWithDarkBackground WhitePlusMinus"
                ShowLineImages="False" CausesValidation="False" OnClientNodeEdited="Layout_ClientNodeEdited" Style="box-sizing: border-box; padding-top: 24px; padding-left: 24px;"
                OnClientLoad="Layout_onClientLayoutTreeLoad" OnClientNodeClicking="Layout_onClientNodeClicking" OnClientNodeEditStart="Layout_OnClientNodeEditStartHandler"
                OnClientContextMenuItemClicking="Layout_onClientContextMenuItemClicking" OnClientContextMenuShowing="Layout_onContextMenuShowing">
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                        <Items>
                            <telerik:RadMenuItem Value="AddLayout" meta:Resourcekey="MenuItem_AddLayout" Text="Add Layout" EnableImageSprite="true" CssClass="MenuAdd"></telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="DuplicateLayout" meta:Resourcekey="MenuItem_DuplicateLayout" Text="Edit Layout" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="EditLayout" meta:Resourcekey="MenuItem_EditLayout" Text="Edit Layout" EnableImageSprite="true" CssClass="MenuEdit"></telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="DeleteLayout" meta:Resourcekey="MenuItem_DeleteLayout" Text="Delete Layout" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
                        </Items>
                    </telerik:RadTreeViewContextMenu>
                </ContextMenus>
                <ExpandAnimation Duration="100" />
                <CollapseAnimation Duration="100" Type="OutQuint" />
            </telerik:RadTreeView>
            <asp:HiddenField ID="hdnNodeText" runat="server" />
        </div>
    </telerik:RadPane>

    <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />

    <telerik:RadPane ID="RadContentPane" CssClass="RDRightPane" runat="server" Width="70%" Index="2" Skin="Default">
        <div class="PMMainPage">
            <div class="row row-8-4">
                <div class="col-8">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblDefineLayouts" runat="server" Text="Define Layouts1" meta:resourcekey="lblDefineLayouts"></asp:Label></legend>
                        <div class="col-4">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLayoutName" runat="server" meta:resourcekey="lblLayoutName" Text="Layout Name1" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLayoutName" runat="server" />
                                        <span id="divLayoutNameError">
                                            <asp:RequiredFieldValidator ID="rfvLayoutName" ControlToValidate="txtLayoutName"
                                                runat="server" CssClass="Validator" ErrorMessage="<%$ Resources:WarningMsg_RequiredField%>" Display="Dynamic"
                                                ValidationGroup="Save"></asp:RequiredFieldValidator>
                                            <asp:Label ID="lblError" Text="Layout name must be unique.1" meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="False"></asp:Label>
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordType" runat="server" meta:resourcekey="lblRecordType" Text="Record Type1" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRecordType" Height="400px" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"
                                            Style="font-size: 11px" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage="Select1" AutoPostBack="true"
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" meta:resourcekey="ddlRecordType"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <span id="divRecordTypeError">
                                            <asp:RequiredFieldValidator ID="rfvRecordType" ControlToValidate="ddlRecordType"
                                                runat="server" CssClass="Validator" ErrorMessage="<%$ Resources:WarningMsg_RequiredField%>" Display="Dynamic"
                                                ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblGrid" runat="server" meta:resourcekey="lblGrid" Text="Grid/Sub-grid1" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlGrid" AllowCustomText="true" runat="server" Width="100%" Skin="Default"
                                            Style="font-size: 11px" EnableItemCaching="false" EmptyMessage="Select1"
                                            NoWrap="True" meta:resourcekey="ddlGrid">
                                        </telerik:RadComboBox>
                                        <span id="divGridError">
                                            <asp:RequiredFieldValidator ID="rfvGrid" ControlToValidate="ddlGrid" Display="Dynamic"
                                                runat="server" CssClass="Validator" ErrorMessage="<%$ Resources:WarningMsg_RequiredField%>"
                                                ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <telerik:RadGrid ID="rdgLayout" runat="server" SetWidth="true" FitParentContainer="true"
                                        AutoGenerateColumns="False" ShowStatusBar="True" UseEditFormInMobile="true"
                                        Font-Size="8px" ShowGroupPanel="False" Height="500px" AllowPaging="true"
                                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" PageSize="250"
                                        AllowSorting="False" GridLines="None" Width="100%">

                                        <MasterTableView NoMasterRecordsText="<%$ Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                            Width="640px" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
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
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="74px" HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Column" UniqueName="Column">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("ColumnUniqueName").ToString%></span>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("ColumnUniqueName").ToString%>
                                                    </EditItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="219px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Width" UniqueName="Width">
                                                    <ItemTemplate>
                                                        <span style="text-align: left"><%#Container.DataItem("Width").ToString%></span>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtWidth" CssClass="PositiveInteger" Width="100%" Text='<%#Bind("Width") %>' runat="server"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                                    <HeaderStyle Wrap="false" Width="130px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="GroupBy" UniqueName="GroupBy">
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
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="130px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="SortBy" UniqueName="SortBy">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSortBy" Text='<%#CStr(IIf(Eval("SortBy") <> String.Empty, IIf(Eval("SortBy").ToString().Trim.ToUpper = "DESC", "Desc", "Asc"), "None"))%>' runat="server" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox Width="100%" Skin="Default" ID="ddlSortBy" runat="server">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="Desc" Value="Desc" />
                                                                <telerik:RadComboBoxItem Text="Asc" Value="Asc" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="130px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>


                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                        CommandName="EditRows" Visible='<%# rdgLayout.EditIndexes.Count = 0 And (Not rdgLayout.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                        CommandName="UpdateEdited" Visible='<%# rdgLayout.EditIndexes.Count > 0 %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                        CommandName="CancelAll" Visible='<%# rdgLayout.EditIndexes.Count > 0 Or rdgLayout.MasterTableView.IsItemInserted %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLoadDefaultState"
                                                        CausesValidation="False" Visible='<%# rdgLayout.EditIndexes.Count = 0 %>' CommandName="LoadDefaultState">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="Label2" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                    &nbsp;&nbsp;
                                                </div>
                                            </CommandItemTemplate>

                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder" AllowDragToGroup="False" Scrolling-ScrollHeight="500px">
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False" AllowColumnResize="True" AllowResizeToFit="true" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblOptions" runat="server" Text="Options1" meta:resourcekey="lblOptions"></asp:Label></legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFreezeColumns" runat="server" meta:resourcekey="lblFreezeColumns" Text="Freeze Columns1" />
                                </td>
                                <td style="width: 60%">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:CheckBox runat="server" ID="chkFreezeColumns" />
                                            </td>
                                            <td style="padding-left: 8px; width: 100%">
                                                <telerik:RadComboBox ID="ddlFreezeColumns" runat="server" Width="100%" Skin="Default" Height="200px"
                                                    Style="font-size: 11px" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr style="display: none;">
                                <td class="labelWidth">
                                    <asp:Label ID="lblGridWidth" runat="server" meta:resourcekey="lblGridWidth" Text="Grid Width1" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtGridWidth" runat="server" Width="99%" CssClass="PositiveInteger" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblShownColWidth" runat="server" meta:resourcekey="lblShownColWidth" Text="Shown Columns Width1" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtShownColWidth" runat="server" BackColor="#f0f0f0" Enabled="false" Style="text-align: right;" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="labelWidth">
                                    <asp:Label ID="lblFreezeHeader" runat="server" meta:resourcekey="lblFreezeHeader" Text="Freeze Header1" />
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkFreezeHeader" runat="server" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="labelWidth">
                                    <asp:Label ID="lblGridHeight" runat="server" meta:resourcekey="lblGridHeight" Text="Grid Height1" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtGridHeight" runat="server" Width="99%" CssClass="PositiveInteger" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPageSize" runat="server" meta:resourcekey="lblPageSize" Text="Freeze Columns1" />
                                </td>
                                <td class="controlWidth" align="right">
                                    <telerik:RadComboBox ID="ddlPageSize" runat="server" Width="100%" Skin="Default"
                                        Style="font-size: 11px" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblVirtualScrolling" runat="server" meta:resourcekey="lblVirtualScrolling" Text="Virtual Scrolling1" />
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkVirtualScrolling" runat="server" />
                                </td>
                            </tr>
                            <%--                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkAllowEdit" runat="server" Text="Default Report11" meta:resourcekey="chkAllowEdit" />
                                        </td> 
                                    </tr>--%>
                        </table>
                    </fieldset>
                    <fieldset style="margin-top:7px">
                        <legend>
                            <asp:Label ID="lblAssignUserGroups" runat="server" Text="Assign To User Groups1" meta:resourcekey="lblAssignUserGroups"></asp:Label></legend>
                        <div>
                            <telerik:RadGrid ID="rdgAssignUserGroups" runat="server" SetWidth="true" FitParentContainer="true"
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" UseEditFormInMobile="true"
                                PageSize="250" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                AllowSorting="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                    EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkShow" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" onClick="rdgAssignUserGroups_CheckboxCheckedChanged(this);" />
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
                                            <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="IsDefault" UniqueName="IsDefault">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")), "checked.png", "unchecked.png"))%>" alt="" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkDefault" AutoPostBack="false" Checked='<%# CBool(IIf(Eval("IsDefault") Is System.DBNull.Value, 0, Eval("IsDefault")))%>' runat="server" onClick="rdgAssignUserGroups_CheckboxCheckedChanged(this);" />
                                            </EditItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                            <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <%--                                        <telerik:GridTemplateColumn HeaderText="IsDisplayed" UniqueName="IsDisplayed">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDisplayed")), "checked.png", "unchecked.png"))%>" alt="" />  
                                        </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                            <HeaderStyle Wrap="false" Width="70px" HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn> --%>
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
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </telerik:RadPane>

</telerik:RadSplitter>


<%--    </telerik:RadAjaxPanel>--%>