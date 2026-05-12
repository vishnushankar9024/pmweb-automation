//$(document).ready(function(){
//    SetFolderManagerEvents();
//    appendDropEvent();
//})

var arrRootSelected = {};
var arrSelected = [];
var lastCharPressed = 0;

function OpenBlubeamMarkup(url) {
    window.location = url;
    return false;
}
 
function GoToPmwebRecord(id){
    window.location = 'PMWebRecord.aspx?Id=' + id;
    return false;
}

function RedirectToFolder(id){
    window.location = 'FolderManager.aspx?FolderId=' + id;
    return false;
}

function SetFolderManagerEvents() {
    document.activeElement.blur(); // quick fix for chrome because it's loosing focus.
    $(document).on('keydown',function (event) {
        if (event.which == "17") // cntrl
            lastCharPressed = 17;
        else if (event.which == "16") // shift
            lastCharPressed = 16
        else // reset
            lastCharPressed = 0
    })
    $(document).on('keyup',function (event) {
        lastCharPressed = 0; // reset
    })

    $("[id$=txtManagerSearch]").unbind('keyup');
    $("[id$=txtManagerSearch]").on('keyup', function (e) {
        if (e.keyCode == 13) {
            $("[id$=btnSearch]")[0].click();
        }
    })

    //to add a variable margin because of the variable height of the mobile breadcrumb
    //if ($("[id$=pnlFolder]")[0] && isMobileScreen()){
    //    $("[id$=pnlFolder]")[0].addEventListener('loaded', setpnlMargin());}
    var openMenu = false;
    var pressTimer;
    if ($("[id$=rdgFiles]")[0]){
        $("[id$=rdgFiles]")[0].addEventListener("touchend",function(e){
            clearTimeout(pressTimer);
            if(openMenu == true)
            {
                setTimeout(function(){
                    if(isMobileScreen()) {
                        openFileActionContextMenu();
                    }
                }, 100);
            }
                
            openMenu = false;
            
        })
        $("[id$=rdgFiles_GridData]")[0].addEventListener("scroll",function(e){
            clearTimeout(pressTimer);
            openMenu = false
        })
        $("[id$=rdgFiles]")[0].addEventListener("touchstart",function(e){
            pressTimer = setTimeout(function(){
                if(isMobileScreen()) {
                    openMenu = true;
                }
            }
                , 800);})}
}

function setpnlMargin(){
    var height = $("[id$=mobileToolbar]")[0].offsetHeight;
    $("[id$=pnlFolder]")[0].style.marginTop = height + "px";
}

function DefineSubscriptionClosed() {  // check this
    var btnRefreshSubscriptionTree = $("[id$=btnRefreshSubscriptionTree]");
    btnRefreshSubscriptionTree.click();
}

function GoToFolder() {
    var btngoToFolder = $("[id$=btnGoToFolder]");
    btngoToFolder.click();
}

function AllowVersioning() {
    return $("[id$=hdnAllowVersioning]").val().toLowerCase() == 'true';
}

function LookupFile_RowDblClick_SelectFile(sender, args) {
    var row = $("#" + args.get_id());
    var CanSelectFile = row.find("[id$='lblCanSelect']").html() == "true";
    if (!CanSelectFile) {
        return false;
    }
    var FileId = row.find("[id$='lblFileId']").html();
    var FileName = row.find("[id$='lblFileName']").html();
    var FullFileName = row.find("[id$='lblFullFileName']").html();
    var ObjectId = row.find("[id$='lblObjectId']").html();
    var FileSize = row.find("[id$='hdnFileSize']").val();

    var ctlId = $(window.parent.document).find("input[id$='hdnSelectedElementId']");

    /** PMWeb Viewer **/

    var IsPMWebViewerFile = $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val();

    if (IsPMWebViewerFile === 'true') {
        var BVFileName = $(window.parent.document).find("input[id$=txtHFileName]").val(FileName);
        var BVFileId = $(window.parent.document).find("input[id$=hdnHFileId]").val(FileId);
        var BVFileSize = $(window.parent.document).find("input[id$=hdnHFileSize]").val(FileSize);
        $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val('false');
        window.parent.Save();

        /** PMWeb Viewer **/
    }
    else {
        var attachement_row = $(window.parent.document).find("[id$=pvAttachments]");

        var txtLink = attachement_row.find("[id$=txtFileName]").val(FileName);
        var chkIsInRotator = attachement_row.find("[id$=chkIsInRotator]")
        var ext = FileName.substring(FileName.lastIndexOf('.') + 1, FileName.length);

        $(chkIsInRotator).attr("checked", (ALLOWED_IMAGE_EXTENSION.indexOf(ext) >= 0 || ext == "dwf" || ext == "dwfx"));
        var hdnFileId = attachement_row.find("[id$=hdnFileId]").val(FileId);
        var hdnFileSizeId = attachement_row.find("[id$=FileSize]").val(FileSize);
        /** Email send **/
        $(window.parent.document).find("input[id$=hdnOjectId]").val(ObjectId).change();
        $(window.parent.document).find("input[id$=hdnFM_SelectedFile]").val(FullFileName).change();
        $(window.parent.document).find("input[id$=btnAttachFromFM]").click();
        /** Email send **/
    }
    CloseRadWnd();
} 

function OpenCheckedInPopup(fileId, folderId) {
    var grid = rdgFiles; //$find($("[id$=rdgFiles]")[0].id);
    var row = grid.get_masterTableView().get_selectedItems()[0];
    if (folderId == 0) {
        folderId = row.getDataKeyValue("FolderId");
    }
    var fileGuid = row.findElement("lblFileGuid").innerHTML;
    //    var fileName = row.findElement("hplDownload").innerText;
    var fileName = row.findElement("lblFileName").innerHTML;

    var versionNumber = 1;
    var OriginalVersionFileId = fileId;

    var versionNumber = 1;
    if (row.findElement("lblVersion") && row.findElement("lblOriginalVersionFileId")) {
        versionNumber = row.findElement("lblVersion").innerHTML;
        OriginalVersionFileId = row.findElement("lblOriginalVersionFileId").innerHTML;
    }

    OpenCheckInPOPUp('FolderFileUpload.aspx?FolderID=' +
                                folderId + '&fileId=' +
                                fileId + '&filename=' +
                                fileName + '&fileGuid=' +
                                fileGuid + '&New=CV' +
                                    '&isver=0' +
                                    '&orgVersId=' + OriginalVersionFileId +
                                    '&ver=' + versionNumber, 450, 440, true, 'rdgFiles');
}

function CloseFileslookupPopup() {
    var btnSaveExit = $("[id$=btnSaveExit]");
    btnSaveExit.click();
    return false;
}

function OpenMultipleCompaniesFilePopup(FileIds) {
    return OpenWindowPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Contacts&txtIds=NotExist&ddlType=Multiple&Source=BLUEBEAMMARKUPS&ProjectId=0&ProjectRequired=0&FileIds=' + FileIds + '&FilesSource=FILEMANAGER', 900, 420);
}

function OpenMultipleCompaniesPopup(FileIds) {
    return OpenWindowPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Contacts&txtIds=NotExist&ddlType=Multiple&Source=BLUEBEAMMARKUPS&ProjectId=0&ProjectRequired=0&FileIds=' + FileIds + '&FilesSource=FILEMANAGER', 900, 420);
}

function OpenCheckInPOPUp(URL, Width, Height, senderId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    var divWindow = wnd._popupElement;
    divWindow.classList.add("rwFolderManager");
    if (isMobileScreen()) {
        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
            wnd.setSize(browserWidth, browserHeight);
        else
            wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
        wnd.Center();
    }
    window.isFileNewlyCheckedIn=false;
    //wnd.add_close(function(){
    //    if(window.isFileNewlyCheckedIn)
    //        rebindGrid(true)();
    //    else
    //        rebindGrid(false)();
    //    window.isFileNewlyCheckedIn=false;
    //});
    wnd.add_close(rebindGrid(true));
    return false;
}

function addNewFolder(e, textbox) {
    if (e.keyCode == 13 && textbox.value.trim()) {
        textbox.setAttribute("onkeypress", "");
        textbox.setAttribute("onblur", "");
        __doPostBack('ctl00$CPH1$btnAddNewFolderAndRefresh', textbox.value);
    }
}

function rebindFileGrid() {
    $("[id$=btnRebindGrid]")[0].click()
}

function Download(Id) {
    var btn = $("[id$=btnDownload]")[0];
    var hdnFieldDownload = $("[id$=hdnDownloadId]")[0];
    hdnFieldDownload.value = Id;
    btn.click();
    return false;
}

function uploadFile(event) {
    __doPostBack('ctl00$CPH1$btnUploadFile', "1");
}

function uploadFileCurrentWorkingFolder() {
    __doPostBack('ctl00$CPH1$btnUploadFile', "");
}

function DeleteSelectedFiles() {
    return confirm(Msg_DeleteSelectedFile);
}


/******************************************* Drag And Drop Zone ************************************************************/
var folders =[];
var files =[];
var filesList = [];
var lst = new DataTransfer();
var myFileList;
var empty = 0;
            

function unbindDropEvent()
{
    var dropZone = $('.Js-DropZone')[0];
    if(!dropZone) return;
    dropZone.removeEventListener('dragover', DragOver);
    dropZone.removeEventListener('drop', DropEvent);
}

var queue = [];
async function DropEvent(event) {
    filesList = [];
    console.log("drop");
    event.stopPropagation();
    event.preventDefault();
    for (const it of event.dataTransfer.items) {
        if (it.kind != 'string') {
            var entry = it.webkitGetAsEntry();
            if (entry.isDirectory) {
                queue.push(scanFiles(entry).then());
            }
            else {
                files.push(entry);
                queue.push(addFile(entry).then());
            } 

        } 
    }
    await Promise.all(queue);

    var totalSize = 0;
    for(var i=0;i<filesList.length;i++)
    {
        lst.items.add(filesList[i]);
        totalSize = totalSize + filesList[i].size;
    }
    if (totalSize >= 2147483648) {
        alert("Uploads cannot be more than 2 GB");
        return;
    }
    var inputfile = document.querySelector("#ctl00_CPH1_inputFiles");
    inputfile.files = lst.files;
    var hdnFolders = document.querySelector("#ctl00_CPH1_hdnFoldersToAdd");
    var hdnFiles = document.querySelector("#ctl00_CPH1_hdnFilesToAdd");
    var manageFolder = document.querySelector("#ctl00_CPH1_hfManageFolder").value == "true";
    var canAdd = document.querySelector("#ctl00_CPH1_hfCanAddFiles").value == "true";
    if(folders.length > 0){
        hdnFolders.value = folders[0].fullPath + ";"
        for(var i=1;i<folders.length;i++){
            if(i != folders.length - 1)
                hdnFolders.value += folders[i].fullPath + ";";
            else
                hdnFolders.value += folders[i].fullPath;
        }
        if(!manageFolder)
            console.log("You don't have permission to upload a folder to the current folder."); 
    }
    var fileInCurrentFolder = false;
    if(files.length > 0){
        hdnFiles.value = files[0].fullPath + ";"
        for(var i=1;i<files.length;i++){
            if(i != files.length - 1)
                hdnFiles.value += files[i].fullPath + ";";
            else
                hdnFiles.value += files[i].fullPath;
        }
        files.forEach(el => {
            if(el.fullPath.lastIndexOf("/") == 0)
                fileInCurrentFolder = true;
        });
        if(!canAdd && fileInCurrentFolder )
            console.log("You don't have permission to upload a file to the current folder");
    }
    if((canAdd && fileInCurrentFolder) || (manageFolder && folders.length > 0))
    {
        var btnUploadDrapAndDrop = document.querySelector("#ctl00_CPH1_btnUploadDrapAndDrop");
        btnUploadDrapAndDrop.click();
        return false;
    }
    files = [];
    folders= [];
    hdnFiles.value = "";
    hdnFolders.value
    return false;

}

