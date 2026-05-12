<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CorrespondenceDetails.ascx.vb"
    Inherits="Website.CorrespondenceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadEditor ID="edtCorrespondence" runat="server" OnClientLoad="OnClientLoad" Style="min-height: 500px; width: 100%; box-sizing: border-box; height: 100%;"
                Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" DialogsScriptFile="~/JS/RadEditorDialog.js" >
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

