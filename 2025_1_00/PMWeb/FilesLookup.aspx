<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="FilesLookup.aspx.vb"
    Inherits="Website.FilesLookup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentManagerDetailsPane.ascx" TagName="DetailPane" TagPrefix="uc12" %>
<%@ Register Src="~/FolderManagerTree.ascx" TagName="FolderManagerTree" TagPrefix="uc13" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>
<body>

    <form id="form1" runat="server">
           <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <style type="text/css">
                @media screen and (min-width:320px) and (max-width:843px) {
                .InActive.ToolbarDetails {
                     display: none;
               }
                .Active.ToolbarDetails {
                    display: none;
                }
                
                div#DetailsPane {
                        position: fixed !important;
                    }
                .MobileDetails .rtbIcon,.Folder_DocumentManager .RadToolBar .rtbItemFocused .MobileDetails .rtbIcon,.Folder_DocumentManager .RadToolBar .rtbItemHovered .MobileDetails .rtbIcon{
                    background-position:-1224px !important;
                    background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png') !important;
                }



                }

               .Folder_DocumentManager .RadGrid_Default {
                    border: 1px solid #E4E4E4 !important;
                }

                .Folder_DocumentManager .labelSelection {
                    color: #999999;
                    height: 24px;
                    display: block;
                    line-height: 24px;
                    padding-left: 24px;
                    /*border-bottom:1px solid #E4E4E4 ;*/
                }

                .Folder_DocumentManager .PMMainPage > .row .col-4 {
                    position: relative !important;
                }

                .Folder_DocumentManager .BreadCrumbLabel {
                    color: #999999 !important;
                }

                .Folder_DocumentManager .RadToolBar_Default {
                    background: white;
                }

                .Folder_DocumentManager .RadGrid.RadGrid_Default.rdgDocumentManager .rgHeader {
                    border: none !important;
                }



                .Folder_DocumentManager .rdgDocumentManager {
                    border-bottom: none !important;
                }



                .Folder_DocumentManager .RadToolBar .ToolBarSort .rtbIn:before {
                    content: ".";
                    width: 0;
                    vertical-align: middle;
                    display: inline-block;
                    overflow: hidden;
                }

                .Folder_DocumentManager #rdgRoot .rgDataDiv {
                    height: calc(100vh - 178px) !important;
                }

                detailPane {
                    height: calc(100vh - 97px) !important;
                }

                .Folder_DocumentManager #txtClipboardValue {
                    display: none;
                }

                 .RadToolBar .ToolbarDetails.InActive .rtbIcon {
                    background-position: -1224px;
                }
               
                   .RadToolBar .ToolbarDetails.Active .rtbIcon {
                    background-position: -1200px !important;
                }

                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarDetails.Active .rtbIcon, 
                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarDetails.InActive .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png') !important;
                    background-position: -1224px;
                
                }

                .Folder_DocumentManager .rwReminder .rwWindowContent {
                    border: 1px solid #999999;
                }


                .Folder_DocumentManager .RadToolBar .ToolBarSort .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                    background-position: 24px !important;
                }

                .Folder_DocumentManager .RadToolBar .ToolBarSort .rtbText {
                    display: none !important;
                }

                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolBarSort .rtbIcon {
                    border: 0;
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                }

                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarDetails .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/24x24 Enabled.png') !important;
                }

                /*.Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarShowLatestVersions .rtbIcon, 
                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarHideLatestVersions .rtbIcon,*/ 
                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarSave .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png') !important;
                }

                .Folder_DocumentManager .RadToolBar .rtbItemHovered .ToolbarSaveAndExit .rtbIcon, 
                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarSaveAndExit .rtbIcon, 
                .Folder_DocumentManager .RadToolBar .rtbItemClicked .ToolbarSaveAndExit .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/24newHovered.png') !important;
                    background-position: -2282px 0px !important;
                }

                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarListView .rtbIcon, 
                .Folder_DocumentManager .RadToolBar .rtbItemFocused .ToolbarCardView .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                }


                .Folder_DocumentManager .RadToolBar .ToolbarListView .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                    background-position: 289px !important;
                    background-repeat: initial;
                }

                .Folder_DocumentManager .RadToolBar .ToolbarCardView .rtbIcon {
                    background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
                    background-position: -3168px !important;
                }

                .Folder_DocumentManager #lblBookMarksSearchPanel, 
                .Folder_DocumentManager #rptFolderIdPanel {
                    display: inline-block !important;
                    width: auto !important;
                }

                .Folder_DocumentManager .FoldersDiv {
                    max-height: 120px;
                    width: 250px;
                    position: absolute;
                    background-color: white;
                    z-index: 1000;
                    overflow: auto;
                    border: 1px solid black;
                }

                .Folder_DocumentManager .FoldersTable {
                    padding: 5px 24px !important;
                    cursor: pointer;
                    display: block;
                }

                    .Folder_DocumentManager .FoldersTable:hover {
                        background-color: #ededed;
                    }

                .Folder_DocumentManager #tblRowBreadCrumb {
                    width: 100%;
                    height: 30px;
                }

                .Folder_DocumentManager .PMMainPage > .row.row-8-4-fit8 {
                    height: 100% !important;
                }

                .Folder_DocumentManager .MaxWidth {
                    width: 100%;
                }

                .Folder_DocumentManager .NoFileSelected {
                    line-height: calc(100vh - 140px);
                }

                .Folder_DocumentManager .RadToolBar .ToolbarHideLatestVersionsPopup .rtbIcon {
                        background-image: url('CSS/Images/ResponsiveIcons/ShowLatestVersionFocused.png') !important;
                }

                .Folder_DocumentManager .RadToolBar .ToolbarShowLatestVersionsPopup .rtbIcon {
                     background-image: url('CSS/Images/ResponsiveIcons/ShowLatestVersion.png') !important;
                }
                  

                .Folder_DocumentManager #mainContentPanel {
                    height: 100% !important;
                }

                .Folder_DocumentManager .RotatorPopup {
                    position: fixed;
                    top: calc(50%);
                    background-color: #fff;
                    width: auto;
                    left: calc(50%);
                    z-index: 10002;
                    height: auto;
                    padding: 10px 10px 10px 10px;
                    transform: translate(-50%, -50%);
                }

                /*.rgDataDiv {
                    height: calc(100vh - 178px) !important;
                }*/

                .Folder_DocumentManager #rdgFiles .rgDataDiv {
                    max-height: calc(100vh - 223px);
                }

                .Folder_DocumentManager .plusIcon {
                    color: white;
                    height: 50px;
                    width: 50px;
                    font-size: 57px;
                    display: block;
                    text-align: center;
                    position: relative;
                    bottom: 1px;
                }


                @media screen and (max-width:843px) {

                    .Folder_DocumentManager tr.ToolBar, 
                    .Folder_DocumentManager table.ToolBar, 
                    .Folder_DocumentManager div.ToolBar {
                        top: 0px !important;
                        display: block !important;
                        height: 50px;
                    }

                    .Folder_DocumentManager .PMMainPage {
                        /*height: calc(100vh - 25px) !important;*/
                        margin-top: 25px;
                        padding: 0 16px !important;
                    }

                    .Folder_DocumentManager .labelSelection {
                        position: fixed;
                        top: 93px;
                        padding-left: 16px;
                    }

                    .Folder_DocumentManager #pnlRoot {
                        margin-top: 55px;
                    }

                    .Folder_DocumentManager #rdgRoot .rgDataDiv {
                        height: calc(100vh - 178px) !important;
                    }

                    /*.closepopup div {
                        top: 12px !important;
                        z-index: 10000;
                    }*/

                    /*.rgDataDiv {
                        height: calc(100vh - 140px) !important;
                    }*/

                    .Folder_DocumentManager .RadToolBar_Default {
                        padding-top: 0px !important;
                        line-height: 42px !important;
                        background: transparent !important;
                    }

                    .Folder_DocumentManager .mobileNoBorderSpacing {
                        border-spacing: 0;
                    }

                    .Folder_DocumentManager tr.breadCrumbRow {
                        /*display: none;*/
                        overflow: hidden;
                        text-overflow: ellipsis;
                        display: inline-block;
                        white-space: nowrap;
                        width: calc(100% - 48px);
                    }

                    .Folder_DocumentManager #mainContent {
                        /*height: calc(100vh - 50px) !important;*/
                    }

                    .Folder_DocumentManager .row-8-4-fit8 {
                        z-index: 2000 !important;
                    }

                    .Folder_DocumentManager #DetailsPane {
                        z-index: 10001;
                    }

                    .Folder_DocumentManager .mobileNoBorderSpacing {
                        border-bottom: none !important;
                    }
                }



                .Folder_DocumentManager .RadToolBar .rtbOuter {
                    background-color: transparent !important;
                }

                /*.closepopup div {
                    background-image: url('CSS/Images/ResponsiveIcons/CloseButton.png') !important;
                    background-repeat: no-repeat;
                    background-position: 0 0 !important;
                    display: inline-block;
                    position: fixed;
                    right: 0px !important;
                    top: 20px;
                }*/

                .Folder_DocumentManager .tblTop {
                    margin-top: 10px;
                }

                .Folder_DocumentManager .CloseProfilePopup {
                    margin-left: 0px !important;
                }

                html, body, form {
                    height: auto !important;
                }

                .Folder_DocumentManager #btnCloseSearch {
                    top: 0 !important;
                    left: 0 !important;
                }

                .Folder_DocumentManager #tableDocuments + #rdgFiles {
                    padding-top: 8px;
                    padding-left: 8px;
                }

                .Folder_DocumentManager #flyoutBackdrop {
                    z-index: 10001 !important;
                }

                .Folder_DocumentManager .toolBar {
                    border-bottom: 1px solid gray;
                    position: fixed;
                }

                .Folder_DocumentManager #pnlFolder {
                    /*position: fixed !important;*/
                    top:0 !important;
                }

                .Folder_DocumentManager #filesGridPane {
                    margin-top: 0px;
                }

                .Folder_DocumentManager .RadGrid.RadGrid_Default.rgHeaderRightBorder .rgHeaderDiv th.rgHeader {
                    border-right: 1px solid #e4e4e4 !Important;
                }
                a.ArrowDown {
                width: 12px;
                height: 12px;
                background-image: url(Css/Images/ResponsiveIcons/16Enabled.png);
                margin-left: 5px;
                margin-right: 15px;
                display: inline-block;
                background-position: -193px,0;
                transform: rotate(90deg);
            }
             .ShowFalse{visibility:hidden}

             /*.rspPane{
                 top:57px;
                 position: relative !important;
             }*/
             .Folder_DocumentManager .DocumentManagerTree{
                 overflow:auto !important;
             }
             .DMVerticalSplitter {
                 position: relative;
                 top: 57px;
             }
             html{
                 overflow:hidden;
             }
             .RadSplitter {
                 margin-left:10px;
             }
             .DMSplitter{
                border-left-width: 1px !important;
             }
             .Folder_DocumentManager .DMSplitterPane {
                 height:calc(100vh - 97px) !important;
             }
             #treeGroupsAndItemsPane .DMSplitterPane {
                overflow: hidden !important;
            }
             .Folder_DocumentManager .active.buttonGrid .Icon {
                    left: 0px !important;
                }
            .Folder_DocumentManager .active.Subscribe.buttonGrid .Icon {
                left: -2px !important;
            }

                .Folder_DocumentManager .DocumentManagerTree {
                    height: calc(100vh - 118px);
                    width: calc(100% - 10px) !important;
                }

                .Folder_DocumentManager .floatButton {
                    bottom: 24px;
                }
            </style>
            <script language="javascript" type="text/javascript">
                window.onload = function(){
                    document.addEventListener("click", function (event) {
                        if (!event.target.classList.contains("arrow")) {
                            var div = document.querySelector(".FoldersDiv");
                            div.style.display = "none";
                        }
                    });
                }

                function RequestStart(sender, args){
                    var evtTarget = args.get_eventTarget();
                    if(evtTarget == "btnCardClick" || evtTarget == "btnListViewRowClick")
                        $("#detailLoadingPanel").css("display" , "block");
                    else
                        $("#loadingPanel").css("display" , "block");
                    if (args.EventTarget.indexOf("btnUploadDragAndDrop") >= 0 || args.EventTarget.indexOf("btnUploadFile") >= 0) {
                        args.EnableAjax = false;
                        return;
                    }
                }

                function RequestEnd(sender, args){
                    var evtTarget = args.get_eventTarget();
                    if(evtTarget == "btnCardClick" || evtTarget == "btnListViewRowClick")
                        $("#detailLoadingPanel").css("display" , "none");
                    else
                        $("#loadingPanel").css("display" , "none");
                }

                function CloseMasterfader() {
                    var flyout = $(".RotatorPopup")[0]
                    var flyoutBackdrop = $('#flyoutBackdrop')[0]
                    var AssetTreeToolBarDiv = $('#AssetTreeToolBarDiv')[0];
                    if (AssetTreeToolBarDiv != undefined && AssetTreeToolBarDiv.className.indexOf('Hide') == -1)
                        return false;
                    if (flyoutBackdrop.className.indexOf('Hide') < 0) {
                        flyoutBackdrop.className = flyoutBackdrop.className + 'Hide';
                    }
                    flyout.className = flyout.className + ' Hide';
                    return false;

                }

              
                var arrRootSelected = {};
                var arrSelected = [];

                var lastCharPressed = 0;

                $(document).keydown(function(event){
                    if(event.which == "17") // cntrl
                        lastCharPressed= 17;
                    else if(event.which == "16") // shift
                        lastCharPressed = 16
                    else // reset
                        lastCharPressed = 0
                })

                $(document).keyup(function(event){
                    lastCharPressed = 0; // reset
                })
           

                $(document).ready(function(){
             
                })
        
                function appendtxtManagerEvent()
                {
                    $('#txtManagerSearch').on('keyup' , function(e){
                        if (e.keyCode == 13) {
                            $("#btnSearch")[0].click();
                        }
                    });
                }


                var gridId = "<%=rdgFiles.ClientID %>";
                let folderPendingClick = 0;

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

                function onCardViewSingleClick(e,curElement) {
                    if (e && e.target && (e.target.tagName.toLowerCase() === "a" )) {
                        return;
                    }   
                  
                    let cur = curElement ? curElement : $(this);;
                    var id = cur.attr('data-Id');
                    var isActive = cur.hasClass('active');
                    $("[id$=hdnCardViewSelected]")[0].value = $("[id$=hdnSelectedFilesFolders]")[0].value
                    $("[id$=hdnCardViewSelected]").val() ?  arrSelected =  $("[id$=hdnCardViewSelected]").val().split(',') :arrSelected = []
                    if( e && e.target && e.target.parentElement && (e.target.classList.contains('check') || e.target.parentElement.classList.contains('check'))){
                        cur.toggleClass('active');
                        !isActive ? arrSelected.push(id) : arrSelected.splice(arrSelected.indexOf(id), 1);
                    }
                    else
                        switch(lastCharPressed){
                            case 0: // others
                                var hasMultipleSelection = arrSelected.length > 1;
                                arrSelected = [];
                                $(".cardView .card , .cardView .folderCard").removeClass('active');
                                if (!isActive || (isActive && hasMultipleSelection)) {
                                    arrSelected.push(id);
                                    cur.addClass('active');
                                }
                                break;

                            case 16 : //shift
                                $(".cardView .card , .cardView .folderCard").removeClass('active');
                                var lastSelected = arrSelected.pop();
                                if(lastSelected){
                                    var arr =  $(".cardView .card , .cardView .folderCard").map(function(){return $(this).attr('data-id')}).toArray();
                                    var lastIndex = arr.indexOf(lastSelected);
                                    var currIndex = arr.indexOf(id);
                                    if ( lastIndex > currIndex ){
                                        arrSelected= arr.filter(function(item){return arr.indexOf(item) >= currIndex && arr.indexOf(item) <=  lastIndex  });
                                        arrSelected.reverse();
                                    }
                                    else
                                        arrSelected = arr.filter(function(item){return arr.indexOf(item) >= lastIndex && arr.indexOf(item) <=  currIndex  });
                                    arrSelected.forEach(function (curr){
                                        $('[data-id =' + curr + ']').addClass("active");
                                    })
                                }
                                else{
                                    arrSelected = [];
                                    if (!isActive){
                                        arrSelected.push(id);
                                        cur.toggleClass('active');
                                    }
                                }
                     
                                break
                            case 17: // cntrl

                                let index = arrSelected.indexOf(id);
                                cur.toggleClass('active');
                                if (index > 0)
                                    arrSelected.splice(index);
                                else
                                    arrSelected.push(id);
                                break;

                        }
                    //cur.hasClass('active') ? arrSelected.splice(arrSelected.indexOf(id), 1) : arrSelected.push(id);
                    //cur.toggleClass('active');
                    var hfPreviouslySelected = document.querySelector("#hfPreviouslySelectedCount");
                    var hfIsControlClicked = document.querySelector("#hfIsControlClicked");
                 
                    hfIsControlClicked.value = lastCharPressed
                    $("[id$=hdnCardViewSelected]").val(arrSelected.join(','));
                    var cardview = document.querySelector("#CardViewContainer");
                    if(!cardview)
                    {
                        cur.hasClass('active')? $("[id$=hdnCardViewSelected]").val(id) : $("[id$=hdnCardViewSelected]").val("");
                        if(document.querySelector(".btnBookMarkCardView"))
                            document.querySelector(".btnBookMarkCardView").click();
                        else
                            document.querySelector(".btnSearchCardView").click();
                        return;
                    }
                    
                    //for (var i = 0; i < arrSelected.length ; i++)
                    //{
                    //    $("[id$=hdnSelectedFilesFolders]")[0].value = addItemToString(',', $("[id$=hdnSelectedFilesFolders]")[0].value, arrSelected[i])
                    //}

                    $("[id$=hdnSelectedFilesFolders]")[0].value = $("[id$=hdnCardViewSelected]")[0].value;
                    updateLabelSelected();
                    __doPostBack('btnCardClick',lastCharPressed);
                }

                function rdgFiles_OnRowContextMenu(sender, args) {
                    var currentIndex = args.get_itemIndexHierarchical();
                    var selectedItemsCount = sender.get_selectedItems().length;
                    if (selectedItemsCount > 0) {
                        var selectedItems = sender.get_selectedItemsInternal();
                        var isExist = selectedItems.find(function (x) {
                            return x.itemIndex == currentIndex
                        });
                        if (isExist) 
                            return;
                    }
                    sender.clearSelectedItems();
                    var item = args.get_gridDataItem();
                    item.set_selected(true);
                    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
                }

                function onCardViewContextMenuClick() {
                    event.preventDefault();
                    let cur = $(this);
                    let id = cur.attr('data-Id');
                    if (arrSelected.length > 1 && arrSelected.indexOf(id) > -1) return;
                    arrSelected = [];
                    $(".cardView .card , .cardView .folderCard").removeClass('active');
                    cur.addClass('active');
                    arrSelected.push(id);
                    $("[id$=hdnCardViewSelected]").val(arrSelected);
                    __doPostBack('btnCardClick','');
                }

                function onCardViewDoubleClick(cur) {
                    let id = cur.attr('data-Id');
                    $("[id$=hdnCardViewSelected]").val(id);
                    var hdnFolderId = document.querySelector("#hdnFolderId");
                    hdnFolderId.value = id.substring(3);
                    var btnDoubleCLick = document.querySelector("#btnDoubleCLick");
                    btnDoubleCLick.click();
                }

                $(document).ready(function(){
                
                  
                })

                function OpenContextMenuFolderActions(e) {
                    var ContextMenuFolderActions = $find(cmFolderActions)
                    var position = $("#dvFolderActionsMenu").offset();
                    ContextMenuFolderActions.showAt(position.left + 5, position.top + 22);
                    $telerik.cancelRawEvent(e);
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
                function loadCardThumbnails(){
                    $.each($('.card'), function() {
                        var FolElem = $("#mainContent")[0];
                        var card = $(this)[0].children[0];
                        var cardimg = card.getElementsByClassName('content')[0].firstElementChild
                        if ((card.offsetTop <= (FolElem.scrollTop + 353 + card.clientHeight)) 
                            && this.getAttribute('isfolder')=='False' && this.hasAttribute('tguid') 
                            && cardimg.src.toLowerCase().includes("css/images/foldermanagericons/defaultthumbnailicon.png") ){
                            cardimg.src = getThumbnailPath(this.getAttribute('name'), this.getAttribute('tguid'), this.getAttribute('ph'));
                        }
                    })
                }

                function setCardViewEvents() {
                    arrSelected = arrSelected || $("[id$=hdnCardViewSelected]").val().split(',') || [];
                    $(".cardView").unbind('click');
                    $(".cardView").unbind('contextmenu');
                    folderPendingClick = 0;
                    $(".cardView").on('click', '.card', onCardViewSingleClick);
                    $(".cardView").on('click', '.folderCard', onFolderCardViewClick);
                    //$(".cardView").on('contextmenu', '.card',onCardViewContextMenuClick);
                    //$(".cardView").on('contextmenu', '.folderCard',onCardViewContextMenuClick);
                    $("#mainContent")[0].addEventListener('scroll',loadCardThumbnails);

                    $('.js-sort').unbind('change');

                    $('.js-sort').on('change' ,'input[type="radio"]' , function(){
                        var selectedSort = '';
                        $('.js-sort input[type="radio"]:checked').each(function(){
                            selectedSort += $(this).attr("sortingBy") + ",";
                        });
                        __doPostBack('btnSorting',selectedSort);
                    })
                   

                }
                var cmFolderActions;
                var cmSorting, folderContextMenu;
                cmSorting = "<%=cmSorting.ClientID %>"
                folderContextMenu = "<%=folderContextMenu.ClientID%>"
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


                // ---------------------------------------------------------------------------


                //------------Grid Command Context Menu-------------

              

                function OpenContextMenuSorting(e) {
                    var ContextMenuSorting = $find(cmSorting)
                    ContextMenuSorting.showAt(position.left + 5, position.top + 22);
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
              
                function RedirectToSearch() {
                    window.location = 'SearchDocument.aspx?O=59'
                }
              
                function DeselectItems() {
                    $('.cardView .card').removeClass("active");
                    return false;
                }
             
                
                function openFolderContextMenu(event) {
                    var contextMenu = $find(folderContextMenu);
                    contextMenu.showAt('50', '50');
                    $telerik.cancelRawEvent(event);
                }

                function ShowImage(src) {
                    if (src == undefined) {
                        var Image = document.querySelector("#ctl00_CPH1_DetailPane1_imgDisplay");
                        src = Image.src;
                    }
                    $("#flyoutBackdrop ,.RotatorPopup").removeClass("Hide");
                    $('.Masterfader img').remove();
                    $('<img src="' + src + '" style="border-width:0px;max-height:320px;" >').prependTo(".Masterfader");
                    var flyout = $(".RotatorPopup")[0]
                    var flyoutBackdrop = $('#flyoutBackdrop')[0]
                    flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
                    flyout.className = flyout.className.replace(' Hide', '');
                    return false;
                }
                var checkInFromDetailsPane = 0;
      
            

         
                function CloseFileslookupPopup() {
                    var btnSaveExit = $("[id$=btnSaveExit]");
                    btnSaveExit.click();
                    return false;
                }

                function mainToolBar_clicked(sender, args) {
                    var value = args.get_item().get_value();
                    switch (value) {
                        case "SaveAndExit":
                            CloseFileslookupPopup();
                            var IsPMWebViewerFile = $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val();
                            if (IsPMWebViewerFile === 'true') SavePMWebViewer();
                            window.close();
                            break;
                        case "Save":
                            CloseFileslookupPopup();
                            break;
                        case "Sort":
                            openSortingContextMenu(args);
                            return false;
                            break;

                        case "Add":
                            openFolderContextMenu(args)
                            break;
                        case "MobileDetails":
                            var detailsPane =  document.querySelector("#DetailsPane");
                            var filesGridPane = document.querySelector("#filesGridPane");
                            if (window.innerWidth < 843){
                                detailsPane.style.display ="block";
                                filesGridPane.style.display = "none";
                                return false;
                            }

                            var isDetailShowing = args.get_item()._element.querySelector("a").classList.contains("Active");
                            if (isDetailShowing) {
                                detailsPane.classList.add("slideRight");
                                filesGridPane.classList.remove("noTransition");
                                filesGridPane.classList.add("transition");
                                filesGridPane.classList.add("gridFullWidth");
                                filesGridPane.classList.remove("transition");
                                args.get_item()._element.querySelector("a").classList.add("InActive");
                                args.get_item()._element.querySelector("a").classList.remove("Active");
                            }
                            else {
                                filesGridPane.classList.remove("noTransition");
                                filesGridPane.classList.add("transition");
                                detailsPane.style.display = "block";
                                filesGridPane.classList.remove("gridFullWidth");
                                setTimeout(function(){
                                    filesGridPane.classList.remove("transition");
                                    detailsPane.classList.remove("slideRight");
                                } , 500);
                                args.get_item()._element.querySelector("a").classList.remove("InActive");
                                args.get_item()._element.querySelector("a").classList.add("Active");
                            } 
                            break;
                            return false;
                    }
                    return false;
                }
                function SavePMWebViewer() {
                    if($("[id$=rdgFiles]").length >0){
                        var rdgFiles = $find($("[id$=rdgFiles]")[0].id).get_masterTableView();

                   var Items = rdgFiles.get_dataItems();
                   if (Items.length > 0){
                       var i=0;
                       for(i=0;i<Items.length;i++){
                           if(Items[i].get_selected()){
                               if(Items[i].getDataKeyValue('IsFolder')==='True') return;
                               var id =Items[i].getDataKeyValue('Id');
                               var element =  Items[i].get_element()

                               var row = $("#" + element.id);
                               var FileId = row.find("[id$='lblFileId']").html();
                               var FileName = row.find("[id$='lblFileName']").html();
                               var BVFileName = $(window.parent.document).find("input[id$=txtHFileName]").val(FileName);
                               var BVFileId = $(window.parent.document).find("input[id$=hdnHFileId]").val(FileId);
                               $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val('false');
                               window.parent.Save();
                               return;
                               }
                           }
                       }
                    }}


                //    var row = $("#" + args.get_id());
                //    var CanSelectFile = row.find("[id$='lblCanSelect']").html() == "true";
                //    if (!CanSelectFile) {
                //        return false;
                //    }
                //    var FileId = row.find("[id$='lblFileId']").html();
                //    var FileName = row.find("[id$='lblFileName']").html();
                //    var FullFileName = row.find("[id$='lblFullFileName']").html();
                //    var ObjectId = row.find("[id$='lblObjectId']").html();
                //    var FileSize = row.find("[id$='hdnFileSize']").val();

                //    var ctlId = $(window.parent.document).find("input[id$='hdnSelectedElementId']");

                //    /** PMWeb Viewer **/

                //    var IsPMWebViewerFile = $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val();

                //    if (IsPMWebViewerFile === 'true') {
                //        var BVFileName = $(window.parent.document).find("input[id$=txtHFileName]").val(FileName);
                //        var BVFileId = $(window.parent.document).find("input[id$=hdnHFileId]").val(FileId);
                //        var BVFileSize = $(window.parent.document).find("input[id$=hdnHFileSize]").val(FileSize);
                //        $(window.parent.document).find("input[id$='hdnHIsPMWebViewerFile']").val('false');
                //        window.parent.Save();

                //        /** PMWeb Viewer **/
                //    }
                //    else {
                //        var attachement_row = $(window.parent.document).find("[id$=pvAttachments]");

                //        var txtLink = attachement_row.find("[id$=txtFileName]").val(FileName);
                //        var chkIsInRotator = attachement_row.find("[id$=chkIsInRotator]")
                //        var ext = FileName.substring(FileName.lastIndexOf('.') + 1, FileName.length);

                //        $(chkIsInRotator).attr("checked", (ALLOWED_IMAGE_EXTENSION.indexOf(ext) >= 0 || ext == "dwf" || ext == "dwfx"));
                //        var hdnFileId = attachement_row.find("[id$=hdnFileId]").val(FileId);
                //        var hdnFileSizeId = attachement_row.find("[id$=FileSize]").val(FileSize);
                //        /** Email send **/
                //        $(window.parent.document).find("input[id$=hdnOjectId]").val(ObjectId).change();
                //        $(window.parent.document).find("input[id$=hdnFM_SelectedFile]").val(FullFileName).change();
                //        $(window.parent.document).find("input[id$=btnAttachFromFM]").click();
                //        /** Email send **/
                //    }
                //    CloseRadWnd();
                //} 

                function closeDetailPane(){
                    $("[id$=DetailsPane]").css("display" , "none");
                    $("[id$=filesGridPane]").css("display" , "block");
                }

                

       
          
                let folders =[];
                let files =[];
                let filesList = [];
                let lst = new DataTransfer();
                var myFileList;
                var empty = 0;


                function unbindDropEvent()
                {
                    var dropZone = $('.Js-DropZone');
                    if(!dropZone) return;
                    dropZone.unbind('drop');
                    dropZone.unbind('dragover');
                }

                function appendDropEvent(){
                    unbindDropEvent();
                    var dropZone = document.querySelector('.Js-DropZone');
                    if(!dropZone) return;
                    dropZone.addEventListener('dragover', function(event) {
                        event.stopPropagation();
                        event.preventDefault();
                        // Style the drag-and-drop as "copy file" operation
                        event.dataTransfer.dropEffect = 'copy';
                    })
                    let queue = [];
                    dropZone.addEventListener('drop',async function(event) {
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
                    
                  
                        for(var i=0;i<filesList.length;i++)
                        {
                            lst.items.add(filesList[i]);

                        }
                        var uploadDragAndDrop = document.querySelector("#uploadDragAndDrop");
                        uploadDragAndDrop.files = lst.files;
                        var hdnFolders = document.querySelector("#hdnFoldersToAdd");
                        var hdnFiles = document.querySelector("#hdnFilesToAdd");
                        var manageFolder = document.querySelector("#hfManageFolder").value == "true";
                        var canAdd = document.querySelector("#hfCanAddFiles").value == "true";
                        if(folders.length > 0){
                            hdnFolders.value = folders[0].fullPath + ";"
                            for(var i=1;i<folders.length;i++){
                                if(i != folders.length - 1)
                                    hdnFolders.value += folders[i].fullPath + ";";
                                else
                                    hdnFolders.value += folders[i].fullPath;
                            }
                            if(!manageFolder)
                                alert("You don't have permission to upload a folder to the current folder."); 
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
                                alert("You don't have permission to upload a file to the current folder");
                        }
                        if((canAdd && fileInCurrentFolder) || (manageFolder && folders.length > 0))
                        {
                            var btnUploadDragAndDrop = document.querySelector("#btnUploadDragAndDrop");
                            btnUploadDragAndDrop.click();
                            return false;
                        }
                        files = [];
                        folders= [];
                        hdnFiles.value = "";
                        hdnFolders.value
                        return false;


                    });
                }
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

                function FilesLookup_onResized(sender, ags) {
                    mainsplitter = sender;
                    var browserWidth = $telerik.$(window).width();
                    if (browserWidth < 843)
                        sender._panes[1].set_width(browserWidth - 20);
                    else
                        sender._panes[1].GetContentElement().style.setProperty('width', 'calc(100vw - ' + sender._panes[0].get_width() + 'px)'); //to let the grid pane take the remaining width
                }

                function OnClientCollapsed(sender, ags) {
                    $("[id$=Splitter]").addClass("removeLeft");
                    //$("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane").addClass("closed");
                    $("[id$=hdnTreeCollapsed]").val("True");
                    $("[id$=btnTreeStateChanged]")[0].click();
        
                }
                function OnClientExpanded(sender, ags) {
                    $("[id$=Splitter]").removeClass("removeLeft");
                    $("[id$=hdnTreeCollapsed]").val("False");
                    $("[id$=btnTreeStateChanged]")[0].click();
                }

                function onTreeResized(sender, args) {
                    $("[id$=hdnTreeWidth]").val(sender.get_width());
                    var newWidth = $(".Folder_DocumentManager").width() - 8 - sender.get_width();
                    $find($("[id$=RadContentPane]")[0].id).getContentElement().style.width = newWidth + 'px';
                    $("[id$=btnTreeStateChanged]")[0].click();
                }

                //-------------RadAsyncUpload Events-------------//

                var uploadsDocFileInProgress = 0;

                function onFileSelected(sender, args) {
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.remove('Hide');
                        $("#loadingPanel").css("display", "block");
                    }
                    uploadsDocFileInProgress++;
                }

                function onFileUploaded(sender, args) {
                    decrementUploadsDocFileInProgress();
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.add('Hide');
                        $("#loadingPanel").css("display", "none");
        
                        setTimeout(function(){
                            var btnUpload = document.querySelector('#btnUploadFile');
                            btnUpload.click();
                            setTimeout(function () {
                                sender.deleteAllFileInputs();
                            }, 10);
                        }, 100)
                    }
                }

                function onFileUploadFailed(sender, args) {
                    decrementUploadsDocFileInProgress();
                    if (uploadsDocFileInProgress <= 0) {
                        sender.get_element().classList.add('Hide');
                        $("#loadingPanel").css("display", "none");
                    }
                }

                function decrementUploadsDocFileInProgress() {
                    uploadsDocFileInProgress--;
                }

                function ClientFileValidationFailed(sender, args) {
                    decrementUploadsDocFileInProgress();
                    alert(WarningMsg_InvalidFile);
                }
                //----------------------------------------------//
                
            </script>
            <script type="text/javascript">

                function loadFolder() {
                    return true;
                }

            

                function refreshRootGrid(){
                    $("[id$=btnRefreshRootGrid]")[0].click()
                }

            
                var folderManagerPendingClick = 0;
                var IsDblClick = false;
                var deselectedRows = []
                var doubleClickPending = 0

                function OnFilesRowClick(sender, eventArgs) {
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
                            if (doubleClickPending) {
                                clearTimeout(doubleClickPending);
                                doubleClickPending = 0;
                            } 
                            var strToBeRemoved = (eventArgs.getDataKeyValue('IsFolder') === 'True' ? 'Fo_' : 'Fi_') + eventArgs.getDataKeyValue('Id');
                            $("[id$=hdnSelectedFilesFolders]")[0].value = removeItemFromString(',', $("[id$=hdnSelectedFilesFolders]").val(), strToBeRemoved);
                            reAddSelectedRows();
                            updateLabelSelected();

                            grid.fireCommand("DoubleClick", commandArgument);
                    }
                };

                var CurrentSelectedFolderId = 0;
                function rdgFilesRowSelecting(sender, args) {
                    var mouseClick = args.get_domEvent().button;
                    if (mouseClick && mouseClick == 2) { // uncheck if right click
                        args.set_cancel(true);
                        return;
                    }
                    try{
                        if (args.get_domEvent().target.closest('a').id.includes("imgAction")){
                            args.set_cancel(true);
                            reAddSelectedRows();
                            return;
                        }
                    }
                    catch(e) { };
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
                    if (target) {
                        folderManagerPendingClick = setTimeout(function () {
                            if (!IsDblClick) {
                                var a = target.closest("a");
                                if (a && a.id.indexOf("imgAction") > -1) {
                                    //args.get_gridDataItem().set_selected(false);
                                    return false;
                                }
                                if (mouseClick)
                                    return false;
                                //if (target.outerHTML.indexOf('selectAllRows') < 0) //to prevent btnListViewRowClick from firing for every row when "select all" is clicked
                                    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
                            } else
                                IsDblClick = false;
                        }, 300);
                    }
                }

                function rdgFilesRowSelected(sender, args){
                    if (!IsDblClick) {
                        var strToBeAdded = (args.getDataKeyValue('IsFolder') === 'True' ? 'Fo_' : 'Fi_') + args.getDataKeyValue('Id');
                        //deselectedRows.splice(deselectedRows.indexOf(strToBeAdded), 1);
                        $("[id$=hdnSelectedFilesFolders]")[0].value = addItemToString(',', $("[id$=hdnSelectedFilesFolders]").val(), strToBeAdded);
                        updateLabelSelected();
                    }
                }

                function reAddSelectedRows(){
                    if (deselectedRows.length > 0){
                        $("[id$=hdnSelectedFilesFolders]")[0].value = addItemToString(',',$("[id$=hdnSelectedFilesFolders]").val(), deselectedRows.join(','))
                        deselectedRows.length = 0;
                    }
                }

                function rdgFilesRowDeSelected(sender, args) {
                    if (args.get_domEvent().target) {
                        if (!IsDblClick){
                            //the previously selected rows are deselected when a folder is double clicked so deselectedRows is used to re-select the deselected rows during this process 
                            var deselectedRow = (args.getDataKeyValue('IsFolder') === 'True' ? 'Fo_' : 'Fi_') + args.getDataKeyValue('Id');
                            if (deselectedRows.indexOf(deselectedRow) < 0) deselectedRows.push(deselectedRow); 
                            doubleClickPending = setTimeout(function(){
                                if (deselectedRows.indexOf(deselectedRow) >= 0) deselectedRows.splice(deselectedRows.indexOf(deselectedRow), 1);
                            }, 200) //this is to ensure there is no confusion between double clicking and unselecting then double clicking after
                            var strToBeRemoved = (args.getDataKeyValue('IsFolder') === 'True' ? 'Fo_' : 'Fi_') + args.getDataKeyValue('Id');
                            $("[id$=hdnSelectedFilesFolders]")[0].value = removeItemFromString(',', $("[id$=hdnSelectedFilesFolders]").val(), strToBeRemoved);
                            updateLabelSelected();
                        }
                        var selectAllCheckbox = $("[id$='rdgFiles'] input[type='checkbox']")[0]
                        var selectCheckBox = args.get_domEvent().target.closest("input");
                        if (selectCheckBox) {
                            if (selectCheckBox.id.indexOf("SelectCheckBox") > -1) {
                                var index = selectCheckBox.id == selectAllCheckbox.id ? -5 : args.get_itemIndexHierarchical();
                                __doPostBack($("[id$=btnListViewRowClick]")[0].name, index);
                            }
                        }
                    }
                }

                function removeItemFromString(separator, string, itemToDelete){
                    var arr = string.split(separator);
                    if (arr.indexOf(itemToDelete) >= 0) arr.splice(arr.indexOf(itemToDelete), 1);
                    return arr.join(separator);
                }
                function addItemToString(separator, string, itemToAdd){
                    var arr = []
                    if (string != ''){arr = string.split(separator);};
                    if (arr.indexOf(itemToAdd) < 0) arr.push(itemToAdd);
                    return arr.join(separator);
                }
                function updateLabelSelected(){
                    var count = 0;
                    var arr = []
                    if ($("[id$=hdnSelectedFilesFolders]")[0].value != '') {
                        arr = [...new Set($("[id$=hdnSelectedFilesFolders]")[0].value.split(','))]; //to get unique values only
                        arr = arr.filter((element)=>{return element!="";}); //to remove empty strings from the array
                        var count = arr.length;
                        $("[id$=hdnSelectedFilesFolders]")[0].value = arr.join(',');
                    }
                    if ($("[id$=lblSelected]")[0]) $("[id$=lblSelected]")[0].innerHTML = 'Selected ' + count;
                }

                function openContextMenu(evt) {
                    var contextMenu = $find("RootContextMenu");
                    contextMenu.showAt('50', '50');
                    $telerik.cancelRawEvent(evt);
                }

            
          
                function openSortingContextMenu(args) {
                    var contextMenu = $find(cmSorting);
                    contextMenu.showAt('50', '50');
                    var evt = args.get_domEvent();
                    $telerik.cancelRawEvent(evt);
                    return false;
                }
            


                function onNoneSelectionFileActions(sender) {
                    for (var i = 0; i < sender.get_allItems().length ; i++) {
                        var item = sender.get_allItems()[i];
                        item.disable();
                    }
                }
              
                

                
                function onFolderContextMenuClicking(sender,args)
                {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var menuItem = args.get_item();
                    switch (menuItem.get_value()) {
                        case "FromComputer":
                            $("[id$=inputFile] .ruFileInput")[0].click();
                            args.set_cancel(true);
                            break;
                    }
                }
                
                function openWindowsExplorer()
                {
                    $("[id$=inputFile] .ruFileInput")[0].click();
                    return false;
                }
         

                function OpenFileAdd(FolderId, ClearFileTable, AllowVersioning, IsCopyAction, IsMoveAction) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.parent.radopen('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction + '&IsFilesLookUp=1');
                    var divWindow = wnd._popupElement;
                    divWindow.classList.add("rwReminder");
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
                            wnd.setSize(browserWidth, browserHeight);
                        else
                            wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    wnd.add_close(rebindFileGrid);
                }

                function rebindGrid(refresh) {
                    return function () {
                        if (refresh)
                            $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
                        else
                            $("[id$=btnRefreshFilesAndFolder]")[0].click();

                    }
                }
                function rebindFileGrid()
                {
                    $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
                }
     

                function OnRowClick(sender, eventArgs) {
                
                    if (eventArgs.get_domEvent().target) {
                        var a = eventArgs.get_domEvent().target.closest("a");
                        if (a) {
                            if (a.id.indexOf("imgAction") > -1) {
                                eventArgs.set_cancel(true);
                                return false;
                            }
                        }
                    }
                    var item = eventArgs.get_gridDataItem();
                    var commandArgument = item._itemIndex;
                    let grid = sender.get_masterTableView();
                    grid.fireCommand("RowClick", commandArgument);

                }

                function Download(Id) {
                    var btn = document.querySelector("#btnDownload");
                    var hdnFieldDownload = document.querySelector("#hdnDownloadId");
                    hdnFieldDownload.value = Id;
                    btn.click();
                    return false;
                }

                function FillFolder(sender) {
                    deselectedRows.length = 0;
                    var folderId = sender.getAttribute("btnId");
                    var hdnFolderId = document.querySelector("#hdnFolderId");
                    hdnFolderId.value = folderId
                    var btnGoToFolder = document.querySelector("#btnGoToFolder");
                    btnGoToFolder.click();
                }

                var isSearch = 0;

                function openAdvancedSearchPopUp() {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();;
                    var searchText = document.querySelector(".txtSearch").value;
                    var wnd = window.parent.radopen("FolderManagerAdvancedSearch.aspx?searchText=" + searchText + "&isFilesLookup=1");
                    var divWindow = wnd._popupElement;
                    divWindow.classList.add("rwReminder");
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(448, browserHeight * 0.9);
                        wnd.Center();
                    }
                    wnd.add_close(showAdvancedSearchResult);
                    return false;
                }

               

                function showAdvancedSearchResult()
                {
                    if(isSearch === 1){
                        isSearch = 0;
                        var btnSearch = document.querySelector("#btnShowSearch");
                        btnSearch.click();
                    }
               
                }

                function onFileItemDragStarted(sender , args){
                    //var id = args.get_dataKeyValues().Id;
                    //var name = args.get_dataKeyValues().FileName;    
                    //console.log(id , name);
                }
                function onFolderItemDragging (sender,args){
                    var evt = args.get_domEvent();
                    var folderContainer = document.getElementById("foldersContainer");
                    if($telerik.isMouseOverElementEx(folderContainer ,evt )){
                        var target = evt.srcElement || evt.originalTarget;
                        if(target && target.id){
                            var draggedIndex = sender._itemDrag._draggedItemIndex;
                            var targetIndex = -1;
                            if(target.id.split('_')[3])
                                targetIndex = target.id.split('_')[3].substr(4);
                            if (draggedIndex == targetIndex) // check if dragover on itself
                                return;

                            if(target.id.indexOf('folderCard') > -1  ){
                                target.style.background = '#ccc';
                                return;
                            }

                            $(".folderCard").each(function(){
                                if ($telerik.isMouseOverElementEx($(this)[0] ,evt ))
                                    $(this)[0].style.background = '#ccc';
                                else
                                    $(this)[0].style.background = 'white';
                            });
                        }
                    }else{
                        $(".folderCard").css("background" , "white");
                    }
            
                }

                function onFileItemDragging(sender , args){
                    var evt = args.get_domEvent();
                    var folderContainer = document.getElementById("ctl00_CPH1_foldersContainer");
              
                    if($telerik.isMouseOverElementEx(folderContainer ,evt )){
                        //$(".folderCard").css("background" , "white");
                        var target = evt.srcElement || evt.originalTarget;
                        if(target && target.id){
                            if(target.id.indexOf('folderCard') > -1 ){
                                target.style.background = '#ccc';
                                return;
                            }
                            $(".folderCard").each(function(){
                                if ($telerik.isMouseOverElementEx($(this)[0] ,evt ))
                                    $(this)[0].style.background = '#ccc';
                                else
                                    $(this)[0].style.background = 'white';
                            });
                        }
                    }else{
                        $(".folderCard").css("background" , "white");
                    }
                }

             



                function onRootRowSelected(sender , args){
                    var id = args.getDataKeyValue("Id");
                    if(!arrRootSelected[id])
                        arrRootSelected[id] = true;
                }
                function onRootRowDeselected(sender , args){
                    var id = args.getDataKeyValue("Id");
                    if(arrRootSelected[id])
                        arrRootSelected[id] = null;
                }
                function onRootRowCreated(sender , args){
                    var id = args.getDataKeyValue("Id");
                    if(arrRootSelected[id])
                        args.get_gridDataItem().set_selected(true);
                }
                function onRootGridCreated(sender , args){}

                function showFolders(event) {
                    
                    var div = document.querySelector(".FoldersDiv");
                    if (!div)
                        return;
                    div.style.zIndex = 1000;
                    div.style.top = "20px";
                    div.style.left = (event.clientX - 50) + "px";
                    var parent = event.target.previousElementSibling;
                    var id = parent.getAttribute("btnid");
                    id == -5 ? id = 58 : id = id;
                    getFolders(id);
                }


                function getFolders(id) {
                    var div = $(".FoldersDiv tbody");
                    var container = $(".FoldersDiv");
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/GetFoldersByFolderFilesLookup",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ id: id }),
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            div.empty();
                            if (data.d.length > 0) {
                                $(data.d).each(function (index, fol) {
                                    div.append(`<tr><td ><a class="FoldersTable" onclick="FillFolder(this)" btnId="${fol.Id}">${fol.Name}</a></td></tr>`)
                                })
                                container.css("display", "block");
                            }
                            else {
                                container.css("display", "none");
                            }
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
                
                function CloseWindow()
                {
                    var wnd = GetRadWindow(window);
                    wnd.Close();
                }

                function setToolBarPosition()
                {
                    var lblSelected = document.querySelector(".labelSelection");
                    var toolbar = document.querySelector(".toolBar");
                    var breadcrumb = document.querySelector(".tblTop");
                    var pnlFolder = document.querySelector("#pnlFolder");
                    var pmMainPage = document.querySelector(".PMMainPage");
                    if(pnlFolder)
                    {
                        toolbar.style.top = breadcrumb.clientHeight + 10 + "px";
                        var pnlFolderTop = toolbar.clientHeight + breadcrumb.clientHeight  + 11 + "px";
                        pnlFolder.style.top = pnlFolderTop;
                        pnlFolderTop = isMobileScreen() ? pnlFolderTop - 25 : pnlFolderTop - 24;
                        pmMainPage.style.height = "calc(100vh - " + pnlFolderTop + ")";
                        if(lblSelected) 
                            lblSelected.style.top = toolbar.clientHeight + breadcrumb.clientHeight  + 11 + "px"  ;
                    }
                    return false;
                }
                window.onresize = function(){
                    setToolBarPosition();
                }

                function OpenPDFViewer(strFullFileName) {
                    window.open('app/viewerpdf/' + strFullFileName, "_blank"); 
                    return false;
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" ScriptMode="Release">
            <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="RequestEnd" />

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnCardClick">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="DetailPane1" />
                        <telerik:AjaxUpdatedControl ControlID="btnCardClick" />
                        <telerik:AjaxUpdatedControl ControlID="lblSelected" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>



            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnListViewRowClick">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="DetailPane1" />
                        <telerik:AjaxUpdatedControl ControlID="btnListViewRowClick" />
                        <telerik:AjaxUpdatedControl ControlID="lblSelected" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="panel">
                    <UpdatedControls>
                        <%--<telerik:AjaxUpdatedControl ControlID="panel" LoadingPanelID="ldpDetails" />--%>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnDoubleCLick">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnGoToFolder">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>



            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgFiles">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnUploadDragAndDrop">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnUploadDragAndDrop" />
                    </UpdatedControls>
                </telerik:AjaxSetting>


            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSorting">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>



            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="pnlRoot">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnShowSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnCloseSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="panel" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

        </telerik:RadAjaxManager>
     

        <%-- <div style="z-index: 89999; width: 100%; height: 100%; position: fixed; zoom: 1; color: black; display: none" class="Hide RadAjax RadAjax_Default" id="">
            <div class="raDiv"></div>
            <div id="PMLoadingIcon" class="raColor raTransp"></div>
        </div>--%>
        <div class="Folder_DocumentManager">
            <div id="loadingPanel" class="RadAjax RadAjax_Default" style="position: absolute; width: 100%; height: 100%; left: 0; top: 0; text-align: center; z-index: 90000; display: none">
                <div class="raDiv"></div>
                <div class="raColor raTransp">
                </div>
            </div>


            <asp:Panel ID="panel" runat="server">
                <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
                <table class="MaxWidth tblTop" cellpadding="0" cellspacing="0">
                    <tr class="breadCrumbRow">
                        <td id="tblRowBreadCrumb" runat="server">
                            <table>
                                <tr>
                                    <td style="padding-left: 17px;">
                                        <asp:Repeater ID="rptFolderId" runat="server">
                                            <ItemTemplate>
                                                <div style="display: inline-block; float: left">
                                                    <asp:LinkButton ID="lnkBtnFolder" runat="server" class="BreadCrumbLabel" Font-Underline='<%# Eval("HasSubFolders") AndAlso Not Eval("IsCurrentFolder") %>' Text='<%# Eval("Name") %>' btnId='<%# Eval("Id") %>'></asp:LinkButton>
                                                  
                                            <%--<span class="BreadCrumbLabel arrow" style="text-decoration: none; color: #666; cursor: pointer" onclick="showFolders(event)">></span>--%>
                                                    <a class="ArrowDown Show<%# Eval("HasSubFolders") %>" onclick="showFolders(event)" ></a>
                                               
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:Label ID="lblBookMarksSearch" runat="server" Visible="false" class="BreadCrumbLabel" Style="display: inline-block;" Text="">
                                                 <a class="ArrowDown Show<%# Eval("HasSubFolders") %>"  onclick="showFolders(event)"></a>
                                        </asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </td>

                        <td style="width: 100%"></td>
                    </tr>
                    <tr class="toolBar" style="width: 100%; background-color: white !important;">
                        <td>
                            <table class="mobileNoBorderSpacing">
                                <tr>
                                    <td style="position: relative; left: -6px;" class="ToolbarTd">
                                        <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="mainToolBar_clicked" runat="server" AutoPostBack="false">
                                            <Items>
                                                <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/NewDoc.png" PostBack="false"
                                                    CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                                    Value="Save" meta:ResourceKey="mainToolBar_Save">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" meta:ResourceKey="mainToolBar_SaveAndExit"></telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton IsSeparator="true" Value="btnSeperator">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Active.png" CssClass="Enabled"
                                                    Value="ShowLatestVersions" CommandName="ShowLatestVersions" ToolTip="Latest Version" meta:ResourceKey="mainToolBar_ShowLatestVersion">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Active.png" CssClass="InActive" EnableViewState="true"
                                                    Value="Details" CommandName="Details" ToolTip="Details" meta:ResourceKey="mainToolBar_Details">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Active.png" CssClass="MobileDetails ShowOnMobile" PostBack="false" EnableViewState="true"
                                                    Value="MobileDetails" CommandName="MobileDetails" ToolTip="Details" meta:ResourceKey="mainToolBar_Details">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton EnableImageSprite="true" Value="CardView" CssClass="ToolbarCardView" CommandName="CardView" meta:ResourceKey="mainToolBar_CardView"></telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton EnableImageSprite="true" Value="ListView" CssClass="ToolbarListView" Visible="false" CommandName="ListView" meta:ResourceKey="mainToolBar_ListView"></telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton EnableImageSprite="true" Value="Sort" CssClass="ToolBarSort" Visible="false" CommandName="Sort" PostBack="false" meta:ResourceKey="mainToolBar_Sort"></telerik:RadToolBarButton>
                                                <telerik:RadToolBarButton IsSeparator="true" Value="txtSeperator" CssClass="HideOnMobileToolbar">
                                                </telerik:RadToolBarButton>
                                            </Items>
                                        </telerik:RadToolBar>
                                        <asp:Button ID="btnGetProjects" CssClass="Hide" runat="server" Text="Go" meta:ResourceKey="btnGetProjects" />
                                    </td>
                                    <td id="SearchBar" runat="server" class="ToolbarTd HideOnMobileToolbar showOnIpad" style="padding-left: 0px">
                                        <div visible="true" class="searchBar" style="margin-left: 0 !important">
                                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="searchLoop">
                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:TextBox ID="txtManagerSearch" CssClass="txtSearch" runat="server"></asp:TextBox>
                                            <asp:LinkButton ID="btnClearSelection" runat="server" CssClass="clearSelection">
                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="ToolbarTd HideOnMobileToolbar showOnIpad">
                                        <asp:LinkButton runat="server" ID="btnAdvancedSearch" OnClientClick="return openAdvancedSearchPopUp();return false;"
                                            CssClass="advancedSearch" meta:ResourceKey="btnAdvancedSearch">
                                            <span class="Icon" id="span2" runat="server"></span>
                                        </asp:LinkButton>
                                    </td>

                                    <td class="ToolbarTd HideOnMobileToolbar showOnIpad">
                                        <asp:Button ID="btnCloseSearch" runat="server" Text="Close Search" Style="width: 120px !important" Visible="false" meta:ResourceKey="btnCloseSearch" />
                                    </td>
                                    <td style="width: 100%"></td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="DMVerticalSplitter" SplitBarsSize="" OnClientLoad="FilesLookup_onResized">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack DMSplitterPane" Style="position: fixed; background: white; top: 0;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" MaxWidth="400" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="onTreeResized">
                <uc13:FolderManagerTree ID="FolderManagerTree" runat="server" />
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="DMSplitter" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="DMSplitterPane" Height="100%">
                <asp:Panel ID="pnlFolder" runat="server" Visible="true" Style="height: auto; width: 100%; position: relative">
                    <div id="tableDocuments" runat="server">
                        <asp:Label ID="lblSelected" CssClass="labelSelection" runat="server" Text="Selected 0"></asp:Label>
                    </div>
                    <div class="PMMainPage" style="height: calc(100vh - 135px); padding: 0 24px;">
                        <div class="row row-8-4-fit8">
                            <div class="col-8" id="filesGridPane" runat="server" style="height: 100%">
                                <div class="Js-DropZone" id="dropZone" runat="server">

                                    <asp:Panel runat="server" ID="mainContent" Style="height: 100%; overflow-y: auto; overflow-x: auto;">
                                        <telerik:RadGrid ID="rdgFiles" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="true" CssClass="rdgDocumentManager rgHeaderRightBorder"
                                            GridLines="None" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true" ClientSettings-Resizing-AllowColumnResize="true"
                                            ShowStatusBar="false" ClientSettings-Scrolling-AllowScroll="true" 
                                            AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                            EnableHeaderContextMenu="false" EnableHeaderContextFilterMenu="false" FitPageHeightOffset="5">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <HeaderStyle Font-Size="8pt" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                                                CommandItemDisplay="None" DataKeyNames="Id,IsSelected,IsEligible" ClientDataKeyNames="Id,IsLastVersion,Extension,DocStatusId,CheckedIn,CheckedById,EditFiles,DeleteFiles,ManageFolder,FolderId,WorkflowStatusId,IsInBluebeamSession,IsEligible,IsFolder" EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" Resizable="true" HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                                    <%-- <telerik:GridTemplateColumn HeaderText="" HeaderStyle-HorizontalAlign="Center" UniqueName="IsInBluebeamSession" ItemStyle-Width="50px" HeaderStyle-Width="50px" Groupable="False" Reorderable="false"
                                            ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="imgBluebeam" Style="cursor: pointer" Visible='<%# Eval("IsInBluebeamSession")%>' runat="server"
                                                    CssClass="BluebeamIcon">
                                                       <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>--%>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" HeaderText="Action" EnableHeaderContextMenu="false"
                                                        ItemStyle-HorizontalAlign="Center" Resizable="true" UniqueName="Action" AllowSorting="false" HeaderStyle-Width="30px" Reorderable="false" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server" OnClick="imgAction_Click">
                                                            <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn EnableHeaderContextMenu="false" HeaderText="Root" HeaderStyle-Width="150px" Resizable="true" ItemStyle-HorizontalAlign="Left" UniqueName="Root" SortExpression="Root" Groupable="true"
                                                        DataField="Root" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="hplRoot" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Root")%></u></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="200px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn EnableHeaderContextMenu="false" HeaderText="Entity" UniqueName="Entity" SortExpression="Entity" Groupable="true"
                                                        DataField="Entity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="hplEntity" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Entity")%></u></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="200px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Folder" EnableHeaderContextMenu="false" HeaderStyle-Width="150px" Resizable="true" UniqueName="Folder" SortExpression="Folder" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                        DataField="Folder" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="hplFolder" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Folder")%></u></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="120px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="" EnableHeaderContextMenu="false" HeaderStyle-Width="30px" Resizable="true" AllowSorting="false" Groupable="False" UniqueName="Icon"
                                                        AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="imgRedlining" runat="server" style="cursor: default;" Enabled="false">
                                                                <span id="spanImg" class="smallIcon" runat="server"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="File Name" EnableHeaderContextMenu="false" HeaderStyle-Width="180px" Resizable="true" UniqueName="FileName" SortExpression="FileName" Groupable="true" GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC"
                                                        ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="padding-left-none" DataField="FileName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span id="lblFileName"><%# IIf(Eval("IsFolder"), Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", ""), Eval("FileName")) %></span>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="150px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Description" EnableHeaderContextMenu="false" HeaderStyle-Width="220px" Resizable="true" UniqueName="Description" SortExpression="Description" Groupable="true" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                                        DataField="Description" CurrentFilterFunction="Contains" ItemStyle-HorizontalAlign="Left" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                                            </span>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="250px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Bookmark" HeaderStyle-Width="220px" Resizable="true" UniqueName="Bookmark" SortExpression="Bookmark" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                        DataField="Bookmark" GroupByExpression="Bookmark [GridColumn_Bookmark] Group By Bookmark ASC" AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnBookMark" runat="server" Visible="true" CssClass="BookMark" Enabled="false">
                                                                <span class="Icon" runat="server"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                     <telerik:GridTemplateColumn HeaderText="Subscribe" HeaderStyle-Width="220px" Resizable="true" UniqueName="Subscribe" SortExpression="Subscribe" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                        DataField="Subscribe" GroupByExpression="Subscribe [GridColumn_Subscribe] Group By Subscribe ASC" AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnSubscribeFiles" Visible="false" Class="Subscribe" runat="server" Enabled="false">
                                                                <span class="Icon"></span>                                                                
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                           <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                     <telerik:GridTemplateColumn HeaderText="PMWeb Viewer" HeaderStyle-Width="220px" Resizable="true" UniqueName="PMWebViewer" ItemStyle-HorizontalAlign="Left" AllowFiltering="False" >
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtIconViewer"  runat="server" Class="PmWebViewer" meta:resourcekey="Redlining" Visible="false" Enabled="false">
                                                                <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                             <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Bluebeam" HeaderStyle-Width="80px" Resizable="true" UniqueName="Bluebeam" Groupable="true" ItemStyle-HorizontalAlign="Left" AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnBlueMarkStudio" class="BlueMarkStudio" runat="server" meta:resourcekey="btnBlueMarkStudio" visible="false" Enabled="false">
                                                                <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                              <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Document #" EnableHeaderContextMenu="false" UniqueName="DocumentNbr" SortExpression="DocumentNbr" Groupable="False"
                                                        DataField="Id" CurrentFilterFunction="EqualTo" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <%--<asp:HyperLink ID="lblDocumentNumber" Font-Underline="true" Text='<%#Container.DataItem("Id").ToString() %>' runat="server" NavigateUrl='<%# "PMWebRecord.aspx?Id" + Container.DataItem("Id").ToString() %>'></asp:HyperLink>
                                                        <asp:LinkButton ID="lnkBtnOpenFolder" runat="server" Visible="false" Text="Open Folder" Style="text-transform: uppercase"></asp:LinkButton>--%>
                                                            <asp:Label ID="lblDocumentNumber" runat="server"><%# Eval("Id") %></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                        <HeaderStyle Width="150px"></HeaderStyle>
                                                        <ItemStyle />
                                                    </telerik:GridTemplateColumn>


                                                    <%-- <telerik:GridTemplateColumn HeaderText="Path" Groupable="True" UniqueName="FolderPath" ItemStyle-Wrap="false" GroupByExpression="Path [GridColumn_FolderPath] Group By Path ASC"
                                        Visible="false" SortExpression="Path" DataField="Path" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPath" runat="server" Text='<%#IIf(Container.DataItem("Path") Is Nothing, "&nbsp;", "/" & Eval("Path"))%>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>--%>
                                                    <telerik:GridTemplateColumn HeaderText="Size" EnableHeaderContextMenu="false" HeaderStyle-Width="75px" Resizable="true" UniqueName="Size" ItemStyle-Wrap="false" Groupable="false" ItemStyle-HorizontalAlign="Left"
                                                        SortExpression="FileSize" DataField="FileSize" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileSize" runat="server" Text='<%#IIf(Container.DataItem("ContentType") = "Folder", "&nbsp;", FormatByte(ParseDouble(Eval("FileSize"))))%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="60px"></HeaderStyle>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Ext." EnableHeaderContextMenu="false" HeaderStyle-Width="75px" Resizable="true" UniqueName="Extension" ItemStyle-Wrap="false" GroupByExpression="Extension [GridColumn_Extension] Group By Extension ASC"
                                                        SortExpression="Extension" DataField="Extension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="txtFileDescription" runat="server" Text='<%#Eval("Extension")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="55px"></HeaderStyle>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Version" EnableHeaderContextMenu="false" HeaderStyle-Width="75px" Resizable="true" UniqueName="Version" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Version [GridColumn_Version] Group By Version ASC"
                                                        SortExpression="Version" DataField="Version" DataType="System.String" CurrentFilterFunction="EqualTo" Visible="true" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label CssClass="Hide" ID="lblIsLastVersion" runat="server" Text='<%#Eval("IsLastVersion")%>'></asp:Label>
                                                            <asp:Label CssClass="Hide" ID="lblOriginalVersionFileId" runat="server" Text='<%#Eval("OriginalVersionFileId")%>'></asp:Label>
                                                            <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("Version")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                        <ItemStyle Wrap="False" CssClass="text-left" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Workflow Status" EnableHeaderContextMenu="false" HeaderStyle-Width="75px" Resizable="true" UniqueName="WorkflowStatus" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="WorkflowStatus [GridColumn_WorkflowStatus] Group By WorkflowStatus ASC"
                                                        SortExpression="WorkflowStatus" DataField="WorkflowStatus" DataType="System.String" CurrentFilterFunction="EqualTo" Visible="true" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWorkflowStatus" runat="server" Text='<%#Eval("WorkflowStatus")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                        <ItemStyle Wrap="False" CssClass="text-left" />
                                                    </telerik:GridTemplateColumn>
                                                    <%--<telerik:GridTemplateColumn HeaderText="Last Updated" EnableHeaderContextMenu="false" HeaderStyle-Width="75px" Resizable="true" SortExpression="LastModified" UniqueName="LastUpdated" GroupByExpression="ModifiedDate1 [GridColumn_LastUpdated] Group By ModifiedDate1 ASC"
                                                        ItemStyle-Wrap="false" DataField="LastUpdated" CurrentFilterFunction="GreaterThanOrEqualTo" ItemStyle-HorizontalAlign="Left" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblUpdatedDate" runat="server" Text='<%#FormatDate(Eval("LastModified"))%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle></ItemStyle>
                                                        <ItemStyle Wrap="False" />
                                                        <HeaderStyle Width="120px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>--%>

                                                    <telerik:GridTemplateColumn Groupable="False" HeaderText="" EnableHeaderContextMenu="false" Display="False" ItemStyle-Wrap="false"
                                                        UniqueName="FileId" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileId" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Groupable="False" EnableHeaderContextMenu="false" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                        UniqueName="FileGuid" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileGuid" runat="server" Text='<%#Eval("FileGuid") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Groupable="False" EnableHeaderContextMenu="false" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                        UniqueName="FolderId" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFolderId" runat="server" Text='<%#PM.FileManager.FolderInfo.CurrentWorkingFolderId %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Groupable="False" EnableHeaderContextMenu="false" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                        UniqueName="CanEdit" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCanEdit" runat="server" Text=''></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="False" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Visible="False" UniqueName="CreatedDate1" DataField="CreatedDate1" DataType="System.DateTime" ItemStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <span></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Visible="False" UniqueName="ModifiedDate1" DataField="ModifiedDate1" DataType="System.DateTime" ItemStyle-HorizontalAlign="left">
                                                        <ItemTemplate>
                                                            <span></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridCheckBoxColumn UniqueName="$Boolean1$" EnableHeaderContextMenu="false" Display="False" AllowFiltering="True" DataType="System.boolean">
                                                    </telerik:GridCheckBoxColumn>
                                                </Columns>
                                                <NoRecordsTemplate>
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td class="Top Center">
                                                                <asp:Label ID="lblNoFileToDisplay" runat="server" meta:ResourceKey="lblNoFileToDisplay"
                                                                    Text="No Files to display."></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </NoRecordsTemplate>
                                            </MasterTableView>
                                            <ClientSettings Scrolling-SaveScrollPosition="true" Selecting-AllowRowSelect="true" AllowRowsDragDrop="false" ClientEvents-OnRowContextMenu="rdgFiles_OnRowContextMenu"
                                                ClientEvents-OnRowClick="OnFilesRowClick" ClientEvents-OnRowSelecting="rdgFilesRowSelecting" ClientEvents-OnRowDeselected="rdgFilesRowDeSelected" ClientEvents-OnRowSelected="rdgFilesRowSelected" >
                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                                            </ClientSettings>

                                        </telerik:RadGrid>
                                        <div class="cardView" id="CardViewContainer" runat="server" style="height: auto; border: 1px solid #e4e4e4; width: 100%;" visible="false">
                                            <div>
                                                <div class="foldersContainer" id="foldersContainer" runat="server">
                                                    <h2 meta:resourcekey="lblFolders">Folders</h2>
                                                    <telerik:RadListView runat="server" ID="rptFoldersCardView" ClientDataKeyNames="Id , FileName" ItemPlaceholderID="FoldersCardViewContainer">
                                                        <LayoutTemplate>
                                                            <div>
                                                                <asp:PlaceHolder ID="FoldersCardViewContainer" runat="server"></asp:PlaceHolder>
                                                            </div>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <div class="rlvI">
                                                                <div class="rlvDrag">
                                                                    <div style="margin: 0px 16px 16px 0; float: left">
                                                                        <div id="folderCard" runat="server" title='<%#Eval("FileName")%>'>
                                                                            <div class="mainContent">
                                                                                <div class="check">
                                                                                    <span class="icon"></span>
                                                                                </div>
                                                                                <span class="FolderIcon" runat="server">
                                                                                    <span class="smallIcon" runat="server"></span>
                                                                                </span>
                                                                                <span class="folderName"><%#Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", "")  %> </span>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </telerik:RadListView>
                                                </div>
                                                <div class="filesContainer" id="filesContainer" runat="server">
                                                    <h2 meta:resourcekey="lblFiles">Files</h2>
                                                    <telerik:RadListView runat="server" ID="rptFilesCardView" ClientDataKeyNames="Id , FileName" ItemPlaceholderID="FilesCardViewContainer">
                                                        <LayoutTemplate>
                                                            <div>
                                                                <asp:PlaceHolder ID="FilesCardViewContainer" runat="server"></asp:PlaceHolder>
                                                            </div>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <div class="rlvI">
                                                                <div class="rlvDrag">
                                                                    <div id="card" runat="server" title='<%#Eval("FileName")%>'>
                                                                        <div class="mainContent">
                                                                            <div class="check">
                                                                                <span class="icon"></span>
                                                                            </div>
                                                                            <div class="content">
                                                                                <%--<img alt="" src="Images/Charts/Marble.gif" />--%>
                                                                                <asp:Image ID="imgDisplay" CssClass="imgDisplay" Style="max-height: 125px;" runat="server" />
                                                                            </div>
                                                                            <div class="linkRecord" style="line-height: 28px;">
                                                                                <span id="cardIcon" runat="server">
                                                                                    <span class="smallIcon"></span>
                                                                                </span>
                                                                                <span style="font-size: 10px; margin-left: 28px; width: 147px; white-space: nowrap; overflow: hidden; display: inline-block; text-overflow: ellipsis; color: #000000; margin-top: -16px;"><%# Eval("Id").ToString() + " - " + Eval("FileName")%> </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </telerik:RadListView>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="emptyFolder" runat="server" style="display: table; text-align: center; height: 100%; width: 100%" visible="false">
                                            <div style="display: table-cell; vertical-align: middle">
                                                <asp:Image ID="imgEmptyFolder" Style="height: 200px; width: 200px; display: inline-block" runat="server" ImageUrl="CSS/Images/FolderManagerIcons/EmptyFolderIcon.png"></asp:Image>
                                                <br />
                                                <asp:Label ID="lblEmptyFolder" meta:resourcekey="lblEmptyFolder" runat="server" Text="Drop files here or click the Add button" Style="font-size: 14px; color: #666;"></asp:Label>
                                            </div>
                                        </div>
                                    </asp:Panel>

                                </div>
                                <asp:Label ID="lblResult" runat="server" Style="display: none;" CssClass="Validator"></asp:Label>
                                <div id="floatButtonFiles" runat="server" class="floatButton" style="text-align: center; line-height: 50px" onclick="openWindowsExplorer();return false;">
                                    <span class="plusIcon">&#43;</span>
                                </div>
                            </div>
                            <div class="col-4" id="DetailsPane" runat="server" style="overflow: auto; height: 100%; border: 1px solid #E4E4E4; background: white;">
                                <div id="detailLoadingPanel" class="RadAjax RadAjax_Default" style="position: absolute; width: 100%; height: 100%; left: 0; top: 0; text-align: center; z-index: 90000; display: none">
                                    <div class="raDiv"></div>
                                    <div class="raColor raTransp">
                                    </div>
                                </div>
                                <uc12:DetailPane ID="DetailPane1" runat="server" />
                            </div>
                        </div>
                    </div>


                </asp:Panel>


                <telerik:RadContextMenu OnClientItemClicking="onFolderContextMenuClicking"
                    runat="server" ID="folderContextMenu" CssClass="rootMenu" ClickToOpen="true" ExpandAnimation-Duration="500">
                    <Items>
                        <telerik:RadMenuItem Value="FromComputer" meta:resourcekey="FolderContextMenu_FromComputer" Text="From Your Computer" PostBack="false"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadContextMenu>
                <telerik:RadContextMenu
                    runat="server" ID="cmSorting" CssClass="rootMenu js-sort" ClickToOpen="true" ExpandAnimation-Duration="500">
                    <Items>
                        <telerik:RadMenuItem Value="SortingBy">
                            <ItemTemplate>
                                <input type="radio" runat="server" id="chkDocumentNumber" clientidmode="Static" name="SortingBy" sortingby="Id" />
                                <label for="chkDocumentNumber" meta:resourcekey="SortingContextMenu_DocumentNumber">Document #</label>
                                <br />
                                <input type="radio" runat="server" id="chkExtension" name="SortingBy" clientidmode="Static" sortingby="Extension" />
                                <label for="chkExtension" meta:resourcekey="SortingContextMenu_Extension">Extension</label>
                                <br />
                                <input type="radio" runat="server" id="chkUpdated" name="SortingBy" clientidmode="Static" sortingby="LastModified" />
                                <label for="chkUpdated" meta:resourcekey="SortingContextMenu_Updated">Updated</label>
                                <br />
                                <input type="radio" runat="server" id="chkName" name="SortingBy" clientidmode="Static" sortingby="FileName" />
                                <label for="chkName" meta:resourcekey="SortingContextMenu_Name">Name</label>
                            </ItemTemplate>
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                        <telerik:RadMenuItem Value="SortingDirection">
                            <ItemTemplate>
                                <input type="radio" runat="server" id="chkAscending" name="SortingDirection" clientidmode="Static" sortingby="ASC" />
                                <label for="chkAscending" meta:resourcekey="SortingContextMenu_Ascending">Ascending</label>
                                <br />
                                <input type="radio" runat="server" id="chkDescending" name="SortingDirection" clientidmode="Static" sortingby="DESC" />
                                <label for="chkDescending" meta:resourcekey="SortingContextMenu_Descending">Descending</label>
                            </ItemTemplate>
                        </telerik:RadMenuItem>
                        <%-- <telerik:RadMenuItem Value="Open" Text="Open"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Bookmark" Text="Bookmark"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="CopyFolderUrl" Text="Copy Url"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Subscribe" Text="Subscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Unsubscribe" Text="Unsubscribe"></telerik:RadMenuItem>--%>
                    </Items>
                </telerik:RadContextMenu>

                <asp:Panel ID="pnlRoot" runat="server" Visible="false">
                    <telerik:RadGrid runat="server" ID="rdgRoot" AllowMultiRowSelection="false" SetWidth="true" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" FitPageHeightOffset="24"
                        ShowFooter="false" ShowGroupPanel="false" CssClass="rdgDocumentManager" GridLines="None" HeaderStyle-Font-Size="8" AppendMenus="true"
                        ClientSettings-Scrolling-AllowScroll="true" Width="100%" AllowFilteringByColumn="false" ClientSettings-Scrolling-UseStaticHeaders="true"
                        EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="false" Height="100%">
                        <HeaderStyle Font-Size="8pt" HorizontalAlign="Left" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None"
                            InsertItemDisplay="Top" EnableHeaderContextMenu="true">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="30px" Groupable="False" Reorderable="false"
                                    ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="FolderIcon" runat="server" style="cursor: default;" Enabled="false">
                                <span class="smallIcon" runat="server"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings Selecting-AllowRowSelect="true" ClientEvents-OnRowDblClick="OnNotesRowClick" ClientEvents-OnRowSelected="onRootRowSelected"
                            ClientEvents-OnRowDeselected="onRootRowDeselected" ClientEvents-OnRowCreated="onRootRowCreated" ClientEvents-OnGridCreated="onRootGridCreated">
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                    </telerik:RadGrid>

                    <div id="floatButton" runat="server" class="floatButton" onclick="openContextMenu(event)">
                        <span class="circle"></span>
                        <span class="circle"></span>
                        <span class="circle"></span>
                    </div>

                </asp:Panel>
            </telerik:RadPane>
        </telerik:RadSplitter>
                <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
                <asp:Button ID="btnUncheckAll" runat="server" CssClass="Hide" />
                <asp:Button ID="btnCheckAll" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hdnIsCardView" runat="server" />
                <asp:Button ID="btnRefreshCurrentWorkingFolder" runat="server" CssClass="Hide" />
                <asp:Button ID="btnRefreshFilesAndFolder" runat="server" CssClass="Hide" />
                <asp:Button ID="btnRefreshWithoutDetailsPane" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hdnFoldersToAdd" runat="server" />
                <asp:HiddenField ID="hdnFilesToAdd" runat="server" />
                <asp:HiddenField ID="hdnAllowVersioning" Value="false" runat="server" />
                <asp:Button ID="btnDownload" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hdnDownloadId" runat="server" />
                <asp:HiddenField ID="hdnFolderId" runat="server" />
                <asp:Button ID="btnSorting" runat="server" CssClass="Hide" />
                <asp:Button ID="btnUploadFile" runat="server" class="Hide" />
                <asp:FileUpload ID="uploadDragAndDrop" CssClass="Hide" EnableViewState="true" runat="server" AllowMultiple="true" />
                <asp:Button ID="btnUploadDragAndDrop" runat="server" class="Hide" />
                <telerik:RadAsyncUpload runat="server" Width="100%" CssClass="ProjectCenterUpload FolderManagerUpload Hide" ID="inputFile" Skin="Default" Style="height: 0 !important; border: 0 !important;"
                    MultipleFileSelection="Automatic" OnClientFileUploaded="onFileUploaded" OnClientFileSelected="onFileSelected" OnClientFileUploadFailed="onFileUploadFailed" OnClientValidationFailed="ClientFileValidationFailed" OnClientFileUploadRemoved="onFileUploadFailed"
                    HideFileInput="true">
                    <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                </telerik:RadAsyncUpload>
                <asp:Button ID="btnUploadFolder" runat="server" class="Hide" />
                <asp:LinkButton ID="btnShowSearch" runat="server" CssClass="Hide" />
                <asp:Button runat="server" ID="btnCardDoubleClick" OnClick="btnCardDoubleClick_Click" CssClass="Hide" />
                <asp:HiddenField ID="hfManageFolder" runat="server" />
                <asp:HiddenField ID="hfCanAddFiles" runat="server" />
                <asp:HiddenField ID="hfIsControlClicked" runat="server" />
                <asp:HiddenField ID="hfPreviouslySelectedCount" runat="server" Value="0" />
                <asp:Button ID="btnTreeStateChanged" runat="server" class="Hide" />
                <asp:HiddenField ID="hdnTreeWidth" runat="server" />
                <asp:HiddenField ID="hdnTreeCollapsed" runat="server" />
                <input type="hidden" runat="server" id="hdnSelectedFilesFolders" />


                <%--<asp:Button runat="server" ID="btnRDGClearSelection" OnclientClick="return DeselectItems();" CssClass="Hide" />--%>

                <div id="foldersDiv" class="FoldersDiv" style="display: none">
                    <table class="TableNoSpacingNoBorder" style="width: 100%">
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div class="RotatorPopup Hide">

                    <div id="PmMasterFader" class="Masterfader" style="position: relative;">

                        <div class="rrButton rrButtonRight" id="popupnext">&nbsp;</div>
                        <div class="rrButton rrButtonLeft" id="popupprev">&nbsp;</div>
                    </div>


                </div>
                <div id="flyoutBackdrop" onclick="javascript:return CloseMasterfader();" class="Hide" style="position: fixed; top: 0; right: 0; left: 0; bottom: 0; z-index: 7002; background-color: rgba(0,0,0,0.7);"></div>

                <telerik:RadWindow ID="rwm" runat="server"></telerik:RadWindow>

                <asp:Button ID="btnSaveExit" runat="server" CssClass="Hide" />
                <input type="hidden" runat="server" id="hdnCardViewSelected" />
            </asp:Panel>
            <asp:Button runat="server" ID="btnCardClick" OnClick="btnCardClick_Click" CssClass="Hide" />
            <asp:Button runat="server" ID="btnListViewRowClick" OnClick="btnListViewRow_Click" CssClass="Hide" />
            <asp:Button ID="btnDoubleCLick" runat="server" OnClick="btnGoToFolder_Click" CssClass="Hide" />
            <asp:Button ID="btnGoToFolder" runat="server" OnClick="btnGoToFolder_Click" CssClass="Hide" />
        </div>
    </form>
</body>
</html>