function DragOver(event) {
    event.stopPropagation();
    event.preventDefault();
    // Style the drag-and-drop as "copy file" operation
    event.dataTransfer.dropEffect = 'copy';
}
function appendDropEvent(){
    unbindDropEvent();
    var dropZone = document.querySelector('.Js-DropZone');
    if(!dropZone) return;
    dropZone.addEventListener('dragover',DragOver )
    dropZone.addEventListener('drop',DropEvent);
}
const addFile = entry => {
    return new Promise(function(resolve,reject){
        entry.file(function(el){resolve(filesList.push(el))})
    })
}

const scanFiles = async (item) => {
    if (item.isDirectory) {
        folders.push(item);
        const isEmpty = await checkIfEmpty(item);
        if (isEmpty) {
            return;
        }

        const entries = await readDirectoryEntry(item);
        for (const entry of entries) {
            await scanFiles(entry);
        }
    }

    else {
        files.push(item);
        await addFile(item);
    }
};

function readDirectoryEntry(item) {
    return new Promise((resolve, reject) => {
        const directoryReader = item.createReader();
        directoryReader.readEntries((entries) => {
            if (entries.length === 0) {
                resolve([]);
            } else {
                resolve(entries);
            }
        }, reject);
    });
}

const checkIfEmpty = entry => {
    return new Promise((resolve, reject) => {
        var directoryReader = entry.createReader();
        directoryReader.readEntries((entries) => {
            resolve(entries.length === 0);
        }, reject);
    });
};

/******************************************* Open Context Menu ************************************************************/

function openContextMenu(evt) {
    var contextMenu = $find($("[id$=RootContextMenu]")[0].id)
    contextMenu.showAt('50', '50');
    $telerik.cancelRawEvent(evt);
}

function openFileActionContextMenu(evt) {
    var contextMenu = $find($("[id$=cmFileActions]")[0].id)
    contextMenu.showAt('50', '50');
    $telerik.cancelRawEvent(evt);
}

function openFolderContextMenu(args) {
    var mainToolBar = $find($("[id$=mainToolBar]")[0].id);
    var contextMenu = $find($("[id$=folderContextMenu]")[0].id)
    var toolbarAdd = mainToolBar.findItemByText('Add');
    contextMenu.showAt(toolbarAdd._element.getBoundingClientRect().x, toolbarAdd._element.getBoundingClientRect().y + 27); /* getBoundingClientRect() used to track the position ofthe add button in the toolbar */ 
    var evt = args.get_domEvent();
    $telerik.cancelRawEvent(evt);
}

function openFolderContextMenuMobile(args) {
    var mainToolBar = $find($("[id$=mainToolBar]")[0].id);
    var contextMenu = $find($("[id$=folderContextMenu]")[0].id)
    var toolbarAdd = mainToolBar.findItemByText('Add');
    contextMenu.showAt('50', '50');
    var evt = args.get_domEvent();
    $telerik.cancelRawEvent(evt);
}

function openSortingContextMenu(args) {
    var contextMenu = $find($("[id$=cmSorting]")[0].id)
    contextMenu.showAt('50', '50');
    var evt = args.get_domEvent();
    $telerik.cancelRawEvent(evt);
}

/******************************************* Refresh Files & Folders ************************************************************/

function rebindGrid(refresh) {
    return function () {
        if (refresh)
            $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
        else
            $("[id$=btnRefreshDetailsPane]")[0].click();


    }
}

function rebindFileGrid() {
    $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
}

function RefreshWithoutDetailsPane() {
    $('[id$=btnRefreshWithoutDetailsPane]')[0].click();
}

/******************************************* CardView Events ************************************************************/


var folderPendingClick = 0;
function onFolderCardViewClick(e) {
    folderPendingClick++;
    var cur = $(this);
    switch (folderPendingClick) {
        case 1:
            folderPendingClickTimer = setTimeout(function () {
                folderPendingClick = 0;
                onCardViewSingleClick(e ,cur);
            }, 300);
            break;
        case 2:
            clearTimeout(folderPendingClickTimer);
            folderPendingClick = 0
            onCardViewDoubleClick(cur);
    }
}

function onCardViewSingleClick(e ,curElement ) {
    if (e && e.target && (e.target.tagName.toLowerCase() === "a")) {
        return;
    }
    var cur = curElement ? curElement : $(this);
    var id = cur.attr('data-Id');
    var isActive = cur.hasClass('active');
    if (cur.attr('isNewFolder'))
        return;
    $("[id$=hdnCardViewSelected]").val() ? arrSelected = $("[id$=hdnCardViewSelected]").val().split(',') : arrSelected = []
    if( e && e.target && e.target.parentElement && (e.target.classList.contains('check') || e.target.parentElement.classList.contains('check'))){
        cur.toggleClass('active');
        !isActive ? arrSelected.push(id) : arrSelected.splice(arrSelected.indexOf(id), 1);
    }
    else
        switch (lastCharPressed) {
            case 0: // others
                var hasMultipleSelection = arrSelected.length > 1;
                arrSelected = [];
                $(".cardView .card , .cardView .folderCard").removeClass('active');
                if (!isActive || (isActive && hasMultipleSelection)) {
                    arrSelected.push(id);
                    cur.addClass('active');
                }
                break;

            case 16: //shift
                $(".cardView .card , .cardView .folderCard").removeClass('active');
                var lastSelected = arrSelected.pop();
                if (lastSelected) {
                    var arr = $(".cardView .card , .cardView .folderCard").map(function () { return $(this).attr('data-id') }).toArray();
                    var lastIndex = arr.indexOf(lastSelected);
                    var currIndex = arr.indexOf(id);
                    if (lastIndex > currIndex) {
                        arrSelected = arr.filter(function (item) { return arr.indexOf(item) >= currIndex && arr.indexOf(item) <= lastIndex });
                        arrSelected.reverse();
                    }
                    else
                        arrSelected = arr.filter(function (item) { return arr.indexOf(item) >= lastIndex && arr.indexOf(item) <= currIndex });
                    arrSelected.forEach(function (curr) {
                        $('[data-id =' + curr + ']').addClass("active");
                    })
                }
                else {
                    arrSelected = [];
                    if (!isActive) {
                        arrSelected.push(id);
                        cur.toggleClass('active');
                    }
                }

                break
            case 17: // cntrl
                var index = arrSelected.indexOf(id);
                cur.toggleClass('active');
                if (index > 0)
                    arrSelected.splice(index);
                else
                    arrSelected.push(id);
                break;

        }

    $("[id$=hdnCardViewSelected]").val(arrSelected);
    var cardview = $("[id$=CardViewContainer]")[0];
    if (!cardview) {
        cur.hasClass('active') ? $("[id$=hdnCardViewSelected]").val(id) : $("[id$=hdnCardViewSelected]").val("");
        if (document.querySelector(".btnBookMarkCardView"))
            document.querySelector(".btnBookMarkCardView").click();
        else
            document.querySelector(".btnSearchCardView").click();
        return;
    }
    __doPostBack('ctl00$CPH1$btnCardClick', lastCharPressed);
    changeVisibilityDeleteDownload();
}

function onCardViewContextMenuClick() {
    event.preventDefault();
    event.stopPropagation();
    var cur = $(this);
    if (cur.attr('isNewFolder')) 
        return;
    var id = cur.attr('data-Id');
    if (arrSelected.length > 1 && arrSelected.indexOf(id) > -1) {
        openFileActionContextMenu(event)
        return;
    }
    arrSelected = [];
    $(".cardView .card , .cardView .folderCard").removeClass('active');
    cur.addClass('active');
    arrSelected.push(id);
    $("[id$=hdnCardViewSelected]").val(arrSelected);
    openFileActionContextMenu(event)
    __doPostBack('ctl00$CPH1$btnCardClick', '');
}

function onCardViewDoubleClick(cur) {
    var id = cur.attr('data-Id');
    if (cur.attr('isNewFolder'))
        return;
    $("[id$=hdnCardViewSelected]").val(id);
    $("[id$=btnCardDoubleClick]").click();
}

