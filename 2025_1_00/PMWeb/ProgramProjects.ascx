<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProgramProjects.ascx.vb" Inherits="Website.ProgramProjects" %>
<%@ Register Src="WBSTemplate.ascx" TagName="WBSTemplate" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdvLocations">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshDocumentGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshDocumentGrid" />
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" />
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
    
<style>
    .positionAbsolute {
        border: 1px solid silver;
    }


/*    @media screen and (min-width:1024px) {
        .treeSplitter td.rspPane.rspFirstItem {
            display: block !important;
            visibility: visible !important;
        }
    }



    @media screen and (min-width:320px) and (max-width:667px) {
        .positionAbsolute {
            position: absolute;
            z-index: 700;
        }
    }

    .height {  
        height: calc(100vh - 154px) !important;
    }

    .pane-overflow {
        overflow: auto !important;
    }*/

    .tree-height {
        color: #ffffff !important;
        background-color: #666666 !important;
        padding: 10px !important;
        padding-left: 5px !important;
    }
/**/

    .RadTreeView_Default .rtSelected .rtIn,
    .RadTreeView_Default .rtHover .rtIn {
        background-color: #cbdae6 !important;
    }


    .removeLeft {
        left: 0 !important;
    }

/*    @media screen and (max-width: 843px) and (min-width: 320px) {
        .tree-splitter-pane {
            margin-top: 87px;
            position: fixed;
            width: 60vw !important;
            background-color: #666666 !important;
            top: 60px;
            z-index: 996;
            border: 1px solid #999;
        }

        .mid-splitter {
            position: fixed;
            left: calc(60vw);
            z-index: 3000;
            height: calc(100vh - 125px) !important;
        }

        .height {
            height: calc(100vh - 184px) !important;
        }

        #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_ProgramProjects_RadContentPane {
            width: calc(100vw - 3px) !important;
        } 
        .RadMenu.trvContextMenu{z-index:999 !important;}
    }*/

    /*.tree-splitter-pane {
        background-color: #666666 !important;
    }*/

    /*#ctl00_CPH1_ProgramProjects_RadSplitter1 {
        width: 100% !important;
    }*/
    .RDSplitter, .RDLeftPane, .RDRightPane {
        height: calc(var(--Content-height) - 50px - 38px) !important;
    }

    .documentMultiPages {
        margin-bottom: 0;
    }
</style>
</telerik:RadCodeBlock>



