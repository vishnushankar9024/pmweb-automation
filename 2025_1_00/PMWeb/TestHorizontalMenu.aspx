<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestHorizontalMenu.aspx.vb" Inherits="Website.TestHorizontalMenu" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="CSS/FileViewer.css" rel="stylesheet" />
    <script type="text/javascript" src="JS/PDFViewer/FileViewer.js"></script>
    <script type="text/javascript" src="JS/PDFViewer/FileViewerWorker.js"></script>
    

</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="false" />
    <script type="text/javascript">
        window.pdfjsLib.GlobalWorkerOptions.workerSrc = 'JS/PDFViewer/FileViewerWorker.js';
    </script>
    <div class="demo-container size-wide no-bg" runat="server">
        <telerik:RadPdfViewer runat="server" ID="RadPdfViewer2" style="height: calc(100vh - 50px)" Width="100%"  EnableEmbeddedSkins="False" EnableRippleEffect="True" RenderMode="Auto">
            <PdfjsProcessingSettings File="http://10.9.8.210/pmweb/Help/test.pdf">
            </PdfjsProcessingSettings>
             <ToolBarSettings Items="pager, spacer, zoom, toggleSelection, spacer, search, download, print" />
        </telerik:RadPdfViewer>
    </div>
     

        
    
    </form>
    </body>
</html>
