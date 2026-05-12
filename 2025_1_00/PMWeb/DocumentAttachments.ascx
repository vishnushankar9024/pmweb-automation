<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentAttachments.ascx.vb"
    Inherits="Website.DocumentAttachments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc6" %>
<%@ Register Src="~/DocumentAttachments_DetailsPane.ascx" TagPrefix="uc6" TagName="DocumentAttachments_DetailsPane" %>


<%--<link runat="server" id="lnkCss" type="text/css" href="CSS/FolderManager.css" rel="stylesheet" />--%>


<style>
    .documentAttachment .RadGrid_Default .rgOptions {
    background-image: url(CSS/Images/ResponsiveIcons/16White.png);
    background-position: -64px 0px !important;
    background-repeat: no-repeat;
    transform: rotate(90deg);
    }

    .documentSinglePage, .documentMultiPages {
        margin-bottom: 0 !important;
    }

    .RadAjax.RadAjax_Default.detailLoadingPanel {
        position: absolute !important;
        z-index: 991 !important;
    }

    .RadMenu .rmGroup.rmVertical > .rmSeparator .rmText, .RadMenu .rmScrollWrap > .rmVertical > .rmSeparator .rmText {
        margin-left: 0;
    }

    .documentAttachment .rgDataDiv {
        height: 100% !important;
        max-height: calc(100vh - 386px);
    }

    .documentAttachment .floatButton {
        bottom: 24px;
    }
</style>

