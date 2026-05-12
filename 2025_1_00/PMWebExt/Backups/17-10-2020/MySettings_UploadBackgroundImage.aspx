<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="MySettings_UploadBackgroundImage.aspx.vb" Inherits="Website.MySettings_UploadBackgroundImage" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <script type="text/javascript">
        var uploadsDocFileInProgress = 0;


        function onDocFileSelected(sender, args) {

            //if (uploadsDocFileInProgress == 2) {
            //    $telerik.$(".ruRemove", args.get_row()).click();
            //return;
            //}
            uploadsDocFileInProgress++;

        }

        function onDocFileUploading(sender, args) {
            var async = $("[id$=rauBackgroundImage]")
            $telerik.$(async[0].getElementsByTagName(".ruCancel")).bind('click', function () {
                decrementUploadsDocFileInProgress();
                args.set_cancel(true)
            });
        }

        function onDocFileUploaded(sender, args) {
            decrementUploadsDocFileInProgress();
            if (uploadsDocFileInProgress <= 0) {
                var btnRefreshAttributesSelected = $("[id$=btnRefreshAttributesSelected]");
                btnRefreshAttributesSelected.click();
                setTimeout(function () {
                    sender.deleteAllFileInputs();
                }, 10);
            }
        }

        function onDocFileUploadFailed(sender, args) {
            decrementUploadsDocFileInProgress();
        }

        function decrementUploadsDocFileInProgress() {

            uploadsDocFileInProgress--;
        }

        function addedDocFile(sender, args) {
            if (document.getElementById('lblUploadOption')) {
                if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                    $("#lblUploadOption").html(lblUploadOptionChFFText);
                } else {
                    document.getElementById('tdUploadOption').style.display = 'none';
                    document.getElementById('rauBackgroundImage').style["padding-top"] = "15px !important";
                }
            }
        }

        function ClientDocFileValidationFailed(sender, args) {
            decrementUploadsDocFileInProgress();
            alert(WarningMsg_InvalidFile);
        }


    </script>
    <form id="form1" runat="server">
        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td style="width: 100%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
            <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" style="width:100%;height:300px" Visible="false" />

        <table border="0" style="width: 100%" class="documentTabs">
            <tr>
                <td>
                    <div id="UploadDropZone">
                        <table border="0">
                            <tr>
                                <td id="tdUploadOption" style="padding-top: 10px; padding-bottom: 10px; text-align: center; padding-left: 6px; color: #fff; background-color: #71b641; width: 250px" runat="server">

                                    <span id="lblUploadOption"></span>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadAsyncUpload runat="server" RenderMode="Native" CssClass="BigUpload" Skin="Default" ID="rauBackgroundImage" OnClientFileUploadFailed="onDocFileUploadFailed" Width="310px"
                                        OnClientFileSelected="onDocFileSelected" OnClientFileUploading="onDocFileUploading" OnClientFileUploaded="onDocFileUploaded" OnClientAdded="addedDocFile" HideFileInput="true"
                                        MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" DropZones="#UploadDropZone" OnFileUploaded="rauBackgroundImage_FileUploaded">
                                        <Localization Select="<%$ Resources:PMWeb, btn_BrowseToUpload %>" />
                                    </telerik:RadAsyncUpload>

                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>

        </table>
        <div>
        </div>
        <asp:Button Id="btnRefreshAttributesSelected" runat="server"  CssClass="Hide"  />
    </form>
</body>
</html>
