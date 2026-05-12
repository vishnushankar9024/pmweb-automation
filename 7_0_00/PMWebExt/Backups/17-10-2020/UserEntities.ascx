<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UserEntities.ascx.vb" Inherits="Website.UserEntities" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link href="CSS/MainCss.css" rel="stylesheet" />
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdvEntities">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdvUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    .TreeDivs {
        border: 1px solid gray;
        overflow: auto !important;
        height: calc(100vh - 119px);
    }

    .btnTreeDropItems {
        display: inline-block !important;
    }

    @media screen and (min-width: 844px) {
        .MarginLeft {
            margin-left: 24px;
            padding-left: 0;
        }

        .MarginTop1 {
            margin-top: 24px;
        }
    }
</style>

<telerik:RadAjaxLoadingPanel ID="ldpUserEntities" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<div class="PMMainPage " style="padding-top:40.81px !important">
    <div class="row">
        <div class="col-4 col-4-left">
            <telerik:RadTreeView ID="rdvEntities" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" 
                BorderStyle="Solid" BorderWidth="1px" CssClass="EntitiesTree" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                OnClientDoubleClick="UserAccess_onEntityNodeDblClicking" OnClientNodeDropping="UserAccess_onEntitiesNodeDropping" CheckBoxes="true"
                OnClientNodeDragging="UserAccess_onNodeDragging" OnNodeDrop="rdvEntities_NodeDrop">
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
            </telerik:RadTreeView>
            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                <div class="btnTreeDropItems">&nbsp;</div>
            </asp:LinkButton>
        </div>
        <div class="col-4 col-4-right col-4-TopPadding">
            <telerik:RadTreeView ID="rdvUsers" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" BorderStyle="Solid" BorderWidth="1px" CssClass="UsersTree"
                OnClientNodeDropping="onNodeDropping" OnNodeDrop="rdvUsers_NodeDrop" CheckBoxes="true"
                OnContextMenuItemClick="rdvUsers_ContextMenuItemClick" OnClientContextMenuShowing="onClientContextMenuShowing">
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                        <Items>
                            <telerik:RadMenuItem Value="Delete" Text="Delete ..." meta:ResourceKey="ContextMenu_Delete" EnableImageSprite="true" CssClass="MenuDelete">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadTreeViewContextMenu>
                </ContextMenus>
            </telerik:RadTreeView>
        </div>
    </div>
</div>
