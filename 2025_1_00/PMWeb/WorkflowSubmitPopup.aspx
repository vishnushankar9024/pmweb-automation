<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowSubmitPopup.aspx.vb" Inherits="Website.WorkflowSubmitPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>111</title>
    <style type="text/css">
        .ruSelectWrap {
            text-align: center !important;
        }

        .PMHeader {
            padding-top: 0px !important;
        }

        .btnRemove {
            background-image: url('Css/Images/Upload/ruSprite.png');
            color: #0e2377;
            background-color: transparent !important;
            overflow: visible;
            height: 17px !important;
            border: 0;
            text-align: left;
            background-position: 2px -74px;
            width: auto;
            padding-left: 16px !important;
            cursor: pointer;
            font-size: 10px;
            width: 17px !important;
            filter: grayscale(1);
            border: none !important;
            margin-left: 4px;
        }

        .divAttachments table {
            background-color: #e4e4e4;
            margin: 5px;
            border-radius: 20px;
        }

        .divAttachments td {
            display: flex;
            padding: 4px 4px 4px 7px;
        }

        .marginleftright {
            margin-right: 24px;
            margin-left: 24px;
        }
        /***************** Green Uploader****************************/
        .RadUpload.viewAttachmentUpload {
            max-width: none;
            border-radius: 0px;
            background-color: rgb(105,185,50);
            border: 1px solid rgb(105,185,50) !important;
            padding: 6px;
            height: 100px;
        }

            .RadUpload.viewAttachmentUpload .ruFileWrap {
                height: 100px !important;
            }

        .viewAttachmentUpload.WorkflowFileUpload {
            box-sizing: border-box;
            height: 56px !important;
        }

        .viewAttachmentUpload .ruDropZone {
            height: 50px !important;
            background-color: rgb(105,185,50) !important;
            border-radius: 0px !important;
            color: #fff !important;
            border: 1px solid rgb(105,185,50) !important;
            padding: 0px !important;
            margin-left: 4px !important;
            padding-right: 12px !important;
            margin-top: -6px !important;
        }

        .RadUpload.viewAttachmentUpload .ruButton {
            color: #fff !important;
            width: 100% !important;
            height: 50px !important;
        }

        .RadUpload.viewAttachmentUpload .ruInputs li {
            text-align: center !important;
        }

        .rutd .RadUpload .ruInputs li {
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .rutd .RadUpload .ruButton, .RadUpload .ruButton:focus {
            background-image: none !important;
            border-width: 0px !important;
            margin-top: -6px !important;
        }

        .RadUpload.viewAttachmentUpload:hover {
            background-color: rgb(105,185,50) !important;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruFileWrap {
            height: 42px !important;
            color: black;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruFileInput,
        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruBrowse {
            display: none;
        }

        .divAttachments {
            display: flex;
            flex-wrap: wrap;
            align-content: flex-start;
            margin-bottom: 0px;
            height: 100%;
        }

        .clearattachments div {
            background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png');
            background-repeat: no-repeat;
            display: inline-block;
            transform: rotate(90deg);
            width: 16px;
            height: 16px;
            background-size: cover;
            background-position: -208px 0px;
            position: absolute;
            right: 0px;
            margin: 5px;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruInputs {
            position: fixed !important;
            top: 50%;
            z-index: 9999999;
            left: 50%;
            width: 50% !important;
            display: block !important;
            transform: translate(-50%, -50%);
            background-color: white;
            border-radius: 5px;
            box-shadow: black 0 0 15px -5px;
            max-height: 60vh;
            overflow-y: auto;
            padding-top: 20px;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload {
            text-transform: none !important;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruFileProgressWrap {
            margin-top: 5px !important;
        }

        .RadUpload.viewAttachmentUpload.WorkflowFileUpload .ruButton {
            color: black !important;
            max-height: 40px;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            display: none;
            z-index: 9999998;
        }

        /*****************************************************(*/

        html, body, form,
        .documentSinglePage, .col-4, .colTable,
        .pnlQuickFileUpload, .TableNoSpacingNoBorder {
            height: 100%;
        }

        .PMMainPage {
            height: calc(100% - 50px);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script language="javascript" type="text/javascript">

                var uploadsDocFileInProgress = 0;

                function onDocFileSelected(sender, args) {
                    $('#overlay').show();
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.add('WorkflowFileUpload');
                    }
                    uploadsDocFileInProgress++;
                }

                function onDocFileUploading(sender, args) {
                    var async = $find("rauAttachment");
                    $telerik.$(".ruCancel", async.get_element()).bind('click', function () {
                        decrementUploadsDocFileInProgress();
                        args.set_cancel(true)
                    });
                }

                function onDocFileUploaded(sender, args) {
                    decrementUploadsDocFileInProgress();
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.remove('WorkflowFileUpload');
                        var btnRefreshAttributesSelected = $("[id$=btnRefreshAttributesSelected]");
                        btnRefreshAttributesSelected.click();
                        setTimeout(function () {
                            sender.deleteAllFileInputs();
                        }, 10);
                    }
                    $('#overlay').hide();
                }

                function onDocFileUploadFailed(sender, args) {
                    decrementUploadsDocFileInProgress();
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.remove('WorkflowFileUpload');
                    }
                    $('#overlay').hide();
                }

                function decrementUploadsDocFileInProgress() {
                    uploadsDocFileInProgress--;
                }

                function addedDocFile(sender, args) {
                    if (document.getElementById('lblUploadOption')) {
                        if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                            $("#lblUploadOption").html(lblUploadOptionChFFText);
                        } else {
                            var senderelement = sender.get_element();
                            var inputs = senderelement.getElementsByTagName("span");
                            for (var i = 0; i < inputs.length; i++) {
                                var input = inputs[i]
                                if (input.className == "ruButton ruBrowse") {
                                    $(input).html(lblBrowseIEText)
                                }
                            }
                            document.getElementById('tdUploadOption').style.display = 'none';
                            document.getElementById('rauAttachment').style["padding-top"] = "15px !important";
                        }
                    }
                }

                function ClientDocFileValidationFailed(sender, args) {
                    decrementUploadsDocFileInProgress();
                    alert(WarningMsg_InvalidFile);
                }

                function SubmitWorkflowError(errorMsg, url) {
                    alert("'" + errorMsg + "'");
                    window.location = url;
                }

                function LoadPanel() {
                    $('[id=DisableAllControlsOnPostback]').removeClass('Hide');
                }

            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadFormDecorator ID="rfdMaster" runat="server" DecoratedControls="Buttons,CheckBoxes,H4H5H6,Label,LoginControls,RadioButtons,Select,ValidationSummary" />

        <div style="z-index: 89999; width: 100%; height: 100%; position: fixed; zoom: 1; color: black;" class="Hide RadAjax RadAjax_Default" id="DisableAllControlsOnPostback">
            <div class="raDiv"></div>
            <div id="PMLoadingIcon" class="raColor raTransp"></div>
        </div>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td valign="middle" align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar" OnClientButtonClicking="LoadPanel">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblComments" runat="server" Text="Comments11" meta:resourcekey="lblComments"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtComments" runat="server" Height="150px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAdditionalCC" runat="server" Text="Additional CC11" meta:resourcekey="lblAdditionalCC"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtAdditionalCC" runat="server" Height="60px" TextMode="MultiLine"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="rfvEmailValidatorCcTo" runat="server"
                                    ControlToValidate="txtAdditionalCC" CssClass="Validator" Display="Dynamic" ForeColor=""
                                    meta:resourcekey="rfvEmailValidator" ValidationGroup="Submit"
                                    ValidationExpression="((\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*([;])*)*">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="controlWidth" style="padding-bottom: 0px !important;">
                                <asp:Panel ID="pnlQuickFileUpload" runat="server">
                                    <table class="TableNoSpacingNoBorder" style="width: 100%; height: calc(100vh - 374px);">
                                        <tr>
                                            <td id="tdUploadOption" runat="server" class="rutd">
                                                <telerik:RadAsyncUpload runat="server" CssClass="viewAttachmentUpload" Skin="Default" ID="rauAttachment" OnClientFileUploadFailed="onDocFileUploadFailed" Style="height: 50px !important; box-sizing: border-box"
                                                    OnClientFileSelected="onDocFileSelected" OnClientFileUploading="onDocFileUploading" OnClientFileUploaded="onDocFileUploaded" OnClientAdded="addedDocFile" HideFileInput="true"
                                                    MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" DropZones="#UploadDropZone" OnFileUploaded="rauAttachment_FileUploaded" OnClientFileUploadRemoved="onDocFileUploadFailed">
                                                    <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                                </telerik:RadAsyncUpload>
                                            </td>
                                        </tr>
                                        <tr style="height: 100%;">
                                            <td style="padding-top: 10px; padding-bottom: 24px; height: 100%;">
                                                <div class="divAttachments" style="overflow: auto; border: 1px solid #666;">
                                                    <asp:LinkButton runat="server" CssClass="clearattachments" ID="btnClearAttachments">
                                                        <div></div>
                                                    </asp:LinkButton>
                                                    <asp:Repeater runat="server" ID="rptSelected">
                                                        <ItemTemplate>
                                                            <table border="0">
                                                                <tr>
                                                                    <td style="vertical-align: top">
                                                                        <asp:Label runat="server" ID="lblFile" Text='<%# CStr(Eval("FileNameWithExtension"))%>' Style="white-space: normal !important"></asp:Label>
                                                                        <asp:Button ID="btnRemove" Text="" FileGuid='<%# CStr(Eval("FileGuid"))%>' class="btnRemove" runat="server"></asp:Button>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <asp:Button ID="btnRefreshAttributesSelected" runat="server" CssClass="Hide" />
                </div>
            </div>
        </div>

        <div id="overlay" class="overlay"></div>

        <asp:HiddenField ID="hdnAction" runat="server" />
        <asp:HiddenField ID="hdnSubject" runat="server" />
        <asp:HiddenField ID="hdnBody" runat="server" />
        <asp:HiddenField ID="hdnRequireComments" runat="server" />
    </form>

</body>
</html>
