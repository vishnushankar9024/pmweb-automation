<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EntityUsers.ascx.vb" Inherits="Website.EntityUsers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdvUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdvEntities">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpEntityUsers" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<style>
    .TreeDivs {
        border: 1px solid gray;
        overflow: auto !important;
        height: calc(100vh - 119px);
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

    .btnTreeDropItems {
        display: inline-block !important;
    }

    .col-4.TreeDivs .UsersTree {
        max-height: 100% !important;
        max-width: 100% !important;
        width: 100% !important;
    }
</style>
<div class="PMMainPage" style="padding-top:40.81px !important">
    <div class="row">
        <div class="col-4 col-4-left">
            <telerik:RadTreeView ID="rdvUsers" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" CssClass="UsersTree"
                OnClientNodeDropping="EntityAccess_onUsersNodeDropping" OnClientNodeDragging="EntityAccess_onNodeDragging" BorderStyle="Solid" BorderWidth="1px"
                OnClientDoubleClick="EntityAccess_onUserNodeDblClicking" OnNodeDrop="rdvUsers_NodeDrop" CheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
            </telerik:RadTreeView>
            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                <div class="btnTreeDropItems">&nbsp; </div>
            </asp:LinkButton>
        </div>
        <div class="col-4 col-4-right col-4-TopPadding">
            <telerik:RadTreeView ID="rdvEntities" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" CssClass="EntitiesTree" BorderStyle="Solid" BorderWidth="1px"
                OnClientNodeDropping="onNodeDropping" OnClientContextMenuShowing="onClientContextMenuShowing" CheckBoxes="true"
                OnContextMenuItemClick="rdvEntities_ContextMenuItemClick" OnNodeDrop="rdvEntities_NodeDrop">
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