function getThumbnailPath(FullFileName, ThumbnailGuid, isPhysical){
    var result;
    var paramJson = JSON.stringify({'FullFileName' :FullFileName  , 'ThumbnailGuid' :ThumbnailGuid });
    $.ajax({
        type: "POST", 
        url: "AjaxService.aspx/GetThumbnailPath",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function(data){
            result = data.d;
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });
    return result;
}
//window.addEventListener('DOMContentLoaded', function(){
//    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
//    if (isCardView)
//        loadCardThumbnails();
//})

function setCardViewEvents() {
    $("[id$=dropZone]").unbind("contextmenu");
    $("[id$=dropZone]").contextmenu(function (e) {
        e.preventDefault();
        e.stopPropagation();
        openFileActionContextMenu(e);
    });
    arrSelected = arrSelected || $("[id$=hdnCardViewSelected]").val().split(',') || [];
    $(".cardView").unbind('click');
    $(".cardView").unbind('contextmenu');
    folderPendingClick = 0;
    $(".cardView").on('click', '.card', onCardViewSingleClick);
    $(".cardView").on('click', '.folderCard', onFolderCardViewClick);
    $(".cardView").on('contextmenu', '.card', onCardViewContextMenuClick)
    $(".cardView").on('contextmenu', '.folderCard', onCardViewContextMenuClick);
    $(".Js-DropZone")[0].addEventListener('scroll',loadCardThumbnails);
    
    $('.js-sort').unbind('change');
    $('.js-sort').on('change', 'input[type="radio"]', function () {
        var selectedSort = '';
        $('.js-sort input[type="radio"]:checked').each(function () {
            selectedSort += $(this).attr("sortingBy") + ",";
        });
        __doPostBack('ctl00$CPH1$btnSorting', selectedSort);
    })
}

function loadCardThumbnails(){
    $.each($('.card'), function() {
        var FolElem = $(".Js-DropZone")[0];
        var card = $(this)[0].children[0];
        var cardimg = card.getElementsByClassName('content')[0].firstElementChild
        if ((card.offsetTop <= (FolElem.scrollTop + 440 + card.clientHeight)) 
            && this.getAttribute('isfolder')=='False' && this.hasAttribute('tguid') 
            && cardimg.src.toLowerCase().includes("css/images/foldermanagericons/defaultthumbnailicon.png") ){
            cardimg.src = getThumbnailPath(this.getAttribute('name'), this.getAttribute('tguid'), this.getAttribute('ph'));
        }
    })
}

function HideDeleteDownload(){
    var mainToolBar = $find($("[id$=mainToolBar]")[0].id);
    var toolbarDelete = mainToolBar.findItemByValue('Delete');
    var toolbarDownload = mainToolBar.findItemByValue('Download');
    var toolbarBluebeam = mainToolBar.findItemByValue('Bluebeam');
    toolbarDownload.set_visible(false);
    toolbarDelete.set_visible(false);
    toolbarBluebeam.set_visible(false);
}

function changeVisibilityDeleteDownload() {
    //to view or hide delete and download toolbar buttons when a card is selected
    isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    try {
        if (!isCardView) {
            var res = $find($("[id$=rdgFiles]")[0].id).get_masterTableView().get_selectedItems();
        } else {
            var res = getSelectedFilesDeletePermissions();
        }
    }
    catch (e) {
        HideDeleteDownload();
        return;
    }
    var isVisible = true;
    var isEligible = true;
    for (var j = 0; j < res.length; j++) {
        var el = res[j];
        if (!isCardView) {
            el.IsFolder = el.getDataKeyValue('IsFolder').toLowerCase() === 'true';
            el.IsEligible = el.getDataKeyValue('IsEligible').toLowerCase() === 'true';
            el.WorkflowStatusId = parseInt(el.getDataKeyValue('WorkflowStatusId'));
            el.CheckedById = parseInt(el.getDataKeyValue('CheckedById'));
            el.CanDelete = el.getDataKeyValue('DeleteFiles').toLowerCase() === 'true';
            el.CheckedIn = el.getDataKeyValue('CheckedIn').toLowerCase() === 'true';
            el.IsFolderManager = el.getDataKeyValue('ManageFolder').toLowerCase() === 'true';
        }

        if (!el.IsFolder) {
            el.IsInWorkflow = el.WorkflowStatusId != 0;
            el.IsCheckedOutByOtherUser = el.CheckedById != CurrentUserId
        }
        if (!el.IsFolder && el.IsEligible) {
            if (el.IsInWorkflow) {
                if (!AllowCreateBlueBeamDuringWorkflow)
                    isEligible = false;
            }
        } else {
            isEligible = false;
        }

        if (CurrentUserId == 5 || el.IsFolderManager)
            continue;

        if (el.IsFolder || (!el.IsFolder && (!el.CanDelete || el.IsInWorkflow || (!el.CheckedIn && el.IsCheckedOutByOtherUser)))) {
            isVisible = false;
            break;
        }
    }
    var hasFolder, hasFile
    for (var k = 0; k < res.length; k++) {
        cur = res[k];
        cur.IsFolder ? hasFolder = true : hasFile = true;
    }

    var mainToolBar = $find($("[id$=mainToolBar]")[0].id);
    var toolbarDelete = mainToolBar.findItemByValue('Delete');
    var toolbarDownload = mainToolBar.findItemByValue('Download');
    var toolbarBluebeam = mainToolBar.findItemByValue('Bluebeam');

    var isBookmark = $("[id$=hdnIsBookmark]").val().toLowerCase() === 'true';
    var isSearch = $("[id$=hdnIsSearch]").val().toLowerCase() === 'true';
    if (toolbarDelete)
        (isVisible && res.length > 0 && !isBookmark && !isSearch) ? toolbarDelete.set_visible(true) : toolbarDelete.set_visible(false)

    if (toolbarDownload)
        (IsMultipleDownload && hasFile && !hasFolder) ? toolbarDownload.set_visible(true) : toolbarDownload.set_visible(false);

    if (toolbarBluebeam)
        (isEligible && res.length > 0) ? toolbarBluebeam.set_visible(true) : toolbarBluebeam.set_visible(false);
}

function removeFolderEditMode(){
    $("[id$=btnRemoveFolderEditMode]")[0].click();
}

function addFolderTempForCardView() {
    if ($(".newFolder")[0])
        return;
    var folder = ` <div style="margin: 0px 16px 16px 0; float: left">
                                   <div class="folderCard" IsFolder="true" isNewFolder="true" >
                                       <div class="mainContent">
                                            <div class="check">
                                                <span class="icon"></span>
                                            </div>
                                            <span class="FolderIcon">
                                                <span class="smallIcon"></span>
                                            </span>
                                            <span class="folderName editable">
                                                <label class="newFolder">
                                                    <input id="txtNewFolderName" onblur="removeFolderEditMode();"  onfocus="this.select();" value="Folder" onkeypress="addNewFolder(event , this)" type="text"/>
                                                </label>
                                            </span>
                                        </div>
                                    </div>
                                </div>`;
    
    $(".preFoldersContainer").prepend(folder);
    if ($(".newFolder input")[0])
        $(".newFolder input")[0].focus();
}


/******************************************* cmFileActions Events ************************************************************/

function FileActionsItemShowing(sender, args) {
    sender.hide();
    var totalNumberOfSelectedFiles,isMultipleSelection , isCardView;
    isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';

    if (isCardView) 
        totalNumberOfSelectedFiles = $('.card.active , .folderCard.active').length;
    else 
        totalNumberOfSelectedFiles = $("[id$=rdgFiles]")[0] ? $find($("[id$=rdgFiles]")[0].id).get_masterTableView().get_selectedItems().length : 0;

    if (totalNumberOfSelectedFiles <= 0) {
        var btnFilePermission = $("[id$=btnFilePermission]")[0]; // To check if in Search or bookmark
        if(btnFilePermission)
            onNoneSelectionFileActions(sender);
        else{
            args.set_cancel(true);
            sender.hide();
        }
        return;
    }

    isMultipleSelection = totalNumberOfSelectedFiles > 1;
    window.DataFromDatabase = getSelectedItemsFromDatabase();
    if(window.DataFromDatabase.length == 0)
    {
        args.set_cancel(true);
        return;
    }
    var menuItems = sender.get_allItems();
    
    if (!isMultipleSelection)
        onSingleSelectionFileActions(menuItems);
    else
        onMultipleSelectionFileActions(menuItems);
}

function FileActionsItemClicking(sender, args) {
    var res = window.DataFromDatabase;
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var menuItem = args.get_item();
    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    var hdnCurrentWorkingFolder = $("[id$=hdnCurrentWorkingFolder]");
    var currentWorkingFolderId = hdnCurrentWorkingFolder.attr("data-Id");
    var currentWorkingFolderName = hdnCurrentWorkingFolder.attr("FolderName");
    var rdgFiles;
    var noSelection = false;
    
    if($("[id$=rdgFiles]")[0])
        rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();

    var cardView = $('.card.active , .folderCard.active');
    if((!isCardView && !rdgFiles ) || (isCardView && cardView.length <= 0 ) || (!isCardView && rdgFiles && rdgFiles.get_selectedItems().length <= 0  ) )
        noSelection = true;

    switch (menuItem.get_value()) {
        case "GoToFolder":
            var hdnFolderId = $("[id$=hdnFolderId]")[0];
            hdnFolderId.value =  res[0].FolderId;
            $("[id$=btnGoToFolder]")[0].click();
            break;      
        case "CheckIn":
            OpenCheckedInPopup(res[0].Id, currentWorkingFolderId, "", res[0].FileGuid, res[0].FileName, res[0].Version, res[0].OriginalVersionFileId);
            break;
        case "Copy":
            var selectedIds, wnd;
            //var isFolder = isFolder ? 1 : 0;
            var isFolder = 1;
            selectedIds =  res.map(function(el){ return el.IsFolder ? "Fo_" + el.Id : "Fi_" + el.Id }).join(';');
            wnd = window.radopen("CopyMoveToDialog.aspx?selectedFiles=" + selectedIds + "&count=" + res.length + "&isFolder=" + isFolder);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(468, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            args.set_cancel(true);
            break;

        case "Subscribe":
            var Id = noSelection ? currentWorkingFolderId : res[0].Id; 
            var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + Id);
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager"); 
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            //if(noSelection)
                wnd.add_close(rebindGrid(true));
            //else
                //wnd.add_close(rebindGrid(false));

            args.set_cancel(true);
            break;

        case "Delete":
            ConfirmDelete() ? args.set_cancel(false) : args.set_cancel(true);
            break;

        case "CopyUrl":
            var wnd = "";
            var id = noSelection ? currentWorkingFolderId : res[0].Id;
            var name = noSelection ? currentWorkingFolderName : res[0].FileName; 
            if ((res && res[0].IsFolder) || noSelection)
                wnd = window.radopen("FileManagerUrl.aspx?FolderId=" + id + "&Name=" +JSEscape(name));
            else
                wnd = window.radopen("FileManagerUrl.aspx?FileId=" + id + "&Name=" +JSEscape( name));

            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, 250);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, 250);
                wnd.Center();
            }
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            args.set_cancel(true);
            break;

        case "Open":
            if (isCardView) 
                $("[id$=btnCardDoubleClick]")[0].click();
            else {
                var selectedItem = rdgFiles.get_selectedItems()[0];
                var lnkImageAction = selectedItem.findElement("imgAction");
                if (lnkImageAction)
                    lnkImageAction.click();
            }
            args.set_cancel(true);
            break;

        case "View":
            if (isCardView){
                var selectedItem = cardView.first();
                ShowImage(selectedItem.find('img').attr('src'));
            }
            else {
                var selectedItem = rdgFiles.get_selectedItems()[0];
                var lnkImageAction = selectedItem.findElement("imgAction");
                if (lnkImageAction)
                    lnkImageAction.click();
            }
            args.set_cancel(true);
            break;

        case "Edit":
            if(noSelection){
                $("[id$=btnFilePermission]")[0].click();
                args.set_cancel(true);
                return;
            }
            var canEditPermissions = res[0].CanEditPermission ? 1 : 0;
            var isFolderManager = res[0].IsFolderManager ? 1 : 0;
            var canRename = res[0].CanRename ? 1 : 0;
            var wnd = window.radopen('FolderManagerEditFolder.aspx?FolderId=' + res[0].Id + '&EditPermissions=' + canEditPermissions + '&ManageFolder=' + isFolderManager + '&CanRename=' + canRename + '&ParentId=' + currentWorkingFolderId);
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.add_close(rebindGrid(false));
            wnd.Center();
            args.set_cancel(true);
            break;

        case "PMWebRecord":
            window.location = 'PMWebRecord.aspx?Id=' + res[0].Id;
            break;

        case "SendToStudio":
            var selectedIds = res.map(function(el){return el.Id}).join(',');
            return OpenMultipleCompaniesFilePopup(selectedIds);
            args.set_cancel(true);
            break;

        case "3DViewer":
            var _3dViewerFunc = res[0].Has3DViewer;
            if (_3dViewerFunc) {
                eval(_3dViewerFunc);
                return false;
            }

        case "GoToBluebeamMarkups":
            var blubeamMarkupUrl = res[0].BlubeamMarkupUrl;
            if (blubeamMarkupUrl) return OpenBlubeamMarkup(blubeamMarkupUrl);
            args.set_cancel(true);
            break;

        case "FromComputer":
            $("[id$=inputFileCurrentWorkingFolder] .ruFileInput")[0].click();
            args.set_cancel(true);
            break;

        case "NewFolder":
            $("[id$=btnAddNewFolder]")[0].click();
            args.set_cancel(true);
            break;
        case "Add":
            return;
    }
    sender.hide();

}

/******************************************* folderContextMenu Events ************************************************************/

function folderContextMenu_OnClientItemClicking(sender, args) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var menuItem = args.get_item();
    switch (menuItem.get_value()) {
        case "FromComputer":
            $("[id$=inputFileCurrentWorkingFolder] .ruFileInput")[0].click();
            args.set_cancel(true);
            break;
        case "NewFolder":
            $("[id$=btnAddNewFolder]")[0].click();
            break;
    }
}


/******************************************* Functions used for cmFileActions ************************************************************/

function onNoneSelectionFileActions(sender) {
    var hdnCurrentWorkingFolder = $("[id$=hdnCurrentWorkingFolder]");
    var id = hdnCurrentWorkingFolder.attr("data-Id");
    var isBookMarked = hdnCurrentWorkingFolder.attr("IsBookMarked") == "True";
    var hasSubscription = hdnCurrentWorkingFolder.attr("HasSubscription") == "True";
    var canEditPermission = hdnCurrentWorkingFolder.attr("CanEditPermission") == "True";
    var isFolderManager = hdnCurrentWorkingFolder.attr("IsFolderManager") == "True";
    var canAdd = hdnCurrentWorkingFolder.attr("CanAdd") == "True";
    var menuItems = sender.get_allItems();
    var item = menuItems[i];
    for (var i = 0; i < menuItems.length; i++) {
        var item = sender.get_allItems()[i];
        switch (item.get_value()) {
            case "Edit":
                item.set_visible(canEditPermission || isFolderManager);
                break;
            case "Bookmark":
                item.set_visible(!isBookMarked);
                break;
            case "UnBookmark":
                item.set_visible(isBookMarked);
                break;
            case "Subscribe":
                item.set_visible(!hasSubscription);
                break;
            case "Unsubscribe":
                item.set_visible(hasSubscription);
                break;
            case "CopyUrl":
                item.set_visible(true);
                break;
            case "Add":
                item.set_visible(canAdd || isFolderManager);
                break;
            case "NewFolder":
                item.set_visible(isFolderManager);
                break;
            case "FromComputer":
                item.set_visible(canAdd);
                break;
            default:
                item.set_visible(false);
        }
    }
}

