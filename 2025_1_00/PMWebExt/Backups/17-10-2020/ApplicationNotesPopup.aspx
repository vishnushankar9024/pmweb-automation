<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ApplicationNotesPopup.aspx.vb" Inherits="Website.ApplicationNotesPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
   
    <table border="0">
        <tr>
            <td>
                <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtDescription" MaxLength="500" Width="500px" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtDescription"
                    CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Description is required."
                    ValidationGroup="Editor" meta:resourcekey="rfvSubject">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr style="height:10px"></tr>
        <tr>
            <td colspan="2" style="background: white;">
                <telerik:RadEditor ID="edtNotes" Skin="Default" runat="server" Width="900px"  ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"   DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                    <Content></Content>
                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <TemplateManager ViewPaths="~/Images/Shared"  UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                </telerik:RadEditor>
                <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="edtNotes"
                    CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Enter the notes."
                    ValidationGroup="Editor" meta:resourcekey="rfvNotes">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" Text="<%$ Resources:PMWeb, PerformInsert %>" runat="server" ValidationGroup="Editor" Visible='<%# Not PM.Application.ApplicationInfo.Submitted.HasValue%>'  />&nbsp;&nbsp;
                <asp:Button ID="btnCancel" Text="<%$ Resources:PMWeb, CancelAll %>" runat="server" Visible='<%# Not PM.Application.ApplicationInfo.Submitted.HasValue%>'  />
            </td>
        </tr>
   </table>
   
    </form>
</body>
</html>
