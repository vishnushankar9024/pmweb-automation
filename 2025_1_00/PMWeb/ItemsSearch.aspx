<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ItemsSearch.aspx.vb" Inherits="Website.ItemsSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
            <style type="text/css">
                @media screen and (min-width:320px) and (max-width:451px) {
                    .AssemblySelector {
                        width: calc(100vw - 230px) !important;
                    }

                }
                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .documentSinglePage {
                        margin-top: 60px !important;
                    }
                }
                @media screen and  (min-width:844px) {
                    .documentSinglePage {
                        margin-top: 10px !important;
                    }
                }

    </style>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="treeGroupsAndItems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript" src="JS/Estimates/Items.js"></script>

    </telerik:RadCodeBlock>
    <telerik:RadContextMenu ID="cmAddFirstNode" runat="server" Skin="Default" OnClientItemClicking="AddFirstItemNode">
        <Targets>
            <telerik:ContextMenuElementTarget ElementID="tblMain" />
        </Targets>
        <Items>
            <telerik:RadMenuItem EnableImageSprite="true" meta:resourcekey="MenuItem_AddRootNode" PostBack="false"
                Value="AddRootNode" CssClass="MenuAdd" Text="<%$ Resources:PMWeb, AddRootNode %>" />
        </Items>
    </telerik:RadContextMenu>

    <div class="PMHeader" style="padding-left: 0;">
        <div class="row documentSinglePage">
            <div class="col-12">
                <table id="tblMain" style="width: 100%; height: 600px; vertical-align: top;" class="TableTree">
                    <tr>
                        <td valign="top">
                            <telerik:RadTreeView ID="treeGroupsAndItems" runat="server" EnableDragAndDrop="True" AllowNodeEditing="false"
                                MultipleSelect="True" OnNodeDrop="treeGroupsAndItems_NodeDrop" OnClientNodeEditStart="OnClientNodeEditStartHandler"
                                OnContextMenuItemClick="treeGroupsAndItems_ContextMenuItemClick" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                                OnClientContextMenuShowing="onClientContextMenuShowing" OnNodeEdit="treeGroupsAndItems_NodeEdit"
                                OnClientDoubleClick="onClientDoubleClick" OnNodeExpand="treeGroupsAndItems_NodeExpand" OnClientNodeEdited="ClientNodeEdited">
                                <NodeTemplate>

                                    <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                </NodeTemplate>
                                <ContextMenus>
                                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                        <Items>
                                            <telerik:RadMenuItem Value="Rename" Text="<%$ Resources:PMWeb, Rename %>" CssClass="MenuRename">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="OpenItem" Text="<%$ Resources:PMWeb, OpenItem %>" CssClass="MenuOpen">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="NewItem" Text="<%$ Resources:PMWeb, NewItem %>" CssClass="MenuAdd">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="NewGroup" Text="<%$ Resources:PMWeb, NewGroup %>" CssClass="MenuAdd">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="Delete" Text="<%$ Resources:PMWeb, Delete %>" CssClass="MenuDelete">
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadTreeViewContextMenu>
                                </ContextMenus>
                                <%--<WebServiceSettings Path="ItemsSearch.aspx" Method="GetGroupsItems" />--%>
                                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                            </telerik:RadTreeView>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
</asp:Content>