function editFolderName(id , newName){
    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    if(!isCardView){
        var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();
        var dataItems = rdgFiles.get_dataItems();
        var row = dataItems.find(function(el){
            return el.getDataKeyValue("IsFolder")== "True" && el.getDataKeyValue("Id")== id;
        })
        if(row){
            var cell = rdgFiles.getCellByColumnUniqueName(row , 'FileName');
            cell.innerHTML = newName
        }
    }else{
        var element = $("[data-id='" + "Fo_" + id + "']");
        if(element[0]){
            element.attr('title' , newName);
            element.find('.folderName span')[0].innerHTML = newName;
        }
    }

    $("[id$=btnRefreshDetailsPane]")[0].click();
}

function deleteItems(itemsToDelete , refresh){
    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    var arr = itemsToDelete.split(',');
    if(isCardView){
        for(var i = 0; i< arr.length ; i++){
            $('[data-id='+ arr[i] +']').parent().remove()
        }
    }else{
        if (($("[id$=rdgFiles]")[0])){
            var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();
            var dataItems = rdgFiles.get_dataItems();
            for(var i = 0; i< arr.length ; i++){
                var cur = arr[i].split('_');
                var isFolder =  cur[0] ==  "Fo"? "True" : "False";
                var id = cur[1];
                var row = dataItems.find(function(el){
                    return el.getDataKeyValue("IsFolder")== isFolder && el.getDataKeyValue("Id")== id;
                })
                if(row){
                    var index =  row.get_itemIndex();
                    rdgFiles.get_dataItems()[index].set_selected(false);
                    var el = rdgFiles.get_dataItems()[index].get_element();
                    rdgFiles.hideItem(index);
                    //el.setAttribute("IsDeleted" , true);
                    //rdgFiles.deleteItem(el)
                    //el.remove();
                }
            }
        }
    }
    if(refresh)
        $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
}

function  getSelectedItemsFromDatabase(){
    var result = [];
    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    var folderIds = [] , fileIds = [];
    if (!isCardView){
        var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();
        for (var i = 0; i < rdgFiles.get_selectedItems().length; i++) {
            var row = rdgFiles.get_selectedItems()[i];
            var isFolder = row.getDataKeyValue("IsFolder") == "True";
            var id = row.getDataKeyValue("Id");
            isFolder ? folderIds.push(id) : fileIds.push(id);
        }
    }else{
        $('.card.active , .folderCard.active').each(function () { 
            var cur = $(this);
            var isFolder = cur.attr('IsFolder') == "True";
            var id = cur.attr('data-id');
            id = id.slice(id.indexOf("_") + 1)
            isFolder ? folderIds.push(id) : fileIds.push(id);
        });
    }
    var paramJson = JSON.stringify({'FolderIDs' :folderIds.join(',')  , 'FileIDs' :fileIds.join(',')  });
    $.ajax({
        type: "POST", 
        url: "AjaxService.aspx/GetFilesAndFoldersInfoForContextMenu",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function(data){
            result = data.d;
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });
    return result;
}

function getSelectedFilesDeletePermissions() {
    var result = [];
    var isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    var folderIds = [], fileIds = [];
    if (!isCardView) {
        var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();
        for (var i = 0; i < rdgFiles.get_selectedItems().length; i++) {
            var row = rdgFiles.get_selectedItems()[i];
            var isFolder = row.getDataKeyValue("IsFolder") == "True";
            var id = row.getDataKeyValue("Id");
            isFolder ? folderIds.push(id) : fileIds.push(id);
        }
    } else {
        $('.card.active , .folderCard.active').each(function () {
            var cur = $(this);
            var isFolder = cur.attr('IsFolder') == "True";
            var id = cur.attr('data-id');
            id = id.slice(id.indexOf("_") + 1)
            isFolder ? folderIds.push(id) : fileIds.push(id);
        });
    }
    var paramJson = JSON.stringify({ 'FolderIDs': folderIds.join(','), 'FileIDs': fileIds.join(',') });
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/GetDeletePermissionsFilesAndFolders",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function (data) {
            result = data.d;
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });
    return result;
}

function onMultipleSelectionFileActions(menuItems){
    var res = window.DataFromDatabase;
    var hasFolder, hasFile, hasBookmark = false, hasUnbookmark = false, isAllEligible = true
    res.forEach(function(cur){
        cur.IsFolder ? hasFolder = true : hasFile = true;
        cur.IsBookmarked ? hasBookmark = true : hasUnbookmark = true;
        if(!cur.IsEligible) isAllEligible = false; 
    });    

    for (var i = 0; i < menuItems.length; i++) {
        var item = menuItems[i];
        switch (item.get_value()) {
            case "Download":
                item.set_visible(IsMultipleDownload && hasFile && !hasFolder);
                break;
            case "Bookmark":
                hasBookmark && hasUnbookmark ? item.set_visible(false) : item.set_visible(hasUnbookmark);
                break;

            case "UnBookmark":
                hasBookmark && hasUnbookmark ? item.set_visible(false) : item.set_visible(hasBookmark);
                break;

            case "SendToStudio":
                hasFile && !hasFolder && isAllEligible ? item.set_visible(true) : item.set_visible(false);
                break;

            case "Copy":
            case "Delete":
                var isVisible = true;
                for (var j = 0 ; j < res.length ; j++) {
                    var el = res[j];
                    if(!el.IsFolder){
                        el.IsInWorkflow = el.WorkflowStatusId != 0;
                        el.IsCheckedOutByOtherUser = el.CheckedById != CurrentUserId 
                    }
                    if (CurrentUserId == 5 || el.IsFolderManager)
                        continue;

                    if (el.IsFolder || (!el.IsFolder && (!el.CanDelete || el.IsInWorkflow || (!el.CheckedIn && el.IsCheckedOutByOtherUser)))) {
                        isVisible = false;
                        break;
                    }
                }
                isVisible ? item.set_visible(true) : item.set_visible(false);
                break;

            default:
                item.set_visible(false);
        }
    }
}

function onSingleSelectionFileActions(menuItems) {
    var hdnCurrentWorkingFolder = $("[id$=hdnCurrentWorkingFolder]");
    var isCurrentFolderManager = hdnCurrentWorkingFolder.attr("IsFolderManager") == "True";
    var canCurrentFolderAdd = hdnCurrentWorkingFolder.attr("CanAdd") == "True";
    var res = window.DataFromDatabase[0];
    res.CanCheckOut = (res.IsFolderManager || res.CanEdit || CurrentUserId == 5) && (!res.IsInBluebeamSession);
    if(!res.IsFolder){
        res.IsInWorkflow = res.WorkflowStatusId != 0;
        res.IsCheckedIn = res.CheckedIn == true;
        res.IsCheckedOutByOtherUser = !res.IsCheckedIn && res.CheckedById > 0 &&  res.CheckedById != CurrentUserId ;
    }
    for (var i = 0; i < menuItems.length; i++) {
        var item = menuItems[i];
        item.set_enabled(true);
        switch (item.get_value()) {
            case "GoToFolder":
                item.set_visible(true);
                break;
            case "Open":
                item.set_visible(res.IsFolder);
                break;
            case "Edit":
                item.set_visible(res.IsFolder && (res.CanEditPermission || res.IsFolderManager));
                break;
            case "Subscribe":
                item.set_visible(res.IsFolder && !res.HasSubscription)
                break;
            case "Unsubscribe":
                item.set_visible(res.IsFolder && res.HasSubscription);
                break;
            case "View":
                item.set_visible(!res.IsFolder);
                break;
            case "Add":
                item.set_visible(isCurrentFolderManager || canCurrentFolderAdd);
                break;
            case "NewFolder":
                item.set_visible(isCurrentFolderManager);
                break;
            case "FromComputer":
                item.set_visible(canCurrentFolderAdd);
                break;
            case "Bookmark":
                item.set_visible(!res.IsBookmarked);
                break;
            case "UnBookmark":
                item.set_visible(res.IsBookmarked);
                break;

            case "CopyUrl":
                item.set_visible(true);
                break;

            case "PMWebRecord":
                item.set_visible(!res.IsFolder);
                break;

            case "Download":
                item.set_visible(!res.IsFolder);
                break;

            case "CheckIn":
                if (res.IsFolder) {
                    item.set_visible(false);
                    continue;
                }
                item.set_visible(true)
                item.disable();
                if (!res.IsCheckedIn && ((!res.IsCheckedOutByOtherUser && res.CanEdit) || res.IsFolderManager))
                    item.enable();
                break;

            case "CheckOut":
                //////disable when Selected records contains files in workflow or no record are selected
                ////Or one record is checked out or dont have right or one record at least is not latest

                if (res.IsFolder) {
                    item.set_visible(false);
                    continue;
                }
                item.set_visible(true);
                item.enable();
                if (res.IsInWorkflow || !res.IsCheckedIn || !res.CanCheckOut || !res.IsLastVersion) {
                    item.disable();
                }
                break;

            case "CancelCheckout":
                if (res.IsFolder) {
                    item.set_visible(false);
                    continue;
                }
                item.set_visible(true);
                item.disable();
                if ((CurrentUserId == 5 || res.IsFolderManager) && !res.IsCheckedIn) {
                    item.enable();
                    break;
                }
                if (res.CanEdit && !res.IsCheckedOutByOtherUser && !res.IsCheckedIn)
                    item.enable();
                   
                break;
            case "3DViewer":
                item.set_visible(!res.IsFolder && res.Has3DViewer);
                break;
            case "Copy":
            case "Delete":
                item.set_visible(res.IsFolderManager || CurrentUserId == 5 || (!res.IsFolder &&  res.CanDelete && !res.IsInWorkflow && !res.IsCheckedOutByOtherUser));
                break;
            case "AddPMWebViewer":
                item.set_visible(!res.IsFolder && !res.HasAnnotation && IsPMWebViewerLicenseEnabled && CanAddPMWebViewer && res.CanPreviewPMWebViewer )
                break;
            case "GoToPMWebViewer":
                item.set_visible(!res.IsFolder && res.HasAnnotation && IsPMWebViewerLicenseEnabled)
                break;
            case "SendToStudio":
                item.set_visible(false);
                if (!res.IsFolder && res.IsEligible) {
                    if (res.IsInWorkflow) {
                        if (AllowCreateBlueBeamDuringWorkflow) 
                            item.set_visible(true);
                        else 
                            item.set_visible(false);
                    } else 
                        item.set_visible(true);
                } else 
                    item.set_visible(false);
                
                break;
            case "GoToBluebeamMarkups":
                item.set_visible(!res.IsFolder && res.IsInBluebeamSession)
                break;

        }
    }
}

