
function trvFolders_OnClientMouseOverHandler(sender, args) {
    var node = args.get_node();
    var nodeId = node.get_value();

    $("input[id$=hdnDropOnFolderId]").val(nodeId);
}

function onClientContextMenuItemClicking(sender, args) {
    var menuItem = args.get_menuItem();
    var treeNode = args.get_node();
    var tree = $find(sender.get_id());
    treeNode.set_selected(true);
    menuItem.get_menu().hide();
    var isGrougSelected = false;
    var nodes = tree.get_selectedNodes();
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var selectedNodeId = nodes[0].get_value()
    var hdnCurrentWorkingFolder = $("[id$=hdnCurrentWorkingFolder]");
    var currentWorkingFolderId = hdnCurrentWorkingFolder.attr("data-Id");
    var currentWorkingFolderName = hdnCurrentWorkingFolder.attr("FolderName");
    var res = window.DataFromDatabase;
    var isCardView = false
    if (!($("[id$=hdnIsCardView]").val() == undefined)) isCardView = $("[id$=hdnIsCardView]").val().toLowerCase() === 'true';
    var rdgFiles;
    var noSelection = false

    if ($("[id$=rdgFiles]")[0])
        rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();

    var cardView = $('.card.active , .folderCard.active');
    //if (selectedNodeId == undefined)
    if ((!isCardView && !rdgFiles) || (isCardView && cardView.length <= 0) || (!isCardView && rdgFiles && rdgFiles.get_selectedItems().length <= 0))
        noSelection = true;
    switch (menuItem.get_value()) {
        case "Delete":
            if (nodes.length > 0) {
                for (var i = 0; i < nodes.length; i++) {
                    var nodeValue = nodes[i].get_value();
                    if (nodeValue.indexOf("_G") > 0) {
                        isGrougSelected = true;
                    }
                }
            }
            var result;
            if (isGrougSelected) {
                result = confirm(Msg_DeleteSelectedFolderWithSubFolders);
            }
            else {
                result = confirm(Msg_DeleteSelectedFolder);
            }
            args.set_cancel(!result);
            break;
        case "Rename":
            treeNode.startEdit();
            break;

        case "CopyFolderUrl":
            var wnd = "";
            //var id = noSelection ? selectedNodeId : res[0].Id;
            //var name = noSelection ? currentWorkingFolderName : res[0].FileName;
            //if ((res && res[0].IsFolder) || noSelection)
            wnd = window.radopen("FileManagerUrl.aspx?FolderId=" + selectedNodeId);
            //else
            //wnd = window.radopen("FileManagerUrl.aspx?FileId=" + id + "&Name=" + JSEscape(name));

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

            //var browserWidth = $telerik.$(window).width();
            //var browserHeight = $telerik.$(window).height();;

            //var wnd = window.radopen("FileManagerUrl.aspx?FolderId=" + treeNode.get_value());

            //wnd.setSize(browserWidth * 0.9, browserHeight * 0.3);
            //wnd.Center();

            ////if (AddClose == true) {
            ////    wnd.add_close(WindowClosed);
            ////    if (gridId) { GridToRebind = gridId; }
            ////}


            //break;

        case "Subscribe":
            var wnd = window.radopen('DefineSubscription.aspx?FolderId=' + selectedNodeId);
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
            wnd.add_close(rebindGrid(true));
            args.set_cancel(true);
            break;

        case "Open":
            var nodeId = treeNode.get_value();
            GoToFolderId(nodeId);
            break;

        case "UploadFile":
            $("[id$=hdnTreeFolderId]")[0].value = selectedNodeId;
            $("[id$=inputFileCurrentWorkingFolderTree] .ruFileInput")[0].click();
            args.set_cancel(true);
            break;

        case "Copy":
            var node = args.get_node();
            var nodeId = treeNode.get_value();
            var nodeText = treeNode.get_text();
            $("[id$=hdnCopiedFolderId]").val(nodeId);
            args.set_cancel(true);
            break;
        case "Paste":
            //            args.set_cancel(true);
            break;

    }
}

