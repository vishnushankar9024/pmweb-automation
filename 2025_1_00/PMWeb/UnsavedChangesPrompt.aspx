<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UnsavedChangesPrompt.aspx.vb" Inherits="Website.UnsavedChangesPrompt" %>

<!DOCTYPE html>
<style type="text/css">
    .headerContainer {
        height: 8%;
        min-height: 60px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #F0C224;
    }

    .header {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .title {
        color: #000000;
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        margin-left: 18px;
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

        .smallbutton:hover {
            font-weight: bold;
        }

    .cancelbtn:hover  {
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


    function CloseUnsavedPrompt() {
        var MFAWindow = GetRadWindow();
        self.close();
        window.parent.document.body.focus();
    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"></head>
<body>
     <div class="headerContainer">
        <div class="header">
            <asp:Label ID="lblTitle" runat="server" Text="Unsaved Data" CssClass="title"></asp:Label>
             <div id="SVGArrow">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#000000" style="cursor: hand; position: relative; left: 255px;" onclick="return CloseUnsavedPrompt();">
                    <path d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z" />
                </svg>
            </div>     
            </div>
         </div>
    <form id="form1" runat="server">
         <div class="msgBox">
             You have unsaved data changes. If
             <br />
             you continue navigating away you
             <br />
             will lose your unsaved changes. Are
             <br />
             you sure you want to continue
             </div>

         <div class="container">

            <table style="margin-top: 35px; margin-left: 140px;">
                <tr>
                    <td>
                        <asp:Button runat="server" CssClass="smallbutton" ID="btnOK" Width="75px" Text="OK"/></td>
                        <td align="right" colspan="2" rowspan="5">
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="75px" Style="margin-left: 0px" CssClass="smallbutton cancelbtn" OnClientClick-="return CloseUnsavedPrompt();"/>
                    </td>
                </tr>
            </table>
        </div>
        </form>

</body>
</html>