function IsSelectedRowsInWorkflow(isCardView) {
    if (isCardView) {
        var result = false;
        $('.card.active').each(function () {
            var cur = $(this);
            var docStatusId = cur.attr("WorkflowStatusId");
            var isFolder = cur.attr("IsFolder").toLowerCase();
            if (docStatusId != 0 && isFolder == 'false') {
                return result = true;
            }
        });

        return result;

    } else {
        var grid = $find($("[id$=rdgFiles]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var docStatusId = row.getDataKeyValue("WorkflowStatusId");
            var isFolder = row.getDataKeyValue("IsFolder").toLowerCase();
            if (docStatusId != 0 && isFolder == 'false') {
                return true;
            }
        }
        return false;
    }
}

function IsAllSelectedRowsCheckedOut(isCardView) {
    var count = 0;
    if (isCardView) {
        $('.card.active').each(function () {
            var cur = $(this);
            var checkedIn = cur.attr("CheckedIn");
            if (checkedIn.toLowerCase() == 'false')
                count = count + 1;
        });
        return count == $('.card.active').length;

    } else {
        var grid = $find($("[id$=rdgFiles]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var checkedIn = row.getDataKeyValue("CheckedIn");
            if (checkedIn.toLowerCase() == 'false')
                count = count + 1;
        }
        return count == grid.MasterTableView.get_selectedItems().length;

    }
}

function IsSelectedRowsCheckedOut(isCardView) {
    if (isCardView) {
        var result = false;
        $('.card.active').each(function () {
            var cur = $(this);
            var checkedIn = cur.attr("CheckedIn").toLowerCase();
            var isFolder = cur.attr("IsFolder").toLowerCase();
            if (checkedIn == 'false' && isFolder == 'false') {
                return result = true;
            }
        });
        return result;
    } else {
        var grid = $find($("[id$=rdgFiles]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var checkedIn = row.getDataKeyValue("CheckedIn").toLowerCase();
            var isFolder = row.getDataKeyValue("IsFolder").toLowerCase();
            if (checkedIn == 'false' && isFolder == 'false') {
                return true;
            }
        }
        return false;
    }
}

function IsSelectedRowsCheckedOutByOtherUser(userId, skip, isCardView) {
    if (isCardView) {
        var result = false;
        $('.card.active').each(function () {
            var cur = $(this);
            var checkedOutById = cur.attr("CheckedById");
            var checkedIn = cur.attr("CheckedIn")
            var isFolder = cur.attr("IsFolder").toLowerCase();
            if (checkedIn.toLowerCase() == 'false' && userId != checkedOutById && isFolder == 'false') {
                return result = true;
            }
            if (checkedIn.toLowerCase() == 'true' && !skip && isFolder == 'false') {
                return result = true;
            }
        });
        return result;

    } else {
        var grid = $find($("[id$=rdgFiles]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var checkedOutById = row.getDataKeyValue("CheckedById");
            var checkedIn = row.getDataKeyValue("CheckedIn")
            var isFolder = row.getDataKeyValue("IsFolder").toLowerCase();
            if (checkedIn.toLowerCase() == 'false' && userId != checkedOutById && isFolder == 'false') {
                return true;
            }
            if (checkedIn.toLowerCase() == 'true' && !skip && isFolder == 'false') {
                return true;
            }
        }
        return false;
    }
}

function IsSelectedRowsLastVersion(isCardView) {
    if (isCardView) {
        var result = true;
        $('.card.active').each(function () {
            var cur = $(this);
            var isLastVersion = cur.attr("IsLastVersion")
            var isFolder = cur.attr("IsFolder").toLowerCase();
            if (isLastVersion.toLowerCase() == 'false' && isFolder == 'false') {
                return false;
            }
        });
        return result;
    } else {
        var grid = $find($("[id$=rdgFiles]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var isLastVersion = row.getDataKeyValue("IsLastVersion")
            var isFolder = row.getDataKeyValue("IsFolder").toLowerCase();
            if (isLastVersion.toLowerCase() == 'false' && isFolder == 'false') {
                return false;
            }
        }
        return true;
    }
}

/******************************************* BreadCrumb Functions ************************************************************/
function FillFolder(sender) {
    var folderId = sender.getAttribute("btnId");
    var hdnFolderId = $("[id$=hdnFolderId]")[0];
    hdnFolderId.value = folderId;
    selectNode(folderId);
    $("[id$=btnGoToFolder]")[0].click();
}

function selectNode(folderId) {
    var tree = $find($("[id$=trvFolders]")[0].id);
    if (folderId == "-5") {
        var folderNode = tree.findNodeByValue(58);
    } else {
        var folderNode = tree.findNodeByValue(folderId);
    }
    if (folderNode) {
        folderNode.set_selected(true);
    }
    else {
        var selectedNodes = tree.get_selectedNodes();
        for (var i = 0; i < selectedNodes.length ; i++) {
            selectedNodes[i].set_selected(false);
        }
    }
}

function Breadcrumb_ItemClick(sender,args){
    if (isNaN(args.get_item().get_value())){
        var value = args.get_item().get_value();
        switch (value) {
        }
    }
    else{
        var folderId = args.get_item().get_value();
        var hdnFolderId = $("[id$=hdnFolderId]")[0];
        hdnFolderId.value = folderId;
        $("[id$=btnGoToFolder]")[0].click();}
}

/******************************************* rptFilesCardView Events ************************************************************/

function rptFilesCardView_OnItemDragging(sender, args) {
    var evt = args.get_domEvent();
    var folderContainer = $("[id$=foldersContainer]")[0];
    if ($telerik.isMouseOverElementEx(folderContainer, evt)) {
        var target = evt.srcElement || evt.originalTarget;
        if (target && target.id) {
            if (target.id.indexOf('folderCard') > -1) {
                target.style.background = '#ccc';
                return;
            }
            $(".folderCard").each(function () {
                if ($telerik.isMouseOverElementEx($(this)[0], evt))
                    $(this)[0].style.background = '#ccc';
                else
                    $(this)[0].style.background = 'white';
            });
        }
    } else
        $(".folderCard").css("background", "white");
}

function rptFilesCardView_OnItemDropping(sender, args) {
    var dest = args.get_destinationElement();
    var IsTrvFolders = $(dest).parents().filter("[id$=trvFolders]").length;
    if (dest) {
        if (!dest.classList.contains("folderCard"))
            dest = $(dest).parents(".folderCard")[0];
        if ((!dest || !dest.id || dest.id.indexOf('rptFoldersCardView') < 0) && !IsTrvFolders)
            args.set_cancel(true);
        else {
            var canDrag = true;
            if (IsTrvFolders){
                var folderId = $("input[id$=hdnDropOnFolderId]").val();
                var destNode = $find($("[id$=trvFolders]")[0].id).findNodeByValue(folderId);
                var destCanUploadFiles = destNode.get_attributes().getAttribute("UF").toLowerCase() == "true";
                var destCanUploadFolders = destNode.get_attributes().getAttribute("MF").toLowerCase() == "true";
            }else{
                var destCanUploadFiles = dest.getAttribute("CanUpload") == "True";
                var destCanUploadFolders = dest.getAttribute("IsFolderManager") == "True";
            }
            var hasFile = false;
            var hasFolder = false;
            var reason = [];
            var keyValue = args.get_dataKeyValues();
            var dataIsFolder = keyValue["IsFolder"].toLowerCase() === 'true';
            var id =  keyValue["Id"];
            var dataId = dataIsFolder ? "Fo_" + id : "Fi_" + id ;
            
            if( !$('[data-id =' + dataId  + ']')[0].classList.contains('active')){
                $('[data-id =' + dataId  + ']')[0].classList.add('active');
                var hdnCardViewSelected = $("[id$=hdnCardViewSelected]");
                var CurrValue = hdnCardViewSelected.val() + "," + dataId;
                if (CurrValue.charAt(0) == ',')
                    CurrValue = CurrValue.substring(1);
                hdnCardViewSelected.val(CurrValue);
            }

            var draggedItems = getSelectedItemsFromDatabase();
            if(draggedItems.length > 0){
                for (var i = 0; i < draggedItems.length; i++) {
                    var el = draggedItems[i];
                    if (el.IsFolder && !el.IsFolderManager && CurrentUserId != 5) {
                        hasFolder = true;
                        canDrag = false
                        reason.push("Folder '" + el.FileName + "' can't be moved");
                        continue;
                    }
                    if (!el.IsFolder) {
                        hasFile = true;
                        if (el.IsFolderManager || CurrentUserId != 5) continue;
                        var isInWorkflow = el.WorkflowStatusId != 0;
                        var isCheckedOutByOtherUser = el.CheckedById != CurrentUserId && el.CheckedById > 0 ;
                        if (!el.CanDelete || isInWorkflow || (!el.CheckedIn && isCheckedOutByOtherUser)) {
                            canDrag = false;
                            reason.push("File '" + el.FileName + "' can't be moved");
                        }
                    } else
                        hasFolder = true;
                }
                if (hasFile && !destCanUploadFiles) {
                    canDrag = false;
                    reason.push("Can't drag files to target Folder.");
                }

                if (hasFolder && !destCanUploadFolders) {
                    canDrag = false;
                    reason.push("Can't drag folders to target Folder.");
                }

                if (!canDrag) {
                    args.set_cancel(true);
                    console.log(reason.join(".\n"));
                    return;
                }
                if (!IsTrvFolders){
                    $("[id$=hdnCardViewSelectedForDrop]").val(dest.id)
                    args._destinationElement = dest;
                }
                args.set_cancel(false);
            }
        }
    }
    $(".folderCard").css("background", "none");
}


/******************************************* rptFoldersCardView Events ************************************************************/

function rptFoldersCardView_OnItemDragging(sender, args) {
    var evt = args.get_domEvent();
    var folderContainer = $("[id$=foldersContainer]")[0];
    if ($telerik.isMouseOverElementEx(folderContainer, evt)) {
        var target = evt.srcElement || evt.originalTarget;
        if (target && target.id) {
            var draggedIndex = sender._itemDrag._draggedItemIndex;
            var targetIndex = -1;
            if (target.id.split('_')[3])
                targetIndex = target.id.split('_')[3].substr(4);
            if (draggedIndex == targetIndex) // check if dragover on itself
                return;

            if (target.id.indexOf('folderCard') > -1) {
                target.style.background = '#ccc';
                return;
            }

            $(".folderCard").each(function () {
                if ($telerik.isMouseOverElementEx($(this)[0], evt))
                    $(this)[0].style.background = '#ccc';
                else
                    $(this)[0].style.background = 'white';
            });
        }
    } else {
        $(".folderCard").css("background", "white");
    }

}

function rptFoldersCardView_OnItemDropping(sender, args) {
    var dest = args.get_destinationElement();
    var IsTrvFolders = $(dest).parents().filter("[id$=trvFolders]").length;
    if (dest) {
        if (!dest.classList.contains("folderCard"))
            dest = $(dest).parents(".folderCard")[0];
        if ((!dest || !dest.id || dest.id.indexOf('rptFoldersCardView') < 0) && !IsTrvFolders)
            args.set_cancel(true);
        else {
            var canDrag = true;
            if (IsTrvFolders){
                var folderId = $("input[id$=hdnDropOnFolderId]").val();
                var destNode = $find($("[id$=trvFolders]")[0].id).findNodeByValue(folderId);
                var destCanUploadFiles = destNode.get_attributes().getAttribute("UF").toLowerCase() == "true";
                var destCanUploadFolders = destNode.get_attributes().getAttribute("MF").toLowerCase() == "true";
            }else{
                var destCanUploadFiles = dest.getAttribute("CanUpload") == "True";
                var destCanUploadFolders = dest.getAttribute("IsFolderManager") == "True";
            }
            var hasFile = false;
            var hasFolder = false;
            var reason = [];
            var keyValue = args.get_dataKeyValues();
            var dataIsFolder = keyValue["IsFolder"].toLowerCase() === 'true';
            var id =  keyValue["Id"];
            var dataId = dataIsFolder ? "Fo_" + id : "Fi_" + id ;
            
            if( !$('[data-id =' + dataId  + ']')[0].classList.contains('active')){
                $('[data-id =' + dataId  + ']')[0].classList.add('active');
                var hdnCardViewSelected = $("[id$=hdnCardViewSelected]");
                var CurrValue = hdnCardViewSelected.val() + "," + dataId;
                if (CurrValue.charAt(0) == ',')
                    CurrValue = CurrValue.substring(1);
                hdnCardViewSelected.val(CurrValue)
            }

            var draggedItems = getSelectedItemsFromDatabase();
            if(draggedItems.length > 0){
                for (var i = 0; i < draggedItems.length; i++) {
                    var el = draggedItems[i];
                    if (el.IsFolder && !el.IsFolderManager && CurrentUserId != 5) {
                        hasFolder = true;
                        canDrag = false
                        reason.push("Folder '" + el.FileName + "' can't be moved");
                        continue;
                    }
                    if (!el.IsFolder) {
                        hasFile = true;
                        if (el.IsFolderManager || CurrentUserId != 5) continue;
                        var isInWorkflow = el.WorkflowStatusId != 0;
                        var isCheckedOutByOtherUser = el.CheckedById != CurrentUserId && el.CheckedById > 0 ;
                        if (!el.CanDelete || isInWorkflow || (!el.CheckedIn && isCheckedOutByOtherUser)) {
                            canDrag = false;
                            reason.push("File '" + el.FileName + "' can't be moved");
                        }
                    } else
                        hasFolder = true;
                }
                if (hasFile && !destCanUploadFiles) {
                    canDrag = false;
                    reason.push("Can't drag files to target Folder.");
                }

                if (hasFolder && !destCanUploadFolders) {
                    canDrag = false;
                    reason.push("Can't drag folders to target Folder.");
                }

                if (!canDrag) {
                    args.set_cancel(true);
                    console.log(reason.join(".\n"));
                    return;
                }
                if (!IsTrvFolders){
                    $("[id$=hdnCardViewSelectedForDrop]").val(dest.id)
                    args._destinationElement = dest;
                }
                args.set_cancel(false);
            }

        }
    }
    $(".folderCard").css("background", "none");
}


/******************************************* MainToolBar Events ************************************************************/
function mainToolBar_ClientLoad(sender, args){
    changeVisibilityDeleteDownload();
}

function mainToolBar_clicked(sender, args) {
    var value = args.get_item().get_value();
    switch (value) {
        case "Sort":
            openSortingContextMenu(args);
            break;
        case "Add":
            openFolderContextMenu(args)
            break;
        case "Details":
            var detailsPane = $("[id$=DetailsPane]")[0];
            var filesGridPane = $("[id$=filesGridPane]")[0];
            if (window.innerWidth < 843) {
                detailsPane.style.display = "block";
                filesGridPane.style.display = "none";
                return false;
            }
            var isDetailShowing = args.get_item()._element.querySelector("a").classList.contains("Enabled");
            if (isDetailShowing) {
                detailsPane.classList.add("slideRight");
                filesGridPane.classList.remove("noTransition");
                filesGridPane.classList.add("transition");
                filesGridPane.classList.add("gridFullWidth");
                filesGridPane.classList.remove("transition");
                args.get_item()._element.querySelector("a").classList.add("Disabled");
                args.get_item()._element.querySelector("a").classList.remove("Enabled");
            }
            else {
                filesGridPane.classList.remove("noTransition");
                filesGridPane.classList.add("transition");
                //detailsPane.style.display = "block";
                filesGridPane.classList.remove("gridFullWidth");
                setTimeout(function () {
                    filesGridPane.classList.remove("transition");
                    detailsPane.classList.remove("slideRight");
                }, 500);
                args.get_item()._element.querySelector("a").classList.remove("Disabled");
                args.get_item()._element.querySelector("a").classList.add("Enabled");
            }

            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateFileManagerDetailPaneVisibility",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ 'isDetailPaneVisible': !isDetailShowing }),
                dataType: "json",
                async: true,
                error: function (data) {
                    console.log('The action could not be taken, please refresh the page and try again.');
                }
            });
            break;
        case "Bluebeam":
            var res = getSelectedItemsFromDatabase();
            var selectedIds = res.map(function(el){return el.Id}).join(',');
            return OpenMultipleCompaniesFilePopup(selectedIds);
            args.set_cancel(true);
            break;
    }
    return false;
}

function OpenCurrentWorkingFolderEdit(url) {
    var wnd = window.radopen(url);
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
    wnd.add_close(rebindGrid(true));
    wnd.Center();
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    var divWindow = wnd._popupElement;
    divWindow.classList.add("rwFolderManager");
    return false;
}

function OpenSpecialPermissionPopUp() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();

    var wnd = window.radopen('FileManagerSpecialPermissionsPopUp.aspx');
    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager");  
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(700, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}


function openAdvancedSearchPopUp() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();;
    var searchText = document.querySelector(".txtSearch").value;
    var wnd = window.radopen("FolderManagerAdvancedSearch.aspx?searchText=" + searchText);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    var divWindow = wnd._popupElement;
    divWindow.classList.add("rwFolderManager");
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(470, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(showAdvancedSearchResult);
    return false;
}

var isSearch = 0;
function showAdvancedSearchResult() {
    if (isSearch === 1) 
        $("[id$=btnShowSearch]")[0].click();
    
}

function mobileToolbar_Click(sender, args){
    var value = args.get_item().get_value();
    switch (value){
        case "Back":
            var hdnFolderId = $("[id$=hdnFolderId]")[0];
            hdnFolderId.value =  args.get_item().get_attributes().getAttribute("ParentId");
            $("[id$=btnGoToFolder]")[0].click();
            break;
    }
}

function MoreMenu_Clicked(sender, args){
    var value = args.get_item().get_value();
    switch (value) {
        case "FolderSettings":
            $("[id$=btnFilePermission]")[0].click();
            break;
        case "Search": 
            $("[id$=btnAdvancedSearch]")[0].click();
            break;
        case "SwitchView": 
            $("[id$=btnSwitchView]")[0].click();
            break;
        case "ShowLatestVersions": 
            $("[id$=btnShowLatestVersions]")[0].click();
            break;
        //case "Add":
        //    openFolderContextMenuMobile(args);
            //    break;
        case "FromComputer":
            $("[id$=inputFileCurrentWorkingFolder] .ruFileInput")[0].click();
            args.set_cancel(true);
            break;

        case "NewFolder":
            $("[id$=btnAddNewFolder]")[0].click();
            args.set_cancel(true);
            break;
        case "Layouts":
            if ($("[id$=rdmFolderManagerLayouts]")[0]){
                $find($("[id$=rdmFolderManagerLayouts]")[0].id).findItemByValue(-7).click();
            }
            else{
                $find($("[id$=rdmFolderManagerLayoutsRoot]")[0].id).findItemByValue(-7).click();
            }
            break;
        case "Details":
            var detailsPane = $("[id$=DetailsPane]")[0];
            var filesGridPane = $("[id$=filesGridPane]")[0];
            if (window.innerWidth < 843) {
                detailsPane.style.display = "block";
                filesGridPane.style.display = "none";
                
                $("[id$=Splitter]").css("display", "none");
                $(".MobileFixedMenu").css("visibility", "hidden");
                return false;
            }
            var isDetailShowing = args.get_item()._element.querySelector("a").classList.contains("Enabled");
            if (isDetailShowing) {
                detailsPane.classList.add("slideRight");
                filesGridPane.classList.remove("noTransition");
                filesGridPane.classList.add("transition");
                filesGridPane.classList.add("gridFullWidth");
                filesGridPane.classList.remove("transition");
                args.get_item()._element.querySelector("a").classList.add("Disabled");
                args.get_item()._element.querySelector("a").classList.remove("Enabled");
            }
            else {
                filesGridPane.classList.remove("noTransition");
                filesGridPane.classList.add("transition");
                //detailsPane.style.display = "block";
                filesGridPane.classList.remove("gridFullWidth");
                setTimeout(function () {
                    filesGridPane.classList.remove("transition");
                    detailsPane.classList.remove("slideRight");
                }, 500);
                args.get_item()._element.querySelector("a").classList.remove("Disabled");
                args.get_item()._element.querySelector("a").classList.add("Enabled");
            }

            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateFileManagerDetailPaneVisibility",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ 'isDetailPaneVisible': !isDetailShowing }),
                dataType: "json",
                async: true,
                error: function (data) {
                    console.log('The action could not be taken, please refresh the page and try again.');
                }
            });
            break;
    }
}

/*******************************************rdgFiles Events************************************************************/

var folderManagerPendingClick = 0;
var IsDblClick = false;

function rdgFiles_OnRowSelected(sender, eventArgs){
    changeVisibilityDeleteDownload();
};

function rdgFiles_OnRowClick(sender, eventArgs) {
   
        
    if (folderManagerPendingClick) {
        clearTimeout(folderManagerPendingClick);
        folderManagerPendingClick = 0;
    }
    let e = eventArgs.get_domEvent().rawEvent.detail;
    let index = eventArgs.get_itemIndexHierarchical();
    let grid = sender.get_masterTableView();
    var item = eventArgs.get_gridDataItem();
    var commandArgument = item._itemIndex;
    switch (e) {
        case 1:
            folderManagerPendingClick = setTimeout(function () {
            }, 300);
            break;
        case 2:
            grid.clearSelectedItems()
            grid.selectItem(grid.get_dataItems()[index].get_element());
            IsDblClick = true;
            grid.fireCommand("DoubleClick", commandArgument);
    }

};

function rdgFiles_OnRowMouseOver(sender, args) {
    
    $("[id$=hdnMouseOverId]").val(args.getDataKeyValue("Id"));
}

function rdgFiles_OnRowSelecting(sender, args) {
    if($(".newFolderCreatedInListView")[0]){
        document.activeElement.blur()
        args.set_cancel(true);
        return;
    }
    try{
        if (args.get_domEvent().rawEvent.path[1].id.includes("lbtIconViewer") 
                || args.get_domEvent().rawEvent.path[1].id.includes("btnBookmarkFiles")
                || args.get_domEvent().rawEvent.path[1].id.includes("btnSubscribeFiles")
                || args.get_domEvent().rawEvent.path[1].id.includes("btnCheckOut")){
            args.set_cancel(true);
            return;
        }
    }
    catch(e) { };
    var mouseClick = args.get_domEvent().button;
    if (mouseClick && mouseClick == 2) { // uncheck if right click
        args.set_cancel(true);
        return;
    }      
    var target = args.get_domEvent().target;
    var clickEvent = event;
    if (!target && lastCharPressed == 16) { // case shift is pressed for muliple selection
        if (clickEvent && clickEvent.target && clickEvent.target.closest("tr")) {
            if (args.get_id() === clickEvent.target.closest("tr").getAttribute("id"))
                setTimeout(function () {
                    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
                });
        }
        return false;
    }
    var checkBoxId = $('.RadGrid .rgHeader input[type=checkbox]')[0] ? $('.RadGrid .rgHeader input[type=checkbox]')[0].id : "ctl00_CPH1_rdgFiles_ctl00_ctl02_ctl00_SelectSelectCheckBox";
    if(target && target.id == checkBoxId && sender.get_masterTableView().get_dataItems().length != parseInt( args.get_itemIndexHierarchical()) + 1){
        return;
    }
    
    if (target) {
        folderManagerPendingClick = setTimeout(function () {
            if (!IsDblClick) {
                var a = target.closest("a");
                if (a && (a.id.indexOf("imgAction") > -1 || a.id.indexOf("btnBookmarkFiles") > -1 || a.id.indexOf("btnSubscribeFiles") > -1 || a.id.indexOf("lbtIconViewer") > -1 || a.id.indexOf("btnCheckOut") > -1)) {
                    args.get_gridDataItem().set_selected(false);
                    return false;
                }
                if (mouseClick)
                    return false;
                __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
            } else
                IsDblClick = false;
        }, 300);
    }
}

function rdgFiles_OnRowClientDropping(sender, args) {
    var IsTrvFolders = $(args._htmlElement).parents().filter("[id$=trvFolders]").length;
    if (!IsTrvFolders){
        if(!args.get_targetGridDataItem()){
            args.set_cancel(true);
            return false;
        }
        var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();
        var dataItems = rdgFiles.get_dataItems();
        var row = dataItems.find(function(el){
            return el.getDataKeyValue("Id")== $("[id$=hdnMouseOverId]").val();
        })
        if (!row) { return false;}
        var isFolder = row.getDataKeyValue("IsFolder")
        if (isFolder == "False") {
            args.set_cancel(true);
            return false;
        }
        var itemIndex = row.get_itemIndex()
        var draggedItems = args.get_draggedItems();
        if (draggedItems.length == 1) {
            if (draggedItems[0].get_itemIndex() == itemIndex) {
                args.set_cancel(true);
                return false;
            }
        }
        var destCanUploadFiles = row.getDataKeyValue("UploadFiles") == "True";
        var destCanUploadFolders = row.getDataKeyValue("ManageFolder") == "True";
    }
    else{
        var folderId = $("input[id$=hdnDropOnFolderId]").val();
        var destNode = $find($("[id$=trvFolders]")[0].id).findNodeByValue(folderId);
        var destCanUploadFiles = destNode.get_attributes().getAttribute("UF").toLowerCase() == "true";
        var destCanUploadFolders = destNode.get_attributes().getAttribute("MF").toLowerCase() == "true";
    }
    
    var canDrag = true;
    var draggedItems = getSelectedItemsFromDatabase();
    
    var hasFile = false;
    var hasFolder = false;
    var reason = [];
    if (draggedItems.length > 0) {
        for (var i = 0; i < draggedItems.length; i++) {
            var el = draggedItems[i];

            if (el.IsFolder && !el.IsFolderManager && CurrentUserId != 5) {
                hasFolder = true;
                canDrag = false
                reason.push("Folder '" + el.FileName + "' can't be moved");
                continue;
            }

            if (!el.IsFolder) {
                hasFile = true;
                if (el.IsFolderManager || CurrentUserId != 5) continue;
                var isInWorkflow = el.WorkflowStatusId != 0;
                var isCheckedOutByOtherUser = el.CheckedById != CurrentUserId && el.CheckedById > 0 ;
                if (!el.CanDelete || isInWorkflow || (!el.CheckedIn && isCheckedOutByOtherUser)) {
                    canDrag = false;
                    reason.push("File '" + el.FileName + "' can't be moved");
                }
            } else
                hasFolder = true;

        }

        if (hasFile && !destCanUploadFiles) {
            canDrag = false;
            reason.push("Can't drag files to target Folder.");
        }

        if (hasFolder && !destCanUploadFolders) {
            canDrag = false;
            reason.push("Can't drag folders to target Folder.");
        }

        if (!canDrag) {
            args.set_cancel(true);
            console.log(reason.join(".\n"));
            return;
        }
    }
}

function rdgFiles_OnRowDeselecting(sender, args) {
    if (sender.get_selectedItems().length > 1 && args.get_domEvent().button == 2)
        args.set_cancel(true);
}

function rdgFiles_OnRowDeselected(sender, args) {
    var target = args.get_domEvent().target;
    if(!target) return;

   
    var checkBoxId = $('.RadGrid .rgHeader input[type=checkbox]')[0] ? $('.RadGrid .rgHeader input[type=checkbox]')[0].id : "ctl00_CPH1_rdgFiles_ctl00_ctl02_ctl00_SelectSelectCheckBox";
    if(target.id == checkBoxId && sender.get_masterTableView().get_dataItems().length != parseInt( args.get_itemIndexHierarchical()) + 1){
        return;
    }
    var selectCheckBox = target.closest("input");
    if (selectCheckBox) {
        if (selectCheckBox.id.indexOf("SelectCheckBox") > -1) {
            var index = target.id == checkBoxId ? -5 : args.get_itemIndexHierarchical();
            __doPostBack($("[id$=btnListViewRowClick]")[0].name, index);
            changeVisibilityDeleteDownload()
        }
    }
    
}

function rdgFiles_OnRowContextMenu(sender, args) {
    var currentIndex = args.get_itemIndexHierarchical();
    var selectedItemsCount = sender.get_selectedItems().length;
    if (selectedItemsCount > 0) {
        var selectedItems = sender.get_selectedItemsInternal();
        var isExist = selectedItems.find(function (x) {
            return x.itemIndex == currentIndex
        })
        if (isExist) {
            openFileActionContextMenu(event);
            return;
        }
    }
    sender.clearSelectedItems();
    var item = args.get_gridDataItem();
    item.set_selected(true);
    openFileActionContextMenu(event);
    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
   
}

/*******************************************rdgRoot Events************************************************************/

function rdgRoot_OnRowCreated(sender, args) {
    var id = args.getDataKeyValue("Id");
    if (arrRootSelected[id])
        args.get_gridDataItem().set_selected(true);
}

function rdgRoot_OnRowSelected(sender, args) {
    var id = args.getDataKeyValue("Id");
    if (!arrRootSelected[id])
        arrRootSelected[id] = true;
}

function rdgRoot_OnRowDeselected(sender, args) {
    var id = args.getDataKeyValue("Id");
    if (arrRootSelected[id])
        arrRootSelected[id] = null;
}

function rdgRoot_OnRowContextMenu(sender, args) {
    var index = args.get_itemIndexHierarchical();
    sender.get_masterTableView().selectItem(sender.get_masterTableView().get_dataItems()[index].get_element(), true)
    openContextMenu(event);
}

/*******************************************RootContextMenu************************************************************/

function RootContextMenu_OnClientShowing(sender, args) {
    var rdgRoot = $find($("[id$=rdgRoot]")[0].id).get_masterTableView();
    var selectedItemsCount = rdgRoot.get_selectedItems().length;
    if (selectedItemsCount == 0) {
        args.set_cancel(true);
        return;
    }
    var isProjectLevel = sender.get_attributes().getAttribute('IsProjectLevel').toLowerCase() == 'true' ? true : false;
    var isMultipleSelection = rdgRoot.get_selectedItems().length > 1;

    if (isMultipleSelection)
        openRootMultiSelection(rdgRoot, isProjectLevel, sender, args);
    else
        openRootSingleSelection(rdgRoot, isProjectLevel, sender);
}

function RootContextMenu_OnClientItemClicking(sender, args) {
    var rdgRoot = $find($("[id$=rdgRoot]")[0].id).get_masterTableView();
    var folderId = 0;
    if (rdgRoot.get_selectedItems().length > 0)
        folderId = rdgRoot.get_selectedItems()[0].getDataKeyValue("Id");
    if (folderId)
        folderId = folderId.indexOf('_') > -1 ? folderId.substring(0, folderId.indexOf('_')) : folderId;
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var menuItem = args.get_item();
    switch (menuItem.get_value()) {
        case "CopyFolderUrl":
            var wnd = window.radopen("FileManagerUrl.aspx?FolderId=" + folderId);
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.3);
            wnd.Center();
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            args.set_cancel(true);
            break;
        case "Subscribe":
            var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + folderId);
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");            
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.add_close(refreshRootGrid);
            args.set_cancel(true);
            break;
        case "Edit":
            var isFolderManager, CanEditPermission, canRename, parentId;
            var selectedItem = rdgRoot.get_selectedItems()[0].get_element();
            isFolderManager = selectedItem.getAttribute("IsFolderManager").toLowerCase() === 'true' ? 1 : 0;
            CanEditPermission = selectedItem.getAttribute("CanEditPermission").toLowerCase() === 'true' ? 1 : 0;
            canRename = selectedItem.getAttribute("CanRename").toLowerCase() === 'true' ? 1 : 0;
            parentId = selectedItem.getAttribute("ParentId");
            var wnd = window.radopen('FolderManagerEditFolder.aspx?FolderId=' + folderId + '&EditPermissions=' + CanEditPermission + '&ManageFolder=' + isFolderManager + '&CanRename=' + canRename + '&ParentId=' + parentId)
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.add_close(rebindGrid(true));
            wnd.Center();
            args.set_cancel(true);
            break;
    }
    sender.hide();
}

