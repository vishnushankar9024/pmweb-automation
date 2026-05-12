<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SessionTimeOutPopUp.aspx.vb" Inherits="Website.SessionTimeOutPopUp" %>

<!DOCTYPE html>
<style type="text/css">

    .container {
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    }

    .dialog-header {
        font-size: 18px;
    }

    .dialog-body {
        font-size: 14px;
        height: 100%;
        align-content: center;
        padding:24px;
    }

    .msgText {
        color: #424242;
        margin-top: 6px;
    }

    .actionsDiv {
    margin-left: auto;
    padding-inline: 24px;
    padding-block: 14px;
    }

    .logInButton {
    font-family: "Inter", sans-serif;
    font-size: 14px;
    color: #ffffff;
    background-color: /*2*/#30788a/*2*/;
    cursor: pointer;
    border-radius: 4px;
    border: none;
    padding-inline: 12px;
    padding-block: 8px;
    font-weight: 600;
    line-height: 20px;
    }
    hr {
        margin: 0;
        border: none;
        height: 0.0625rem;
        background-color: #eaecf0;
        flex-shrink: 0;
    }
</style>

<script type="text/javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

        return oWindow;
    }


    function CloseDeletePopup() {
        var MFAWindow = GetRadWindow();
        var btn = MFAWindow.BrowserWindow.$("[id$=btnDeleteAfterConfirmation]")[0];
        if (btn != null) {
            btn.click();

        }
        MFAWindow.close();

    }

    function onClickEnterKey() {
        if (event.key === "Enter") {
            var btnLogIn = document.getElementById("btnLogIn");
            event.preventDefault();
            btnLogIn.click();
        }
    }


    window.addEventListener('keydown', (event) => {
        onClickEnterKey();

    });

    window.parent.addEventListener('keydown', (event) => {
        onClickEnterKey();

    });

    function refreshToLogin() {
        var current = window.location.href;
        var newUrl = current.substr(0, current.lastIndexOf("/"));
        newUrl = newUrl + "/default.aspx"
        window.parent.location = newUrl;
    }

    function ClosePopup() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        oWindow.close();
        refreshToLogin();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server"></head>
<script src="JS/jquery.min.js" type="text/javascript"></script>
<script src="JS/jQuery-migrate.js" type="text/javascript"></script>
<script src="JS/TelerikUtilities.js" type="text/javascript"></script>
<body style="background-color: rgba(255,255,255,1); margin: 0;overflow: hidden;font-family: 'Inter', sans-serif;">

    <form id="form1" runat="server">
        <div class="container">

            <div class="dialog-body">
                <div class="dialog-header">
                  <strong>You've been logged out</strong>
                </div>
                <p class="msgText">Your session has timed out due to inactivity. You will need to log in again.</p>
            </div>

            <hr />

            <div class="actionsDiv">
               <asp:Button ID="btnLogIn" runat="server" Text="Log In" CssClass="logInButton" OnClientClick="return ClosePopup();" />
            </div>

        </div>
    </form>

        <button id="hdnPostBackToDefault" onclick="refreshToLogin();" style="display: none;"></button>

</body>
</html>