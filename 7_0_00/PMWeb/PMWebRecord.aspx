<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMWebRecord.aspx.vb" Inherits="Website.PMWebRecord" MasterPageFile="~/PmMaster.Master" %>

<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc2" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc3" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc8" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="FolderManager_AttributesHeader.ascx" TagName="AttributesHeader" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpPMWebRecord">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPMWebRecord" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPMWebRecord" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server" Skin="Default">
        <Calendar runat="server" Width="200px"></Calendar>
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <style>
        div#ctl00_CPH1_mainToolBar_i2_i0_rauPMWebRecord {
            height: 20px;
            border: none !important;
            margin-top: -10px;
        }

        input.ruButton.ruBrowse {
            width: 100%;
            color: #666 !important;
            font-size: 12px !important;
            font-family: 'Work Sans' !important;
            text-transform: none !important;
            text-align: left;
            padding-left: 11px !important;
        }

        input[type="button"]:hover, input[type="submit"]:hover {
            border-color: #b0b0b0 !important;
            color: #000000 !important;
            background-color: #c5c5c5 !important;
            background-image: linear-gradient(#e1e1e1, #c5c5c5) !important;
        }

        span.ruFileWrap.ruStyled {
            width: 100%;
        }

        a.BreadCrumbLabel:active {
            font-size: 16px;
        }

        .ruButton .ruBrowse .ruButtonHover {
            border-color: #b0b0b0 !important;
            color: #000000 !important;
            background-color: #c5c5c5 !important;
            background-image: linear-gradient(#e1e1e1, #c5c5c5) !important;
        }

        .rtbItem .rtbTemplate .ToolbarButtonNew .rtbItemHovered {
            border-color: #b0b0b0 !important;
            color: #000000 !important;
            background-color: #c5c5c5 !important;
            background-image: linear-gradient(#e1e1e1, #c5c5c5) !important;
        }

        div#ctl00_CPH1_mainToolBar_i2_i0_rauPMWebRecord {
            border-radius: 3px !important;
        }

        .paddingleft24 {
            padding-left: 24px;
        }

        .FileManager .rrButton {
            display: none !important;
        }

        .active.ToolbarBlueMarkStudio .rtbIcon {
            background-position: -24px 0;
        }

        .ToolbarBlueMarkStudio:hover .rtbIcon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Hovered.png') !important;
        }

        .ToolbarBlueMarkStudio .rtbIcon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 White.png') !important;
            background-position: -24px 0;
        }

        .ToolbarBlueMarkStudio.inSession .rtbIcon, .BlueMarkStudio.inSession .rtbIcon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
            background-position: -24px 0;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript" src="JS/FileManager/FileManager.js?version=<%= PM.Security.LicenseInfo.PMWebVersion %>"></script>
        <script src="JS/Scoring.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            var uploadsDocFileInProgress = 0;
            var forceMoreMenuToClose = true;

            function onDocFileSelected(sender, args) {
                uploadsDocFileInProgress++;
            }

            function OpenFileAdd(FolderId, ClearFileTable, AllowVersioning, IsCopyAction, IsMoveAction) {
                return OpenPOPUp('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction, 800, 440, true, 'rdgFiles');
            }

            function onDocFileUploaded(sender, args) {
                decrementUploadsDocFileInProgress();
                if (uploadsDocFileInProgress <= 0) {
                    var btnRefreshFolderGrid = $("[id$=btnRefreshFolderGrid]");
                    btnRefreshFolderGrid.click();
                    setTimeout(function () {
                        sender.deleteAllFileInputs();
                    }, 10);
                }
            }

            function uploadFileCurrentWorkingFolder() {
                __doPostBack('ctl00$CPH1$btnUploadFile', "");
            }

            function onDocFileUploadFailed(sender, args) {
                decrementUploadsDocFileInProgress();
            }

            function decrementUploadsDocFileInProgress() {
                uploadsDocFileInProgress--;
            }
            function addedDocFile(sender, args) {
                if (document.getElementById('lblUploadOptions')) {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $("#lblUploadOptions").html(lblDropFilesToUploadText);
                    } else {
                        $("#lblUploadOptions").html(lblUploadOptIEText);
                    }
                }
            }
            function ClientDocFileValidationFailed(sender, args) {
                decrementUploadsDocFileInProgress();
                alert(WarningMsg_InvalidFile);
            }
            function CheckListddlResourceChange(sender, eventArgs) {
                var btnSaveChecklistResource = $("[id$=btnSaveChecklistResource]");
                btnSaveChecklistResource.click();

            }
            function ChecklistSubmiteddateSelected(sender, eventArgs) {
                var btnSaveChecklistDate = $("[id$=btnSaveChecklistDate]");
                btnSaveChecklistDate.click();

            }
            function ActivateButton(sender, args) {
                var btn = sender.closest('a');
                btn.classList.toggle('active');
                var FolderId = sender.getAttribute("FolderId");
                var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + FolderId);
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(DefineSubscriptionClosed);
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), sender, args);
            }

            function RefreshPage() {
                if (window.refreshPage)
                    window.location.reload();
                window.RefreshPage = false;

            }
            function ReloadPage() {
                window.location.reload();
            }
            function RedirectPage() {
                var btnRedirect = $("[id$=btnRedirect]");
                btnRedirect.click();

            }
            function maintoolbarClick(Value, sender, args) {
                var HasMergeTemplate = '<%= PM.FileManager.FileInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.FileManager.FileInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.FileManager.FileInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.FileManager.FileInfo.Description)%>';
                var Id = '<%= PM.FileManager.FileInfo.CurrentWorkingFileId%>';
                var fileGuid = '<%= PM.FileManager.FileInfo.FileGuid%>';
                var version = '<%= PM.FileManager.FileInfo.Version%>';
                var originalVersionFileId = '<%= PM.FileManager.FileInfo.OriginalVersionId%>';
                var FileName = '<%= PM.FileManager.FileInfo.FileName%>';
                var folderId = document.querySelector("#ctl00_CPH1_hfFolderId").value;
                var workflowStatusId = '<%= PM.FileManager.FileInfo.WorkflowStatusId%>';
                var aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW = '<%=PM.Parameters.ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW%>';
                var isInBlueBeamSession = '<%= PM.FileManager.FileInfo.IsInBluebeamSession%>' == "True";
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("FILEMANGER_LOOKUPFILES")%>';
                switch (Value) {
                    case 'View':
                        ShowRecordImage(); return false;
                        break;
                    case 'CopyUrl':
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var wnd = window.radopen("FileManagerUrl.aspx?FileId=" + Id + "&Name=" + JSEscape(FileName));
                        wnd.set_visibleTitlebar(false);
                        wnd._topResizer.parentElement.className = "";
                        var divWindow = wnd._popupElement;
                        divWindow.classList.add("rwFolderManager");
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.4);
                            wnd.Center();
                        }
                        return false;
                        //CopyUrl();
                        break;
                    case 'PMWebSubscribe':
                        Subscribe(this);
                        break;
                    case 'BlueMarkStudio':
                        if (isSendToStudio == "False") { // Go to bluebeam
                            args.set_cancel(true);
                            window.location = "BluebeamMarkups.aspx?Id=" + bluebeamMarkupId + "&ModuleId=8&pageId=332"
                            return false;
                        } else if (isSendToStudio == "True") { // Send to studio
                            args.set_cancel(true);
                            return OpenMultipleCompaniesPopup(Id);
                        }
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var URL = "MergeTemplatePopup.aspx?ObjectType=FILEMANGER_LOOKUPFILES&Id=" +
                                    '<%= PM.FileManager.FileInfo.CurrentWorkingFileId%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.FileManager.FileInfo.ProjectId%>' + "&EntityType=0"
                            return OpenPOPUp(URL, 1045, 515, false, '');
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var URL = "Notification.aspx?ObjectType=FILEMANGER&Id=" +
                              '<%= PM.FileManager.FileInfo.CurrentWorkingFileId%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.FileManager.FileInfo.ProjectId%>' + "&EntityType=0"
                        return OpenPOPUp(URL, 820, 500, false, '');
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var URL = "ReportsPreviewPopup.aspx?ObjectType=FILEMANGER_LOOKUPFILES&Id=" +
                                  '<%= PM.FileManager.FileInfo.CurrentWorkingFileId%>'
                           + "&RecordDescription=" + RecordDescription
                           + "&EntityId=" + '<%=PM.FileManager.FileInfo.ProjectId%>' + "&EntityType=0";
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            var URL = "ReportsPreviewPopup.aspx?ObjectType=FILEMANGER_LOOKUPFILES&Id=" +
                                  '<%= PM.FileManager.FileInfo.CurrentWorkingFileId%>'
                           + "&RecordDescription=" + RecordDescription
                           + "&EntityId=" + '<%=PM.FileManager.FileInfo.ProjectId%>' + "&EntityType=0";
                            return OpenPOPUp(URL, 890, 430, false, '');
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            var URL = "PMWebReports.aspx?ObjectType=FILEMANGER_LOOKUPFILES&Id=" + Id
                      + "&EntityId=" + '<%=PM.FileManager.FileInfo.ProjectId%>' + "&EntityType=0"
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                    case 'New':
                        $("[id$=inputFileCurrentWorkingFolder]")[0].click();
                        break;
                    case 'Copy':
                        var URL = "CopyMoveToDialog.aspx?selectedFiles=FI_" + Id + "&count=1&isFolder=0"
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();;
                        var wnd = window.radopen(URL);
                        wnd.set_visibleTitlebar(false);
                        wnd._topResizer.parentElement.className = "";
                        var divWindow = wnd._popupElement;
                        divWindow.classList.add("rwFolderManager");
                        window.refreshPage = false;
                        wnd.add_close(RefreshPage);
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(450, browserHeight * 0.9);
                            wnd.Center();
                        }
                        break;
                    case "CheckIn":
                        OpenCheckedInPopup(Id, folderId, fileGuid, FileName, version, originalVersionFileId);
                        return false;
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('FILEMANGER');
                        break;
                    default:
                        break;
                }
            }
            function CopyUrl() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();;
                var wnd = window.radopen("FileManagerUrl.aspx");
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                var divWindow = wnd._popupElement;
                divWindow.classList.add("rwFolderManager");
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.45);
                    wnd.Center();
                }
                return false;
            }

            function Subscribe(sender) {
                if (!sender.classList.contains("active")) {
                    var FolderId = sender.getAttribute("FolderId");
                    var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + FolderId);
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    var divWindow = wnd._popupElement;
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    //wnd.add_close(DefineSubscriptionClosed);
                    return false;
                }
                else {
                    return true;
                }

            }
            function ShowRecordImage() {
                //var Image = document.querySelector("#ctl00_CPH1_imgPreview");
                //var src = Image.src;
                var src = $("[id$=hfImgSrc]").val()

                $("#flyoutBackdrop ,.RotatorPopup").removeClass("Hide");
                $(".RotatorPopup").addClass("FileManager");
                $('#PmMasterFader img').remove();
                $('<img src="' + src + '" style="border-width:0px;height:320px;width:370px;" >').prependTo("#PmMasterFader");
                var flyout = $(".RotatorPopup")[0]
                var flyoutBackdrop = $('#flyoutBackdrop')[0]
                flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
                flyout.className = flyout.className.replace(' Hide', '');
                return false;
            }


            function OpenCheckedInPopup(fileId, folderId, fileGuid, fileName, version, originalVersionFileId) {
                var OriginalVersionFileId = fileId;
                var versionNumber = 1;
                if (version != null && originalVersionFileId != null) {
                    versionNumber = version;
                    OriginalVersionFileId = originalVersionFileId;
                }
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('FolderFileUpload.aspx?FolderID=' +
                                            folderId + '&fileId=' +
                                            fileId + '&filename=' +
                                            fileName + '&fileGuid=' +
                                            fileGuid + '&New=CV' +
                                                '&isver=0' +
                                                '&orgVersId=' + OriginalVersionFileId +
                                                '&ver=' + versionNumber + '&IsFromPMWebRecord=true');
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                wnd.add_close(ReloadPage);
                var divWindow = wnd._popupElement;
                divWindow.classList.add("rwFolderManager");
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                if (args.get_item().get_value() == "Download") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Download");
                    button.click();
                } else if (args.get_item().get_value() == "View") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("View");
                    button.click();
                } else if (args.get_item().get_value() == "CheckOut") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("CheckOut");
                    button.click();
                } else if (args.get_item().get_value() == "CheckIn") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("CheckIn");
                    button.click();
                } else if (args.get_item().get_value() == "Bookmark") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Bookmark");
                    button.click();
                } else if (args.get_item().get_value() == "CopyUrl") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("CopyUrl");
                    button.click();
                } else if (args.get_item().get_value() == "GoogleDrive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("GoogleDrive");
                    button.click();
                } else if (args.get_item().get_value() == "PMWebSubscribe") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("PMWebSubscribe");
                    button.click();
                } else if (args.get_item().get_value() == "PmWebViewer") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("PmWebViewer");
                    button.click();
                } else if (args.get_item().get_value() == "BlueMarkStudio") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("BlueMarkStudio");
                    button.click();
                } else if (args.get_item().get_value() == "OneDrive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("OneDrive");
                    button.click();
                } else if (args.get_item().get_value() == "ModelManager") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ModelManager");
                        button.click();
                    }
    maintoolbarClick(args.get_item().get_value(), sender, args)
}

