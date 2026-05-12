<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="AssembliesSearch.aspx.vb" Inherits="Website.AssembliesSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
     
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="treeGroupsAndAssemblies">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="treeGroupsAndAssemblies" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <style type="text/css">
                @media screen and (min-width:320px) and (max-width:451px) {
                    .AssemblySelector {
                        width: calc(100vw - 230px) !important;
                    }
                }
                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .documentSinglePage {
                        margin-top: 20px !important;
                      
                    }
                }

    </style>
        <script language="javascript" type="text/javascript" src="JS/Estimates/Assemblies.js"></script>

    </telerik:RadCodeBlock>

    <telerik:RadContextMenu ID="cmAddFirstNode" runat="server" OnClientItemClicking="AddFirstAssemblyNode">
        <Targets>
            <telerik:ContextMenuElementTarget ElementID="tblMain" />
        </Targets>
        <Items>
            <telerik:RadMenuItem EnableImageSprite="true" Text="<%$ Resources:PMWeb, AddRootNode %>" PostBack="false" Value="AddRootNode" CssClass="MenuAdd" />
        </Items>
    </telerik:RadContextMenu>

    <table class="ToolBar" cellpadding="0" cellspacing="0" style="height:50px;">
        <tr>
            <td style="width:160px;">
                <b>
                    <asp:Label ID="lblTitle" runat="server" Text="Search Assemblies" meta:resourcekey="lblTitle" Style="font-weight: normal !important"></asp:Label>
                </b>
            </td>
            <td style="width: 240px;" class="AssemblySelector">
                <telerik:RadComboBox ID="ddlAssemblies" runat="server" Filter="Contains" MarkFirstMatch="True"
                    LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    Skin="Default" Width="100%" AutoPostBack="True"
                    NoWrap="True" AllowCustomText="True" CausesValidation="False" Height="400px"
                    EnableLoadOnDemand="True" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                    OnItemsRequested="ddlAssemblies_ItemsRequested" meta:resourcekey="ddlAssemblies" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td></td>
        </tr>
    </table>

    <div class="PMHeader" style="padding-left: 0;">
        <div class="row documentSinglePage">
            <div class="col-12">
                <table class="colTable">
                    <tr>
                        <td>
                            <table id="tblMain" style="width: 100%; height: 600px; vertical-align: top;margin-top:5px;">
                                <tr>
                                    <td valign="top">
                                        <telerik:RadTreeView ID="treeGroupsAndAssemblies" runat="server" EnableDragAndDrop="True"
                                            Skin="Default" MultipleSelect="True" OnNodeDrop="treeGroupsAndAssemblies_NodeDrop" AllowNodeEditing="false"
                                            OnContextMenuItemClick="treeGroupsAndAssemblies_ContextMenuItemClick" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                                            OnClientContextMenuShowing="onClientContextMenuShowing" OnNodeEdit="treeGroupsAndAssemblies_NodeEdit"
                                            OnClientDoubleClick="onClientDoubleClick" OnNodeExpand="treeGroupsAndAssemblies_NodeExpand">
                                            <NodeTemplate>
                                                <asp:Literal ID="lblNode" Mode="Encode" runat="server" Text='<%# DataBinder.Eval(Container, "Text")%>'></asp:Literal>
                                            </NodeTemplate>

                                            <ContextMenus>
                                                <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                                    <Items>
                                                        <telerik:RadMenuItem Value="Rename" EnableImageSprite="true" Text="<%$ Resources:PMWeb, Rename %>" CssClass="MenuRename">
                                                        </telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Value="OpenAssembly" EnableImageSprite="true" Text="<%$ Resources:PMWeb, OpenAssembly %>" CssClass="MenuOpen">
                                                        </telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Value="NewAssembly" EnableImageSprite="true" Text="<%$ Resources:PMWeb, NewAssembly %>" CssClass="MenuAdd">
                                                        </telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Value="NewGroup" EnableImageSprite="true" Text="<%$ Resources:PMWeb, NewGroup %>" CssClass="MenuAdd">
                                                        </telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Value="Delete" EnableImageSprite="true" Text="<%$ Resources:PMWeb, Delete %>" CssClass="MenuDelete">
                                                        </telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadTreeViewContextMenu>
                                            </ContextMenus>
                                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                            <ExpandAnimation Duration="100"></ExpandAnimation>
                                        </telerik:RadTreeView>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <telerik:RadAjaxLoadingPanel ID="ldpAssemblies" runat="server" Skin="Default" />
</asp:Content>
