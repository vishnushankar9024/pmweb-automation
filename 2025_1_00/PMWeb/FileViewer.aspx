<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FileViewer.aspx.vb" Inherits="Website.FileViewer" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PDF Viewer</title>
    <link href="CSS/FileViewer.css" rel="stylesheet" />
    <script type="text/javascript" src="JS/PDFViewer/FileViewer.js"></script>
</head>
<body>
    <style type="text/css">
        .RadPdfViewer {
            height: calc(100vh - 50px) !important;
        }
    </style>
    <form id="form1" runat="server">
     <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <script type="text/javascript">
        window.pdfjsLib.GlobalWorkerOptions.workerSrc = 'JS/PDFViewer/FileViewerWorker.js';
    </script>
    <telerik:RadPdfViewer runat="server" ID="RadPdfViewer" style="height: calc(100vh - 50px)" Width="100%"  EnableEmbeddedSkins="False" EnableRippleEffect="True" RenderMode="Auto">
        <PdfjsProcessingSettings File="http://10.9.8.210/pmweb/Help/test.pdf">
        </PdfjsProcessingSettings>
            <ToolBarSettings Items="pager, spacer, zoom, toggleSelection, spacer, search, download, print" />
     </telerik:RadPdfViewer>
    </form>
</body>
</html>
 