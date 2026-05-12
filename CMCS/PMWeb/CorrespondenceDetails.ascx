<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CorrespondenceDetails.ascx.vb"
    Inherits="Website.CorrespondenceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadEditor ID="edtCorrespondence" runat="server" OnClientLoad="OnClientLoad" Style="min-height: 500px; width: 100%; box-sizing: border-box; height: 100%;"
                Skin="Default" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" DialogsScriptFile="~/JS/RadEditorDialog.js">
                <Tools>
                    <telerik:EditorToolGroup>
                        <telerik:EditorTool Name="AjaxSpellCheck" Text="Spellcheck" />
                        <telerik:EditorTool Name="FontName" Text="Font Name" ShortCut="CTRL+SHIFT+F" />
                        <telerik:EditorTool Name="RealFontSize" Text="Font Size" ShortCut="CTRL+SHIFT+P" />
                        <telerik:EditorTool Name="Bold" ShortCut="CTRL+B" Text="Bold" />
                        <telerik:EditorTool Name="Italic" ShortCut="CTRL+I" Text="Italic" />
                        <telerik:EditorTool Name="Underline" ShortCut="CTRL+U" Text="Underline" />
                        <telerik:EditorTool Name="StrikeThrough" Text="Strikethrough" />
                        <telerik:EditorTool Name="JustifyLeft" Text="Align Left" />
                        <telerik:EditorTool Name="JustifyCenter" Text="Align Center" />
                        <telerik:EditorTool Name="JustifyRight" Text="Align Right" />
                        <telerik:EditorTool Name="JustifyFull" Text="Justify" />
                        <telerik:EditorTool Name="ForeColor" Text="Font Color" />
                        <telerik:EditorTool Name="BackColor" Text="Background Color" />
                        <telerik:EditorTool Name="ImageManager" Text="Image Manager" />
                        <telerik:EditorTool Name="TemplateManager" Text="Template Manager" ShortCut="CTRL+M" />
                    </telerik:EditorToolGroup>
                </Tools>
                <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                    SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                    ViewPaths="~/Images/Shared" />
                <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                    SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                    ViewPaths="~/Images/Shared" />
            </telerik:RadEditor>
        </div>
    </div>
</div>