<telerik:radscriptblock id="RadScriptBlock1" runat="server">

    <script type="text/javascript">
        var lastCharPressed = 0;

        $(document).keydown(function(event){
            if(event.which == "17") // cntrl
                lastCharPressed= 17;
            else if(event.which == "16") // shift
                lastCharPressed = 16
            else // reset
                lastCharPressed = 0;
        }) 

        $(document).keyup(function(event){
            lastCharPressed = 0; // reset
        })
        $(document).ready(function () {
            var arrSelected = {};
        });

        function OpenCommentEditorPopup(URL, Width, Height) {
                 
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL+ '&Source=DocumentAttachment');
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
            wnd.setSize(464, 512);
            wnd.Center();
            wnd.add_close(refreshPage);
            return false;
        }

        function Open3DViewer(ObjectType, ObjectId, FileGUID) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen('PMWeb3DViewer.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId + '&FileGUID=' + FileGUID, null);
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.add_close(refreshPage);
            return false;
        }

        function downloadAttachment() {
            var btnDownloadAttachment = document.querySelector('.downloadAttachment');
            btnDownloadAttachment.click();
            return false;
        }

        var rdgDocumentAttachmentsId = "<%= rdgDocumentAttachments.ClientID %>"
        var cmFileActions = "<%=cmFileActions.ClientID %>";
        var folderContextMenu = "<%=addContextMenu.ClientID%>"
    
        function openFileActionContextMenu(evt) {
            if(event == undefined)
            {
                var contextMenu = $find(cmFileActions);
                contextMenu.showAt('50', '50');
                return;
            }
            var contextMenu = $find(cmFileActions);
            contextMenu.showAt('50', '50');
            $telerik.cancelRawEvent(evt);
        }

        function openFileActionContextMenuFromGrid(sender,args) {
            var contextMenu = $find(cmFileActions);
            contextMenu.showAt('50', '50');
            var evt = args.get_domEvent();
            $telerik.cancelRawEvent(evt);
        }

        function openFolderContextMenu(args) {
            var mainToolBar = $find($("[id$=mainToolBar]")[1].id);
            var contextMenu = $find(folderContextMenu);
            var toolbarAdd = mainToolBar.findItemByText("Add");
            contextMenu.showAt(toolbarAdd._element.getBoundingClientRect().x, toolbarAdd._element.getBoundingClientRect().y + 27); /* getBoundingClientRect() used to track the position ofthe add button in the toolbar */
            var evt = args.get_domEvent();
            $telerik.cancelRawEvent(evt);
        }

        function OpenRedlining(url)
        {
            window.location.href = url;
        }

        function mainToolBar_clicked(sender, args) {
            var value = args.get_item().get_value();
            switch (value) {
                case "toolbarDelete":
                    if (!confirm(Msg_ConfirmDeleteDocument)) {
                        args.set_cancel(true);
                    }
                    break;
                case "Sort":
                    openSortingContextMenu(args);
                    break;
                case "Add":
                    openFolderContextMenu(args)
                    break;
                case "Details":
                    var detailsPane = document.querySelector(".detailsPane");
                    var filesGridPane = document.querySelector(".filesGridPane");

                    if (window.innerWidth < 843) {
                        detailsPane.style.display = "block";
                        filesGridPane.style.display = "none";
                        return false;
                    }

                    var IsShowing = args.get_item()._element.querySelector("a").classList.contains("Enabled");                  
                    
                    if (IsShowing) {
                        detailsPane.classList.add("slideRight");
                        detailsPane.classList.add("HideDetailPaneForAssets");
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
                        detailsPane.classList.remove("HideDetailPaneForAssets");
                        setTimeout(function(){
                            filesGridPane.classList.remove("transition");
                            detailsPane.classList.remove("slideRight");
                        } , 500);
                        args.get_item()._element.querySelector("a").classList.remove("Disabled");
                        args.get_item()._element.querySelector("a").classList.add("Enabled");
                    }
                    //return false;
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/UpdateDocumentAttachmentsDetailPaneVisibility",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ isDetailPaneVisible: !IsShowing }),
                        dataType: "json",
                        async: true,
                        error: function (data) {
                            console.log('The action could not be taken, please refresh the page and try again.');
                        }
                    });
                    break;
            }
            return false;
        }

        function closeDetailPane(){
            $("[id$=DetailsPane]").css("display" , "none");
            $("[id$=filesGridPane]").css("display" , "block");
        }


        function ShowImage(src) {
            if (src == undefined) {
                var Image = document.querySelector(".imgDisplay");
                src = Image.src;
            }
            $("#flyoutBackdrop ,.RotatorPopup").removeClass("Hide");
            $('#PmMasterFader img').remove();
            $('<img src="' + src + '" style="border-width:0px;max-height:320px;" >').prependTo("#PmMasterFader");
            var flyout = $(".RotatorPopup")[0]
            var flyoutBackdrop = $('#flyoutBackdrop')[0]
            flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
            flyout.className = flyout.className.replace(' Hide', '');
            return false;
        }

        function Download(Id) {
            var btn = document.querySelector(".download");
            //var hdnFieldDownload = document.querySelector("#ctl00_CPH1_DocumentAttachments_hdnFieldDownload");
            var hdnFieldDownload=$("[id$=hdnFieldDownload]")[0];
            hdnFieldDownload.value = Id;
            btn.click();
            return false;
        }

        function OpenPDFViewer(strFullFileName) {
            window.open('app/viewerpdf/' + strFullFileName, "_blank"); 
            return false;
        }

        function activatePMwebViewer() {
            var btn = document.querySelector(".PmWebViewer");
            btn.classList.add("active");
            return false;
        }

        function FileActionsItemShowing(sender, args) {
            var isCardView = $("[id$=hfIsCardView]").val().toLowerCase() === '1';
            var selectedItem,hasAnnotation,PMWebViewer,has3DViewer,extension,aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW,isEligible,isInBluebeamSession,FileOption;
            var download = true;
            var isn
            var imgExtensions =["jpg", "jpeg", "png", "gif", "pdf"];
           //var fileExtensions=["as", "bmp", "css", "csv", "doc", "docx", "dwf", "dwfx", "dxf" ,"gif", "jpe", "jpeg", "jpg", "pdf", "png", "ppt", "pptx", "rar", "rvt", "swf", "template", "txt", "xls", "xlsx", "xml", "xsl", "zip"]
           
            $("[id$=hdnCardViewSelected]").val() ?  arrSelected =  $("[id$=hdnCardViewSelected]").val().split(',,') :arrSelected = [];
            arrSelected = arrSelected.filter(x => x!= "");
            var selected = arrSelected.length > 0;
            if(!isCardView)
            {
                var rdgAttachments = $find(rdgDocumentAttachmentsId) ? $find(rdgDocumentAttachmentsId).get_masterTableView() : null;
                if(rdgAttachments && arrSelected.length > 0){
                    selectedItem = rdgAttachments.get_selectedItems()[0].get_element();
                    hasAnnotation = selectedItem.getAttribute("HasAnnotation").toLowerCase() === "true" ? true : false;
                    has3DViewer = selectedItem.getAttribute("has3DViewer");
                    PMWebViewer = selectedItem.getAttribute("PMWebViewer").toLowerCase() === 'true';
                    extension = selectedItem.getAttribute("Extension");
                    //isEligible = selectedItem.getAttribute("isEligible") && selectedItem.getAttribute("isEligible").toLowerCase() === 'true';
                    isEligible = true;
                    rdgAttachments.get_selectedItems().forEach(function(cur){
                        if (cur.get_element().getAttribute("isEligible") && cur.get_element().getAttribute("isEligible").toLowerCase() === 'false')
                            isEligible = false;
                    });
                    isInBluebeamSession = selectedItem.getAttribute("IsInBluebeamSession") && selectedItem.getAttribute("IsInBluebeamSession").toLowerCase() === 'true';
                    aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW = selectedItem.getAttribute("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW") && selectedItem.getAttribute("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW").toLowerCase() === 'true';
                    FileOption = rdgAttachments.get_selectedItems()[0].getDataKeyValue("FileOption");
                }
                else{
                    extension = "";
                    PMWebViewer = false
                    hasAnnotation = false;
                    has3DViewer = false;
                    download = false
                    FileOption = ""
                }
            }
            else{
                
                selectedItem = $('.card.active').first();
                if(selectedItem.length > 0){
                    PMWebViewer = selectedItem.attr("PMWebViewer").toLowerCase() === 'true';
                    hasAnnotation = selectedItem.attr("HasAnnotation") === "1" ? true : false;
                    has3DViewer = selectedItem.attr("has3DViewer") === "true";
                    extension = selectedItem.attr("Extension");
                    isEligible = selectedItem.attr("isEligible") && selectedItem.attr("isEligible").toLowerCase() === 'true';
                    isInBluebeamSession = selectedItem.attr("IsInBluebeamSession") && selectedItem.attr("IsInBluebeamSession").toLowerCase() === 'true';
                    aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW = selectedItem.attr("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW") && selectedItem.attr("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW").toLowerCase() === 'true';
                    FileOption = selectedItem.attr("FileOption");
                }
                else{
                    extension = "";
                    PMWebViewer = false
                    hasAnnotation = false;
                    has3DViewer = false;
                    download = false;
                    FileOption = ""
                }
            }
            var menuItems = sender.get_allItems();
            for (var i = 0; i < menuItems.length; i++) {
                var item = sender.get_allItems()[i];
                item.set_visible(false);
                switch (item.get_value()) {
                    case "Download":
                        download && extension != "Folder" && extension!="link" && selected ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "PMWebViewer":
                        if(arrSelected.length === 1)
                            hasAnnotation.toString() === 'false' && PMWebViewer ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "Delete":
                        download && selected ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "View":
                        if(imgExtensions.indexOf(extension.toLowerCase()) > -1 && arrSelected.length === 1)
                            item.set_visible(true);
                        break;
                    case "Replace File" :
                        if(FileOption == "UPLOAD" && arrSelected.length === 1)
                            item.set_visible(true);
                        break;
                    case "3DViewer":
                        if(arrSelected.length === 1)
                            has3DViewer ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "GoToPMWebViewer":
                        if(arrSelected.length === 1)
                            hasAnnotation.toString() === 'true' && PMWebViewer ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "SendToStudio":
                        if(arrSelected.length > 0 && isEligible)
                            item.set_visible(true);
                        break;
                    case "GoToBluebeamMarkups":
                        if(arrSelected.length === 1 && isEligible)
                            isInBluebeamSession ? item.set_visible(true) : item.set_visible(false);
                        break;
                    default:
                        item.set_visible(true);
                }
            }
            var deleteItem = sender.findItemByValue("Delete");
            var downloadItem = sender.findItemByValue("Download");
            var addSeperator2  = sender.findItemByValue("AddSeperator2");
            var addSeperator1  = sender.findItemByValue("AddSeperator1");
            addSeperator2.set_visible(deleteItem.get_visible());
            addSeperator1.set_visible(downloadItem.get_visible());

        }
   
        function CheckChanged(){
            document.querySelector(".saveCheck").click();
            return false;
        }

        function FileActionsItemClicking(sender, args) {

            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var menuItem = args.get_item();

            var rdgAttachments, Id, isFolder, selectedIds;
            var isCardView = $("[id$=hfIsCardView]").val().toLowerCase() === '1';
            if(arrSelected.length > 0)
            {
                if (isCardView) {
                    selectedItems = $('.card.active');
                    selectedIds = selectedItems.map(function(el){return $(this).attr("data-Id");}).toArray().join(',');
                    selectedItem = selectedItems.first();
                    Id = selectedItem.attr("data-Id");
                    $("[id$=hdnCardViewSelected]").val("");
                    $(".card.active").each(function(){
                        $("[id$=hdnCardViewSelected]").val( $("[id$=hdnCardViewSelected]").val() + $(this).attr("data-id") + ",,");
                    });

                } else {
                    if ($find(rdgDocumentAttachmentsId)){
                        rdgAttachments = $find(rdgDocumentAttachmentsId).get_masterTableView();
                        Id = rdgAttachments.get_selectedItems()[0].getDataKeyValue("Id");
                        selectedItems = rdgAttachments.get_selectedItems();
                        selectedIds = selectedItems.map(function(el){return el.getDataKeyValue("Id")}).join(',');
                        selectedItem = rdgAttachments.get_selectedItems()[0];
                    }
                }
            }


            switch (menuItem.get_value()) {
                case "View":
                    if (isCardView) {
                        ShowImage(selectedItem.find(".imgDisplay").attr('src'));
                    } else {
                        var lnkImageAction = selectedItem.findElement("imgAction");
                        if (lnkImageAction)
                            lnkImageAction.click();
                    }
                    args.set_cancel(true);
                    break;
                case "FromComputer":
                    var btn = $('[id$=rauAttachment] .ruFileInput')[0];
                    btn.click();
                    args.set_cancel(true);
                    break;
                case "LinkProjectEmail":
                    //OpenPOPUp('EmailHomePopup.aspx?EntityId=' + DocId, 1080, 510, false);                   
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('EmailHomePopup.aspx?EntityId=' + DocId);
                    var divWindow = wnd._popupElement;
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
                    wnd.add_close(WindowClosed);

                    args.set_cancel(true);
                    break;
                case "LinkWebUrl":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("LinkWebUrlPopUp.aspx");
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
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
                    args.set_cancel(true);
                    break;
                case "SharePoint":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();;
                    var wnd = window.radopen("LinkWebUrlPopUp.aspx?isSharePoint=1");
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.4);
                        wnd.Center();
                    }
                    break;
                case "LinkPmwebRecord":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height()
                    var wnd = window.radopen('GlobalLinkedRecords.aspx?Id=' + 0 + '&ProjectId=' + entityId + '&Source=DocumentAttachment');
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    break;
                case "FromDocumentManager":
                    OpenFolderManagerPopup();
                    break;
                case "Aconex":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('AconexDocumentsLookup.aspx?EntityId=' +  DocId );
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    break;

                case"Replace File":
                    var btn = $('[id$=fileupload_Edit] .ruFileInput')[0];
                    btn.click();
                    args.set_cancel(true);         
                    break;
                case "Add":
                    return;
                case "Delete":
                    ConfirmDelete() ? args.set_cancel(false) : args.set_cancel(true);
                    break;
                case "SendToStudio":
                    return OpenMultipleCompaniesFilePopup(selectedIds);
                    args.set_cancel(true);
                    break;
            }
            sender.hide();

        }

        function editFileUpload(){
            if($('[id$=fileupload_Edit] .ruFileInput')[0].value != ''){
                setTimeout(function(){
                    __doPostBack($('[id$=btnUploadEdit]')[0].name, '');
                }, 300)
            }
  
        }
        function OpenMultipleCompaniesFilePopup(FileIds) {
            return OpenWindowPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Contacts&txtIds=NotExist&ddlType=Multiple&Source=BLUEBEAMMARKUPS&ProjectId=0&ProjectRequired=0&FileIds=' + FileIds + '&FilesSource=UPLOAD', 900, 420);
        }
        function OpenFolderManagerPopup() {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen('FilesLookup.aspx?EntityId=' + DocId + '&MultiSelect=1');
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.add_close(refreshPage);
            return false;
        }
        function refreshPage()
        {
            document.querySelector(".Refresh").click();
        }
        var DocId = '<%=Me.PM.DocumentAttachmentInfo.EntityTypeId %>' + "_" + '<%=Me.PM.DocumentAttachmentInfo.EntityId %>'
        var recordId=<%=Me.PM.DocumentAttachmentInfo.DocumentId %>
        var documentType='<%=Me.PM.DocumentAttachmentInfo.DocumentType %>'
        var ALLOWED_IMAGE_EXTENSION = '<%=Me.PM.Parameters.ALLOWED_IMAGE_EXTENSION%>'

        function ddlItems_OnClientSelectedIndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            if (item != null) {
                var EntityId = item._attributes.getAttribute("EntityId");
                if (EntityId > 0) {
                    var hdnEntityId = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnEntityId');
                    if (hdnEntityId != null) {
                        $(hdnEntityId).val(EntityId);
                    }
                }
            }
        }

        function onRowDeSelected(sender, args) {
            var id = args.getDataKeyValue("Id");
            arrSelected = arrSelected.filter(x => x != id);
            $("[id$=hdnCardViewSelected]").val().replace(arrSelected.join(",,"));
            if (args.get_domEvent().target) {
                var selectCheckBox = args.get_domEvent().target.closest("input");
                if (selectCheckBox) {
                    if (selectCheckBox.id.indexOf("SelectCheckBox") > -1) {
                        __doPostBack($("[id$=btnListViewRowClick]")[0].name, args.get_itemIndexHierarchical());
                    }
                }
            }
            changeToolbarButtonsVisibility();
        }
        var arrSelected = [];
        function onRowSelected(sender, args) {
            var target = args.get_domEvent().target;
            var clickEvent = event;
            var id = args.getDataKeyValue("Id");
            arrSelected = [];
            for(var i=0; i< sender.get_masterTableView().get_selectedItems().length; i++)
            {
                arrSelected.push(sender.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Id"))
            }
            $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,") + ",,");
            if (!target && lastCharPressed == 16) {
                if (clickEvent)
                    if (clickEvent.target)
                        if (clickEvent.target.closest("tr")) {
                            var row = clickEvent.target.closest("tr");
                            if (args.get_id() === row.getAttribute("id")) {
                                folderManagerPendingClick = setTimeout(function () {
                                    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
                                }, 300)
                            }
                        }
                return false;
            }
            if (target) {                
                folderManagerPendingClick = setTimeout(function () {
                  
                    if (target) {
                        var a = target.closest("a");
                        if (a) {
                            if (a.id.indexOf("imgAction") > -1 || a.id.indexOf("lbtIconViewer") > -1) {
                                args.get_gridDataItem().set_selected(false);
                                return false;
                            }
                        }
                    }
                    if(args.get_domEvent().button){
                        //args.get_gridDataItem().set_selected(false);
                        return false;
                    }
                    __doPostBack($("[id$=btnListViewRowClick]")[0].name, '');
                }, 300);
            }
            changeToolbarButtonsVisibility();
        }
        
        function HideToolbarButtons(){
            var mainToolBar = $find($("[id$=mainToolBar]")[1].id);
            var toolbarDelete = mainToolBar.findItemByValue('toolbarDelete');
            var toolbarDownload = mainToolBar.findItemByValue('toolbarDownload');
            var toolbarBluebeam = mainToolBar.findItemByValue('toolbarBluebeam');
            toolbarDownload.set_visible(false);
            toolbarDelete.set_visible(false);
            toolbarBluebeam.set_visible(false);
        }

        function changeToolbarButtonsVisibility(){
            //to view or hide delete and download toolbar buttons when a card is selected
            try { 
                var res = getSelectedItemsFromDatabase();
            }
            catch (e) {
                HideToolbarButtons()
                return;
            }
            
            var isVisible = true;
            var isEligible = true;
            
            var mainToolBar = $find($("[id$=mainToolBar]")[1].id);
            var toolbarDelete = mainToolBar.findItemByValue('toolbarDelete');
            var toolbarDownload = mainToolBar.findItemByValue('toolbarDownload');
            var toolbarBluebeam = mainToolBar.findItemByValue('toolbarBluebeam');

            if (toolbarDelete) 
                (isVisible && res.length > 0) ? toolbarDelete.set_visible(true) : toolbarDelete.set_visible(false)
            var canDownload = true;
            res.forEach(function(cur){
                if (cur.IsFolder || cur.Extension == "url" || cur.Extension == "link") canDownload=false;
                if (!cur.IsEligible) { isEligible = false;}
            });   
            if (toolbarDownload)
                (res.length > 0 && canDownload) ? toolbarDownload.set_visible(true) : toolbarDownload.set_visible(false);

            if (toolbarBluebeam)
                (isEligible && res.length > 0) ? toolbarBluebeam.set_visible(true) : toolbarBluebeam.set_visible(false);
        }
        
        function  getSelectedItemsFromDatabase(){
            class Selection {
                constructor(IsEligible, Extension, IsFolder, Id) {
                    this.IsEligible = IsEligible;
                    this.Extension = Extension;
                    this.IsFolder = IsFolder;
                    this.Id = Id;
                }
            }
            var result = [];
            var isCardView = $("[id$=hfIsCardView]").val().toLowerCase() === '1';
            if (!isCardView){
                var rdgFiles = $find($("[id$=rdgDocumentAttachments]")[0].id).get_masterTableView();
                for (var i = 0; i < rdgFiles.get_selectedItems().length; i++) {
                    var row = rdgFiles.get_selectedItems()[i];
                    var isFolder = row.getDataKeyValue("Extension") == "Folder";
                    var id = row.getDataKeyValue("Id");
                    var isEligible = row.get_element().getAttribute("iseligible") && row.get_element().getAttribute("iseligible").toLowerCase() === 'true';
                    var extension = row.get_element().getAttribute("extension");
                    var item = new Selection(isEligible, extension, isFolder, id);
                    result.push(item);
                }
            }else{
                $('.card.active , .folderCard.active').each(function () { 
                    var cur = $(this);
                    var isFolder = cur.attr('Extension') == "Folder";
                    var id = cur.attr('data-id');
                    id = id.slice(id.indexOf("_") + 1);
                    var isEligible = cur.attr("isEligible") && cur.attr("isEligible").toLowerCase() === 'true';
                    var extension = cur.attr("extension");
                    var item = new Selection(isEligible, extension, isFolder, id);
                    result.push(item);
                });
            }
            return result;
        }

        function mainToolBar_ClientLoad(sender, args){
            changeToolbarButtonsVisibility();
        }

        function onRowCreated(sender, args) {
            var id = args.getDataKeyValue("Id");
            if (arrSelected[id])
                args.get_gridDataItem().set_selected(true);
        }


        function rdgDocumentAttachment_OnRowContextMenu(sender, args) {
            arrSelected = $("[id$=hdnCardViewSelected]").val().split(",,");
            arrSelected = arrSelected.filter(el => el != "");
            var item = args.get_gridDataItem();
            if(arrSelected.indexOf(item.getDataKeyValue("Id")) > -1)
            {
                openFileActionContextMenu(event);
            } else {
                sender.clearSelectedItems();
                var item = args.get_gridDataItem();
                item.set_selected(true);
                $("[id$=hdnCardViewSelected]").val(item.getDataKeyValue("Id"));
                __doPostBack($("[id$=btnListViewRowClick]")[0].name, 'context');
            }
        }

        function saveNotes() {
            var btnSaveNotes = document.querySelector('.SaveNotes');
            btnSaveNotes.click();
        }

        function onCardViewSingleClick(e) {
            if (e && e.target && (e.target.tagName.toLowerCase() === "a")) {
                return;
            }
           
            let cur = $(this);
            let id = cur.attr('data-Id');
            let isActive = cur.hasClass('active');
            if( e && e.target && e.target.parentElement && (e.target.classList.contains('check') || e.target.parentElement.classList.contains('check'))){
                cur.toggleClass('active');
                !isActive ? arrSelected.push(id) : arrSelected.splice(arrSelected.indexOf(id), 1);
                $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,"))
            }else
                switch(lastCharPressed){
                    case 0 : // others
                        var hasMultipleSelection = arrSelected.length > 1;
                        arrSelected = [];
                        $(".cardView .card , .cardView .folderCard").removeClass('active');
                        if (!isActive || (isActive && hasMultipleSelection)) {
                            arrSelected.push(id);
                            cur.addClass('active');
                        }
                        $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,"))
                        break;

                    case 16 : //shift
                        $(".cardView .card").removeClass('active');
                        arrSelected = $("[id$=hdnCardViewSelected]").val().split(",,");
                        var lastSelected = arrSelected[0];
                        if(lastSelected){
                            var arr =  $(".cardView .card").map(function(){return $(this).attr('data-id')}).toArray();
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
                            $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,"))
                        }
                        else{
                            arrSelected = [];
                            if (!isActive){
                                arrSelected.push(id);
                                cur.toggleClass('active');
                            }
                        }
                        $("[id$=hdnCardViewSelected]").val("");
                        arrSelected.forEach(el => $("[id$=hdnCardViewSelected]").val($("[id$=hdnCardViewSelected]").val() + el + ",,"));
                        break;
                    case 17: // cntrl
                        arrSelected = [];
                        arrSelected =  $("[id$=hdnCardViewSelected]").val().split(",,");
                        arrSelected = arrSelected.filter(el => el != "");
                        cur.toggleClass('active');
                        arrSelected.push(id);
                        $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,"));
                        break;

                }
            $("[id$=btnCardClick]").click();
            changeToolbarButtonsVisibility();
        }

        function lazyLoadGridThumbnails() {
            const lazyImages = document.querySelectorAll(".lazy-thumbnail");
            const observer = new IntersectionObserver((entries, observer) => {
                const grid = $find(rdgDocumentAttachmentsId);
                const masterTableView = grid.get_masterTableView();
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        const rowElement = $(img).closest("tr")[0];
                        const dataItem = masterTableView.get_dataItems()[rowElement.rowIndex - 1];
                        if (img.src.toLowerCase().endsWith("whitedot.gif")) {
                            img.src = getThumbnailPath(dataItem.getDataKeyValue('FullFileName'), dataItem.getDataKeyValue('ThumbnailGUID'), dataItem.getDataKeyValue('IsphysicallyExists'));
                        }
                        observer.unobserve(img);
                    }
                });
            });
            lazyImages.forEach(img => observer.observe(img));
        }

        function setCardViewEvents() {
            $("[id$=hdnCardViewSelected]").val() ?  arrSelected =  $("[id$=hdnCardViewSelected]").val().split(',,') :arrSelected = [];
            $(".cardView").unbind('click');
            $(".cardView").on('click', '.card', onCardViewSingleClick);
            $(".cardView").on('contextmenu', '.card', onCardViewContextMenuClick);
            $('.js-sort').unbind('change');

            //$("[id$=dropZone]").contextmenu(function (e) {
            //    e.preventDefault();
            //});

            $('.Js-DropZone')[0].addEventListener('scroll', loadCardThumbnails);
            $('.js-sort').on('change' ,'input[type="radio"]' , function(){
                var selectedSort = '';
                $('.js-sort input[type="radio"]:checked').each(function(){
                    selectedSort += $(this).attr("sortingBy") + ",";
                });
                __doPostBack($('[id$=btnSorting]')[0].name,selectedSort);
            })
        }
        function loadCardThumbnails(){
            $.each($('.card'), function() {
                var FolElem = $(".Js-DropZone")[0];
                var card = $(this)[0].children[0];
                var cardimg = card.getElementsByClassName('content')[0].firstElementChild
                if ((card.offsetTop <= (FolElem.scrollTop + 414 + card.clientHeight)) 
                    && this.hasAttribute('tguid') 
                    && cardimg.src.toLowerCase().includes("css/images/foldermanagericons/")){
                    cardimg.src = getThumbnailPath(this.getAttribute('name'), this.getAttribute('tguid'), this.getAttribute('ph'));
                }
            })
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

        function onCardViewContextMenuClick() {
            event.preventDefault();
            var cur = $(this)[0];
            var id = cur.getAttribute('data-Id');
            arrSelected = $("[id$=hdnCardViewSelected]").val().split(",,");
            arrSelected = arrSelected.filter(el => el != "");
            if (arrSelected.indexOf(id) > -1){
                openFileActionContextMenu(event);
                return;
            }
            arrSelected = [];
            $(".cardView .card").removeClass('active');
            cur.classList.add('active');
            arrSelected.push(id);
            $("[id$=hdnCardViewSelected]").val(arrSelected.join(",,"));
            __doPostBack($('[id$=btnCardClick]')[0].name,"context")
        }
        var entityId = '<%=Me.PM.DocumentAttachmentInfo.EntityId  %>'

        function addContextMenuClick(sender, args) {
            var menuItem = args.get_item();
            switch (menuItem.get_value()) {
                case "FromComputer":
                    var btn = $('[id$=rauAttachment] .ruFileInput')[0];
                    btn.click();
                    break;
                case "LinkProjectEmail":                             
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('EmailHomePopup.aspx?EntityId=' + DocId);
                    var divWindow = wnd._popupElement;
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
                    wnd.add_close(WindowClosed);


                    return false;
                    break;
                case "LinkWebUrl":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();;
                    var wnd = window.radopen("LinkWebUrlPopUp.aspx");
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.4);
                        wnd.Center();
                    }
                    break;
                case "SharePoint":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();;
                    var wnd = window.radopen("LinkWebUrlPopUp.aspx?isSharePoint=1");
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.4);
                        wnd.Center();
                    }
                    break;
                case "LinkPmwebRecord":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height()
                    var wnd = window.radopen('GlobalLinkedRecords.aspx?Id=' + 0 + '&ProjectId=' + entityId + '&Source=DocumentAttachment');
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    break;
                case "FromDocumentManager":
                    OpenFolderManagerPopup();
                    break;
                case "Aconex":
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('AconexDocumentsLookup.aspx?EntityId=' +  DocId );
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    divWindow.classList.add("rwFolderManager");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    break;
                    
            }
            sender.hide();
        }

       
        function wssClick(sender)
        {
            var url = sender.getAttribute("url");
            __doPostBack($("[id$=lbtWSS]")[0].name,url);
            return true;
        }
        function AconexClick(sender)
        {
            var url = sender.getAttribute("url");
            __doPostBack($("[id$=lbtAconex]")[0].name,url);
            return true;
        }

        //------ Sorting Context Menu

       

        var cmSorting;
        cmSorting = "<%=cmSorting.ClientID %>"

        function openSortingContextMenu(args) {
            var contextMenu = $find(cmSorting);
            contextMenu.showAt('50', '50');
            var evt = args.get_domEvent();
            $telerik.cancelRawEvent(evt);
        }

        //------- Drag and Drop files and folders

      


        function unbindDropEvent()
        {
            var dropZone = document.querySelector('.Js-DropZone');
            if(!dropZone) return;
            dropZone.removeEventListener('drop',DropEvent);
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
            dropZone.addEventListener('drop',DropEvent); 
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

            var totalSize = 0
            for(var i=0;i<filesList.length;i++)
            {
                lst.items.add(filesList[i]);
                totalSize = totalSize + filesList[i].size;
            }
            if (totalSize >= 2147483648) {
                alert("Uploads cannot be more than 2 GB");
                return;
            }
            var uploadDragAndDrop = document.querySelector(".uploadDragAndDrop");
            uploadDragAndDrop.files = lst.files;
            if(files.length>  0 || folders.length > 0)
            {
                var btn = document.querySelector(".btnUploadDragAndDrop");
                btn.click();
            }

        }

       
      
        //--------Comments----------//

        function OpenCommentsPopup(sender) {
                
            var RecordId = sender.getAttribute('RecordId');
            var recordType = sender.getAttribute("RecordType");
            var wnd = window.radopen('CommentDialogPopup.aspx?RecordId=' + RecordId + '&RecordType=' + recordType+  '&Source=DocumentAttachment', true);
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
            wnd.setSize(464, 512);
            wnd.center();
            wnd.add_close(refreshPage);
            return false;
        }
        var uploadsDocFileInProgress = 0;

        function onDocFileSelected(sender, args) {
            var fileName = args.get_fileName()
            var extension = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2)
            if (extension == '') {sender.deleteAllFileInputs(); alert("You can't drop a folder"); return;}

            var ldp =  $find("ctl00_ldpPM");
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
                if(ldp) ldp.hide('ctl00_CPH1_DocumentAttachments_filesGridPane')
            }
        }

        function decrementUploadsDocFileInProgress() {
            uploadsDocFileInProgress--;
        }

        function ClientDocFileValidationFailed(sender, args) {
            decrementUploadsDocFileInProgress();
            alert(WarningMsg_InvalidFile);
        }

        //function onClientFileUploaded(sender, args) {
        //    __doPostBack("rauAttachment", "");
        //}
        function OpenInNewTab(Url) {
            window.open(Url,"_blank");           
        }
        function MergePrintPopupt(Id) {
            var  wnd;
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
          
            wnd = window.radopen("MergePrintPopup.aspx?AttachmentId=" + Id + "&Source=DocumentAttachment" );
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize( browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwFolderManager");
            wnd.add_close(refreshPage);
            return false;

        }
        function OpenGoogleAddressesPicker() {
            var Id = '<%= PM.DocumentAttachmentInfo.Id %>';
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            if (Id > 0) {
                var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=ATTACHMENTS&ObjectId=" + Id + "&PickerSender=RecordAddress");
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
            }
            return false;
        }
       
    </script>

</telerik:radscriptblock>
<telerik:radajaxloadingpanel id="detailAttachmentLoadingPanel" cssclass="detailLoadingPanel" runat="server" />
<telerik:radajaxmanagerproxy id="RamWorKOrderResource" runat="server">
</telerik:radajaxmanagerproxy>

<div class="Folder_DocumentManager documentAttachment">
    <div style="width: calc(100% - 24px); margin-top: -1px" class="menu" id="menuToolbar" runat="server">
        <telerik:radtoolbar id="mainToolBar" onclientbuttonclicked="mainToolBar_clicked" runat="server" autopostback="true" OnClientLoad="mainToolBar_ClientLoad">
            <Items>
                <telerik:RadToolBarButton SecurityButtonType="Read" CssClass="Add" Value="Add" ImageUrl="Images/ToolBar/Save.png" PostBack="false"
                    CommandName="Add" AccessKey="s" ToolTip="Save (Alt+s)" Text="Add">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" Text="Delete" CssClass="toolbarDelete" ImageUrl="Images/ToolBar/Delete.png"
                    CommandName="toolbarDelete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="toolbarDelete" OnClientClick="return ConfirmDelete()">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" Text="Download" CssClass="toolbarDownload"
                    CommandName="toolbarDownload"  Value="toolbarDownload" ImageUrl="Images/ToolBar/Download.png">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" Text="Send to Studio" CssClass="toolbarBluebeam"
                    CommandName="toolbarBluebeam"  Value="toolbarBluebeam" ImageUrl="Images/ToolBar/Bluebeam.png">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton Value="AddSeperator" IsSeparator="true" CssClass="HideOnMobileToolbar">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="Details" CssClass="Enabled" PostBack="false"
                    CommandName="Details" AccessKey="s" Text="Details">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="CardView"
                    CommandName="CardView" AccessKey="s" ToolTip="Save (Alt+s)" Text="Card View">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="ListView"
                    CommandName="ListView" AccessKey="s" ToolTip="Save (Alt+s)" Text="List View">
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="Sort" PostBack="false"
                    CommandName="Sort" AccessKey="s" ToolTip="Save (Alt+s)" Text="Sort">
                </telerik:RadToolBarButton>
            </Items>
        </telerik:radtoolbar>
        <telerik:radmenu id="rdmAttachmentLayouts" style="float: none; display: inline-block; margin-left: -10px; vertical-align: middle;" securitybuttontype="ItemMode" enableroundedcorners="true" enableautoscroll="true"
            collapseanimation-type="None" onitemclick="rdmAttachmentLayouts_ItemClick" onclientitemclicking="rdmLayouts_ItemClicking"
            runat="server" enableselection="true" cssclass="trvContextMenu bringToBack rdmLayouts HideOnMobileToolbar "
            enableshadows="true" causesvalidation="false"
            visible="true">
        </telerik:radmenu>
    </div>
    <div class="PMMainPage">
        <div class="row row-8-4-fit8">
            <div class="col-8 filesGridPane" id="filesGridPane" runat="server" style="z-index: 995">
                <div class="Js-DropZone" style="height: calc(100vh - 260px)" id="dropZone" runat="server">
                    <telerik:radgrid id="rdgDocumentAttachments" clientsettings-enablepostbackonrowclick="false" runat="server" allowmultirowselection="true" autogeneratecolumns="false" cssclass="rdgDocumentManager rgHeaderRightBorder"
                        gridlines="None" headerstyle-font-size="8" setwidth="true" appendmenus="true" autogenerateeditcolumn="false" autogeneratedeletecolumn="false" clientsettings-allowdragtogroup="true"
                        showstatusbar="false" clientsettings-scrolling-allowscroll="true" clientsettings-allowcolumnsreorder="true"
                        allowsorting="true" showfooter="false" width="100%" allowfilteringbycolumn="True" filtertype="HeaderContext" clientsettings-scrolling-usestaticheaders="true" fitpageheightoffset="5"
                        enableheadercontextmenu="True" enableheadercontextfiltermenu="True" clientsettings-resizing-allowcolumnresize="true" mastertableview-allowmulticolumnsorting="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderStyle Font-Size="8pt" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                            CommandItemDisplay="None" DataKeyNames="Id" ClientDataKeyNames="Id,Extension,FileOption,FullFileName,IsphysicallyExists,ThumbnailGUID">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" AllowSorting="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server" OnClick="imgAction_Click">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="" AllowSorting="false" Groupable="False" UniqueName="Icon"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgRedlining" runat="server" style="cursor: default;" Enabled="false">
                                            <span id="spanImg" class="smallIcon" runat="server"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                    <HeaderStyle Width="30px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" SortExpression="Name" Groupable="true" GroupByExpression="Name [GridColumn_FileName] Group By Name ASC"
                                    DataField="Name" ItemStyle-HorizontalAlign="Left" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%# Eval("Name") %></span>
                                        <%--<span><%# IIf(Eval("FileOption").ToString() = "URL", IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").ToString()), IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").Split("."c)(0).ToString())) %></span>--%>
                                    </ItemTemplate>
                                    <ItemStyle />
                                    <HeaderStyle Width="180px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description" Groupable="true"
                                    DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Resizable="true">
                                    <ItemTemplate>
                                        <span><%# Eval("Description") %></span>
                                    </ItemTemplate>
                                    <ItemStyle />
                                    <HeaderStyle Width="220px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                 <telerik:GridTemplateColumn HeaderText="Linked Line" SortExpression="Item"
                                    UniqueName="Items" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item"
                                    GroupByExpression="Item [GridColumn_Items] Group By Item">
                                    <ItemTemplate>
                                        <span><%# Eval("Item") %></span>
                                       <%-- <%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%>--%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Width="220px" />
                                </telerik:GridTemplateColumn>

                                 <telerik:GridTemplateColumn HeaderText="Thumbnail" HeaderStyle-Width="80px" Groupable="False" Reorderable="false"
                                    ItemStyle-HorizontalAlign="Center" AllowFiltering="false" UniqueName="Thumbnail" ItemStyle-Height="50px">
                                    <ItemTemplate>
                                        <asp:Image runat="server" ID="imgThumbnail" Height="50px" Width="50px" CssClass="lazy-thumbnail" ImageUrl="~/Images/Global/WhiteDot.gif"/>
                                    </ItemTemplate>
                                    <EditItemTemplate></EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="PMWeb viewer" UniqueName="PMWebViewer" HeaderStyle-Width="70px" Groupable="False"
                                    ItemStyle-HorizontalAlign="Center" AllowFiltering="false"> 
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtIconViewer" Style="cursor: pointer" meta:resourcekey="Redlining" runat="server" Visible="false"
                                            CssClass="PmWebViewer" OnClick="PMWebViewer_Click">
                                                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 
                                <telerik:GridTemplateColumn HeaderText="bluebeam"  UniqueName="IsInBluebeamSession" Groupable="false" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" AllowFiltering="false">

                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnBlueMarkStudio" Visible="false" CssClass="BlueMarkStudio" runat="server" meta:resourcekey="btnBlueMarkStudio">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn Visible="false" ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid" HeaderText="Include In Bid" Groupable="False" HeaderStyle-Width="80px"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Select">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" AutoPostBack="true" runat="server" OnCheckedChanged="chkSelectAll_OnChekedChanged" />
                                        <asp:Label ID="lblIncludeInBid" runat="server" Text='<%# GetLocalResourceObject("GridColumn_IncludeInBid")%>' />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                                    </ItemTemplate>
                                    <EditItemTemplate>&nbsp;</EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ID" UniqueName="Id" Resizable="true" SortExpression="Id" Groupable="False"
                                    DataField="Id" CurrentFilterFunction="EqualTo" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%-- <asp:HyperLink ID="lblDocumentNumber" Font-Underline="true" Text='<%#Container.DataItem("Id").ToString() %>' runat="server" NavigateUrl='<%# "PMWebRecord.aspx?Id" + Container.DataItem("Id").ToString() %>'></asp:HyperLink>--%>
                                        <span id="spnId" runat="server"><%# Eval("Id") %></span>
                                        <%-- <asp:LinkButton ID="lnkBtnOpenFolder" runat="server" Visible="false" Text="Open Folder" Style="text-transform: uppercase"></asp:LinkButton>--%>
                                    </ItemTemplate>
                                    <ItemStyle />
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Display" SortExpression="IsInRotator" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="IsInRotator"
                                UniqueName="IsDisplayed" Groupable="false">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkIsInRotator" runat="server" Checked='<%# CBool(IIF(Eval("IsInRotator") is system.DBNULL.value, 0, Eval("IsInRotator"))) %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <img id="imgCheckBox" runat="server" src='<%# "Images/Global/" + CStr(IIF(Eval("IsInRotator"),"checked.png" , "unchecked.png")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn Groupable="False" HeaderText="" Display="False" ItemStyle-Wrap="false"
                                    UniqueName="FileId" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileId" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Ext." UniqueName="Extension" ItemStyle-Wrap="false" GroupByExpression="Extension [GridColumn_Extension] Group By Extension ASC" ItemStyle-HorizontalAlign="Left"
                                    SortExpression="Extension" DataField="Extension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <asp:Label ID="txtFileDescription" runat="server" Text='<%#Eval("Extension")%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="55px"></HeaderStyle>
                                    <ItemStyle Wrap="False" />
                                </telerik:GridTemplateColumn>

                               <telerik:GridTemplateColumn HeaderText="Attached By" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CreatedByUserName"
                                    SortExpression="CreatedByUserName" UniqueName="CreatedByUserName" GroupByExpression="CreatedByUserName [GridColumn_CreatedByUserName] Group By CreatedByUserName">
                                    <EditItemTemplate>
                                        <span><%# Eval("CreatedByUserName")%></span>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("CreatedByUserName") = String.Empty, "&nbsp;", Container.DataItem("CreatedByUserName"))%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>

                               <telerik:GridTemplateColumn HeaderText="Create Date" CurrentFilterFunction="GreaterThanOrEqualTo" FilterListOptions="VaryByDataType" DataField="CreateDate"
                                    SortExpression="CreateDate" UniqueName="CreateDate" GroupByExpression="CreateDate [GridColumn_CreateDate] Group By CreateDate" DataType="System.DateTime">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Eval("CreateDate"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Modified" DataField="Modified"
                                    SortExpression="Modified" UniqueName="Modified" DataType="System.DateTime">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("Modified"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <EditItemTemplate>
                                        <span><%#FormatDate(Eval("Modified"))%></span>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" CssClass="text-left" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" ItemStyle-Wrap="false" Groupable="false" ItemStyle-HorizontalAlign="Left"
                                    SortExpression="FileSize" DataField="FileSize" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileSize" runat="server" Text='<%#IIf(Container.DataItem("FileSize") = 0, "&nbsp;", FormatByte(ParseDouble(Eval("FileSize"))))%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="75px"></HeaderStyle>
                                    <ItemStyle Wrap="False" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Version" Resizable="true" UniqueName="Version" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="FileVersion [GridColumn_FileVersion] Group By FileVersion ASC"
                                    SortExpression="FileVersion" DataField="FileVersion" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("FileVersion")%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="75px"></HeaderStyle>
                                    <ItemStyle Wrap="False" />
                                </telerik:GridTemplateColumn>

                                 <telerik:GridTemplateColumn HeaderText="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Notes"
                                    SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes")) %>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="true"></ItemStyle>
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                               
                                      <telerik:GridTemplateColumn HeaderText="Added From" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AddedFrom"
                                    SortExpression="AddedFrom" UniqueName="AddedFrom" GroupByExpression="AddedFrom [GridColumn_AddedFrom] Group By AddedFrom">
                                    <EditItemTemplate>
                                        <span><%# Eval("AddedFrom")%></span>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("AddedFrom") = String.Empty, "&nbsp;", Container.DataItem("AddedFrom"))%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                </telerik:GridTemplateColumn>


                                <%-- <telerik:GridTemplateColumn HeaderText="Display" SortExpression="IsInRotator" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="IsInRotator"
                                UniqueName="IsDisplayed" Groupable="false">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkIsInRotator" runat="server" Checked='<%# CBool(IIF(Eval("IsInRotator") is system.DBNULL.value, 0, Eval("IsInRotator"))) %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <img id="imgCheckBox" runat="server" src='<%# "Images/Global/" + CStr(IIF(Eval("IsInRotator"),"checked.png" , "unchecked.png")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>--%>
                                <%-- <telerik:GridTemplateColumn HeaderText="bluebeam" UniqueName="IsInBluebeamSession" Groupable="false" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" AllowFiltering="false">

                                <ItemTemplate>
                                    <asp:LinkButton ID="imgBluebeam" Reorderable="false" runat="server" SecurityButtonType="ItemMode_Edit" Visible='<%# Eval("IsInBluebeamSession")%>'
                                        CssClass="BlueBeam">
                                        
                                        <span class="BlueBeamIcon"></span>
                                        
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
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
                        <ClientSettings Scrolling-SaveScrollPosition="true"
                            ClientEvents-OnRowSelected="onRowSelected" ClientEvents-OnRowCreated="onRowCreated" ClientEvents-OnRowDeselected="onRowDeSelected" ClientEvents-OnRowContextMenu="rdgDocumentAttachment_OnRowContextMenu">
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>

                    </telerik:radgrid>
                    <div class="cardView" style="box-sizing: border-box;height:auto!important" id="CardViewContainer" visible="false" runat="server">
                        <div class="filesContainer" id="filesContainer" runat="server">
                            <telerik:radlistview runat="server" id="rptFilesCardView" clientdatakeynames="Id , FullFileName" itemplaceholderid="FilesCardViewContainer">
                                <ClientSettings AllowItemsDragDrop="false">
                                </ClientSettings>
                                <LayoutTemplate>
                                    <div>
                                        <asp:PlaceHolder ID="FilesCardViewContainer" runat="server"></asp:PlaceHolder>
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="rlvI">
                                        <div class="rlvDrag" onmousedown="Telerik.Web.UI.RadListView.HandleDrag(event , '<%#Container.OwnerListView.ClientID %>' , <%#Container.DisplayIndex %>)">
                                            <div id="card" runat="server" title='<%# IIf(Eval("FileOption").ToString() = "URL", IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").ToString()), IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FileNameWithoutExtension").ToString())) %>'>
                                                <div class="mainContent">
                                                    <div class="check">
                                                        <span class="icon"></span>
                                                    </div>
                                                    <div class="content">
                                                        <%--<img alt="" src="Images/Charts/Marble.gif" />--%>
                                                        <asp:Image ID="imgDisplay" CssClass="imgDisplay" Style="max-height: 125px;" runat="server" />
                                                        <%--<span id="spnIcon" runat="server" class="BigIcon"></span>--%>
                                                    </div>
                                                    <div class="linkRecord">
                                                        <span id="cardIcon" runat="server">
                                                            <span class="smallIcon"></span>
                                                        </span>
                                                        <asp:Label ID="lblCard" runat="server" Style="font-size: 10px; margin-left: 28px; width: 147px; white-space: nowrap; overflow: hidden; display: inline-block; text-overflow: ellipsis; color: #000000; margin-top: -8px;"
                                                            Text='<%# Eval("Id").ToString() + " - " + IIf(Eval("FileOption").ToString() = "URL", IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").ToString()), IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FileNameWithoutExtension").ToString()))%>'></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </telerik:radlistview>
                        </div>
                    </div>
                    <div id="emptyFolder" runat="server" style="display: table; text-align: center; height: 100%; width: 100%" visible="false">
                        <div style="display: table-cell; vertical-align: middle">
                            <asp:Image ID="imgEmptyFolder" Style="height: 200px; width: 200px; display: inline-block" runat="server" ImageUrl="CSS/Images/FolderManagerIcons/EmptyFolderIcon.png"></asp:Image>
                            <br />
                            <asp:Label ID="lblEmptyFolder" meta:ResourceKey="lblEmptyFolder" runat="server" Text="Drop files here or click the Add button" Style="font-size: 14px; color: #666;"></asp:Label>
                        </div>
                    </div>
                     <div id="NotEmptyFolder" runat="server" style="display:table;text-align:center;width:100%;margin-top:24px" visible="false">
                         <asp:Label ID="lblNotEmptyFolder" meta:ResourceKey="lblEmptyFolder" runat="server" Text="Drop files here or click the Add button" Style="font-size: 14px; color: #666;"></asp:Label>
                    </div>
                    <div id="floatButtonFiles" class="floatButton" onclick="openFileActionContextMenu(event)">
                        <span class="circle"></span>
                        <span class="circle"></span>
                        <span class="circle"></span>
                    </div>
                </div>
            </div>
            <div class="col-4 detailsPane" id="DetailsPane" runat="server" style="overflow: auto; border-left: 1px solid gray; background: white; z-index: 99">

                <div runat="server" id="DetailpaneAjaxHolder">
                    <asp:Button runat="server" ID="btnListViewRowClick" CssClass="Hide" />
                    <asp:Button ID="btnCardClick" runat="server" CssClass="Hide" />
                    <uc6:DocumentAttachments_DetailsPane runat="server" id="DetailsPane1" />
                </div>


            </div>
        </div>
    </div>

    <telerik:radcontextmenu id="cmFileActions" onclientitemclicking="FileActionsItemClicking" onclientshowing="FileActionsItemShowing" skin="Default" runat="server" cssclass="rootMenu">
        <Items>
            <telerik:RadMenuItem Text="View" Value="View" meta:ResourceKey="FileContextMenu_View" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Download" Value="Download" meta:ResourceKey="FileContextMenu_Download" EnableImageSprite="false" CssClass="MenuDownload"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Add PMWeb Viewer" Value="PMWebViewer" meta:ResourceKey="FileContextMenu_PMWebViewer" EnableImageSprite="false" CssClass="MenuPmWebViewr"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Go To PMWeb Viewer" Value="GoToPMWebViewer" meta:ResourceKey="FileContextMenu_GoToPMWebViewer" EnableImageSprite="false" CssClass="MenuPmWebViewr"></telerik:RadMenuItem>
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_SendToStudio" Text="Send to Studio" Value="SendToStudio" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_GoToBluebeamMarkups" Text="Go to Bluebeam Markups" Value="GoToBluebeamMarkups" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
            <telerik:RadMenuItem Text="Add 3D Viewer" Value="3DViewer" meta:ResourceKey="FileContextMenu_PMWebViewer" EnableImageSprite="false" CssClass="MenuPmWebViewr"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="AddSeperator1" IsSeparator="true" Enabled="false" />
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Add" PostBack="false" Text="Add" Value="Add" EnableImageSprite="true" CssClass="MenuCopy">
                <Items>
                    <telerik:RadMenuItem Value="FromComputer" meta:ResourceKey="FileContextMenu_Add_FromComputer" PostBack="false"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="FromDocumentManager" meta:ResourceKey="FileContextMenu_Add_FromDocumentManager" PostBack="false"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="LinkPmwebRecord" meta:ResourceKey="FileContextMenu_Add_LinkPmwebRecord" PostBack="false"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="LinkProjectEmail" meta:ResourceKey="FileContextMenu_Add_LinkProjectEmail" PostBack="false"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="LinkWebUrl" meta:ResourceKey="FileContextMenu_Add_LinkWebUrl" PostBack="false"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="SharePoint" Text="SharePoint" meta:ResourceKey="FileContextMenu_Add_SharePoint" PostBack="false"></telerik:RadMenuItem>
                    <%--<telerik:RadMenuItem Value="Aconex" Text="Aconex" meta:ResourceKey="FileContextMenu_Add_Aconex" PostBack="false"></telerik:RadMenuItem>--%>
                </Items>
            </telerik:RadMenuItem>
            <telerik:RadMenuItem Value="AddSeperator2" IsSeparator="true" Enabled="false" />
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_ReplaceFile" Text="Replace File" Value="Replace File" EnableImageSprite="false" CssClass="MenuReplace" PostBack ="false" ></telerik:RadMenuItem>
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Delete" Text="Delete" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete"></telerik:RadMenuItem>
        </Items>
    </telerik:radcontextmenu>
    <telerik:radcontextmenu style="display: none" onclientitemclicking="addContextMenuClick"
        runat="server" id="addContextMenu" cssclass="rootMenuAdd" clicktoopen="true" expandanimation-duration="500">
        <Items>
            <telerik:RadMenuItem Value="FromComputer" meta:ResourceKey="FileContextMenu_Add_FromComputer" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="FromDocumentManager" meta:ResourceKey="FileContextMenu_Add_FromDocumentManager" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkPmwebRecord" meta:ResourceKey="FileContextMenu_Add_LinkPmwebRecord" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkProjectEmail" meta:ResourceKey="FileContextMenu_Add_LinkProjectEmail" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkWebUrl" meta:ResourceKey="FileContextMenu_Add_LinkWebUrl" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="SharePoint" Text="SharePoint" meta:ResourceKey="FileContextMenu_Add_SharePoint" PostBack="false"></telerik:RadMenuItem>
            <%--<telerik:RadMenuItem Value="Aconex" Text="Aconex" meta:ResourceKey="FileContextMenu_Add_Aconex" PostBack="false"></telerik:RadMenuItem>--%>
        </Items>
    </telerik:radcontextmenu>

    <telerik:radcontextmenu
        runat="server" id="cmSorting" cssclass="rootMenu js-sort" clicktoopen="true" expandanimation-duration="500">
        <Items>
            <telerik:RadMenuItem Value="SortingBy">
                <ItemTemplate>
                    <input type="radio" runat="server" id="chkDocumentNumber" clientidmode="Static" name="SortingBy" sortingby="Id" />
                    <label for="chkDocumentNumber" meta:resourcekey="SortingContextMenu_DocumentNumber">Document #</label>
                    <br />
                    <input type="radio" runat="server" id="chkExtension" name="SortingBy" clientidmode="Static" sortingby="Extension" />
                    <label for="chkExtension" meta:resourcekey="SortingContextMenu_Extension">Extension</label>
                    <br />
                    <input type="radio" runat="server" id="chkModified" name="SortingBy" clientidmode="Static" sortingby="Modified" />
                    <label for="chkModified" meta:resourcekey="SortingContextMenu_Modified">Modified</label>
                    <br />
                    <input type="radio" runat="server" id="chkName" name="SortingBy" clientidmode="Static" sortingby="FullFileName" />
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
    </telerik:radcontextmenu>
    <telerik:radasyncupload runat="server" width="100%" cssclass="ProjectCenterUpload FolderManagerUpload Hide" id="rauAttachment" skin="Default" Style="height: 0 !important; border: 0 !important;"
        multiplefileselection="Automatic" onclientfileuploaded="onClientFileUploaded" onclientfileselected="onDocFileSelected" onclientfileuploadfailed="onDocFileUploadFailed" onclientvalidationfailed="ClientDocFileValidationFailed"
        hidefileinput="true" OnClientFileUploadRemoved="onDocFileUploadFailed">
        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
    </telerik:radasyncupload>
    <asp:Button ID="btnUpload" runat="server" CssClass="Hide btnUpload" />
    <telerik:radasyncupload runat="server" width="100%" CssClass="inputFileEdit Hide" id="fileupload_Edit" skin="Default"  
        Style="height: 0 !important; border: 0 !important;" multiplefileselection="Disabled" onclientfileuploaded="editFileUpload"
        hidefileinput="true" OnClientFileUploadRemoved="onDocFileUploadFailed">
    </telerik:radasyncupload> 

    <asp:Button ID="btnRefresh" runat="server" CssClass="Hide Refresh" />
    <asp:Button ID="btnUploadEdit" runat="server" CssClass="Hide btnUploadEdit" />
    <asp:HiddenField ID="hfWebUrl" runat="server" />
    <asp:HiddenField ID="hfEmailId" runat="server" />
    <asp:HiddenField ID="hfEmailDescription" runat="server" />
    <asp:HiddenField ID="hfEmailName" runat="server" />
    <asp:HiddenField ID="hfEmailNotes" runat="server" />
    <asp:HiddenField ID="hfAconex" runat="server" />
    <asp:HiddenField ID="hfDescription" runat="server" />
    <asp:Button ID="btnSorting" runat="server" CssClass="Hide" />
    <asp:Button ID="btnSaveUrl" runat="server" CssClass="Hide SaveUrl" />
    <asp:Button ID="lbtWSS" runat="server" CssClass="Hide" />
    <asp:Button ID="lbtAconex" runat="server" CssClass="Hide" />
    <asp:Button ID="btnSaveSharePoint" runat="server" CssClass="Hide SaveSharePoint" />
    <asp:Button ID="btnSaveEmail" runat="server" CssClass="Hide SaveEmail" />
    <asp:Button ID="btnLoadAttachment" runat="server" CssClass="Hide LoadAttachment" />
    <asp:Button ID="btnDownloadAttachment" runat="server" CssClass="Hide download" />
    <asp:Button ID="btnSaveAconex" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hdnSelectedElementId" runat="server" />
    <asp:HiddenField ID="hdnCardViewSelected" runat="server" Value="" />
    <asp:HiddenField ID="hfIsCardView" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFieldDownload" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFolderAttachmentIds" runat="server" Value="" /> 
    <asp:FileUpload ID="uploadDragAndDrop" runat="server" CssClass="Hide uploadDragAndDrop" />
    <asp:Button ID="btnUploadDragAndDrop" runat="server" CssClass="Hide btnUploadDragAndDrop" />
</div>


