<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WBS.ascx.vb" Inherits="Website.WBS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="WBSTemplate.ascx" TagName="WBSTemplate" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdvLocations">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnRefreshDocumentGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocs" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshDocumentGrid" />
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgDocs">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocs" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnRefreshWBS">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshWBS" />

            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        function ToggleAssetMenu() {
            var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
            var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
            var form = $('form')[0]
            var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
            if (tdAssetMenu.style.display == 'none') {
                tdAssetMenu.style.display = '';
                tdAssetExplorerBar.style.left = "285px";
                tdAssetExplorerBar.className = 'AssetExplorerBar MobileFormsExplorerBar1'
                btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
            } else {
                tdAssetMenu.style.display = 'none';
                tdAssetExplorerBar.style.left = "0px";
                tdAssetExplorerBar.className = 'AssetExplorerBar MobileAssetExplorerBarClosed'
                btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
            }
            return false;
        }
    </script>
<style>
    .rdvLocations {
            height: 100% !important;
        }
    @media screen and (max-width: 843px) and (min-width: 320px) {
        .MobileFormsExplorerBar1 {
            position: fixed;
            z-index: 9999;
            left: 307px !important;
            height: calc(100vh) !important;
        }

      
        .MobileFormsTree {
            height: calc(100vh - 138px);
        }

        .MobileFormsExplorerBar1 {
            height: calc(100vh - 124px) !important;
        }
    }
    .AssetExplorerVerticalSplitter{height:calc(100vh - 154px);   }
    div#dvTree {
        height: calc(100vh - 200px) !important;
        overflow-y: auto;
    }

    .RadTreeView {
        max-height: 100%;
    }
    #ctl00_CPH1_WBS1_RadSplitter1{
        width:100% !important;
    }
        .GridLayoutsLeftSplitterPane {
            height: calc(100vh - 152px) !important;
            background-color: white;
        }
        .GridLayoutsSplitterPane {
            height: calc(100vh - 156px) !important;
            background-color: white;
        }



    @media screen and (max-width:843px) {
          .RadMenu.trvContextMenu{z-index:999 !important;}
        .GridLayoutsLeftSplitterPane {
            position: fixed;
            width: 60vw !important;
            top: 0;
            height: calc(100vh - 126px) !important;
            z-index: 3000;
            border: 1px solid #999;            
            background-color: white;
            top:87px;
        }

        .GridsLayoutSplitter {
            position: fixed;
            left: calc(60vw);
            z-index: 3000;
            height: calc(100vh - 126px) !important;
        }

        .GridLayoutsSplitterPane {
            width: calc(100vw - 3px) !important;
            height: calc(100vh - 126px) !important;
        }
    }

    .removeLeft {
        left: 0 !important;
    }
</style>
</telerik:RadCodeBlock>

<telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
    <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="GridLayoutsLeftSplitterPane" EnableEmbeddedBaseStylesheet="False" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
         <table class="treePaddingOnMobile TableNoSpacingNoBorder" style="width:100%">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background:#EDEDED !important; padding-left:24px; width:160px !important;">
                           <asp:Label runat="server" ID="lblWBSFrom" Text="WBS From"></asp:Label>&nbsp;&nbsp;
                        </td>
                        <td class="controlWidth" Style="background:#EDEDED !important;width:240px !important">
                            <telerik:RadComboBox runat="server" ID="ddlUseFrom" AutoPostBack="true" Width="240px">
                        <Items>
                            <telerik:RadComboBoxItem Text="<%$Resources:PMWeb, Portfolio %>" Value="0"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem Text="<%$Resources:PMWeb, WBS_Program %>" Value="1"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem Text="<%$Resources:PMWeb, WBS_Project %>" Value="2"></telerik:RadComboBoxItem>
                        </Items>
                    </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>                    
                    <tr>
                        <td colspan="3" valign="top" style="background-color: white !important">
                            <telerik:RadTreeView ID="rdvLocations" runat="server" EnableDragAndDropBetweenNodes="true" Width="100%" OnClientNodeClicked="OnClientNodeClicking"
                            MultipleSelect="true" OnClientContextMenuShowing="onClientContextMenuShowing" OnClientDoubleClick="OnClientDoubleClick" CssClass="rdvLocations">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <ContextMenus>
                                <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" CssClass="trvContextMenu">
                                    <Items>
                                        <telerik:RadMenuItem Value="AddChild" meta:resourcekey="MenuItem_AddChild" Text="Add WBS" EnableImageSprite="true" CssClass="MenuAdd">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="DELETE" meta:resourcekey="MenuItem_DELETE" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="Rename" meta:resourcekey="MenuItem_Rename" Text="Rename" EnableImageSprite="true" CssClass="MenuRename">
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadTreeViewContextMenu>
                            </ContextMenus>
                            <NodeTemplate>
                                <uc1:WBSTemplate ID="WBSTemplate1" runat="server" />
                            </NodeTemplate>
                        </telerik:RadTreeView>
                        </td>
                    </tr>
                </table>
    </telerik:RadPane>
    <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />
    <telerik:RadPane ID="RadPane1" CssClass="GridLayoutsSplitterPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="ClientResized">
        <div class="PMHeader">
            <div class="row">
                <div class="col-12 ResponsiveMargin">
                    <telerik:RadGrid ID="rdgDocs" runat="server" CssClass="WithoutTopBorder"
                        AutoGenerateColumns="False" ShowStatusBar="False" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        Font-Size="8px" PageSize="20" ShowFooter="false" AllowPaging="True" ShowGroupPanel="True"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                            EditMode="InPlace" EnableHeaderContextMenu="true">

                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Record Type" DataField="RecordType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="RecordType" SortExpression="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="WBS" DataField="WBS" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="WBS" SortExpression="WBS" GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("WBS") = String.Empty, "&nbsp;", Container.DataItem("WBS"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="Record_Number" DataField="RecordNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_Record_Number] Group By RecordNumber ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliCode" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%>'
                                            NavigateUrl='<%#CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Workflow Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                                    UniqueName="Status" SortExpression="Status" DataField="Status" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                    UniqueName="Description" SortExpression="Description" DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC" DataField="Company"
                                    UniqueName="Company" SortExpression="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="Value" GroupByExpression="Value [GridColumn_Value] Group By Value ASC" DataField="Value">
                                    <ItemTemplate>
                                        <asp:Label ID="lblValue" runat="server"></asp:Label>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Item" GroupByExpression="Item [GridColumn_Item] Group By Item ASC" DataField="Item"
                                    UniqueName="Item" SortExpression="Item" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cost Code" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode"
                                    UniqueName="CostCode" SortExpression="CostCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Item Value" UniqueName="ItemValue" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="ItemValue" GroupByExpression="ItemValue [GridColumn_ItemValue] Group By ItemValue ASC" DataField="ItemValue">
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemValue" runat="server"></asp:Label>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <ItemStyle Wrap="false" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <telerik:RadComboBox ID="ddlLevels" EmptyMessage="WBS Levels..." meta:resourcekey="ddlLevels" Height="200px" runat="server" AllowCustomText="True" Width="150px">
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <asp:CheckBox runat="server" ID="chkprApply" />
                                                <asp:Label runat="server" ID="Label1" AssociatedControlID="chkprApply"></asp:Label>
                                                <%#Eval("Level")%>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                        SecurityButtonType="ItemMode" CommandName="RebindGrid">
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>
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
                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </telerik:RadPane>
</telerik:RadSplitter>

<asp:Button runat="server" ID="btnRefreshDocumentGrid" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hdnrefreshValue" />
<asp:Button runat="server" ID="btnRefreshWBS" CssClass="Hide" />

