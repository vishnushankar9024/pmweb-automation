<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowAdobeSignPopup.aspx.vb" Inherits="Website.WorkflowAdobeSignPopup" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Adobe Sign Popup</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .centerContent {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-direction: column;
        }

        .message {
            color: #666;
            text-transform: uppercase;
        }

        .error {
            color: red;
            width: 50%;
            text-align: center;
        }

        .btnClose {
            border: 1px solid #666;
            padding: 10px 50px;
            border-radius: 5px;
            display: block;
            text-decoration: none;
            color: #666;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
    <script type="text/javascript">

        document.addEventListener('DOMContentLoaded', function () {
            var params = new URLSearchParams(window.location.search);
            if (params.get('step') === 'send') {
                // prevent accidental re-submits on refresh/postback loops
                if (sessionStorage.getItem('autoSent')) return;
                sessionStorage.setItem('autoSent', '1');

                // set the hidden field to window.name
                var hidden = document.getElementById('<%= hdnWindowNameField.ClientID %>');
                if (hidden) hidden.value = window.name || '';

                        var btn = document.getElementById('<%= btnSend.ClientID %>');
                        if (btn) btn.click();
                    }
                });

        function closeWnd() {
            window.close();
            return false;
        }
        function ReloadParentPage() {
            if (window.opener.location.toString().indexOf("Home") > 0) {
                $(window.opener.document).find("[id$=lbtRefresh2]")[0].click();
            } else {
                $(window.opener.document).find("[id$=btnReloadWorkflowDoc]")[0].click();
            }
            return false;
        }
    </script>
    <form id="form1" runat="server">
        <div class="centerContent">
            <asp:Label runat="server" ID="lblMessage" CssClass="message" Text="Adobe Sign agreement has been sent.1"></asp:Label>
            <asp:LinkButton  runat="server" ID="btnClose" CssClass="btnClose" meta:resourceKey="btnClose" OnClientClick="return closeWnd();"></asp:LinkButton>
        </div>


        
        <asp:HiddenField ID="hdnWindowNameField" runat="server" />
        <asp:Button ID="btnSend" runat="server" Text="Send" style="display: none !important;"/>

   
    </form>
</body>
</html>
