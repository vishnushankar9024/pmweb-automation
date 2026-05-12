<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardCardView.ascx.vb" Inherits="Website.ActivityBoardCardView" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


    <telerik:RadContextMenu ID="RadContextMenu1" runat="server" OnClientItemClicked="FireColumnCommand" CssClass="ABMenu">
    <Items>
        <telerik:RadMenuItem Text="Rename Column" Value="Edit" meta:resourcekey="MenuItem_RenameColumn"></telerik:RadMenuItem>
        <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Delete Column" Value="Delete" meta:resourcekey="MenuItem_DeleteColumn"></telerik:RadMenuItem>
    </Items>
    </telerik:RadContextMenu>

    <telerik:RadContextMenu ID="RadContextMenu2" runat="server" OnClientItemClicked="FireTaskCommand" OnClientShowing="OnTaskContextMenuShowing" CssClass="ABMenu">
    <Items>
        <telerik:RadMenuItem Text="Mark Done" Value="MarkDone" meta:resourcekey="MenuItem_MarkDone" ></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Copy Task" Value="CopyTask" meta:resourcekey="MenuItem_CopyTask"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Move Task" Value="MoveTask" meta:resourcekey="MenuItem_MoveTask"></telerik:RadMenuItem>
        <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Delete Task" Value="DeleteTask" meta:resourcekey="MenuItem_DeleteTask"></telerik:RadMenuItem>
    </Items>
    </telerik:RadContextMenu>

<div class="Js-DropZone" id="dropZone" runat="server">
    <div id="MainBoard" runat="server" style="padding-left: 16px;padding-top:16px;padding-bottom:36px;white-space: nowrap;display: flex;background-color:inherit;min-height: 100%;min-width: 100%;box-sizing: border-box;">
    </div>
</div>

    <asp:FileUpload ID="FileToUpload" runat="server" Width="180px" CssClass="Hide inputFile" />
    <asp:Button ID="btnUploadFile" runat="server" CssClass="Hide btnUpload"></asp:Button>
    <asp:HiddenField ID="hdnTaskId" runat="server" />