function OnClientNodeEditStartHandler(sender, eventArgs) {
    var node = eventArgs.get_node();
    var textInput = node.get_inputElement();
    if (textInput.value.lastIndexOf(" (") >= 0) {
        textInput.value = textInput.value.substring(0, textInput.value.lastIndexOf(" ("));
    }
    textInput.maxLength = 200;
}

function onClientContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    if (args.get_menu()) {
        setMenuItemsState(args.get_menu().get_items(), treeNode);
    }
}

function setMenuItemsState(menuItems, treeNode) {
    var nodes = treeNode;

    //if (nodes.length >= 1) {

        for (var i = 0; i < menuItems.get_count() ; i++) {
            var menuItem = menuItems.getItem(i);
            var selectedNode = nodes;

            switch (menuItem.get_value()) {
                case "Subscribe":
                    if (nodes) {
                        menuItem.set_enabled(!(selectedNode.get_contentCssClass().indexOf("trvSubscribe") >= 0) && !(selectedNode.get_value() < 0));
                    }
                    break;
                case "Rename":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true' &&
                            selectedNode.get_attributes().getAttribute("CR").toLowerCase() == 'true');
                    break;
                case "CopyFolderUrl":
                    menuItem.set_enabled(true);
                    break;
                case "NewFolder":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true');
                    break;
                case "Delete":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true' &&
                            selectedNode.get_attributes().getAttribute("CD").toLowerCase() == 'true');
                    break;
                case "unsubscribe":
                    menuItem.set_enabled(false);
                    menuItem.set_enabled(selectedNode.get_contentCssClass().indexOf("trvSubscribe") >= 0);
                    break;
                case "PasteFiles":

                    menuItem.set_visible(false);
                    menuItem.get_element().style.display = "none"
                    if ((selectedNode.get_attributes().getAttribute("UF").toLowerCase() == 'true' || selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true')
                         && $("[id$=hdnCopiedFileIds]").val() != "") {
                        menuItem.set_visible(true);
                        menuItem.get_element().style.display = ""
                    }
                    break;
                case "Copy":
                    var objectId = selectedNode.get_attributes().getAttribute("OId").toLowerCase();
                    var objectTypeId = selectedNode.get_attributes().getAttribute("OTId").toLowerCase();
                    var level = selectedNode.get_level();

                    var isParentSharedFolder = (objectId == -1 && objectTypeId == -1 && level == 0);
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true' && !isParentSharedFolder);
                    break;
                case "Paste":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true' &&
                                $("[id$=hdnCopiedFolderId]").val() != "");
                    break;
                case "UploadFile":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("UF").toLowerCase() == 'true');
                    break;
                case "EditPermissions":
                    menuItem.set_enabled(selectedNode.get_attributes().getAttribute("EP").toLowerCase() == 'true');
                    break;
                case "EditFolder":
                    menuItem.set_enabled((selectedNode.get_attributes().getAttribute("MF").toLowerCase() == 'true' ||
                                       selectedNode.get_attributes().getAttribute("EP").toLowerCase() == 'true' ||
                                       (selectedNode.get_value() == '-6' && EnablePermissionsByFolderGroups.toLowerCase() == 'true')));
            }
        }
    //}
}



function onResized(sender, ags) {
    mainsplitter = sender;
    var browserWidth = $telerik.$(window).width();
    if (browserWidth < 843)
        sender._panes[1].set_width(browserWidth - 20);
    else {
        var newWidth = $(".Folder_DocumentManager").width() - 8 - sender._panes[0].get_width();
        //$("[id$=RadSplitter1]")[0].style.width = $(".Folder_DocumentManager").width() + 'px';
        sender._panes[1].GetContentElement().style.setProperty('width', newWidth + 'px'); //to let the grid pane take the remaining width
    }
}



function uploadFileCurrentWorkingFolderTree() {
    __doPostBack('ctl00$CPH1$FolderManagerTree$btnUploadFileTree', "");
}