function refreshRootGrid(){
    $("[id$=btnRefreshRootGrid]")[0].click()
}

function openRootSingleSelection(rdgRoot, isProjectLevel, sender) {
    var el = rdgRoot.get_selectedItems()[0].get_element();
    var hasSubscription = el.getAttribute('hasSubscription') ? true : false;
    var isBookmarked = el.getAttribute("Bookmark") == 'True' ? true : false;
    var isFolderManager = el.getAttribute('IsFolderManager') && el.getAttribute('IsFolderManager').toLowerCase() == 'true';
    var canEditPermission = el.getAttribute('CanEditPermission') && el.getAttribute('CanEditPermission').toLowerCase() == 'true';
    var contextMenuItems = sender.get_allItems();

    for (var i = 0; i < contextMenuItems.length; i++) {
        var item = contextMenuItems[i];
        switch (item.get_value()) {
            case "Open": item.set_enabled(true);
                break;
            case "CopyFolderUrl":
                isProjectLevel ? item.set_visible(true) : item.set_visible(false);
                break;
            case "Subscribe":
                isProjectLevel ? item.set_visible(!hasSubscription) : item.set_visible(false);
                break;
            case "Unsubscribe":
                isProjectLevel ? item.set_visible(hasSubscription) : item.set_visible(false);
                break;
            case "Bookmark":
                isProjectLevel ? item.set_visible(!isBookmarked) : item.set_visible(false);
                break;
            case "UnBookmark":
                isProjectLevel ? item.set_visible(isBookmarked) : item.set_visible(false);
                break;
            case "Edit":
                isProjectLevel && (canEditPermission || isFolderManager) ? item.set_visible(true) : item.set_visible(false);
                break;
        }
    }
}

