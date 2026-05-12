<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetExplorer.ascx.vb" Inherits="Website.AssetExplorer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<style type="text/css">
    .Disabled {
        color: #8d8da1;
    }
    .AssetExplorerTree {
    width:calc(100% - 15px);
    overflow:auto;
    }
    .paddingTop{padding-top:50px !important}
     .removeLeft {
        left:0 !important
        }
     div#flyoutBackdrop {
        z-index: 3000 !important;
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AssetTreeToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvAssetExplorer" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="AssetTreeToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="cmRefresh">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvAssetExplorer" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdvAssetExplorer">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvAssetExplorer" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadContextMenu ID="cmRefresh" runat="server">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="dvTree" />
    </Targets>
    <Items>
        <telerik:RadMenuItem Text="Refresh" EnableImageSprite="true" meta:resourcekey="MenuItem_Refresh" PostBack="true" Value="Refresh" CssClass="MenuRefresh" />
    </Items>
</telerik:RadContextMenu>
<div style="width:100%;position:relative" id="dvTree">
                <div id="ConfigureAssetTreeDiv" style="position:relative;width:100%">   
                     <table style="width: 100%;background-color: RGB(237,237,237);background-image:none;" cellpadding="0" cellspacing="0" >
                        <tr>
                            <td class="ToolbarTd">
                                <asp:LinkButton runat="server" ID="btnAssetTree" OnClientClick="javascript:return ShowAssetTreeToolbar()">
                                <div class="btnAssetTree">
                                    &nbsp; 
                                </div>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                 </div>
                 <div id="AssetTreeToolBarDiv" style="background-color:#fff;width:100%;position:absolute;top:0;z-index:3001" class="Hide" >   
                     <table style="width: 100%;background-color: RGB(237,237,237);background-image:none;" cellpadding="0" cellspacing="0" >
                        <tr>
                            <td class="ToolbarTd" style="border-bottom:0.5px solid gray">
                               <telerik:RadToolBar ID="AssetTreeToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="AssetTreeClick_handler">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Close" PostBack="false"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                     <table style="width:100%;padding:24px" cellPadding="0" cellSpacing ="0">
                         <tr>
                             <td>
                                  <asp:Label ID="lblGroupBy" runat="server" meta:Resourcekey="lblGroupBy"  Text="Group By"></asp:Label>
                             </td>
                              <td>
                                    <telerik:RadComboBox ID="ddlAssetExplorerGroup"  Width="100%" runat="server"></telerik:RadComboBox>
                              </td>
                         </tr>
                         <tr>
                              <td style="padding-top:10px">
                                    <asp:Label ID="lblInactive" runat="server" meta:Resourcekey="chkInactive"  Text="Show Inactive Locations"></asp:Label>
                                </td>
                                <td style="padding-top:10px;text-align:right">
                                    <asp:CheckBox ID="chkInactive" runat="server" class="mobile-switch" />
                                </td>
                         </tr>
                     </table>
                 </div>
                <telerik:RadTreeView ID="rdvAssetExplorer" runat="server" EnableDragAndDrop="True" CssClass="AssetExplorerTree WhitePlusMinus"
                        OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientNodeEditStart="OnClientNodeEditStartHandler"
                        MultipleSelect="true" OnClientContextMenuShowing="onClientContextMenuShowing"
                        OnClientDoubleClick="onClientDoubleClick" OnClientNodeExpanding="ClientNodeExpanding">
                        <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                        <ExpandAnimation Duration="100"></ExpandAnimation>
                        <NodeTemplate>
                            <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                        </NodeTemplate>
                        <ContextMenus>
                            <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                <Items>
                                    <telerik:RadMenuItem Value="Rename" EnableImageSprite="true" meta:Resourcekey="MenuItem_Rename" Text="Rename" CssClass="MenuRename">
                                    </telerik:RadMenuItem>
                                    <telerik:RadMenuItem Value="OpenItem" EnableImageSprite="true" Text="Open" meta:Resourcekey="MenuItem_OpenItem" CssClass="MenuOpen">
                                    </telerik:RadMenuItem>
                                    <telerik:RadMenuItem Value="Add" EnableImageSprite="true" Text="Add" meta:Resourcekey="MenuItem_Add" CssClass="MenuAdd">
                                        <Items>
                                            <telerik:RadMenuItem Value="AddProperty" EnableImageSprite="true" meta:Resourcekey="MenuItem_AddProperty" Text="Location" CssClass="MenuAddProperty">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AddBuilding" EnableImageSprite="true" meta:Resourcekey="MenuItem_AddBuilding" Text="Building" CssClass="MenuAddBuilding">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AddFloor" EnableImageSprite="true" meta:Resourcekey="MenuItem_AddFloor" Text="Floor" CssClass="MenuAddFloor">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AddSpace" EnableImageSprite="true" meta:Resourcekey="MenuItem_AddSpace" Text="Space" CssClass="MenuAddSpace">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AddEquipment" EnableImageSprite="true" meta:Resourcekey="MenuItem_AddEquipment" Text="Equipment" CssClass="MenuAddEquipment">
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                    <telerik:RadMenuItem Value="Delete" EnableImageSprite="true" meta:Resourcekey="MenuItem_Delete" Text="Delete" CssClass="MenuDelete">
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadTreeViewContextMenu>
                        </ContextMenus>
                    </telerik:RadTreeView>

</div>

