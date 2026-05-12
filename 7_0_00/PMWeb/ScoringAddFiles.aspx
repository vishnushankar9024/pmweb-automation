<%@ Page Language="vb" AutoEventWireup="false"  meta:resourcekey="Page" CodeBehind="ScoringAddFiles.aspx.vb" Inherits="Website.ScoringAddFiles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add File(s)</title>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            var uploadsInProgress = 0;
            var stopUpload = false;
            var DeleteAllFiles = false;
            function onScoringFileSelected(sender, args) {
                DeleteAllFiles = false;
                $("span[id$='lblTotalNumberError']").hide();
                if (uploadsInProgress >= TotalFilesToUpload) {
                    stopUpload = true;
                    DeleteAllFiles=true;
                    return;
                }
                uploadsInProgress++;

            }

            function onScoringFileUploaded(sender, args) {
                if (stopUpload == true) {
                    uploadsInProgress = 0;
                    stopUpload = false;
                    
                }
                if (DeleteAllFiles == true) {
                    $telerik.$(".ruRemove", args.get_row()).click();
                    $("span[id$='lblTotalNumberError']").show();
                }
                if (uploadsInProgress == 0) { return; }
                decrementUploadsInProgress();
                if (uploadsInProgress <= 0) {
                    var btnRefresh = $("[id$=btnRefresh]");
                    var DivUploadingMessage = $("Div[id$=DivUploadingMessage]");
                    DivUploadingMessage.show();
                    btnRefresh.click();
                    setTimeout(function () {
                        sender.deleteAllFileInputs();
                    }, 10);
                }
            }
            function onScoringUploadFailed(sender, args) {
                decrementUploadsInProgress();
             

            }

            function decrementUploadsInProgress() {
                if(uploadsInProgress>0)
                uploadsInProgress--;
            }

            function Scoringadded(sender, args) {
                if (document.getElementById('lblUploadOption')) {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $("#lblUploadOption").html(lblUploadOptionChFFText);
                    } else {
                        $("#lblUploadOption").html(lblUploadOptionIEText);
                    }
                }
            }

            function ScoringClientValidationFailed(sender, args) {
                decrementUploadsInProgress();
                alert(WarningMsg_InvalidFile);
                window.location = "ScoringAddFiles.aspx?RecordType=" + GetquerySt('RecordType') + '&RecordId=' + GetquerySt('RecordId') + '&LineId=' + GetquerySt('LineId');
            }

            function ClearLoadingMessage(rnd) {
                var DivUploadingMessage = $("span[id$=DivUploadingMessage]");
                DivUploadingMessage.hide();
            }
        </script>
        <style type="text/css">
            .RadUpload_Default .ruFakeInput{display:none}
            .maxWidth {
                max-width: 100px;
                height:20px !important;
                font-size:10px !important;
            }
        </style>
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table style="width: 100%">
        <tr>
            <td style="padding-top: 5px">
                 <fieldset>
                    <legend><asp:label ID="lblFilesUpload" runat="server"  meta:resourcekey="lblFilesUpload" text="Files Upload"></asp:label></legend>
                         <asp:Panel ID="pnlQuickFileUpload" runat="server">
                            <fieldset style="padding: 0px; border:none">
                                <table border="0" style="width: 100%">
                                    <tr>
                                        <td align="left">
                                            <table border="0">
                                                 <tr>
                                                    <td>
                                                        <div id="DivUploadingMessage" runat="server"  style="display:none;" >
                                                        <asp:label id="lblUploadingMessage" runat="server" meta:resourcekey="lblUploadingMessage" Text="Files are being processed, please wait " style="padding-left: 5px;font-weight:bold;color:#818181;font-size:12px;" >
                                                        </asp:label>
                                                             <img src="Images/Toolbox/dots.gif" style="height:5px;" />
                                                            </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="padding-top:10px; padding-bottom:10px; padding-left:6px">
                                                       <span id="lblUploadOption"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <telerik:RadAsyncUpload runat="server" ID="rauAttachment" Skin="Default" OnClientFileUploadFailed="onScoringUploadFailed" CssClass="ProjectCenterUpload"  
                                                            OnClientFileSelected="onScoringFileSelected" OnClientFileUploaded="onScoringFileUploaded" OnClientAdded="Scoringadded" 
                                                            MultipleFileSelection="Automatic" OnClientValidationFailed="ScoringClientValidationFailed" Width="250px" OnFileUploaded="rauAttachment_FileUploaded">
                                                        </telerik:RadAsyncUpload>
                                                        <asp:Label runat="server" id="lblTotalNumberError" Text="" style="display:none;" CssClass="Validator"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                    </asp:Panel>
                 </fieldset>
            </td>
        </tr>
        <tr>
            <td>
                <table runat="server" id="tblFilesUploaded" style="width:100%">
                    <tr>
                        <td>
                            <fieldset style="width:400px;margin-left:10px;">
                                <legend><asp:label ID="lblFilesUploaded" runat="server"  meta:resourcekey="lblFilesUploaded" text="File(s) Uploaded"></asp:label></legend>
                                     <asp:Repeater runat="server" ID="rptFiles">
                                        <ItemTemplate>           
                                                <table border="0"  >
                                                    <tr>
                                                        <td style="vertical-align:top">   
                                                            <asp:Label runat="server" ID="lblFile"></asp:Label>
                                                            <asp:Button ID="btnRemove" Text="Remove" FileId='<%# CInt(Eval("FileId"))%>' class="btnRemove maxWidth" runat="server">   </asp:Button>
                                                            </td> 
                                                        </tr>
                                                    </table>       
                                        </ItemTemplate>
                                    </asp:Repeater>
                             </fieldset>
                         </td>
                    </tr>
                </table>
                
            </td>
        </tr>    
    </table>
        <asp:Button Id="btnRefresh" runat="server"  CssClass="Hide"  />
    </form>
</body>
</html>
