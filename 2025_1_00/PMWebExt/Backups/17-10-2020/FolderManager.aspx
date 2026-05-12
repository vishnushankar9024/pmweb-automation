<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FolderManager.aspx.vb"
    MasterPageFile="~/PmMaster.Master" Inherits="Website.FolderManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="FileManagerPermissions.ascx" TagName="FileManagerPermissions" TagPrefix="uc1" %>
<%@ Register Src="FilesAttributes.ascx" TagName="FilesAttributes" TagPrefix="uc2" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc3" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc6" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc9" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" EnableStyleSheetCombine="true"></telerik:RadStyleSheetManager>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript" src="JS/FileManager/FileManager.js?version=<%= PM.Security.LicenseInfo.PMWebVersion %>"></script>
        <script src="JS/Scoring.js" type="text/javascript"></script>
        <%--<script type="text/javascript" src="https://apis.google.com/js/api.js"></script>--%>
        <script language="javascript" type="text/javascript">

            //  var lastContext = null;
            //  var longTouchID = 0;
            //  var menuShown = false;
            //  var FoldertreeId = "<%=trvFolders.ClientID %>";
            var gridId = "<%=rdgFiles.ClientID %>";
            var cmFileActions;
            var cmFolderActions;
            cmFileActions = "<%=cmFileActions.ClientID %>"
            cmFolderActions = "<%=cmFolderActions.ClientID %>"

            /******** GDrive *****/
            //var GDrivedeveloperKey = 'AIzaSyBAbvn6XO_GyYl83g0LCdFakSnkQcHK4_4'; // API Key
            //var GDriveclientId = "1068310945367-kqt6h8gaberaalovbrtu737lqt73blcg.apps.googleusercontent.com" // OAUTH Crdentials For Web Application Client ID
            //var GDriveappId = "1068310945367"; // IAM settings Project Number
            //var scope = ['https://www.googleapis.com/auth/drive.file'];
            //var pickerApiLoaded = false;
            //var oauthToken;
            //var arrDocs;
            function loadGDrivePicker() {
            //    gapi.load('auth', { 'callback': onAuthApiLoad });
            //    gapi.load('picker', { 'callback': onPickerApiLoad });
                return false;
            }
            //function onAuthApiLoad() {
            //    window.gapi.auth.authorize(
            //        {
            //            'client_id': GDriveclientId,
            //            'scope': scope,
            //            'immediate': false
            //        },
            //        handleAuthResult);
            //}
            //function onPickerApiLoad() {
            //    pickerApiLoaded = true;
            //    createPicker();
            //}
            //function handleAuthResult(authResult) {
            //    if (authResult && !authResult.error) {
            //        oauthToken = authResult.access_token;
            //        createPicker();
            //    } else {
            //        alert(authResult.error);
            //    }
            //}
            //function createPicker() {
            //    if (pickerApiLoaded && oauthToken) {
            //        var view = new google.picker.View(google.picker.ViewId.DOCS);
            //        var uploadView = new google.picker.DocsUploadView()
            //        uploadView.setIncludeFolders(true);
            //        var DocsViewMe = new google.picker.DocsView();
            //        DocsViewMe.setIncludeFolders(true);
            //        var DocsViewShared = new google.picker.DocsView();
            //        DocsViewShared.setIncludeFolders(true);
            //        DocsViewShared.setEnableDrives(true);
            //        view.setMimeTypes("image/png,image/jpeg,image/jpg");
            //        var picker = new google.picker.PickerBuilder()
            //            .enableFeature(google.picker.Feature.MULTISELECT_ENABLED)
            //            .enableFeature(google.picker.Feature.SIMPLE_UPLOAD_ENABLED)
            //            .enableFeature(google.picker.Feature.SUPPORT_DRIVES)
            //            .setAppId(GDriveappId)
            //            .setOAuthToken(oauthToken)
            //            .addView(DocsViewMe)
            //            .addView(DocsViewShared)
            //            .addView(uploadView)
            //            .setDeveloperKey(GDrivedeveloperKey)
            //            .setCallback(pickerCallback)
            //            .build();
            //        picker.setVisible(true);
            //    }
            //}
            //function pickerCallback(argdata) {
            //    if (argdata.action == google.picker.Action.PICKED) {
            //        // var fileId = argdata.docs[0].id;
            //        // alert('The user selected: ' + fileId);
            //        arrDocs = JSON.stringify(argdata.docs);
            //        PageMethods.SaveGDriveFiles(arrDocs,
            //                       function (response) {
            //                           var btnRefreshFolderGrid = $("[id$=btnRefreshFolderGrid]");
            //                           btnRefreshFolderGrid.click();
            //                       },
            //                       function (msg) { alert(msg) },
            //                                   null);
            //        return false;
            //    }
            //}

            //function saveData() {
               
            //}
            /******** GDrive End *****/

            function OpenFileAdd(FolderId, ClearFileTable, AllowVersioning, IsCopyAction, IsMoveAction) {
                return OpenPOPUp('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction, 800, 440, true, 'rdgFiles');
            }

            function CheckListddlResourceChange(sender, eventArgs) {
                var btnSaveChecklistResource = $("[id$=btnSaveChecklistResource]");
                btnSaveChecklistResource.click();

            }
            function ChecklistSubmiteddateSelected(sender, eventArgs) {
                var btnSaveChecklistDate = $("[id$=btnSaveChecklistDate]");
                btnSaveChecklistDate.click();

            }
            function GetGridObject(sender, eventArgs) {
                rdgFiles = sender;
                Grid = $find($("[id$=rdgFiles]")[0].id);
                btnBluebeam = $($("a[id$=btnBluebeam]")[0]);
            }
            var trvFoldersId = "<%= trvFolders.ClientID %>";

            function DeleteSelectedFiles() {

                return confirm(Msg_DeleteSelectedFile);
            }

            // ----------------------------------Quik Upload ------------------------

            var uploadsDocFileInProgress = 0;

            function onDocFileSelected(sender, args) {
                uploadsDocFileInProgress++;
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


            // ---------------------------------------------------------------------------

            //------------Grid Command Context Menu-------------

            function OpenContextMenuFileActions(e) {
                var ContextMenuFileActions = $find(cmFileActions)
                var position = $("#dvFileActionsMenu").offset();
                ContextMenuFileActions.showAt(position.left + 5, position.top + 22);
                $telerik.cancelRawEvent(e);
            }

            function OpenContextMenuFolderActions(e) {
                var ContextMenuFolderActions = $find(cmFolderActions)
                var position = $("#dvFolderActionsMenu").offset();
                ContextMenuFolderActions.showAt(position.left + 5, position.top + 22);
                $telerik.cancelRawEvent(e);
            }

            function RefreshFilesGrid() {
                var btnRefreshId = $("a[id$=btnRefresh]")[0];
                if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }

            }
            function OpenRedlining(url) {
                window.location = url;
                return false;
            }
            function RedirectToSearch() {
                window.location = 'SearchDocument.aspx?O=59'
            }
            function DetailCommandClicked(sender, args) {
                switch (args.get_item().get_commandName()) {
                    //                    case 'Upload':
                    //                        UploadFileFromGrid();
                    //                        break;
                    case 'CopyURL':
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();;
                        //OpenPOPUp("FileManagerUrl.aspx",
                        //        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=550,height=145,top=' + top + ',left=' + left);
                        var wnd = window.radopen("FileManagerUrl.aspx");
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.3);
                            wnd.Center();
                        }
                        //if (AddClose == true) {
                        //    wnd.add_close(WindowClosed);
                        //    if (gridId) { GridToRebind = gridId; }
                        //}

                        return false;
                        break;
                    default:
                        break;
                }
            }

            Sys.Application.add_load(function () {
                if (detailpane == null) return;
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = mainsplitter.get_width() - 20

                    mainsplitter.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }

                $(document).scrollTop(1);
                while ($(document).scrollTop() != 0) {
                    var NewHeight = detailpane.get_height() - 20

                    detailpane.set_height(NewHeight);
                    $(document).scrollTop(1);
                    if (NewHeight <= 100) {

                        break;
                    }
                }
            })
            var mainsplitter = null;
            function onResized(sender, ags) {
                ////var NewWidth = sender._panes[1].get_width() - 20;
                ////sender._panes[1].set_width(NewWidth);
                ////return false;
                mainsplitter = sender;
                var browserWidth = $telerik.$(window).width();
                if (browserWidth < 843)
                    sender._panes[1].set_width(browserWidth - 20);
            }

            function onClientResized(sender, ags) {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 20
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
                OpenRecentDocumentsPopup('');
            }
            var detailpane = null;
            var headerPane = null;
            var maindiv = $("#ctl00_CPH1_maindiv");
            function onDetailPaneClientResized(sender, ags) {
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Tr = pane1._element;
                pane2.set_height(splitter._element.clientHeight - pane1Tr.clientHeight - 8);
                //   var browserHeight = $telerik.$(window).height();
                //   var headerPaneHeight = $("#ctl00_CPH1_DMHeaderPane").height();
                ////   alert(headerPaneHeight)
                //   //if ($("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DMHeaderPane").css('display') == "none") {
                //   //    sender.set_height(browserHeight);
                //   //}
                //   var maindiv = $("#ctl00_CPH1_maindiv");
                //  setTimeout(function () {
                //      if (headerPaneHeight != 0)
                //          if (maindiv.hasClass("DMIframe"))
                //              sender.set_height(document.documentElement.clientHeight - headerPaneHeight - 20);
                //          else
                //              sender.set_height(document.documentElement.clientHeight - headerPaneHeight - 80);
                //      OpenRecentDocumentsPopup('');
                //       //headerPane.set_height(headerPaneHeight);
                //  },50);
            }



            var horizantalpane = null;
            function OnClientLoad(sender, args) {
                detailpane = sender._panes[1];
                headerPane = sender._panes[0];
                horizantalpane = sender;
                setTimeout(function () {
                    var browserHeight = $telerik.$(window).height();

                    var maindiv = $("#ctl00_CPH1_maindiv");
                    if (maindiv.hasClass("DMIframe")) {
                        sender._panes[0].set_height((document.documentElement.clientHeight / 2) - 20);
                        sender._panes[1].set_height((document.documentElement.clientHeight / 2) - 20);
                    }
                    else {
                        sender._panes[0].set_height((document.documentElement.clientHeight / 2) - 60);
                        sender._panes[1].set_height((document.documentElement.clientHeight / 2) - 60);
                    }
                    //setTimeout(function () {}, 400);
                }, 500);
                return false;
            }

            function OnClientCollapsed(sender, ags) {
                $("#ctl00_CPH1_Splitter").addClass("removeLeft");
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane").addClass("closed");
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane").removeClass("closed");
            }

            function OnHorizontalClientExpanded(sender, ags) {
                //$("#RAD_SPLITTER_ctl00_CPH1_DMHorizontalSplitter").removeClass("MarginTop");
                var maindiv = $("#ctl00_CPH1_maindiv");
                if (maindiv.hasClass("DMIframe"))
                    detailpane.set_height(document.documentElement.clientHeight - headerPane.get_height() - 20);
                else
                    detailpane.set_height(document.documentElement.clientHeight - headerPane.get_height() - 80);
                onDetailPaneClientResized(sender, ags);
            }

            function OnHorizontalClientCollapsed(sender, ags) {
                //  $("#RAD_SPLITTER_ctl00_CPH1_DMHorizontalSplitter").addClass("MarginTop");
                var maindiv = $("#ctl00_CPH1_maindiv");
                if (maindiv.hasClass("DMIframe"))
                    detailpane.set_height(document.documentElement.clientHeight - 20);
                else
                    detailpane.set_height(document.documentElement.clientHeight - 80);

            }

            function OpenBlubeamMarkup(url) {
                window.location = url;
                return false;
            }
            function fixSplitterSize(isRail) {
                if (mainsplitter == null) return;
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }


            }

            <%--function ToggleAssetMenu() {
                var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
                var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>');
                var tdAssetrestofpage = document.getElementById('<%=tdAssetrestofpage.ClientID %>');
                var form = $('form')[0]
                var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    tdAssetExplorerBar.style.left = "285px";
                    tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'inline', 60);
                    //  form.className = form.className + ' ReportManagerTabs';
                } else {
                    tdAssetMenu.style.display = 'none';
                    tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.style.width = "4px";
                    tdAssetrestofpage.style.width = "100%";
                    tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'none', 60);
                    //  form.className = form.className.replace(' ReportManagerTabsVisiible', '')
                }
                ResizeAllGrids();
                return false;
            }--%>

        </script>
        <style type="text/css">
                .MobileAssetTree, .AssetExplorerBar, MobileAssetExplorerBar {
                    top: 50px;
                }

                .btncancel .Icon {
                    background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
                    width: 24px !important;
                    height: 24px !important;
                    background-repeat: no-repeat;
                    background-position: -1248px 0px !important;
                    display: inline-block !important;
                    vertical-align: middle;
                    margin-left: 24px;
                    margin-top: 10px;
                }

                .tbsFolderManager .rtsLevel.rtsLevel1 {
                    width: calc(99%) !important;
                }

                .SpecificationPadding {
                    padding-left: 0 !important;
                }

                .labelWidth {
                    min-width: 130px;
                }

                .DMSearchButton .Icon {
                    background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
                    width: 24px;
                    height: 24px;
                    background-repeat: no-repeat;
                    background-position: -216px 0px !important;
                    display: inline-block;
                    vertical-align: middle;
                }


                input[type="button"].configureTree ::before {
                }

                .configureTree:hover {
                    color: #666666 !important;
                }


                /*@media screen and (min-width:320px) and (max-width:880px) {
                    .tbsFolderManager .rtsLevel.rtsLevel1 {
                        width: 94vw !important;
                    }
                }

                @media screen and (min-width:880px) and (max-width:1510px) {
                    .tbsFolderManager .rtsLevel.rtsLevel1 {
                        width: calc(94vw - 290px) !important;
                    }
                }*/
                .DMSplitterPane {
                    height: calc(100vh - 62px) !important;
                }

                @media screen and (max-width: 843px) and (min-width: 650px) {
                    .PMHeader .row .col-6 {
                        flex: 0 0 50% !important;
                        max-width: 50% !important;
                    }
                }

                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .DMSplitterPane {
                        height: calc(100vh - 50px) !important;
                    }


                    #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane, .DMHorizontalSplitter {
                        height: calc(100vh - 35px) !important;
                    }

                    #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DMHeaderPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DetailPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane {
                        width: calc(100vw - 3px) !important;
                    }
                }

                @media screen and (min-width:844px) {
                    .DMHorizontalSplitter {
                        height: calc(100vh - 60px) !important;
                    }
                }

                .RadUpload.ProjectCenterUpload {
                    max-width: none;
                    border-radius: 0px;
                    background-color: rgb(105,185,50);
                    border: 1px solid rgb(105,185,50) !important;
                    padding: 0px !important;
                }

                    .RadUpload.ProjectCenterUpload .ruFileWrap {
                        height: 40px;
                    }

                .ProjectCenterUpload .ruDropZone {
                    height: 62px !important;
                    background-color: rgb(105,185,50);
                    border-radius: 0px;
                    color: #fff !important;
                    border: 1px solid rgb(105,185,50) !important;
                    padding: 0px !important;
                    margin-left: 4px !important;
                    padding-right: 12px !important;
                    margin-top: -6px !important;
                }

                .ProjectCenterUpload .ruButton {
                    color: #fff !important;
                    width: 100%;
                }

                .RadUpload.ProjectCenterUpload .ruInputs li {
                    text-align: center;
                }

                div#ctl00_CPH1_trvFolders {
                    color: #ffffff !important;
                    background-color: #666666 !important;
                }

                div#ctl00_CPH1_trvConfigureFolders {
                    color: #ffffff !important;
                    background-color: #666666 !important;
                }

                .tbshorizantaltabs {
                    visibility: visible !important;
                }

                .tbsDocSpec {
                    display: none !important;
                }

                .PMHeader .row .col-2 {
                    flex: 0 0 100% !important;
                    max-width: 100% !important;
                    margin-left: 0px !important;
                    /*float:none !important;*/
                }

                .PMHeader .row .col-10 {
                    flex: 0 0 100% !important;
                    max-width: 100% !important;
                    margin-left: 0px !important;
                    /*float:none !important;*/
                }

                .configureTree .Icon {
                    background-image: url('CSS/Images/ResponsiveIcons/24enabled.png');
                    height: 24px;
                    width: 24px;
                    background-position: -2424px 0 !important;
                    display: inline-block;
                    vertical-align: middle;
                }

                .configureTree {
                    background-color: transparent !important;
                    /*border-radius: 10px;*/
                    /*width: 270px;*/
                    /*height: 32px;*/
                    display: block;
                    text-decoration: none;
                    position: relative;
                    left: -10px;
                }

                    .configureTree .lblConfigureFolders {
                        text-transform: uppercase;
                        position: relative;
                        top: 10px;
                        color: white;
                        text-decoration: none;
                        left: 24px;
                    }

                .saveTree {
                    background-color: transparent !important;
                }

                    .saveTree .Icon {
                        background-image: url('CSS/Images/ResponsiveIcons/24enabled.png');
                        height: 24px;
                        width: 24px;
                        background-position: -720px 0 !important;
                        display: inline-block;
                        vertical-align: middle;
                    }

                    .saveTree .lblConfigureFolders {
                        text-transform: uppercase;
                        position: relative;
                        text-decoration: none;
                        color: #666666;
                        font-size: 13px;
                    }

                .removeLeft {
                    left: 0 !important;
                }

                .DMVerticalSplitter {
                    height: calc(100vh - 80px) !important;
                }
                /*.DetailPane{min-height:calc((100vh - 20px) /2) !important;}*/
                .DMHeaderPane {
                    Height: calc(50vh - 80px);
                }

                .fullWidth {
                    width: 100vw !important;
                }

                .DMIframe .DMSplitterPane {
                    height: calc(100vh - 10px) !important;
                }

                .DMIframe .DMHorizontalSplitter {
                    height: calc(100vh - 20px) !important;
                }
                /*.DMIframe .DetailPane{min-height:calc((100vh - 70px) /2) !important;}*/
                .DMIframe .DocumentManagerTree {
                    height: calc(100vh - 60px) !important;
                }

                .ToolbarCopyURL .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/DMURL.png') !important;
                }

                .rtbItemHovered .ToolbarCopyURL .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/DMURLHovered.png') !important;
                }

                .rtbItemFocused .ToolbarCopyURL .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/DMURLHovered.png') !important;
                }


                .DocumentManagerTree {
                    height: calc(100vh - 112px);
                }

                .closed {
                    width: 0px !important;
                }

                .ToolBar {
                    background-color: RGB(237,237,237);
                    background-image: none;
                    position: unset;
                    z-index: 999;
                    table-layout: fixed;
                    top: 30px;
                    width: 100%;
                }
            </style>
</telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>  
                <telerik:AjaxSetting AjaxControlID="mlpDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails"  />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" LoadingPanelID="ldpPM"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="trvFolders">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblContent" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="hdnAllowVersioning" />
                    <telerik:AjaxUpdatedControl ControlID="mlpFolderManager" />
                    <telerik:AjaxUpdatedControl ControlID="hdnCopiedFileIds" />
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                    <telerik:AjaxUpdatedControl ControlID="pnlQuickFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnGetProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblContent" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgFiles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblFiles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                    <telerik:AjaxUpdatedControl ControlID="lblResult" />
                    <telerik:AjaxUpdatedControl ControlID="hdnDropOnFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgFolderAttributes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFolderAttributes" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefreshSubscriptionTree">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRebindTree">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblContent" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmFileActions">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="hdnCopiedFileIds" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefreshFolderGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshFolderGrid" />
                    <telerik:AjaxUpdatedControl ControlID="lblResult" />
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btngoToFolder">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                    <telerik:AjaxUpdatedControl ControlID="btngoToFolder" />
                    <telerik:AjaxUpdatedControl ControlID="lblResult" />
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfigureFolders">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvConfigureFolders" />
                    <telerik:AjaxUpdatedControl ControlID="btnCancel" />
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <%-- <telerik:AjaxUpdatedControl ControlID="btnConfigureFolders" />--%>
                    <telerik:AjaxUpdatedControl ControlID="tblContent" />
                    <telerik:AjaxUpdatedControl ControlID="pnlQuickFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="pnlSearch" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                    <%-- <telerik:AjaxUpdatedControl ControlID="spanConfigureFolders" />
                    <telerik:AjaxUpdatedControl ControlID="lblConfigureFolders" />--%>
                    <telerik:AjaxUpdatedControl ControlID="pnlConfigureTree" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvConfigureFolders" />
                    <telerik:AjaxUpdatedControl ControlID="btnCancel" />
                    <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                    <telerik:AjaxUpdatedControl ControlID="btnConfigureFolders" />
                    <telerik:AjaxUpdatedControl ControlID="tblContent" />
                    <telerik:AjaxUpdatedControl ControlID="pnlQuickFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="pnlSearch" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDetails" />
                    <telerik:AjaxUpdatedControl ControlID="mlpDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="pnlSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblContent" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <div id="maindiv" runat="server">
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="DMVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack DMSplitterPane" Style="position: fixed; background: white; top: 0;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" MaxWidth="400" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
                <div style="position: relative; width: 100%">
                    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar DocumentManagerToolbar">
                        <tr valign="top">
                            <td valign="middle" class="ToolbarTd" style="display: inline-flex">
                                <asp:Panel runat="server" ID="pnlConfigureTree" Style="margin-top: 10px">
                                    <asp:LinkButton runat="server" ID="btnConfigureFolders" CssClass="configureTree">
                                        <span class="Icon" id="spanConfigureFolders" runat="server"></span>&nbsp
                                                    <asp:Label ID="lblConfigureFolders" runat="server" Visible="false" CssClass="lblConfigureFolders">Configure Tree</asp:Label>
                                    </asp:LinkButton>
                                </asp:Panel>
                                <asp:Button ID="btnGetProjects" CssClass="Hide" runat="server" Text="Go" />
                                <asp:LinkButton runat="server" ID="btnCancel" CssClass="btncancel">
                                    <span class="Icon" id="span1" runat="server"></span>&nbsp
                                </asp:LinkButton>
                            </td>

                        </tr>
                    </table>
                </div>
                <telerik:RadTreeView ID="trvFolders" runat="server" EnableDragAndDropBetweenNodes="true" OnClientNodeEditStart="OnClientNodeEditStartHandler"
                    EnableDragAndDrop="true" MultipleSelect="false" OnClientMouseOver="trvFolders_OnClientMouseOverHandler"
                    OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onClientContextMenuShowing"
                    OnContextMenuItemClick="treeFoldersAndFiles_ContextMenuItemClick" CssClass="DocumentManagerTree TreeWithDarkBackground WhitePlusMinus"
                    OnNodeEdit="treeFoldersAndFiles_NodeEdit" Skin="Default" Width="99%">
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default"
                            Width="100%" CssClass="trvContextMenu">
                            <Items>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_NewFolder"
                                    Text="New Folder" Value="NewFolder" EnableImageSprite="false" CssClass="MenuAdd">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Text="Open" meta:ResourceKey="ContextMenu_Open"
                                    Value="Open" EnableImageSprite="false" CssClass="MenuOpen">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_EditFolder"
                                    Text="" Value="EditFolder" EnableImageSprite="false" CssClass="MenuEdit">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem PostBack="false" Text="Rename"
                                    meta:ResourceKey="ContextMenu_Rename" Value="Rename" EnableImageSprite="false" CssClass="MenuRename">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_Subscribe"
                                    Text="Attributes" Value="Subscribe" PostBack="false" EnableImageSprite="false" CssClass="MenuSubscribe">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Text="Unsubscribe11" Value="unsubscribe" meta:ResourceKey="ContextMenu_Unsubscribe" EnableImageSprite="false" CssClass="MenuUnsubscribe"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Text="Copy Folder URL1" Value="CopyFolderUrl" meta:ResourceKey="ContextMenu_CopyFolderUrl"
                                    EnableImageSprite="false" CssClass="MenuUrl">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>

                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_UploadFile"
                                    Text="Upload File" Value="UploadFile" EnableImageSprite="false" CssClass="MenuUpload">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_PasteFiles" Text="Paste" Value="PasteFiles" EnableImageSprite="false" CssClass="MenuPaste"></telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_CopyFolder"
                                    Text="Copy" Value="Copy" EnableImageSprite="false" CssClass="MenuCopy">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_PasteFolder"
                                    Text="Paste" Value="Paste" EnableImageSprite="false" CssClass="MenuPaste">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem meta:ResourceKey="ContextMenu_DeleteFolder"
                                    Text="Delete" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <CollapseAnimation Duration="100" Type="OutQuint"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
                <telerik:RadTreeView ID="trvConfigureFolders" runat="server" EnableDragAndDropBetweenNodes="true" EnableNodeTextHtmlEncoding="true"
                    EnableDragAndDrop="false" MultipleSelect="false" CheckBoxes="true" Width="100%" Skin="Default">
                </telerik:RadTreeView>
                <asp:Button runat="server" ID="btnRefreshSubscriptionTree" CssClass="Hide" />
                <asp:Button runat="server" ID="btnRebindTree" CssClass="Hide" />
            </telerik:RadPane>
            <%-- <td id="tdAssetExplorerBar" runat="server" class="AssetExplorerBar MobileAssetExplorerBar">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="return ToggleAssetMenu();" />
            </td>--%>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="DMSplitter" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="onClientResized">
                <%--<td valign="top" id="tdAssetrestofpage" runat="server" style="width: 100%">--%>

                <telerik:RadSplitter ID="DMHorizontalSplitter" runat="server" Orientation="Horizontal" Width="100%" CssClass="DMHorizontalSplitter" OnClientLoad="OnClientLoad">
                    <telerik:RadPane ID="DMHeaderPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DMHeaderPane"
                        OnClientExpanded="OnHorizontalClientExpanded" OnClientCollapsed="OnHorizontalClientCollapsed">
                        <table cellpadding="0" cellspacing="0" width="100%" runat="server" id="tblQuickFileUpload">
                            <tr class="divTableOnMobile ">
                                <td>
                                    <div class="PMHeader">
                                        <div class="row">
                                            <div class="col-6">
                                                <asp:Panel ID="pnlQuickFileUpload" runat="server" Width="100%">
                                                    <table border="0" style="width: 100%">
                                                        <tr>
                                                            <td align="center">
                                                                <table border="0" style="width: 98%">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadAsyncUpload runat="server" ID="rauAttachments" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
                                                                                OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnClientAdded="addedDocFile"
                                                                                MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true"
                                                                                OnFileUploaded="rauAttachment_FileUploaded" Width="100%" CssClass="ProjectCenterUpload">
                                                                                <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                                                            </telerik:RadAsyncUpload>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                            <div class="col-6" style="padding: 24px 10px;">
                                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 50%;" align="center">
                                                                <asp:TextBox ID="txtSearch" CssClass="SearchButton" runat="server" Width="85%"></asp:TextBox>

                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnSearch1" Style="margin-left: -10px" runat="server" CssClass="DMSearchButton">
                                                                        <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td align="right" style="padding-left: 10px;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblSearchContent" runat="server" Text="Search file contents" meta:ResourceKey="chkSearchContent"></asp:Label>
                                                                        </td>
                                                                        <td style="text-align: right;">
                                                                            <label class="switch">
                                                                                <input id="chkSearchContent" runat="server" type="checkbox" />
                                                                                <span class="slider round"></span>
                                                                            </label>

                                                                        </td>
                                                                    </tr>
                                                                </table>

                                                                <asp:Button ID="btnSearch" runat="server" CssClass="Hide" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" style="width: 100%" runat="server" id="tblContent">
                            <tr>
                                <td>
                                    <table cellpadding="0" runat="server" id="tblFiles" cellspacing="0" width="99%">
                                        <tr>
                                            <td>
                                                <div class="PMHeader">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <telerik:RadGrid ID="rdgFiles" runat="server" AllowMultiRowSelection="True" AutoGenerateColumns="True"
                                                                GridLines="None" HeaderStyle-Font-Size="8" AppendMenus="true" setWidth="true"
                                                                ShowStatusBar="false" PageSize="10" ShowGroupPanel="True" AllowPaging="True" ClientSettings-Scrolling-AllowScroll="true"
                                                                AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                                                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                                                <HeaderStyle Font-Size="8pt" />
                                                                <ClientSettings Selecting-AllowRowSelect="true" EnablePostBackOnRowClick="true"
                                                                    ClientEvents-OnRowDropping="rdgFiles_onNodeDropping" AllowRowsDragDrop="true">
                                                                    <Selecting AllowRowSelect="True" />
                                                                    <ClientEvents OnRowDropping="rdgFiles_onNodeDropping" />
                                                                </ClientSettings>
                                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                                                                    CommandItemDisplay="Top" DataKeyNames="Id,IsSelected,IsEligible" ClientDataKeyNames="Id,IsLastVersion,Extension,DocStatusId,CheckedIn,CheckedById,EditFiles,DeleteFiles,ManageFolder,FolderId,WorkflowStatusId,IsInBluebeamSession,IsEligible" EnableHeaderContextMenu="true">
                                                                    <CommandItemTemplate>
                                                                        <div style="padding-top: 6px;">
                                                                            <asp:LinkButton ID="btnOpenSearchpage" Style="float: left !important;" runat="server" CommandName="Search" CssClass="GridCmdManagerPage"
                                                                                CausesValidation="false" OnClientClick="javascript:RedirectToSearch();return false;">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label runat="server" ID="Label1" Text="Manager Page"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnUpLoadFile" Style="float: left !important;" runat="server" CssClass="GridCmdUploadFile"
                                                                                OnClientClick="javascript:UploadFileFromGrid();return false;" CommandName="UploadFile"
                                                                                CausesValidation="false"
                                                                                Visible="<%# rdgFiles.EditIndexes.Count = 0 And (Not rdgFiles.MasterTableView.IsItemInserted) %>">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label
                                                                                    runat="server" Text="Check In" ID="Label2"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <div id="dvFileActionsMenu" onclick="OpenContextMenuFileActions(event)" style="float: left; cursor: pointer; vertical-align: middle">
                                                                                <div style="text-align: center; float: left; vertical-align: middle" class="Menue">
                                                                                </div>
                                                                                <asp:Label runat="server" ID="lblFileActions" Text="File Actions"></asp:Label>
                                                                                &nbsp;
                                                                            </div>
                                                                            <asp:LinkButton ID="btnOpenContainingFolder" runat="server" CausesValidation="false" CssClass="GridCmdOpenContainingFolder"
                                                                                CommandName="OpenContainingFolder">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label
                                                                                    runat="server" Text="Open Containing Folder" ID="lblOpenContainingFolder"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnBluebeam" runat="server" SecurityButtonType="ItemMode_Edit" CssClass="BluebeamIconDisabled" CausesValidation="false" CommandName="CreateBluebeamSession" Visible="true">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label runat="server" ID="lblBluebeam" CssClass="rtbText"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnGDrive" runat="server" SecurityButtonType="ItemMode_Edit" CssClass="GDriveIcon Hide" CausesValidation="false" CommandName="GDrive" Visible="true" OnClientClick="return loadGDrivePicker();" CommandArgument="">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label runat="server" ID="lblGDrive" CssClass="rtbText"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                                                Visible="<%# rdgFiles.EditIndexes.Count = 0 And (Not rdgFiles.MasterTableView.IsItemInserted) %>">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label
                                                                                    runat="server" ID="lblRefresh"></asp:Label>&nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                                                                CommandName="SaveState">
                                                                                <asp:Label ID="lblsavestate" runat="server"></asp:Label>
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                                                                CausesValidation="False" CommandName="LoadDefaultState">
                                                                                &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="lblloaddefaultstate" runat="server"></asp:Label>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </CommandItemTemplate>
                                                                    <Columns>
                                                                        <telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="IsInBluebeamSession" HeaderStyle-Width="50px" Groupable="False" Reorderable="false"
                                                                            ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="imgBluebeam" Style="cursor: pointer" Visible='<%# Eval("IsInBluebeamSession")%>' runat="server"
                                                                                    CssClass="BluebeamIcon">
                                                                     <span class="Icon"></span>
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="StorageLocation" HeaderStyle-Width="50px" Groupable="False" Reorderable="false"
                                                                            ItemStyle-HorizontalAlign="Center" AllowFiltering="false" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="imgStorageLocation" Style="cursor: pointer" runat="server"
                                                                                    CssClass="GDriveIcon">
                                                                                        <span class="Icon" style="display:block"> </span>
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="" Reorderable="false" ItemStyle-Wrap="false" UniqueName="CheckedIn_Out"
                                                                            AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton runat="server" ID="imgCheck" Style="cursor: pointer" CssClass="CheckedIn">
                                                                     <span class="Icon"></span>
                                                                                </asp:LinkButton>
                                                                                <asp:Label runat="server" ID="hdnCanDelete" Style="display: none;" Text='<%#Eval("DeleteFiles").ToString%>' />
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="27px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="" Groupable="False" UniqueName="Redlining"
                                                                            AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="imgRedlining" Style="cursor: pointer" meta:resourcekey="Redlining" runat="server"
                                                                                    CssClass="PMwebViewerButton">
                                                                     <span class="Icon"></span>
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="27px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Document #" UniqueName="Id" SortExpression="Id" Groupable="False"
                                                                            DataField="Id" CurrentFilterFunction="EqualTo" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#IIf(Container.DataItem("Id").ToString = String.Empty, "&nbsp;", Container.DataItem("Id").ToString)%>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                            <ItemStyle />
                                                                            <HeaderStyle Width="150px"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description" Groupable="true" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                                                            DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                            <ItemStyle />
                                                                            <HeaderStyle Width="150px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="File Name" UniqueName="FileName" SortExpression="FileName" Groupable="true" GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC"
                                                                            DataField="FileName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFileName" CssClass="Hide" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                                                                                <asp:HyperLink ID="hplDownload" runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("FileName")%></u></asp:HyperLink>
                                                                                <asp:LinkButton ID="btnFileName" runat="server" Text='<%#Eval("FilePath") %>' Visible="false"></asp:LinkButton>
                                                                                <asp:LinkButton ID="lbtFile" runat="server" CommandArgument='<%#Eval("FilePath") %>'
                                                                                    CommandName="Preview" Text='<%#Eval("FileName") %>' Visible="false"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle />
                                                                            <HeaderStyle Width="150px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Path" Groupable="True" UniqueName="FolderPath" ItemStyle-Wrap="false" GroupByExpression="Path [GridColumn_FolderPath] Group By Path ASC"
                                                                            Visible="false" SortExpression="Path" DataField="Path" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPath" runat="server" Text='<%#IIf(Container.DataItem("Path") Is Nothing, "&nbsp;", "/" & Eval("Path"))%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="150px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" ItemStyle-Wrap="false" Groupable="false"
                                                                            SortExpression="FileSize" DataField="FileSize" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFileSize" runat="server" Text='<%#FormatByte(ParseInt(Eval("FileSize")))%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="60px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" HorizontalAlign="Right" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Ext." UniqueName="Extension" ItemStyle-Wrap="false" GroupByExpression="Extension [GridColumn_Extension] Group By Extension ASC"
                                                                            SortExpression="Extension" DataField="Extension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="txtFileDescription" runat="server" Text='<%#Eval("Extension")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="55px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-Wrap="false" GroupByExpression="Type [GridColumn_Type] Group By Type ASC"
                                                                            SortExpression="Type" DataField="Type" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="100px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" ItemStyle-Wrap="false" GroupByExpression="Category [GridColumn_Category] Group By Category ASC"
                                                                            SortExpression="Category" DataField="Category" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="100px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Workflow Status" UniqueName="WorkflowStatus" ItemStyle-Wrap="false" GroupByExpression="WorkflowStatus [GridColumn_WorkflowStatus] Group By WorkflowStatus ASC"
                                                                            SortExpression="WorkflowStatus" DataField="WorkflowStatus" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#IIf(Container.DataItem("WorkflowStatus") = String.Empty, "&nbsp;", Container.DataItem("WorkflowStatus"))%>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="140px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Version" UniqueName="Version" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Version [GridColumn_Version] Group By Version ASC"
                                                                            SortExpression="Version" DataField="Version" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label CssClass="Hide" ID="lblIsLastVersion" runat="server" Text='<%#Eval("IsLastVersion")%>'></asp:Label>
                                                                                <asp:Label CssClass="Hide" ID="lblOriginalVersionFileId" runat="server" Text='<%#Eval("OriginalVersionFileId")%>'></asp:Label>
                                                                                <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("Version")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="50px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" HorizontalAlign="Right" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Added" SortExpression="CreatedDate" UniqueName="CreatedDate" GroupByExpression="CreatedDate1 [GridColumn_CreatedDate] Group By CreatedDate1 ASC"
                                                                            ItemStyle-Wrap="false" DataField="CreatedDate" CurrentFilterFunction="GreaterThanOrEqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblCreatedDate" runat="server" Text='<%#FormatDate(Eval("CreatedDate")) + " " + FormatTime(Eval("CreatedDate"))%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="120px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Added by" UniqueName="CreatedByUserName" GroupByExpression="CreatedByUserName [GridColumn_CreatedByUserName] Group By CreatedByUserName ASC"
                                                                            ItemStyle-Wrap="false" SortExpression="CreatedByUserName" DataField="CreatedByUserName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblCreatedByUserName" runat="server" Text='<%#Eval("CreatedByUserName")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="130px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Last Checked In/Out" SortExpression="LastModified" UniqueName="LastModified" GroupByExpression="ModifiedDate1 [GridColumn_LastModified] Group By ModifiedDate1 ASC"
                                                                            ItemStyle-Wrap="false" DataField="LastModified" CurrentFilterFunction="GreaterThanOrEqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblModifiedDate" runat="server" Text='<%#FormatDate(Eval("LastModified")) + " " + FormatTime(Eval("LastModified"))%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="120px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Last Checked In/Out" UniqueName="CheckedByUserName" GroupByExpression="CheckedByUserName [GridColumn_CheckedByUserName] Group By CheckedByUserName ASC"
                                                                            ItemStyle-Wrap="false" SortExpression="CheckedByUserName" DataField="CheckedByUserName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblCheckedByUserName" runat="server" Text='<%#Eval("CheckedByUserName")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                            <HeaderStyle Width="130px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                                            UniqueName="FileId" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFileId" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                                            UniqueName="FileGuid" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFileGuid" runat="server" Text='<%#Eval("FileGuid") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                                            UniqueName="FolderId" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFolderId" runat="server" Text='<%#PM.FileManager.FolderInfo.CurrentWorkingFolderId %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                                            UniqueName="CanEdit" AllowFiltering="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblCanEdit" runat="server" Text=''></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="False" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Visible="False" UniqueName="CreatedDate1" DataField="CreatedDate1" DataType="System.DateTime">
                                                                            <ItemTemplate>
                                                                                <span></span>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Visible="False" UniqueName="ModifiedDate1" DataField="ModifiedDate1" DataType="System.DateTime">
                                                                            <ItemTemplate>
                                                                                <span></span>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridCheckBoxColumn UniqueName="$Boolean1$" Display="False" AllowFiltering="True" DataType="System.boolean">
                                                                        </telerik:GridCheckBoxColumn>
                                                                        <telerik:GridDateTimeColumn UniqueName="$Date1$" Display="False" AllowFiltering="True" DataType="System.DateTime">
                                                                        </telerik:GridDateTimeColumn>
                                                                    </Columns>
                                                                    <NoRecordsTemplate>
                                                                        <table style="height: 200px; width: 100%">
                                                                            <tr>
                                                                                <td class="Top Center">
                                                                                    <asp:Label ID="lblNoFileToDisplay" runat="server" meta:ResourceKey="lblNoFileToDisplay"
                                                                                        Text="No Files to display."></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </NoRecordsTemplate>
                                                                </MasterTableView>
                                                                <ClientSettings AllowColumnsReorder="true" AllowDragToGroup="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="True">
                                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                                                    <ClientEvents OnGridCreated="GetGridObject" OnRowSelected="FilesOnRowSelected" OnRowDeselected="FilesOnRowDeselected" />
                                                                    <Selecting EnableDragToSelectRows="true" AllowRowSelect="true" />
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </div>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblResult" runat="server" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPane>
                    <telerik:RadSplitBar ID="RadSplitBar1" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CollapseMode="Forward" />
                    <telerik:RadPane ID="DetailPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DetailPane" OnClientResized="onDetailPaneClientResized">
                        <table style="width: 100%; table-layout: fixed" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <telerik:RadTabStrip ID="tbsDetails" runat="server" CausesValidation="False" EnableViewState="true" Visible="true" CssClass="tbsFolderManager"
                                        meta:resourcekey="tbsDocumentResource1" MultiPageID="mlpDetails" OnClientTabSelecting="onTabSelecting"
                                        SelectedIndex="0" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left" Width="100%">
                                        <Tabs>
                                            <telerik:RadTab meta:resourcekey="tab_Details" Selected="True" Text="Details" Value="Details" />
                                            <telerik:RadTab Selected="false" Value="spec" />
                                            <telerik:RadTab Text="Tasks" Value="Checklists" />
                                            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
                                            <telerik:RadTab Value="Rating"></telerik:RadTab>
                                            <telerik:RadTab meta:resourcekey="tab_Notes" Selected="false" Text="Notes" Value="Notes" />
                                            <telerik:RadTab meta:resourcekey="tab_Attachments" Selected="false" Value="Attachments" Text="Attachments" />
                                            <telerik:RadTab Value="Workflow" Text="Workflow" />
                                            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
                                            <telerik:RadTab Text="Notification" Value="NotificationLog" />
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadMultiPage ID="mlpDetails" runat="server" meta:resourcekey="mlpFolderManagerResource1"
                                        RenderSelectedPageOnly="True" SelectedIndex="0">
                                        <telerik:RadPageView ID="pvDetails" runat="server"
                                            Selected="True" Width="100%">
                                            <uc2:FilesAttributes ID="FilesAttributes1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pSpecs" runat="server" CssClass="DocumentManagerSpecs" Selected="false">
                                            <uc3:DocumentSpecifications ID="DocumentSpecifications1" runat="server" style="width: calc(98vw - 290px)!important;" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvChecklist" runat="server">
                                            <uc10:DocumentCheckList ID="DocumentCheckList1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvScoring" runat="server"
                                            Selected="false">
                                            <uc6:DocumentScoring ID="DocumentScoring1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvRating" runat="server">
                                            <uc7:DocumentRating ID="DocumentRating1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvNotes" runat="server"
                                            Selected="false">
                                            <uc4:DocumentNotes ID="DocumentNotes1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                                            <uc5:DocumentAttachments ID="DocumentAttachments1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
                                            <uc9:WorkflowDocument ID="WorkflowDocument" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                                            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvNotificationLog" runat="server" Visible="False">
                                            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPane>
                </telerik:RadSplitter>



                <telerik:RadContextMenu ID="cmFileActions" OnClientShowing="onClientFileActionsContextMenuShowing" OnClientItemClicking="FileActionsItemClicking" Skin="Default" runat="server" CssClass="trvContextMenu">
                    <Items>
                        <telerik:RadMenuItem Text="Upload11" Value="Upload" meta:ResourceKey="FileContextMenu_Upload" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Download11" Value="Download" meta:ResourceKey="FileContextMenu_Download" EnableImageSprite="false" CssClass="MenuDownload"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Copy" Text="Copy" Value="Copy" EnableImageSprite="false" CssClass="MenuCopy"></telerik:RadMenuItem>
                        <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Paste" Text="Paste" Value="Paste" EnableImageSprite="false" CssClass="MenuPaste"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem Text="Check In11" Value="CheckIn" meta:ResourceKey="FileContextMenu_CheckIn" EnableImageSprite="false" CssClass="MenuCheckedIn"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Check Out11" Value="CheckOut" meta:ResourceKey="FileContextMenu_CheckOut" EnableImageSprite="false" CssClass="MenuCheckedOut"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Cancel Check Out11" Value="CancelCheckout" meta:ResourceKey="FileContextMenu_CancelCheckOut" EnableImageSprite="false" CssClass="MenuCancel"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem Text="PMWeb Viewer11" Value="PMWebViewer" meta:ResourceKey="FileContextMenu_PMWebViewer" EnableImageSprite="false" CssClass="MenuPmWebViewr"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Delete" Text="Delete11" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete"></telerik:RadMenuItem>
                        <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_3DViewer" Text="Delete11" Value="3DViewr" EnableImageSprite="false" CssClass="MenuPmWebViewr"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" Value="LastSeparator" />
                        <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuEmpty" Text="Show Latest Versions Only11" meta:ResourceKey="FileContextMenu_ShowLatestVersions" Value="ShowLatestVersions"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadContextMenu>
                <telerik:RadContextMenu ID="cmFolderActions" Skin="Default" runat="server" CssClass="trvContextMenu">
                    <Items>
                        <telerik:RadMenuItem Text="Add Folder11" meta:ResourceKey="FolderContextMenu_AddFolder" EnableImageSprite="false" CssClass="MenuAdd"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" />
                        <telerik:RadMenuItem Text="Edit Folder11" meta:ResourceKey="FolderContextMenu_EditFolder" EnableImageSprite="false" CssClass="MenuEdit"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" />
                        <telerik:RadMenuItem Text="Subscribe11" meta:ResourceKey="FolderContextMenu_Subscribe" EnableImageSprite="false" CssClass="MenuSubscribe"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Unsubscribe11" meta:ResourceKey="FolderContextMenu_Unsubscribe" EnableImageSprite="false" CssClass="MenuUnsubscribe"></telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuUpload"
                            Text="Upload File11" Value="UploadFiles" meta:ResourceKey="FolderContextMenu_UploadFiles">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuPaste" meta:ResourceKey="FolderContextMenu_Paste"
                            Text="Paste Files11" Value="Paste">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuDelete" meta:ResourceKey="FolderContextMenu_Delete"
                            Text="Delete Folders & Subfolders11" Value="Delete">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                    </Items>
                </telerik:RadContextMenu>
            </telerik:RadPane>

        </telerik:RadSplitter>
    </div>
    <asp:Button ID="btnRefreshFolderGrid" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hdnEntitiesValues" runat="server" />
    <asp:HiddenField ID="hdnDropOnFolderId" runat="server" />
    <asp:HiddenField ID="hdnAllowVersioning" Value="false" runat="server" />
    <asp:HiddenField ID="hdnCopiedFolderId" runat="server" />
    <asp:HiddenField ID="hdnCopiedFileIds" runat="server" />
    <asp:Button ID="btngoToFolder" runat="server" CssClass="Hide" />
    <telerik:RadRating Style="padding-top: 0px; display: none;" Width="100px" ID="rdratingEdit" runat="server" ItemCount="5"
        Value="3" SelectionMode="Continuous" Height="10px" Skin="Default" Precision="half" Orientation="Horizontal" />
    <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="True" Width="100%" Style="display: none;"></telerik:RadToolBar>
    <telerik:RadTabStrip ID="RadTabStrip1" CssClass="Hide" runat="server" CausesValidation="False" EnableViewState="false" Visible="true"
        meta:resourcekey="tbsDocumentResource1" MultiPageID="mlpDetails" OnClientTabSelecting="onTabSelecting"
        SelectedIndex="0" Skin="Default" Style="width: 100%;">
        <Tabs>
            <telerik:RadTab meta:resourcekey="tab_Details" Selected="True" Text="Details" Value="Details" />
            <telerik:RadTab Selected="false" Value="spec" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
            <telerik:RadTab Value="Rating"></telerik:RadTab>
            <telerik:RadTab meta:resourcekey="tab_Notes" Selected="false" Text="Notes" Value="Notes" />
            <telerik:RadTab meta:resourcekey="tab_Attachments" Selected="false" Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <asp:Button ID="btnRefresh" runat="server" CssClass="Hide" />
</asp:Content>
