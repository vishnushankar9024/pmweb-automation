<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMWebViewerStampsPopUp.aspx.vb" meta:resourcekey="Page" Inherits="Website.PMWebViewerStampsPopUp" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server">
    <script type="text/javascript">
        function clickstamp(sender) {
            var src = '<%= QueryStringSource %>'
            var Id = sender.children[1].value
            var BVFileId = $(window.parent.document).find("input[id$=hdnStamp]").val(Id);
            if (src == 'Menu')
            {
                window.parent.AddStampFromMenu();
            }
            var oWnd = GetRadWindow();
            oWnd.close();
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
    </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        
        .stampItems 
        {
            border:3px solid red;
            padding:1px;
            margin:5px;
            cursor:pointer;
            float:left;
            white-space:nowrap;
            font-size:14px;
            color:Red;
        }

        .stampItems:hover
        {
             border:3px dashed red;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    
<div class="PMMainPage PMPopupMainPage">
    <div class="row">
    <telerik:RadListView runat ="server" ID="lvStamps" AllowPaging ="false" Width="400px">
        <ItemTemplate>
            <a href="#" onclick="clickstamp(this);">
                <asp:Label runat="server" ID="lblStamps" CssClass="stampItems" Visible="false" ></asp:Label>
                <asp:Image runat="server" ID="imgStamps" Visible="false" Width="200px" Height="200px" />
                <asp:HiddenField runat="server" ID="hdnId" />
            </a>
        </ItemTemplate>
    </telerik:RadListView>
    </div>
     </div>
    </form>
</body>
</html>