<div style="width: 100%">
    <telerik:RadSplitter ID="RadSplitter1" runat="server" CssClass="RDSplitter" Orientation="vertical" Skin="Default" Width="100%" SplitBarsSize="" >
        <telerik:RadPane ID="rpPunchListDetails" Style="background: white;" runat="server" CssClass="RDLeftPane" Width="35%" Index="0" EnableEmbeddedBaseStylesheet="False"
            Skin="" >
               <table class="treePaddingOnMobile TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background:#EDEDED !important; padding-left:24px; box-sizing:border-box; width:160px !important;min-width:118px !important;">
                           <asp:Label runat="server" ID="lblWBSFrom" Text="WBS From"></asp:Label>
                        </td>
                        <td class="controlWidth" Style="background:#EDEDED !important;">
                             <telerik:RadComboBox runat="server" ID="ddlUseFrom" AutoPostBack="true" Style="width: 240px !important">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="<%$Resources:PMWeb, Portfolio %>" Value="0" />
                                                        <telerik:RadComboBoxItem Text="<%$Resources:PMWeb, WBS_Program %>" Value="2" />
                                                    </Items>
                                                </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>                    
                    <tr>
                        <td colspan="3" valign="top" style="background-color: white !important">
                            <telerik:RadTreeView ID="rdvLocations" runat="server" CssClass="tree-height WhitePlusMinus" EnableDragAndDropBetweenNodes="true" OnClientNodeClicked="OnClientNodeClicking"
                                MultipleSelect="true" OnClientContextMenuShowing="onClientContextMenuShowing" OnClientDoubleClick="OnClientDoubleClick">
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
        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="mid-splitter" CollapseMode="Forward" />
        <telerik:RadPane ID="RadContentPane" BorderWidth="0" Width="100%" runat="server" CssClass="RDRightPane" Index="2" Skin="Default" >
            <div class="PMHeader">
                <div class="row">
                    <div class="Col-12" style="width: 100%">
                        <telerik:RadGrid ID="rdgProjects" runat="server" Width="100%" allow-scroll="true" SetWidth="true" AppendMenus="true"
                            AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                            PageSize="250" AllowPaging="true" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                            AllowMultiRowEdit="false" AllowMultiRowSelection="false" AllowSorting="true" ShowGroupPanel="true">
                            <PagerStyle Mode="NextPrevAndNumeric" />

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                EditMode="InPlace">
                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="Project Number" CurrentFilterFunction="Contains" UniqueName="ProjectNumber" DataField="ProjectNumber"
                                        AutoPostBackOnFilter="true" SortExpression="ProjectNumber" DataType="System.String" FilterListOptions="VaryByDataType"
                                        GroupByExpression="ProjectNumber [GridColumn_ProjectNumber] Group By ProjectNumber ASC">
                                        <ItemTemplate>
                                            <a class="Link" href="<%#Me.GetUrlByObjectType(Library.ProjectInfo.OBJECT_TYPE_NAME,Container.DataItem("Id") ) %>"><%#Container.DataItem("ProjectNumber")  %></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="right" />
                                        <HeaderStyle Width="120px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Project Name" CurrentFilterFunction="Contains" SortExpression="ProjectName"
                                        UniqueName="ProjectName" DataField="ProjectName" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC"
                                        AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("ProjectName")%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="160px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Manager" CurrentFilterFunction="Contains" UniqueName="Manager" SortExpression="Manager"
                                        DataField="Manager" AutoPostBackOnFilter="true"
                                        GroupByExpression="Manager [GridColumn_Manager] Group By Manager ASC" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Manager") = String.Empty, "&nbsp;", Container.DataItem("Manager"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="200px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="GC" CurrentFilterFunction="Contains" UniqueName="GC"
                                        DataField="GC" SortExpression="GC"
                                        GroupByExpression="GC [GridColumn_GC] Group By GC ASC" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("GC") = String.Empty, "&nbsp;", Container.DataItem("GC"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Client" CurrentFilterFunction="Contains" UniqueName="Client"
                                        DataField="Client" SortExpression="Client"
                                        GroupByExpression="Client [GridColumn_Client] Group By Client ASC" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Client") = String.Empty, "&nbsp;", Container.DataItem("Client"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Project Status" DataField="ProjectStatus" AutoPostBackOnFilter="true" UniqueName="ProjectStatus" SortExpression="ProjectStatus"
                                        GroupByExpression="ProjectStatus [GridColumn_ProjectStatus] Group By ProjectStatus ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("ProjectStatus") = String.Empty, "&nbsp;", Container.DataItem("ProjectStatus"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Target Budget" CurrentFilterFunction="EqualTo" SortExpression="TargetBudget"
                                        UniqueName="TargetBudget" DataField="TargetBudget" GroupByExpression="TargetBudget [GridColumn_TargetBudget] Group By TargetBudget ASC"
                                        AutoPostBackOnFilter="true" DataType="System.Double" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <%#FormatCurrency(ParseDouble(Container.DataItem("TargetBudget")), CurrencyId:=CInt(Container.DataItem("CurrencyId")))%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="right" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Target Revenue" CurrentFilterFunction="EqualTo" SortExpression="TargetRevenue"
                                        UniqueName="TargetRevenue" DataField="TargetRevenue" GroupByExpression="TargetRevenue [GridColumn_TargetRevenue] Group By TargetRevenue ASC"
                                        AutoPostBackOnFilter="true" DataType="System.Double" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <%#FormatCurrency(ParseDouble(Container.DataItem("TargetRevenue")), CurrencyId:=CInt(Container.DataItem("CurrencyId")))%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="right" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Target Duration" CurrentFilterFunction="EqualTo" SortExpression="TargetDuration"
                                        UniqueName="TargetDuration" DataField="TargetDuration" GroupByExpression="TargetDuration [GridColumn_TargetDuration] Group By TargetDuration ASC"
                                        AutoPostBackOnFilter="true" DataType="System.Double" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <%#ParseDouble(Container.DataItem("TargetDuration"))%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="right" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="UOM" CurrentFilterFunction="Contains" SortExpression="UOM"
                                        UniqueName="UOM" DataField="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                                        AutoPostBackOnFilter="true" DataType="System.Double" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="right" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="City" CurrentFilterFunction="Contains" UniqueName="City"
                                        DataField="City" SortExpression="City"
                                        GroupByExpression="City [GridColumn_City] Group By City ASC" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="140px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="State" CurrentFilterFunction="Contains" UniqueName="StateKey" SortExpression="StateKey"
                                        DataField="StateKey" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType"
                                        GroupByExpression="StateKey [GridColumn_StateKey] Group By StateKey ASC">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("StateKey") = String.Empty, "&nbsp;", Container.DataItem("StateKey"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="120px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Country" CurrentFilterFunction="Contains" UniqueName="Country" SortExpression="Country"
                                        DataField="Country" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType"
                                        GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Executive" Groupable="true" DataField="Executive"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" DataType="System.String"
                                        UniqueName="Executive" SortExpression="Executive" FilterListOptions="VaryByDataType"
                                        GroupByExpression="Executive [GridColumn_Executive] Group By Executive ASC"
                                        AllowFiltering="true">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Executive") = String.Empty, "&nbsp;", Container.DataItem("Executive"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn HeaderText="Superintendents" DataField="Superintendents" AutoPostBackOnFilter="true" UniqueName="Superintendents" SortExpression="Superintendents"
                                        GroupByExpression="Superintendents [GridColumn_Superintendents] Group By Superintendents ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Superintendents") = String.Empty, "&nbsp;", Container.DataItem("Superintendents"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Project Type" DataField="ProjectType" AutoPostBackOnFilter="true" UniqueName="Type" SortExpression="ProjectType"
                                        GroupByExpression="ProjectType [GridColumn_ProjectType] Group By ProjectType ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("ProjectType") = String.Empty, "&nbsp;", Container.DataItem("ProjectType"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Project Category" DataField="ProjectCategory" AutoPostBackOnFilter="true" UniqueName="ProjectCategory" SortExpression="ProjectCategory"
                                        GroupByExpression="ProjectCategory [GridColumn_ProjectCategory] Group By ProjectCategory ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%# IIf(Container.DataItem("ProjectCategory") = String.Empty, "&nbsp;", Container.DataItem("ProjectCategory"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Location" DataField="Location" AutoPostBackOnFilter="true" UniqueName="Location" SortExpression="Location"
                                        GroupByExpression="Location [GridColumn_Location] Group By Location ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />

                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Status" DataField="DocStatusName" AutoPostBackOnFilter="true" UniqueName="DocStatusName" SortExpression="DocStatusName"
                                        GroupByExpression="DocStatusName [GridColumn_DocStatusName] Group By DocStatusName ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%# Container.DataItem("DocStatusName")%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Owner" DataField="Owner" AutoPostBackOnFilter="true" UniqueName="Owner" SortExpression="Owner"
                                        GroupByExpression="Owner [GridColumn_Owner] Group By Owner ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Owner") = String.Empty, "&nbsp;", Container.DataItem("Owner"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Commitment Company" DataField="CompanyCommitment" AutoPostBackOnFilter="true" UniqueName="CompanyCommitment" SortExpression="CompanyCommitment"
                                        GroupByExpression="CompanyCommitment [GridColumn_CompanyCommitment] Group By CompanyCommitment ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("CompanyCommitment") = String.Empty, "&nbsp;", Container.DataItem("CompanyCommitment"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Architect" DataField="Architect" AutoPostBackOnFilter="true" UniqueName="Architect" SortExpression="Architect"
                                        GroupByExpression="Architect [GridColumn_Architect] Group By Architect ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Architect") = String.Empty, "&nbsp;", Container.DataItem("Architect"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="ProjectName"></telerik:GridSortExpression>
                                </SortExpressions>
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                            SecurityButtonType="ItemMode_Edit"
                                            CommandName="EditRows" Visible='<%# rdgProjects.EditIndexes.Count = 0 And (Not rdgProjects.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                            SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow" Visible='<%# rdgProjects.EditIndexes.Count = 0 AND (Not rdgProjects.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                            Visible='<%# rdgProjects.EditIndexes.Count = 0 And (Not rdgProjects.MasterTableView.IsItemInserted) %>'
                                            SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                            <span class="Icon"></span>
                                            <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                            SecurityButtonType="ItemMode"
                                            CommandName="RebindGrid" Visible='<%# rdgProjects.EditIndexes.Count = 0 AND (Not rdgProjects.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <%--<asp:LinkButton ID="treeToggle" runat="server" CausesValidation="false" CssClass="GridCmdTreeListView ShowOnMobile"
                                        SecurityButtonType="ItemMode" OnClientClick="ToggleTree(true)" Text=""
                                        CommandName="TreeListView" Visible='<%# rdgProjects.EditIndexes.Count = 0 AND (Not rdgProjects.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>--%>
                                        <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                            CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                            EnableShadows="true" CausesValidation="false"
                                            Visible="true">
                                        </telerik:RadMenu>
                                    </div>
                                </CommandItemTemplate>

                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowDblClick="RowDblClick"
                                AllowDragToGroup="True">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                            </ClientSettings>

                            <%-- <ValidationSettings ValidationGroup="Users" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />--%>
                        </telerik:RadGrid>
                    </div>
                </div>
            </div>
        </telerik:RadPane>
    </telerik:RadSplitter>
</div>




<asp:Button runat="server" ID="btnRefreshDocumentGrid" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hdnrefreshValue" />
<asp:Button runat="server" ID="btnRefreshWBS" CssClass="Hide" />