function changeMask() {
    if ($("[id$=btnCancel]")[0].classList.contains("Hide") && !isMobileScreen())
        applyMask();
    else
        removeMask();

}

function applyMask() {
    $("[id$=FolderManager_overlay]")[0].classList.add("active");
    $("[id$=treeGroupsAndItemsPane]")[0].classList.add("trvConfigureFolders");
}

function removeMask() {
    $("[id$=FolderManager_overlay]")[0].classList.remove("active");
    $("[id$=treeGroupsAndItemsPane]")[0].classList.remove("trvConfigureFolders");
}

function trvFolders_ClientNodeClicked(sender, args) {
    var treeNode = args.get_node();
    //treeNode.toggle();
    var nodeId = treeNode.get_value();
    GoToFolderId(nodeId);
}
function GoToFolderId(id) {
    if (window.location.href.toLowerCase().includes("fileslookup") && (id == '-3' || id == '-2')) {
        return;
    }
    var hdnFolderId = $("[id$=hdnFolderId]")[0];
    hdnFolderId.value = id;
    $("[id$=btnGoToFolder]")[0].click();
}

function CheckNode() {
    var tree = $find($("[id$=trvConfigureFolders]")[0].id);
    if (!tree) { return false; }
    var lastSelectedList = LastSelected.split(',');
    for (var i = 0; i < lastSelectedList.length ; i++) {
        var folderNode = tree.findNodeByValue(lastSelectedList[i]);
        if (folderNode) {
            folderNode.set_checked(true);
        } else {
            var parent = lastSelectedList[i].split('_')[0];
            switch (parent) {
                case "1":
                    folderNode = tree.findNodeByValue('-2');
                    break;
                case "4":
                    folderNode = tree.findNodeByValue('-2');
                    break;
                case "5":
                    folderNode = tree.findNodeByValue('-3');
                    break;
                case "9":
                    folderNode = tree.findNodeByValue('-3');
                    break;
                case "3":
                    folderNode = tree.findNodeByValue('-5');
                    break;
            }
            if (folderNode) {
                tree.findNodeByValue('-1').get_checkBoxElement().className = 'rtIndeterminate';
                folderNode.get_checkBoxElement().className = 'rtIndeterminate';
            }
            var parentEntity = GetEntityParentIds(lastSelectedList[i]);
            folderNode = tree.findNodeByValue(parentEntity);
            if (folderNode) {
                folderNode.get_checkBoxElement().className = 'rtIndeterminate';
            }
        }
    }
}

function updateLastSelected(newValue)
{
    LastSelected = newValue;
}

function GetEntityParentIds(FolderId) {
    var result = [];
    var paramJson = JSON.stringify({ 'FolderId': FolderId });
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/GetEntityParentIds",
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

var uploadsDocFileInProgress = 0;

function onDocFileSelected(sender, args) {
    var ldp = $find("ctl00_ldpPM");
    var filesGridPane = document.querySelector(".filesGridPane");

    if (uploadsDocFileInProgress <= 0) {
        sender.get_element().classList.remove('Hide');
        if (ldp) ldp.show(filesGridPane.id);
    }
    uploadsDocFileInProgress++;
}

function onClientFileUploaded(sender, args) {
    decrementUploadsDocFileInProgress();
    if (uploadsDocFileInProgress <= 0) {
        sender.get_element().classList.add('Hide');
        var ldp = $find("ctl00_ldpPM");
        var filesGridPane = document.querySelector(".filesGridPane");
        if (ldp) ldp.hide(filesGridPane.id)

        setTimeout(function () {
            var btnUpload = document.querySelector('.btnUploadFileTree');
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
        var ldp = $find("ctl00_ldpPM");
        var filesGridPane = document.querySelector(".filesGridPane");
        if (ldp) ldp.hide(filesGridPane.id)
    }
}

function decrementUploadsDocFileInProgress() {
    uploadsDocFileInProgress--;
}

function ClientDocFileValidationFailed(sender, args) {
    decrementUploadsDocFileInProgress();
    alert(WarningMsg_InvalidFile);
}
