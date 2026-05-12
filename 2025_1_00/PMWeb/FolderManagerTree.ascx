<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FolderManagerTree.ascx.vb" Inherits="Website.FolderManagerTree" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnUploadFileTree">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="inputFileCurrentWorkingFolderTree" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="trvFolders" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript" src="JS/FileManager/FolderManagerTree.js?version=<%= PM.Security.LicenseInfo.PMWebVersion %>"></script>
    <link href="CSS/FolderManagerTree.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
</telerik:RadCodeBlock>

<div id="mainContentTree">
                <div id="TreeToolbar" style="position: relative; width: 100%" runat="server">
                    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="DocumentManagerToolbar">
                        <tr valign="top">
                            <td valign="middle" class="ToolbarTd" style="display: inline-flex; padding-left: 0px;">
                                <asp:Panel runat="server" ID="pnlConfigureTree">
                                    <asp:LinkButton runat="server" ID="btnConfigureFolders" CssClass="configureTree" OnClientClick="applyMask()" ToolTip="Folder Tree Pane Settings">
                                        <span class="Icon" id="spanConfigureFolders" runat="server"></span>&nbsp
                                                    <asp:Label ID="lblConfigureFolders" runat="server" Visible="false" CssClass="lblConfigureFolders">Configure Tree</asp:Label>
                                    </asp:LinkButton>
                                </asp:Panel>
                                <asp:Button ID="btnGetProjects" CssClass="Hide" runat="server" Text="Go" />
                                <asp:LinkButton runat="server" ID="btnSave" CssClass="btnSave" Visible="false" ToolTip="Save">
                                    <span class="Icon" id="span2" runat="server"></span>&nbsp
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" ID="btnSaveExit" CssClass="btnSaveExit" OnClientClick="removeMask()" Visible="false" ToolTip="Save & Exit">
                                    <span class="Icon" id="span3" runat="server"></span>&nbsp
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" ID="btnCancel" CssClass="btncancel" OnClientClick="removeMask()" Visible="false" ToolTip="Cancel">
                                    <span class="Icon" id="span1" runat="server"></span>&nbsp
                                </asp:LinkButton>
                            </td>

                        </tr>
                    </table>
                </div>
<telerik:RadTreeView ID="trvFolders" runat="server" EnableDragAndDropBetweenNodes="true" OnClientNodeEditStart="OnClientNodeEditStartHandler"
    EnableDragAndDrop="true" MultipleSelect="false" OnClientMouseOver="trvFolders_OnClientMouseOverHandler" OnClientNodeClicked="trvFolders_ClientNodeClicked"
    OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onClientContextMenuShowing"
    OnContextMenuItemClick="trvFolders_ContextMenuItemClick" CssClass="DocumentManagerTree TreeWithDarkBackground WhitePlusMinus"
    OnNodeEdit="trvFolders_NodeEdit" Skin="Default" Width="100%">
    <ContextMenus>
        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default"
            Width="100%" CssClass="trvContextMenu">
            <Items>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_NewFolder"
                    Text="New Folder" Value="NewFolder" EnableImageSprite="false" CssClass="MenuAdd">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Open" meta:ResourceKey="ContextMenu_Open"
                    Value="Open" EnableImageSprite="false" CssClass="MenuOpen" PostBack="false">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_EditFolder"
                    Text="" Value="EditFolder" EnableImageSprite="false" CssClass="MenuEdit">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem PostBack="false" Text="Rename"
                    meta:ResourceKey="ContextMenu_Rename" Value="Rename" EnableImageSprite="false" CssClass="MenuRename">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_Subscribe"
                    Text="Attributes" Value="Subscribe" PostBack="false" EnableImageSprite="false" CssClass="MenuSubscribe">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Unsubscribe11" Value="unsubscribe" meta:ResourceKey="ContextMenu_Unsubscribe" EnableImageSprite="false" CssClass="MenuUnsubscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Copy Folder URL1" Value="CopyFolderUrl" meta:ResourceKey="ContextMenu_CopyFolderUrl"
                    EnableImageSprite="false" CssClass="MenuUrl">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>

                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_UploadFile"
                    Text="Upload File" Value="UploadFile" EnableImageSprite="false" CssClass="MenuUpload">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_PasteFiles" Text="Paste" Value="PasteFiles" EnableImageSprite="false" CssClass="MenuPaste"></telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_CopyFolder"
                    Text="Copy" Value="Copy" EnableImageSprite="false" CssClass="MenuCopy">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_PasteFolder"
                    Text="Paste" Value="Paste" EnableImageSprite="false" CssClass="MenuPaste">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_DeleteFolder"
                    Text="Delete" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadTreeViewContextMenu>
    </ContextMenus>
    <CollapseAnimation Duration="100" Type="OutQuint"></CollapseAnimation>
    <ExpandAnimation Duration="100"></ExpandAnimation>
</telerik:RadTreeView>
<telerik:RadTreeView ID="trvConfigureFolders" runat="server" EnableDragAndDropBetweenNodes="true" EnableNodeTextHtmlEncoding="true"
    EnableDragAndDrop="false" MultipleSelect="false" CheckBoxes="true" Width="100%" Skin="Default" TriStateCheckBoxes="true" OnClientNodePopulated="CheckNode">
</telerik:RadTreeView>
<asp:Button runat="server" ID="btnRefreshSubscriptionTree" CssClass="Hide" />
<asp:HiddenField ID="hdnCopiedFolderId" runat="server" />
<asp:HiddenField ID="hdnAllowVersioning" Value="false" runat="server" />
<asp:HiddenField ID="hdnCopiedFileIds" runat="server" />
<asp:HiddenField ID="hdnTreeFolderId" runat="server" />
<asp:Button ID="btnUploadFileTree" runat="server" class="btnUploadFileTree Hide" />
<%--<asp:Button ID="btnEditFolderTree" runat="server" class="Hide" />--%>
<%--<asp:FileUpload ID="inputFileCurrentWorkingFolderTree" CssClass="Hide" onchange="uploadFileCurrentWorkingFolderTree(event)" EnableViewState="true" runat="server" AllowMultiple="true" />--%>
    <telerik:radasyncupload runat="server" width="100%" cssclass="ProjectCenterUpload FolderManagerUpload Hide" id="inputFileCurrentWorkingFolderTree" skin="Default" Style="height: 0 !important; border: 0 !important;"
        multiplefileselection="Automatic" onclientfileuploaded="onClientFileUploaded" onclientfileselected="onDocFileSelected" onclientfileuploadfailed="onDocFileUploadFailed" onclientvalidationfailed="ClientDocFileValidationFailed"
        hidefileinput="true" OnClientFileUploadRemoved="onDocFileUploadFailed">
    </telerik:radasyncupload>
    </div>
