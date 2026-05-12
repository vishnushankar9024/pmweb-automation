<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagerProjects.ascx.vb" Inherits="Website.IntegrationManagerProjects" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdvEntities">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadListBox1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RadListBox1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadListBox1" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadListBox1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cm1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadListBox1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="cm1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style type="text/css">
    .btnTreeDropItems {
        display: inline-block !important;
    }
</style>
<telerik:RadContextMenu ID="cm1"
    runat="server" CssClass="trvContextMenu">
    <Items>
        <telerik:RadMenuItem Value="Delete" meta:resourcekey="MenuItem_DELETE" PostBack="true" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
    </Items>
</telerik:RadContextMenu>
<telerik:RadAjaxLoadingPanel ID="ldpUserEntities" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<div class="PMMainPage">
    <div class="row">
        <div class="col-4 col-4-left">
            <fieldset>
                <legend>
                    <asp:Label ID="lblprojects" Text="All Projects" runat="server"></asp:Label>
                </legend>
                <telerik:RadTreeView ID="rdvEntities" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" Width="100%"
                    Height="583px" OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" CheckBoxes="true" Style="border: #8e8e8e solid 1px"
                    OnClientNodeChecked="ShowHidebtnTreeDropItems">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
                <asp:LinkButton runat="server" ID="btnTreeDropItems" Enabled="false" CssClass="Hide">
                <div class="btnTreeDropItems">&nbsp;</div>
                </asp:LinkButton>
            </fieldset>
        </div>
        <div class="col-4 col-4-right col-4-TopPadding">
            <fieldset>
                <legend>
                    <asp:Label ID="lblSelectedProjects" Text="Selected Projects" meta:Resourcekey="lblSelectedProjects" runat="server"></asp:Label></legend>
                <telerik:RadListBox ID="RadListBox1" Skin="Default" runat="server" Visible="True" Height="585px" Width="100%"
                    AllowTransfer="false" AutoPostBackOnTransfer="false"
                    AllowReorder="false" OnDropped="RadListBox1_Dropped"
                    AllowDelete="false" SelectionMode="Multiple" DataKeyField="Id"
                    AutoPostBackOnReorder="false" EnableDragAndDrop="true" OnClientContextMenu="showContextMenu">
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td>
                                    <div id="dvIcon" runat="server" class="dvSmallIconContainer">
                                        <span class="rtSp"></span>
                                    </div>
                                </td>

                                <td>
                                    <asp:Label runat="server" ID="lblItem"
                                        Text='<%#Eval("ProjectName")%>'></asp:Label>

                                </td>
                            </tr>

                        </table>
                    </ItemTemplate>
                </telerik:RadListBox>
            </fieldset>
        </div>
    </div>
</div>