function openRootMultiSelection(rdgRoot, isProjectLevel, sender, args) {
    var selectedItems = rdgRoot.get_selectedItems();
    var contextMenuItems = sender.get_allItems();
    var hasBookmark = false;
    var hasUnbookmark = false;

    selectedItems.forEach(function (selectedItem) {
        var el = selectedItem.get_element();
        el.getAttribute("Bookmark") == 'True' ? hasBookmark = true : hasUnbookmark = true;
    });

    if (hasBookmark && hasUnbookmark){
        args.set_cancel(true);
        sender.hide();
    }
    for (var i = 0; i < contextMenuItems.length; i++) {
        var item = contextMenuItems[i];
        switch (item.get_value()) {
            case "Bookmark":
                isProjectLevel & !hasBookmark && hasUnbookmark ? item.set_visible(true) : item.set_visible(false);
                break;

            case "UnBookmark":
                isProjectLevel & hasBookmark && !hasUnbookmark ? item.set_visible(true) : item.set_visible(false);
                break;
            default:
                item.set_visible(false);
        }
    }
}

/******************************************* White Popup ************************************************************/
function OpenWhitePopUp(url, width, height) {
    var wnd = window.radopen(url);
    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager");
    if (isMobileScreen()) {
        wnd.setSize(width, height);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(width, height);
        wnd.Center();
    }
}

/******************************************* Details Pane Fuctions ************************************************************/

function updateAttributesFromDetailPane(id, isFolder, attributeName, value) {
    var rdgFiles = $find($("[id$=rdgFiles]")[0].id);
    var items = rdgFiles.get_masterTableView().get_dataItems();
    for (var i = 0 ; i < items.length; i++) {
        if (items[i].getDataKeyValue("Id") == id && items[i].getDataKeyValue("IsFolder").toLowerCase() == isFolder.toLowerCase()) {
            items[i].get_element().setAttribute(attributeName, value);
            return;
        }
    }
}

