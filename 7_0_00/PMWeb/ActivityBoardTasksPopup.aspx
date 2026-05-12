<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardTasksPopup.aspx.vb" Inherits="Website.ActivityBoardTasksPopup"
    meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Comments.ascx" TagName="Comments" TagPrefix="uc1" %>
<%@ Register Src="ActivityBoardAttachments.ascx" TagName="Attachments" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<telerik:radcodeblock id="CodeBlock" runat="server">
            <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
            <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
            <style>
                html {
                    height: 100%;
                }

                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .colTable .RadPicker {
                        width: 287px !important;
                    }
                }

                .RadMenu .rmGroup.rmVertical > .rmSeparator .rmText, .RadMenu .rmScrollWrap > .rmVertical > .rmSeparator .rmText {
                    margin-left: 0px !important;
                }

                .rmSlide {
                    left: -96px !important;
                    z-index: 2999 !important;
                }

                .RadGrid.RadGrid_Default tr.rgSelectedRow > td, .RadGrid_Default tr.rgActiveRow > td, .RadGrid_Default tr.rgEditRow > td {
                    padding-left: 7px;
                }

                .RadGrid_Default .rgMasterTable .rgSelectedCell, .RadGrid_Default .rgSelectedRow {
                    background: white !important;
                }

                .RadGrid.RadGrid_Default .rgRow > td, .RadGrid.RadGrid_Default .rgAltRow > td, .RadGrid.RadGrid_Default, .RadGrid div.rgHeaderWrapper {
                    border: 0;
                }

                .RadGrid.RadGrid_Default {
                    outline: none;
                    border: 0 !important;
                }

                .RadGrid.RadGrid_Default .rgSelectedRow > td, .RadGrid_Default .rgActiveRow > td, .RadGrid_Default .rgEditRow > td {
                    padding-left: 8px;
                    border-color: #c5c5c5 !important;
                }

                .rgRow, .rgAltRow, .rgEditRow {
                    height: 41px;
                }

                .RadGrid_Default tr.rgEditRow {
                    background: white !important;
                }

                .RadGrid .rgMasterTable .rgCommandRow, .RadGrid .rgNoRecords {
                    display: none;
                }

                .subtaskName {
                    font-size: 14px;
                    color: #666666;
                    text-align: left;
                    width: 212px;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    display: inline-block;
                    white-space: nowrap;
                    line-height: 24px;
                }

                .subtaskDate {
                    font-size: 12px;
                    color: #666666;
                    text-align: right;
                    vertical-align: bottom;
                    padding-left: 10px;
                    text-decoration: none;
                }

                .initialsBox {
                    border: 1px solid #666666;
                    width: 28px;
                    height: 23px;
                    text-align: center;
                    padding-top: 5px;
                    display: inline-block;
                    border-radius: 50%;
                }

                 .DatePickerNoInput .Icon {
                    background: url(CSS/Images/ResponsiveIcons/16Enabled.png) no-repeat !important;
                    background-position: -576px 0px !important;
                    display: inline-block !important;
                    width: 16px !important;
                    height: 16px !important;
                    margin-left: 4px !important;
                }

                .rgEditRow .AssignUserButton {
                    float: right;
                    padding-left: 8px;
                }

                .RadGrid.RadGrid_Default .rgRow > td, .RadGrid.RadGrid_Default .rgAltRow > td {
                    border-color: white !important;
                }

                .rgRow:first-of-type > td {
                    border-top: 1px solid #ffffff !important;
                }

                tr.rgRow td:first-child, tr.rgAltRow td:first-child {
                    border-top-left-radius: 5px;
                    border-bottom-left-radius: 5px;
                    border-left: 1px solid #ffffff !important;
                }

                tr.rgRow td:last-child, tr.rgAltRow td:last-child {
                    border-top-right-radius: 5px;
                    border-bottom-right-radius: 5px;
                    border-right: 1px solid #ffffff !important;
                }

                /* tr hover */

                .RadGrid.RadGrid_Default .rgRow.rgSelectedRow > td, .RadGrid.RadGrid_Default .rgAltRow.rgSelectedRow > td {
                    border-color: #c5c5c5 !important;
                }

                .rgRow.rgSelectedRow:first-of-type > td {
                    border-top: 1px solid #c5c5c5 !important;
                }

                tr.rgRow.rgSelectedRow td:first-child, tr.rgAltRow.rgSelectedRow td:first-child {
                    border-top-left-radius: 5px;
                    border-bottom-left-radius: 5px;
                    border-left: 1px solid #c5c5c5 !important;
                }

                tr.rgRow.rgSelectedRow td:last-child, tr.rgAltRow.rgSelectedRow td:last-child {
                    border-top-right-radius: 5px;
                    border-bottom-right-radius: 5px;
                    border-right: 1px solid #c5c5c5 !important;
                }

                tr.rgRow.rgSelectedRow .RadPicker td:last-child, tr.rgAltRow.rgSelectedRow .RadPicker td:last-child {
                    border-right: none !important;
                }

                tr.rgRow:hover, tr.rgAltRow:hover {
                    cursor: pointer;
                }

                /*tr:before {
            top: 0px; 
            height: 40px;
            content: '' ;
            width: 400px;
            background: none;
            border-radius: 10px;
            position: absolute;
        }*/


                .RadToolBar .ToolbarMarkUndone .rtbIcon, .RadToolBar .ToolbarMarkUndone .rtbIcon:hover {
                    width: 16px;
                    height: 16px;
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/16x16 White.png') !important;
                    background-repeat: no-repeat;
                    display: inline-block;
                    background-position: -2080px 0 !important;
                }

                .rtbDisabled a.lnkButtonBar.ToolbarMarkUndone {
                    color: black !important;
                }

                 .RadToolBar .rtbDisabled .ToolbarMarkUndone .rtbIcon, .RadToolBar .rtbDisabled .ToolbarMarkUndone .rtbIcon:hover {
                        background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
                 }

                 .RadPicker_Default .rcCalPopup.rcDisabled{
                     cursor:auto;
                 }

                 .RadPicker_Default .rcCalPopup.rcDisabled:hover{
                      background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png) !important;
                 }
                

                a.lnkButtonBar.ToolbarMarkUndone {
                    background-color: #999999;
                    color: white;
                    border-color: #999999;
                }

                .rtbItemClicked .ToolbarMarkUndone .rtbIn {
                    color: white;
                }

                .RadToolBar .lnkButtonBar .rtbIn {
                    padding: 0;
                    height: 20px !important;
                    line-height: 20px !important;
                }

                .RadToolBar .ToolbarGoToParent .rtbIcon {
                    background-position: -268px 0px;
                }

                .ToolbarLikeTaskByUser .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                    background-repeat: no-repeat;
                    display: inline-block;
                    background-position: -3096px 0 !important;
                }

                .rtbItemHovered .ToolbarLikeTaskByUser .rtbIcon, .rtbItemFocused .ToolbarLikeTaskByUser .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Hovered.png') !important;
                    background-repeat: no-repeat;
                    display: inline-block;
                    background-position: -3096px 0 !important;
                }

                .RadToolBar_Horizontal .ToolbarNumberOfLikes {
                    margin-right: 0px !important;
                    font-size: 12px;
                    color: #999999;
                }

                .ToolbarMobileMenu {
                    display: inline-block !important;
                    padding-left: 5px;
                }

                .menuAttachment > span {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                    background-repeat: no-repeat;
                    display: inline-block;
                    background-position: -3216px 0 !important;
                }

                .rtbItemHovered .menuAttachment > span, .rtbItemFocused .menuAttachment > span {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Hovered.png') !important;
                }

                .attachment a {
                    text-decoration: none;
                    color: #666666;
                }

                            
            .RadMenu .rmGroup a.rmLink{
                border:1px white solid !important;
             }

              .RadMenu .rmGroup a.rmLink:hover, .RadMenu .rmGroup a.rmFocused, .RadMenu .rmGroup a.rmSelected, .RadMenu .rmGroup a.rmExpanded {
                color: #455A64;
                background: #ECEFF1 !important;
                border:1px #b0b0b0 solid !important;
                }

              .RadMenu .rmSeparator{
                  margin-top:2px;
              }

             .RadMenu .rmGroup a.rmLink:hover .rmText, .RadMenu .rmGroup a.rmFocused .rmText, .RadMenu .rmGroup a.rmSelected .rmText, .RadMenu .rmGroup a.rmExpanded .rmText {
                 background: none !important;
             }  
             .RadMenu .rmLink{
                 height:20px;
             }
             .UpperDiv{
                 height: 39px; 
                 padding-left: 7px; 
                 border: 1px solid white; 
                 border-radius: 4px;
             }
             .UpperDiv:hover{
                 border: 1px solid #b0b0b0 !important; 
                 cursor: pointer;                 
             }
          .rwWindowContent > iframe{
                border-radius:10px;
            }
            .rwWindowContent{
               background: transparent !important;
            }

            .RadGrid .rgClipCells .rgEditRow > td {
                overflow: visible !important;
            }
            </style>
            <script type="text/javascript">
                var forceMoreMenuToClose = true;

                $(document).ready(function () {
                    $('body').click(function (e) {
                        var q = e.target;
                        var s = $(q);
                        var targetid = e.target.id;
                        if (targetid.indexOf('_txtSubtaskName') == -1 && $('[id$=txtSubtaskName]').length > 0) {
                            eval($('[id$=btnCancel]')[0].href.split(":")[1]);
                        }
                        if (s.parents('[id$=tblAttachments]').length == 0 && targetid.indexOf('tblAttachments') == -1 && s.parents('[id$=tblAttachmentsimg]').length == 0 && targetid.indexOf('tblAttachmentsimg') == -1) {
                            var attachment = $('.attachment');
                            if (!attachment.hasClass('Hide'))
                                attachment.addClass('Hide')
                        }
                    })
                })

                function OpenInNewTab(Url) {
                    window.open(Url, "_blank");
                }

                function querySt(ji) {
                    hu = window.location.search.substring(1);
                    gy = hu.split("&");
                    for (i = 0; i < gy.length; i++) {
                        ft = gy[i].split("=");
                        if (ft[0] == ji) {
                            return ft[1];
                        }
                    }
                }

                function ToggleSubtasksSection() {
                    eval($('[id$=btnAdd]')[0].href.split(":")[1]);
                    return false;
                }

                function FocusTxtName() {
                    setTimeout(function () {
                        $('[id$=txtSubtaskName]').focus()
                    }, 800);

                    $('[id$=txtSubtaskName]').keypress(function (e) {
                        if (e.key === 'Enter') {
                            eval($('[id$=btnSave]')[0].href.split(":")[1]);
                            return false;
                        }
                    });

                }

                function hoverRow() {
                    $(".RadGrid table tr.rgRow").hover(function () {
                        $(this).addClass("rgSelectedRow");
                    }, function () {
                        $(this).removeClass("rgSelectedRow");
                    });
                    $(".RadGrid table tr.rgAltRow").hover(function () {
                        $(this).addClass("rgSelectedRow");
                    }, function () {
                        $(this).removeClass("rgSelectedRow");
                    });
                }


                function OpenActivityBoardCopyTaskPopup() {
                    var wnd = window.radopen('ActivityBoardCopyTaskPopup.aspx?TaskId=' + querySt("taskId"));
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(448, 500);
                    wnd.center();
                    return false;
                }


                function OpenActivityBoardMoveTaskPopup() {
                    var wnd = window.radopen('ActivityBoardMoveTaskPopup.aspx?TaskId=' + querySt("taskId"));
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(448, 500);
                    wnd.center();
                    return false;
                }

                function OpenActivityBoardFlagsPopup() {
                    var wnd = window.radopen('ActivityBoardFlagsPopup.aspx');
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(464, 544);
                    wnd.center();
                    return false;
                }

                function OpenAssignUserToTaskPopup(taskId) {
                    var wnd = window.radopen('AssignUserToTaskPopup.aspx?taskId=' + taskId);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(448, 500);
                    wnd.center();
                    wnd.add_close(CloseAssignUserToTaskPopup);
                    return false;
                }

                function CloseAssignUserToTaskPopup() {
                    eval($('[id$=btnRefresh]')[0].href.split(":")[1]);
                }

                function OpenCommentsPopup() {
                    var RecordId = '<%=PM.ActivityBoardTaskInfo.Id%>';
                    var RecordType = '<%=PM.ActivityBoardTaskInfo.ObjectType%>';
                    var wnd = window.radopen('CommentDialogPopup.aspx?RecordId=' + RecordId + '&RecordType=' + RecordType, true);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(464, 512);
                    wnd.center();
                    wnd.add_close(CloseCommentsPopup);
                    return false;
                }

                function CloseCommentsPopup() {
                    eval($('[id$=btnRefreshComments]')[0].href.split(":")[1]);
                }


                function OpenCommentEditorPopup(URL, Width, Height) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen(URL);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    wnd.setSize(464, 512);
                    wnd.Center();
                    wnd.add_close(CloseCommentsPopup);
                    return false;
                }

                function OpenFolderManagerPopup() {
                    EntityId = '1_' + '<%=PM.ActivityBoardInfo.ProjectId %>'
                    var DocId='<%=PM.ActivityBoardTaskInfo.Id %>'
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('FilesLookup.aspx?EntityId=' + EntityId + '&Source=ACTIVITYBOARDS_TASKS&MultiSelect=1&DocId='+DocId);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    wnd.add_close(RefreshAttachmentSection);
                }

                function OpenAttachmentsLinkUrlPopup(Width, Height) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('AttachmentsLinkUrlPopup.aspx');
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    if (browserWidth < 700) {
                        wnd.setSize(browserWidth - 10, Height);
                    }
                    else {
                        wnd.setSize(650, Height);
                    }
                    wnd.Center();
                    wnd.add_close(RefreshAttachmentSection);
                    return false;
                }

                function OpenYourComputer() {
                    $("#FileToUpload").click();
                    return false;
                }

                function UploadFile() {
                    $('[id$=btnUploadFile]')[0].click();
                    return false;
                }

                function RefreshAttachmentSection() {
                    $('[id$=btnRefreshAttachments]')[0].click();
                }

                function showAttachmentMenu() {
                    var attachment = $('.attachment');
                    attachment[0].className = attachment[0].className.replace(' Hide', '')
                    return false;
                }

                function OpenPMWebRecordPopup() {
                    var RecordId = '<%=PM.ActivityBoardTaskInfo.Id%>';
                    var RecordType = '<%=PM.ActivityBoardTaskInfo.ObjectType%>';
                    var ProjectId = '<%=PM.ActivityBoardInfo.ProjectId%>';

                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('GlobalLinkedRecords.aspx?Id=' + RecordId + '&ProjectId=' + ProjectId + '&Source=' + RecordType);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    wnd.add_close(RefreshAttachmentSection);
                }
                function OpenNoteDetailPopupNewStyle(txtNoteId, Source) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&Source=' + Source);
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    return false;
                }

                function GoToSubtask(sender, eventArgs) {
                    var taskId = eventArgs.getDataKeyValue("Id");
                    window.location = 'ActivityBoardTasksPopup.aspx?taskId=' + taskId
                    return false;
                }

                function OpenFileLink(URL, FileOption) {
                    switch (FileOption) {
                        case "URL":
                            return OpenPOPUp(URL, 920, 415, false);
                        case "LinkToPMWebRecord":
                            window.parent.location.href = URL;
                        case "FILEMANAGER":
                            window.parent.location.href = URL;
                    }
                    return false;
                }

                function OpenActivityBoardLink(ActivityBoardId) {
                    window.parent.location.href = "ActivityBoards.aspx?Id=" + ActivityBoardId + "&ModuleId=8&PageId=365";
                    return false;
                }

                function OpenSubtaskRadDatePicker(sender, e, atRight) {
                    var datePickerId = sender.id.replace("lblDueDate", "RadDatePickerDue");
                    var datePicker = $find($("[id$=" + datePickerId + "]")[0].id);
                    currentDatePicker = datePicker;
                    if (datePicker.isPopupVisible()) {
                        datePicker.hidePopup();
                    };
                    var position = { x: $(sender).offset().left, y: $(sender).offset().top - 20 };
                    datePicker.showPopup((!atRight) ? position.x + sender.offsetWidth - 220 : position.x, position.y + sender.offsetHeight + 20);
                    e.preventDefault();
                    return false;
                }
                
                //function ABRequestStart(sender, args) {
                //    if (args.EventTarget) {
                //        if (args.EventTarget.indexOf("mainToolBar") >= 0) {
                //            args.EnableAjax = false;
                //            return;
                //        }
                //    }
                //}

                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                        sender.close(true);
                        openDivByCommandName(args.get_item().get_value());
                    }
                }

                function maintoolbarClick(sender, args) {
                    var value = args.get_item().get_commandName();
                    openDivByCommandName(value);
                }

                function openDivByCommandName(value) {

                    switch (value) {
                        case 'AddSubtask':
                            ToggleSubtasksSection();
                            break;
                        case 'AddComment':
                            OpenCommentsPopup();
                            break;
                        case 'YourComputer':
                            OpenYourComputer();
                            break;
                        case 'DocumentManager':
                            OpenFolderManagerPopup();
                            break;
                        case 'PMWebRecord':
                            OpenPMWebRecordPopup();
                            break;
                        case 'WebURL':
                            OpenAttachmentsLinkUrlPopup(500, 185);
                            break;
                        case 'Flag':
                            OpenActivityBoardFlagsPopup();
                            break;
                        case "CopyTask":
                            OpenActivityBoardCopyTaskPopup();
                            break;
                        case "MoveTask":
                            OpenActivityBoardMoveTaskPopup();
                            break;
                        case "DeleteTask":
                            var x = ConfirmDelete();
                            if (x) {
                                eval($('[id$=btnDeleteTask]')[0].href.split(":")[1]);
                            }
                            break;
                        default:
                            //                        eventArgs.set_cancel(false);
                            break;
                    }

                }

                function MoreMenuOpening(sender, args) {
                    if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                }

                function MoreMenuClosing(sender, args) {
                    if (forceMoreMenuToClose) {
                        //forceradmenuToClose = false;
                        return;
                    }
                    args.set_cancel(true);
                }


                function unbindDropEvent() {
                    var dropZone = document.querySelector('.Js-DropZone');
                    if (!dropZone) return;
                    dropZone.removeEventListener('drop', DropEvent);
                }

                function appendDropEvent() {
                    unbindDropEvent();
                    var dropZone = document.querySelector('.Js-DropZone');
                    if (!dropZone) return;
                    dropZone.addEventListener('dragover', function (event) {
                        event.stopPropagation();
                        event.preventDefault();
                        // Style the drag-and-drop as "copy file" operation
                        event.dataTransfer.dropEffect = 'copy';
                    })
                    dropZone.addEventListener('drop', DropEvent);
                }

                async function DropEvent(event){
                    let queue = [];
                    let folders = [];
                    let files = [];
                    let filesList = [];
                    let lst = new DataTransfer();
                    var myFileList;
                    var empty = 0;

                    const addFile = entry => {
                        return new Promise(function(resolve,reject){
                            entry.file(function(el){resolve(filesList.push(el))})
                        })
                    }

                    const scanFiles =  (item) => {
                        return new Promise(async function(resolve,reject) {
                            if(item.isDirectory){
                                folders.push(item);
                                await checkIfEmpty(item);
                                if(empty == 1)
                                    resolve(1);
                                else{
                                    await readDirectoryEntry(item);
                                    let directoryReader = item.createReader();
                                    directoryReader.readEntries(function(entries){
                                        entries.forEach(function(entry,index){
                                            if(index == entries.length - 1)
                                                resolve(1);
                                        })
                        
                                    })
                                }
                            }
                        });
                    }
         

                    function readDirectoryEntry(item)
                    {
                        return new Promise((resolve,reject) => {
                            let directoryReader = item.createReader();
                            directoryReader.readEntries(async function(entries){
                        
                                await entries.forEach(async function(entry,index){
                                    if(entry.isDirectory)
                                    {     await scanFiles(entry);
                                        if(index == entries.length - 1)
                                            resolve(1);}
                                    else
                                    {
                                        files.push(entry);
                                        await addFile(entry);
                                        if(index == entries.length - 1)
                                            resolve(1);
                                    }
                                })
                       
                
                    })
            })
                    }
        
                    const checkIfEmpty = entry =>{
                        return new Promise((resolve,reject) =>{
                            let directoryReader = entry.createReader();
                            directoryReader.readEntries(function(entries){
                                if(entries.length == 0)
                                    resolve(empty = 1);
                                else
                                    resolve(empty = 0);
                            })
                        })
                
                    }
                    event.stopPropagation();
                    event.preventDefault();
                    for(const it of event.dataTransfer.items){
                        var entry = it.webkitGetAsEntry();
                        if (entry.isDirectory)
                        { 
                            queue.push(scanFiles(entry).then());
                        }
                        else
                        {
                            files.push(entry);
                            queue.push(addFile(entry).then());
                        }  
                    }
                    await Promise.all(queue);
                    
                    for(var i=0;i<filesList.length;i++)
                    {
                        lst.items.add(filesList[i]);

                    }
                    var rauFiles = document.querySelector(".inputFile");
                    rauFiles.files = lst.files;
                    if(files.length>  0 || folders.length > 0)
                    {
                        var btn = document.querySelector(".btnUpload");
                        btn.click();
                    }

                }

            </script>
        </telerik:radcodeblock>

