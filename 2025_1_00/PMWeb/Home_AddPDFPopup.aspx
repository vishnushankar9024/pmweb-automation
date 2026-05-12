<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="Home_AddPDFPopup.aspx.vb" Inherits="Website.Home_AddPDFPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function ClientValidationFailed(sender, args) {
                //alert(WarningMsg_InvalidFile);
            }

            function onFileUploaded(sender, args) {
                $("[id$=btnRefresh]")[0].click()
            }
            var Upload = document.querySelector('.rauPDfUpload');
            var txt = document.querySelector('.ruFakeInput');
        </script>
        <style>
            /*#rauPDfUpload .ruInputs{
                 visibility:hidden;
             }*/
            .ruFileWrap input[type = text] {
                border: none;
            }
        </style>
        <div class="PMMainPage PMPopupMainPage">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadAsyncUpload runat="server" CssClass="ProjectCenterUpload" style="padding:0 !important" ID="rauPDfUpload" HideFileInput="true" MultipleFileSelection="Disabled"  OnClientValidationFailed="ClientValidationFailed" Width="100%" OnClientFileUploaded="onFileUploaded" OnFileUploaded="rauPDfUpload_FileUploaded" AllowedFileExtensions="pdf">
                        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>"  />
                    </telerik:RadAsyncUpload>
                    <asp:Button runat="server" ID="btnRefresh" CssClass="Hide" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblFileName"></asp:Label>
                </td>
            </tr>
        </table>
            </div>
    </form>
</body>
</html>
