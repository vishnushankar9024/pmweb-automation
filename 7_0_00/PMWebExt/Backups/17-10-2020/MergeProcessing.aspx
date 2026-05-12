<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MergeProcessing.aspx.vb" Inherits="Website.MergeProcessing" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
</head>

<telerik:RadCodeBlock ID="CodeBlock" runat="server"> 
<script type="text/javascript">

    var secs
    var timerID = null
    var timerRunning = false
    var delay = 1000

    function InitializeTimer() {
        secs = 5
        StopTheClock()
        StartTheTimer()
    }

    function StopTheClock() {
        if (timerRunning)
            clearTimeout(timerID)
        timerRunning = false
    }

    function StartTheTimer() {
        if (secs == 0) {
            StopTheClock()
            $("img").hide();
            window.onload = null
            var btnDownload = $("[id$=btnDownload]");
            btnDownload.click();
        }
        else {
            self.status = secs
            secs = secs - 1
            timerRunning = true
            timerID = self.setTimeout("StartTheTimer()", delay)
        }
    }

    function LoadImage() {
        document.getElementById('imgMerge').src = '<%= "Images/Menu/Merge.gif?rnd=" & cstr((New random).Next()) %>';
}
</script>
</telerik:RadCodeBlock>
<body onload="LoadImage();">

    <form id="form1" runat="server" >
    <div>
    <asp:PlaceHolder ID="plhScript" runat="server"></asp:PlaceHolder>
    <img id="imgMerge" alt="" />
    <asp:Button ID="btnDownload" CssClass="Hide" runat="server" Text="Button" />
    
    </div>
    
    </form>
</body>
</html>