function MoreMenuClosing(sender, args) {
    if (forceMoreMenuToClose) {
        //forceradmenuToClose = false;
        return;
    }
    args.set_cancel(true);
}
function MoreMenuOpening(sender, args) {
    if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

}

function OpenGoogleAddressesPicker() {
    var Id = '<%= Me.PM.FileManager.FileInfo.CurrentWorkingFileId %>';
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    if (Id > 0) {
        var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=FILEMANGER_LOOKUPFILES&ObjectId=" + Id + "&PickerSender=RecordAddress");
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(8, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
    }
    return false;
}
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnExplorer" meta:Resourcekey="btnExplorer">
                                <div class="btnToolbarExplorer">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=59">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent" style="width: 24px;">
                <asp:LinkButton runat="server" ID="btnRecent">
                    <div class="btnToolbarRecent">&nbsp; </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btBookmark" OnClick="btBookmark_Click" ToolTip="Bookmark">
                                <div class="btnBookMarks">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s" Value="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" Value="New" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add"
                                    CommandName="New" Value="Add" PostBack="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Copy"
                                    CommandName="Copy" PostBack="false"  ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint ">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="View" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="View" ImageUrl="Images/ToolBar/EmailMessage.gif" PostBack="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Download" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="Download" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="CheckOut" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="CheckOut" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="CheckIn" OuterCssClass="HideOnMobileToolbar" PostBack="false"
                            CausesValidation="false" Value="CheckIn" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Bookmark" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="Bookmark" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="CopyUrl" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="CopyUrl" ImageUrl="Images/ToolBar/EmailMessage.gif" PostBack="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="GoogleDrive" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="GoogleDrive" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="PMWebSubscribe" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="PMWebSubscribe" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="PmWebViewer" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="PmWebViewer" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" meta:Resourcekey="BlueMarkStudio" CommandName="BlueMarkStudio" CssClass="BlueMarkStudio" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="BlueMarkStudio" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="OneDrive" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="OneDrive" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ModelManager" OuterCssClass="HideOnMobileToolbar"
                            CausesValidation="false" Value="ModelManager" ImageUrl="Images/ToolBar/EmailMessage.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="View" Value="View" CssClass="View"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Download" Value="Download" CssClass="Download"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Check Out" Value="CheckOut" CssClass="CheckOut"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Check In" Value="CheckIn" CssClass="CheckIn"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Bookmark" Value="Bookmark" CssClass="Bookmark"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="CopyUrl" Value="CopyUrl" CssClass="CopyUrl" PostBack="false"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="GoogleDrive" Value="GoogleDrive" CssClass="GoogleDrive"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="PMWebSubscribe" Value="PMWebSubscribe" CssClass="PMWebSubscribe"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="PmWebViewer" Value="PmWebViewer" CssClass="PmWebViewer"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="BlueMarkStudio" Value="BlueMarkStudio" CssClass="BlueMarkStudio"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="OneDrive" Value="OneDrive" CssClass="OneDrive"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('FILEMANGER');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="ModelManager" Value="ModelManager" CssClass="ModelManager"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('FILEMANGER');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                          <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <div class="Hide">
        <asp:Image ID="imgDisplay" CssClass="imgDisplay" Style="width: 100%; height: 100px" runat="server" Visible="false" />
    </div>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpPMWebRecord" Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="spec" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
            <telerik:RadTab Text="Ratings" Value="Rating"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpPMWebRecord" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:Resourcekey="lblCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVersion" runat="server" Text="Version" meta:Resourcekey="lblVersion"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtVersion" CssClass="Integer" runat="server"></asp:TextBox>
                                    </td>
                                </tr>--%>
                                <tr id="trAllowVersionning" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:Resourcekey="lblStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default"></telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox ID="txtVersion" CssClass="PositiveInteger" runat="server" MaxLength="9"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trNoVersionning" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="Label1" runat="server" Text="Status" meta:Resourcekey="lblStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus1" runat="server" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trGoogleAddress" runat="server">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Geolocation"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleAddressesPicker();">
                                                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 100%;" valign="top">
                                        <uc12:AttributesHeader ID="AttributesHeader" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable" style="width: 400px !important;">
                                <tr id="trPreview" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlPreview" runat="server">
                                            <img id="imgPreview" runat="server" src="Images/Global/WhiteDot.gif" style="width: 100% !important; max-height: 300px; padding-bottom: 10px; object-fit: cover; object-position: top" onclick="ShowRecordImage(); return false;" />
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr id="trPreviewUnavailable" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlPreviewUnavailable" runat="server" Style="height: 300px; border: 1px solid gray; text-align: center; line-height: 300px; margin-bottom: 10px">
                                            <asp:Label runat="server" ID="lblPreviewUnavailabe" meta:Resourcekey="lblPreviewUnavailabe" Text="Preview Unavailable"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDocNum" runat="server" meta:Resourcekey="lblDocNum" Text="Document #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDocNum" runat="server" ReadOnly="true" CssClass="Right"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFile" runat="server" meta:Resourcekey="lblFile" Text="File"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFile" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFileType" runat="server" meta:Resourcekey="lblFileType" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFileType" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSize" runat="server" meta:Resourcekey="lblSize" Text="Size"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSize" runat="server" ReadOnly="true" CssClass="Integer"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAddedFrom" runat="server" meta:Resourcekey="lblAddedFrom" Text="Added From"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddedFrom" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAdded" runat="server" meta:Resourcekey="lblAdded" Text="Added"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAdded" runat="server" ReadOnly="true" CssClass="Right"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAddedBy" runat="server" meta:Resourcekey="lblAddedBy" Text="Added By"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddedBy" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLastCheckedInOut" runat="server" meta:Resourcekey="lblLastCheckedInOut" Text="Last Checked In/Out"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLastCheckedInOut" runat="server" ReadOnly="true" CssClass="Right"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLastCheckedInOutBy" runat="server" meta:Resourcekey="lblLastCheckedInOutBy" Text="Last Checked In/Out By"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLastCheckedInOutBy" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc10:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc1:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc2:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc3:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc4:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc7:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server">
            <uc8:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc9:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:Button ID="btnRefreshFolderGrid" runat="server" CssClass="Hide" />
    <asp:Button ID="btnFinisheCheckIn" runat="server" CssClass="Hide" />
    <asp:Button ID="btnRefresh" runat="server" class="Hide" OnClick="btnRefresh_Click" />
    <asp:HiddenField ID="hfFolderId" runat="server" />
    <asp:HiddenField ID="hfGoogleAddress" runat="server" />
    <asp:HiddenField ID="hfElevation" runat="server" />
    <asp:HiddenField ID="hfLatitude" runat="server" />
    <asp:HiddenField ID="hfLongitude" runat="server" />
    <asp:HiddenField ID="hfIsGeoLocationUpdated" runat="server" />
    <asp:HiddenField ID="hfImgSrc" runat="server" />
    <asp:HiddenField ID="hfZoomLevel" runat="server" />
    <asp:HiddenField ID="hfCenter" runat="server" />
    <asp:FileUpload ID="inputFileCurrentWorkingFolder" CssClass="Hide" AllowMultiple="false" onchange="uploadFileCurrentWorkingFolder(event)" EnableViewState="true" runat="server" />
    <asp:Button ID="btnUploadFile" runat="server" class="Hide" />
    <asp:Button ID="btnRedirect" runat="server" CssClass="Hide" />
</asp:Content>
