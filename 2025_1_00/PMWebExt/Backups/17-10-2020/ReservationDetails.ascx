<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ReservationDetails.ascx.vb" Inherits="Website.ReservationDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
     Height="383px" ID="edtComment" Skin="Office2007" runat="server" Width="100%" OnClientLoad="Details_OnClientLoad"  CssClass="WithoutTopBorder">
    <Content>
    </Content>
    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
        SearchPatterns="*.*" />
    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
        SearchPatterns="*.*" />
</telerik:RadEditor>



