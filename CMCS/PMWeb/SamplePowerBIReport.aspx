<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SamplePowerBIReport.aspx.vb" Inherits="Website.SamplePowerBIReport" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, maximum-scale=1" />
</head>
<body>
     <form id="form1" runat="server">

                    <iframe src="" runat="server" frameborder="0" id="WebPageSamplePowerBI" visible="true" width="100%" class="ProjectCenterIframe"
                         height="660px" style="background-image: none !important;padding-top:30px; border: 0px;"></iframe>               

         </form>

</body>

</html>