<body style="display: inline-block; height: 100%; width: 100%;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:radajaxmanager id="PMAjaxManager" runat="server">
            
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgSubtasks">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                        <telerik:AjaxUpdatedControl ControlID="tblSubtasksimg" />
                        <telerik:AjaxUpdatedControl ControlID="rdgSubtasks" />
                        <telerik:AjaxUpdatedControl ControlID="lblSubtasks" />  
                        <telerik:AjaxUpdatedControl ControlID="rptSubtasks" />                           
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="tblSubtasksimg">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                        <telerik:AjaxUpdatedControl ControlID="tblSubtasksimg" />
                        <telerik:AjaxUpdatedControl ControlID="rdgSubtasks" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="dtpDate">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="dtpDate" />
                    </UpdatedControls>
                </telerik:AjaxSetting>    
                <telerik:AjaxSetting AjaxControlID="btnRefreshAttachments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnRefreshAttachments" />
                        <telerik:AjaxUpdatedControl ControlID="Attachments" />
                        <telerik:AjaxUpdatedControl ControlID="lblAttachments" /> 
                    </UpdatedControls>
                </telerik:AjaxSetting> 
                <telerik:AjaxSetting AjaxControlID="Attachments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Attachments" />
                        <telerik:AjaxUpdatedControl ControlID="lblAttachments" />                        
                    </UpdatedControls>
                </telerik:AjaxSetting>     
                <telerik:AjaxSetting AjaxControlID="btnRefreshComments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnRefreshComments" />
                        <telerik:AjaxUpdatedControl ControlID="Comments" />
                        <telerik:AjaxUpdatedControl ControlID="lblComments" /> 
                    </UpdatedControls>
                </telerik:AjaxSetting>  
                <telerik:AjaxSetting AjaxControlID="Comments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="Comments" />
                        <telerik:AjaxUpdatedControl ControlID="lblComments" />                        
                    </UpdatedControls>
                </telerik:AjaxSetting>     
            </AjaxSettings>
        </telerik:radajaxmanager>
        <telerik:radwindowmanager id="PMWindowManager" runat="server" visiblestatusbar="False"
            reloadonshow="True" modal="True" keepinscreenbounds="True" behavior="Default"
            iconurl="Images/Global/favicon.ico" initialbehavior="None" left="" style="display: none;"
            top="">
        </telerik:radwindowmanager>
         <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table class="ToolBar LargeToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="middle" class="ToolbarTd">
                    <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="True" cssclass="popup-toolbar" onclientbuttonclicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarGoToParent" CommandName="GoToParentTask">
                            </telerik:RadToolBarButton>
                           
                            <telerik:RadToolBarButton CssClass="lnkButtonBar" PostBack="true" Value="MarkDone" CommandName="MarkDone" Text="Mark Done"  meta:resourcekey="lbtMarkDone"
                                HoveredCssClass="SubmitHover" DisabledCssClass="BorderDisabled" ImageUrl="Images/ToolBar/PMWebW.gif" Width="100px" Height="20px">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton CssClass="lnkButtonBar" PostBack="true" Value="MarkUndone" CommandName="MarkUndone" Text="Done!"  meta:resourcekey="lbtMarkUndone"
                                HoveredCssClass="SubmitHover" DisabledCssClass="BorderDisabled" ImageUrl="Images/ToolBar/PMWebW.gif" Width="100px" Height="20px">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save" AccessKey="s" Style="margin-left: 16px;">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png" runat="server" PostBack="false"
                                CommandName="AddSubtask" Value="AddSubtask" ToolTip="Add Subtask" CausesValidation="false" CssClass="ToolbarAddSubtask">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png" PostBack="false"
                                CommandName="AddComment" Value="AddComment" ToolTip="Add Comment" CausesValidation="false" OuterCssClass="ToolbarAddComment">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Post.png" CommandName="MobileMenu1" Value="MobileMenu1">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" ID="MobileRadmen1" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore menuAttachment">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Your Computer" Value="YourComputer" EnableImageSprite="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Document Manager" Value="DocumentManager" EnableImageSprite="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="PMWeb Record" Value="PMWebRecord" EnableImageSprite="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Web URL" Value="WebURL" EnableImageSprite="true"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton OuterCssClass="ToolbarNumberOfLikes">
                                <ItemTemplate>
                                    <asp:Label ID="lblNumberOfLikes" runat="server" style="font-size: 16px;"></asp:Label>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png"
                                CommandName="LikeTask" Value="LikeTask" ToolTip="Like Task" CausesValidation="false" OuterCssClass="ToolbarLikeTask">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png" PostBack="false"
                                CommandName="Flag" Value="Flag" ToolTip="Flag" CausesValidation="false" OuterCssClass="ToolbarFlag">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Copy Task..." Value="CopyTask" EnableImageSprite="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Move Task..." Value="MoveTask" EnableImageSprite="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Delete Tasks..." Value="DeleteTask" EnableImageSprite="true"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:radtoolbar>
                </td>
                <td></td>
            </tr>
        </table>

        <div class="Js-DropZone" style="height:calc(100vh - 95px) !important;" id="dropZone" runat="server">
            <div class="PMMainPage PMPopupMainPage documentSinglePage TitleToolbarTop">
            <div class="row JustifyContent">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" runat="server" Text="Name*" meta:resourcekey="lblTaskName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxtName" runat="server" ControlToValidate="txtName"
                                    CssClass="Validator" Display="Dynamic" ValidationGroup="Save" ForeColor="" meta:resourcekey="rfvtxtName">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAssignedTo" runat="server" Text="Assigned To" meta:resourcekey="lblAssignedTo"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:radcombobox id="ddlAssignedTo" filter="Contains" markfirstmatch="true" allowcustomtext="true"
                                    runat="server" skin="Default" nowrap="true" enableloadondemand="true" onitemsrequested="ddl_ItemsRequested"
                                    showmoreresultsbox="True" autopostback="false" onclienttextchange="LOD_DropDownTextChange"
                                    enablevirtualscrolling="True" height="300px">
                                </telerik:radcombobox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDue" runat="server" Text="Due" meta:resourcekey="lblDue"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <span runat="server" id="rmd_dtpDate" style="display: block;">
                                    <telerik:raddatepicker id="dtpDate" runat="server" mindate="1901-01-01" maxdate="2100-01-01" autopostback="true">
                                        <DateInput ID="DateInput1" runat="server">
                                        </DateInput>
                                    </telerik:raddatepicker>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left">
                                    <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                </div>
                                <div class="floatRight">
                                    <asp:LinkButton runat="server" ID="imgMemo" OnClientClick="return OpenNoteDetailPopupNewStyle(this.id.replace('imgMemo','txtDescription'), 'ACTIVITYBOARDS')" CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" MaxLength="4000" TextMode="MultiLine" ID="txtDescription" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset style="width: 375px !important; float: left;">
                                    <legend class="legend">
                                        <asp:Label runat="server" ID="lblSubtasks" meta:Resourcekey="lblSubtasks"></asp:Label>
                                    </legend>
                                </fieldset>
                                <div style="margin-top: 4px; float: right;">
                                    <asp:LinkButton src="Images/Workflow/wMinus.png" runat="server" ID="tblSubtasksimg" OnClientClick="return ToggleSubtasksSection(this);">
                                             <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                   <div style="overflow:visible auto;max-height:calc(100vh - 350px)" >
                    <asp:Repeater ID="rptSubtasks" runat="server" Visible="true">
                        <ItemTemplate>                                
                            <div style="padding-left: 7px; border: 1px solid white; height: 39px; border-radius: 4px;" class="UpperDiv">
                                <div style="float: left;">
                                    <div class="UncheckedButton" id="chkDoneStatus1">
                                        <span class="Icon"></span>
                                    </div>

                                    <asp:Label ID="lblSubtaskName1" runat="server" class="subtaskName" style="margin-right: 74px; margin-left: 5px;height: 26px;line-height: 35px;">hello</asp:Label>
                                </div>
                                <div style="float: right; margin-right: 8px; margin-top: 10px;">
                                    <div class="AssignUserButton" id="lbtAssignUser1" style="float: left; margin-right: 3px;">
                                        <span class="Icon"></span>
                                    </div>

                                    <div class="DatePickerNoInput" id="RadDatePickerDue1">
                                        <span class="Icon"></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <telerik:radgrid id="rdgSubtasks" runat="server" height="100%" allowpaging="false" 
                        autogeneratecolumns="False" headerstyle-font-size="8" allowmultirowedit="false" allowmultirowselection="false" showgrouppanel="false" clientsettings-selecting-allowrowselect="true">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id, ParentId" CommandItemDisplay="top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="false" EditMode="InPlace" ShowHeader="false">
                            <Columns>
                                <telerik:GridTemplateColumn UniqueName="LineNumber" Visible="false"
                                    Groupable="false" Reorderable="true" AllowFiltering="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("LineNumber").ToString%>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="20px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false" UniqueName="DoneStatus" Groupable="False" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="chkDoneStatus" runat="server" CssClass="UncheckedButton" OnClick="UpdateSubtasksDoneStatus">
                                             <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="24px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" UniqueName="Name" Groupable="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubtaskName" runat="server" class="subtaskName"><%#Container.DataItem("Name").ToString%></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSubtaskName" runat="server" Width="240px" AutoPostBack="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSubtaskName" runat="server" ControlToValidate="txtSubtaskName" ValidationGroup="SubtaskSave"
                                            CssClass="Validator" meta:resourcekey="rfvtxtName" ErrorMessage="Required" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="true"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" UniqueName="AssignToDue" Groupable="False">
                                    <ItemTemplate>

                                        <div>
                                            <div id="divInitials" runat="server" class="initialsBox"
                                                visible="false">
                                                <asp:LinkButton runat="server" ID="lbtInitials" Style="text-decoration: solid;"></asp:LinkButton>
                                            </div>

                                            <asp:ImageButton ID="imgUser" runat="server" Height="30px" Width="30px" Visible="false" Style="border-radius: 50%;" />

                                            <asp:LinkButton CssClass="AssignUserButton" src="Images/Workflow/wMinus.png" Visible="True" runat="server" ID="lbtAssignUser">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>

                                            <asp:LinkButton runat="server" ID="lblDueDate" Visible="false" class="subtaskDate" OnClientClick="OpenSubtaskRadDatePicker(this,event,true);"></asp:LinkButton>
                                            <telerik:RadDatePicker ID="RadDatePickerDue" runat="server" style="display: inline-block;" MinDate="1901-01-01" MaxDate="2100-01-01" AutoPostBack="true"
                                                CssClass="DatePickerNoInput Hide" OnSelectedDateChanged="UpdateSubtasksDueDates">
                                                <DateInput ID="DateInput2" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>


                                        </div>

                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="130px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        SecurityButtonType="ItemMode_Add">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" ValidationGroup="SubtaskSave"
                                        SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                        SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                        SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowRowsDragDrop="true" AllowAutoScrollOnDragDrop="true" AllowDragToGroup="true">
                            <Selecting AllowRowSelect="true" />
                            <ClientEvents OnRowDblClick="GoToSubtask" />
                        </ClientSettings>
                    </telerik:radgrid>
                   </div>
                </div>
                <div class="col-4 col-4-middle">
                    <div>
                        <fieldset style="width: 375px !important; float: left;">
                            <legend class="legend">
                                <asp:Label runat="server" ID="lblComments" meta:Resourcekey="lblComments"></asp:Label>
                            </legend>
                        </fieldset>
                        <div style="margin-top: 4px; float: right;">
                            <asp:LinkButton CssClass="ShowFieldsetButton" src="Images/Workflow/wMinus.png" runat="server" ID="tblCommentsimg" OnClientClick="return OpenCommentsPopup();">
                                <span class="Icon"></span>
                            </asp:LinkButton>
                        </div>
                        <div style="clear: both;"></div>
                    </div>
                    <uc1:Comments ID="Comments" runat="server" />
                </div>
                <div class="col-4 col-4-right">
                    <div style="min-height: 150px;">
                        <div>
                            <fieldset style="width: 375px !important; float: left;">
                                <legend class="legend">
                                    <asp:Label runat="server" ID="lblAttachments" meta:Resourcekey="lblAttachments"></asp:Label>
                                </legend>
                            </fieldset>
                            <div style="margin-top: 4px; float: right;">
                                <asp:LinkButton CssClass="ShowFieldsetButton" src="Images/Workflow/wMinus.png" runat="server" ID="tblAttachmentsimg" OnClientClick="return showAttachmentMenu(); return false;">
                                                     <span class="Icon"></span>
                                </asp:LinkButton>
                                <div class="attachment Hide" style="position: absolute; background-color: white; border: 1px solid gray; left: 290px; z-index: 999; margin-top: 10px;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtYourComputer" runat="server" Text="Your Computer" OnClientClick="OpenYourComputer(); return false;"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtDocumentManager" runat="server" Text="Document Manager" OnClientClick="OpenFolderManagerPopup(); return false;"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtPMWebRecord" runat="server" Text="PMWeb Record" OnClientClick="OpenPMWebRecordPopup(); return false;"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtWebURL" runat="server" Text="Web URL" OnClientClick="OpenAttachmentsLinkUrlPopup(500, 185); return false;"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <asp:Button ID="btnRefreshAttachments" runat="server" CssClass="Hide"></asp:Button>
                        <uc2:Attachments ID="Attachments" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        </div>

        <asp:FileUpload ID="FileToUpload" runat="server" Width="180px" onchange="UploadFile();" CssClass="Hide inputFile" />
        <asp:LinkButton ID="btnRefreshComments" runat="server" CssClass="Hide"></asp:LinkButton>
        <asp:LinkButton ID="btnDeleteTask" runat="server" CssClass="Hide"></asp:LinkButton>
        <asp:Button ID="btnUploadFile" runat="server" CssClass="Hide btnUpload"></asp:Button>



    </form>
</body>
</html>