function OpenFileAdd(FolderId, ClearFileTable, AllowVersioning, IsCopyAction, IsMoveAction) {
    var browserWidth = $telerik.$(window.parent).width();
    var browserHeight = $telerik.$(window.parent).height();
    if (GetRadWindowManager()) {
        var wnd = window.parent.radopen('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction, 800, 440, true, 'rdgFiles');
        wnd.set_visibleTitlebar(false);
        wnd._topResizer.parentElement.className = "";
        var divWindow = wnd._popupElement;
        divWindow.classList.add("rwFolderManager");
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(8, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        wnd.add_close(rebindGrid(true));
        return false;
    }
    else{
        setTimeout(function(){
            var wnd = window.parent.radopen('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction, 800, 440, true, 'rdgFiles');
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.add_close(rebindGrid(true));
            return false;
        }, 500)
    }
    
}

function ActivateButton(sender, args) {
    var btn = sender.closest('a');
    btn.classList.toggle('active');
    var FolderId = sender.getAttribute("FolderId");
    var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + FolderId);

    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager"); 
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

function ShowImage(src) {
    if (src == undefined) {
        var Image = $(".imgDisplayDetailsPane")[0];
        src = Image.src;
    }
    $("#flyoutBackdrop ,.RotatorPopup").removeClass("Hide");
    $('#PmMasterFader img').remove();
    $('<img src="' + src + '" style="border-width:0px;max-height:320px;" >').prependTo("#PmMasterFader");
    var flyout = $(".RotatorPopup")[0]
    var flyoutBackdrop = $('#flyoutBackdrop')[0]
    flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
    flyout.className = flyout.className.replace(' Hide', '');
    $('#popupnext').remove();
    $('#popupprev').remove();
    return false;
}

var checkInFromDetailsPane = 0;
function CheckIn(sender, eventArgs) {
    var FolderId = sender.getAttribute("FolderId");
    var FileId = sender.getAttribute("FileId");
    var fileGuid = sender.getAttribute("FileGuid");
    var fileName = sender.getAttribute("FileName");
    var version = sender.getAttribute("Version");
    var originalVersionFileId = sender.getAttribute("OriginalVersionFileId");
    checkInFromDetailsPane = 1;
    if (sender.classList.contains('active')) {
        OpenCheckedInPopup(FileId, FolderId, sender.getAttribute("Id"), fileGuid, fileName, version, originalVersionFileId);
        return false;
    }

}

function OpenCheckedInPopup(fileId, folderId, senderId, fileGuid, fileName, version, originalVersionFileId) {
    var versionNumber = 1;
    var OriginalVersionFileId = fileId;
    var versionNumber = 1;
    if (version != null && originalVersionFileId != null) {
        versionNumber = version;
        OriginalVersionFileId = originalVersionFileId;
    }
    OpenCheckInPOPUp('FolderFileUpload.aspx?FolderID=' +
                                folderId + '&fileId=' +
                                fileId + '&filename=' +
                                fileName + '&fileGuid=' +
                                fileGuid + '&New=CV' +
                                    '&isver=0' +
                                    '&orgVersId=' + OriginalVersionFileId +
                                    '&ver=' + versionNumber + '&senderId=' + senderId + "&IsDetailsPane=" + checkInFromDetailsPane, 450, 440, senderId);

}

function CopyUrl(sender) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var folderId = sender.getAttribute("FolderId");
    var fileId = sender.getAttribute("FileId");
    var fileName =  sender.getAttribute("FileName")
    
    var wnd = window.radopen("FileManagerUrl.aspx?FolderId=" + folderId + "&FileId=" + fileId + "&Name=" + JSEscape(fileName));
    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager"); 
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, 250);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, 250);
        wnd.Center();
    }
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    var divWindow = wnd._popupElement;
    divWindow.classList.add("rwFolderManager");
    return false;
}

function Subscribe(sender) {
    if (!sender.classList.contains("active")) {
        var FolderId = sender.getAttribute("FolderId");
        var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + FolderId);
        var divWindow = wnd._popupElement;
        wnd.set_visibleTitlebar(false);
        wnd._topResizer.parentElement.className = "";
        divWindow.classList.add("rwFolderManager"); 
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        wnd.add_close(rebindGrid(false));
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }
    else {
        return true;
    }
}

function GridSubscribe(sender, FolderId) {
    if (!sender.classList.contains("active")) {
        //var FolderId = sender.getAttribute("FolderId");
        var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + FolderId);
        var divWindow = wnd._popupElement;
        wnd.set_visibleTitlebar(false);
        wnd._topResizer.parentElement.className = "";
        divWindow.classList.add("rwFolderManager"); 
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        if ($("[id$=rdgRoot]")[0]){
            wnd.add_close(refreshRootGrid);
        }else{
            wnd.add_close(rebindGrid(true));
        }
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }
    else {
        var hdnFolderId = $("[id$=hdnFolderId]")[0];
        hdnFolderId.value =  FolderId;
        $("[id$=btnGridUnsubscribe]")[0].click();
    }
}

function ActivateButtonSubscribe() {
    var btnSubscribe = $("[id$=btnSubscribe]")[0]
    if (btnSubscribe) {
        btnSubscribe.classList.add("active");
        btnSubscribe.setAttribute("title", "Unsubscribe");
    }
}

function CloseCommentsPopup() {
    $('[id$=btnRefreshComments]')[0].click();
}

function OpenCommentsPopup(sender) {
    var isFolder = sender.getAttribute('IsFolder').toLowerCase() === 'true';
    var RecordId = sender.getAttribute('RecordId');
    var recordType;
    if (isFolder) {
        recordType = 'FILEMANGER'
    } else {
        recordType = 'FILEMANGER_LOOKUPFILES'
    }
    var wnd = window.radopen('CommentDialogPopup.aspx?RecordId=' + RecordId + '&RecordType=' + recordType, true);
    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager");  
    wnd.setSize(464, 512);
    wnd.center();
    wnd.remove_close(CloseCommentsPopup);
    wnd.add_close(CloseCommentsPopup);
    return false;
}

function OpenCommentEditorPopup(URL, Width, Height) {
                 
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    var divWindow = wnd._popupElement;
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    divWindow.classList.add("rwFolderManager");  
    wnd.setSize(464, 512);
    wnd.Center();
    wnd.add_close(CloseCommentsPopup);
    return false;
}

function OpenEditPopUp(sender) {
    var FolderId = sender.getAttribute("FolderId");
    var ParentId = sender.getAttribute("ParentId");
    var CanRename = sender.getAttribute("CanRename");
    var EditPermissions = sender.getAttribute("EditPermissions");
    var ManageFolder = sender.getAttribute("ManageFolder");
    if (EditPermissions == 0 && ManageFolder == 0) return false;
    var wnd = window.radopen('FolderManagerEditFolder.aspx?FolderId=' + FolderId + '&EditPermissions=' + EditPermissions + '&ManageFolder=' + ManageFolder + '&CanRename=' + CanRename + '&ParentId=' + ParentId)
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
    wnd.Center();
    wnd.set_visibleTitlebar(false);
    wnd.add_close(rebindGrid(false));
    wnd._topResizer.parentElement.className = "";
    var divWindow = wnd._popupElement;
    divWindow.classList.add("rwFolderManager");
    return false;
}

function closeDetailPane() {
    $("[id$=DetailsPane]").css("display", "none");
    $("[id$=filesGridPane]").css("display", "block");
    $("[id$=Splitter]").css("display", "block");
    $(".MobileFixedMenu").css("visibility", "");
}

/******************************************* rauattachment events (Quick Upload)  ************************************************************/

var uploadsDocFileInProgress = 0;

function onDocFileSelected(sender, args) {
    var ldp =  $find("ctl00_ldpPM");
    var filesGridPane = document.querySelector(".filesGridPane");

    if (uploadsDocFileInProgress <= 0) {
        sender.get_element().classList.remove('Hide');
        if (ldp) ldp.show(filesGridPane.id);
    }
    uploadsDocFileInProgress++;
}

function onDocFileUploaded(sender, args) {
    decrementUploadsDocFileInProgress();
    if (uploadsDocFileInProgress <= 0) {
        sender.get_element().classList.add('Hide');
        var ldp =  $find("ctl00_ldpPM");
        var filesGridPane = document.querySelector(".filesGridPane");
        if(ldp) ldp.hide(filesGridPane.id)
        
        setTimeout(function(){
            var btnUpload = document.querySelector('.btnUpload');
            btnUpload.click();
            setTimeout(function () {
                sender.deleteAllFileInputs();
            }, 10);
        }, 100)
    }
}

function onDocFileUploadFailed(sender, args) {
    decrementUploadsDocFileInProgress();
    if (uploadsDocFileInProgress <= 0) {
        sender.get_element().classList.add('Hide');
        var ldp =  $find("ctl00_ldpPM");
        var filesGridPane = document.querySelector(".filesGridPane");
        if(ldp) ldp.hide(filesGridPane.id)
    }
}

function decrementUploadsDocFileInProgress() {
    uploadsDocFileInProgress--;
}

function ClientDocFileValidationFailed(sender, args) {
    decrementUploadsDocFileInProgress();
    alert(WarningMsg_InvalidFile);
}

function OpenRedlining(url) {
    window.location = url;
    return false;
}

/******************************************* Files Attributes Events  ************************************************************/
function DetailCommandClicked(sender, args) {
    switch (args.get_item().get_commandName()) {
        case 'CopyURL':
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();;
            var wnd = window.radopen("FileManagerUrl.aspx");
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager"); 
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, 250);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(448, 250);
                wnd.Center();
            }
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            return false;
            break;
        default:
            break;
    }
}

function MobileMenu_Close(sender, args){
    if ($("[id$=MoreMenu]")[0].id == sender.get_id())
    {
        $find($("[id$=rdmBreadcrumb]")[0].id).close();
    }
    else
    {
        if ($("[id$=rdmBreadcrumb]")[0].id == sender.get_id()){
            $find($("[id$=MoreMenu]")[0].id).close();
        }
    }
    var RootContextMenu = $("[id$=RootContextMenu]")[0];
    var cmFileActions = $("[id$=cmFileActions]")[0];
    if(RootContextMenu){$find(RootContextMenu.id).hide();}
    if(cmFileActions){$find(cmFileActions.id).hide();}
}

function RefreshCurrentFolderWithoutTree(){
    $("[id$=btnRefresh]")[0].click();
}

function OpenCheckInContextMenu(sender, args){
    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
    if (sender.classList.contains('active')){
        var hdnFileIdToCheckInOut = $("[id$=hdnFileIdToCheckInOut]")[0];
        hdnFileIdToCheckInOut.value = sender.getAttribute("FileId");
        var CheckInOutContextMenu = $find($("[id$=CheckInOutContextMenu]")[0].id)
        CheckInOutContextMenu.showAt(event.screenX, event.screenY - 100);
        $telerik.cancelRawEvent(event);
        return false;
    }
}

function CheckInOutContextMenu_ItemClicked(sender, args){
    var hdnCurrentWorkingFolder = $("[id$=hdnCurrentWorkingFolder]");
    var currentWorkingFolderId = hdnCurrentWorkingFolder.attr("data-Id");
    var res = GetFileFromDatabase($("[id$=hdnFileIdToCheckInOut]")[0].value);
    var menuItem = args.get_item();
    switch (menuItem.get_value()) {
        case "CheckIn":
            OpenCheckedInPopup(res[0].Id, currentWorkingFolderId, "", res[0].FileGuid, res[0].FileName, res[0].Version, res[0].OriginalVersionFileId);
            break;
    }
}

function GetFileFromDatabase(FileId){
    var result = [];
    var paramJson = JSON.stringify({'FolderIDs' :''  , 'FileIDs' :FileId  });
    $.ajax({
        type: "POST", 
        url: "AjaxService.aspx/GetFilesAndFoldersInfoForContextMenu",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function(data){
            result = data.d;
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });
    return result;
}

function OnClientCollapsed(sender, ags) {
    $("[id$=Splitter]").addClass("removeLeft");
    //$("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane").addClass("closed");
    $("[id$=hdnTreeCollapsed]").val("True");
    $("[id$=btnTreeStateChanged]")[0].click();
        
}
function OnClientExpanded(sender, ags) {
    $("[id$=Splitter]").removeClass("removeLeft");
    //$("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane").removeClass("closed");
    $("[id$=hdnTreeCollapsed]").val("False");
    $("[id$=btnTreeStateChanged]")[0].click();
}

function onTreeResized(sender, args) {
    $("[id$=hdnTreeWidth]").val(sender.get_width());
    var newWidth = $(".Folder_DocumentManager").width() - 8 - sender.get_width();
    //$("[id$=RadSplitter1]")[0].style.width = $(".Folder_DocumentManager").width() + 'px';
    $find($("[id$=RadContentPane]")[0].id).getContentElement().style.width = newWidth + 'px';
    $("[id$=btnTreeStateChanged]")[0].click();
}

function OpenWorkflowSubmitPopup(ObjectType) {
    OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
}

function OpenGoogleAddressesPicker(fileId) {
    var Id = fileId;
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

function clearDragAndDropHiddenFields() {
    $("[id$=hdnCardViewSelected]").val("");
    $("input[id$=hdnDropOnFolderId]").val("");
    $("input[id$=hdnCardViewSelectedForDrop]").val("");
}