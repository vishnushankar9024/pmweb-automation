<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SearchDocumentDeleteRecordsConfirmationPopUp.aspx.vb" Inherits="Website.SearchDocumentDeleteRecordsConfirmationPopUp" %>

<!DOCTYPE html>
<style type="text/css">
    .headerContainer {
        height: 8%;
        min-height: 60px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        /*background-color: /*1*/#00568F/*1*/;*/
        background-color: #F0C224;
    }

    .header {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    div#ClientBox {
        margin-top: 311px;
        margin-left: -159px !important;
    }

    .title {
        color: #000000;
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        margin-left: 18px;
    }

    table {
        border-collapse: collapse;
    }

    div#SVGArrow {
        position: relative;
        right: 125px;
        height: 23px;
    }

    .label {
        text-align: left;
        width: 40%;
        text-wrap: nowrap;
    }

    .msgBox {
        margin-top: 25px;
        margin-left: 20px;
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        color: #555555;
        text-align: left;
        line-height: 25px;
    }

    .smallbutton {
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        color: #000000;
        text-align: left;
        line-height: 25px;
        border: none;
        background-color: rgba(255,255,255,1);
        cursor: pointer;
    }

    .cancelbtn {
        font-weight: bold;
    }

    .smallbutton:hover {
        font-weight: bold;
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


    function ClosePopup() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        var popupElement = $(oWindow.get_popupElement());
        popupElement.css({
            opacity: 1,
        });

        popupElement.animate({
            opacity: 0
        }, 200, function () {
            oWindow.close();
        });
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server"></head>
<script src="JS/jquery.min.js" type="text/javascript"></script>
<script src="JS/jQuery-migrate.js" type="text/javascript"></script>
<script src="JS/TelerikUtilities.js" type="text/javascript"></script>
<body style="background-color: rgba(255,255,255,1); margin: 0;">
    <div class="headerContainer">
        <div class="header">

            <asp:Label ID="lblTitle" runat="server" Text="Confirm Delete" CssClass="title"></asp:Label>
            <div id="SVGArrow">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#000000" style="cursor: hand; position: relative; left: 255px;" onclick="ClosePopup()">
                    <path d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z" />
                </svg>
            </div>         
        </div>
    </div>
    <form id="form1" runat="server">
        <div class="msgBox">
            Are you sure you want to delete? 
            <br />
            This cannot be undone.
        </div>
        <div class="container">

            <table style="margin-top: 35px; margin-left: 140px;">
                <tr>
                    <td>
                        <asp:Button runat="server" CssClass="smallbutton" ID="btnSave" ValidationGroup="Save" Width="75px" Text="Delete" OnClientClick="CloseDeletePopup()" /></td>
                        <td align="right" colspan="2" rowspan="5">
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="75px" Style="margin-left: 0px" CssClass="smallbutton cancelbtn" OnClientClick="return ClosePopup();" />
                    </td>
                </tr>
            </table>

        </div>
    </form>

</body>
</html>
