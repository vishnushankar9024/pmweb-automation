<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentAttachments.ascx.vb"
    Inherits="Website.DocumentAttachments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc6" %>
<%@ Register Src="~/DocumentAttachments_DetailsPane.ascx" TagPrefix="uc6" TagName="DocumentAttachments_DetailsPane" %>


<%--<link runat="server" id="lnkCss" type="text/css" href="CSS/FolderManager.css" rel="stylesheet" />--%>


<style>
    .documentSinglePage, .documentMultiPages {
        margin-bottom: 0 !important;
    }

    .RadAjax.RadAjax_Default.detailLoadingPanel {
        position: absolute !important;
        z-index: 991 !important;
    }

    .RadMenu .rmGroup.rmVertical > .rmSeparator .rmText, .RadMenu .rmScrollWrap > .rmVertical > .rmSeparator .rmText{
        margin-left:0;
    }
</style>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

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
            var contextMenu = $find(folderContextMenu);
            contextMenu.showAt('50', '50');
            var evt = args.get_domEvent();
            $telerik.cancelRawEvent(evt);
        }

        function OpenRedlining(url)
        {
            window.location = url
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
                        data: "{'isDetailPaneVisible':" + !IsShowing + "}",
                        dataType: "json",
                        async: true,
                        error: function (data) {
                            console.log('The action could not be taken, please refresh the page and try again.');
                        }
                    });
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
            $('<img src="' + src + '" style="border-width:0px;height:320px;width:370px;" >').prependTo("#PmMasterFader");
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

        function activatePMwebViewer() {
            var btn = document.querySelector(".PmWebViewer");
            btn.classList.add("active");
            return false;
        }

        function FileActionsItemShowing(sender, args) {
            var isCardView = $("[id$=hfIsCardView]").val().toLowerCase() === '1';
            var selectedItem,hasAnnotation,PMWebViewer,has3DViewer,extension,aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW,isEligible,isInBluebeamSession;
            var download = true;
            var imgExtensions =["jpg", "jpeg", "png", "gif", "pdf"];
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
                    isEligible = selectedItem.getAttribute("isEligible") && selectedItem.getAttribute("isEligible").toLowerCase() === 'true';
                    isInBluebeamSession = selectedItem.getAttribute("IsInBluebeamSession") && selectedItem.getAttribute("IsInBluebeamSession").toLowerCase() === 'true';
                    aLLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW = selectedItem.getAttribute("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW") && selectedItem.getAttribute("ALLOW_CREATING_BLUEBEAM_SESSION_DURING_WORKFLOW").toLowerCase() === 'true';
                }
                else{
                    extension = "";
                    PMWebViewer = false
                    hasAnnotation = false;
                    has3DViewer = false;
                    download = false
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
                }
                else{
                    extension = "";
                    PMWebViewer = false
                    hasAnnotation = false;
                    has3DViewer = false;
                    download = false
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
                    case "3DViewer":
                        if(arrSelected.length === 1)
                            has3DViewer ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "GoToPMWebViewer":
                        if(arrSelected.length === 1)
                            hasAnnotation.toString() === 'true' && PMWebViewer ? item.set_visible(true) : item.set_visible(false);
                        break;
                    case "SendToStudio":
                        if(arrSelected.length === 1 && isEligible)
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
            }
            sender.hide();

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
                            if (a.id.indexOf("imgAction") > -1) {
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

            debugger;
            $('.js-sort').on('change' ,'input[type="radio"]' , function(){
                var selectedSort = '';
                $('.js-sort input[type="radio"]:checked').each(function(){
                    selectedSort += $(this).attr("sortingBy") + ",";
                });
                __doPostBack($('[id$=btnSorting]')[0].name,selectedSort);
            })
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
            var ldp =  $find("ctl00_ldpPM");
            var filesGridPane = document.querySelector(".filesGridPane");

            if(ldp) ldp.show(filesGridPane.id);
            uploadsDocFileInProgress++;
        }

        function onClientFileUploaded(sender, args) {

            decrementUploadsDocFileInProgress();
            if (uploadsDocFileInProgress <= 0) {
                var ldp =  $find("ctl00_ldpPM");
                var filesGridPane = document.querySelector(".filesGridPane");

                if(ldp) ldp.hide(filesGridPane.id)
                __doPostBack("rauAttachment", "");
                setTimeout(function () {
                    sender.deleteAllFileInputs();
                }, 10);
            }
        }

        function onDocFileUploadFailed(sender, args) {
            decrementUploadsDocFileInProgress();
            if (uploadsDocFileInProgress <= 0) {
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
        function MergePrintPopupt() {
            var  wnd;
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var Id='<%= PM.DocumentAttachmentInfo.Id %>';
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
            //wnd.add_close(rebindGrid(true));
                
               

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

</telerik:RadScriptBlock>
<telerik:RadAjaxLoadingPanel ID="detailAttachmentLoadingPanel" CssClass="detailLoadingPanel" runat="server" />
<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
</telerik:RadAjaxManagerProxy>

<div class="Folder_DocumentManager documentAttachment">
    <div style="width: calc(100% - 24px); margin-top: -1px" class="menu" id="menuToolbar" runat="server">
        <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="mainToolBar_clicked" runat="server" AutoPostBack="true">
            <Items>
                <telerik:RadToolBarButton SecurityButtonType="Read" CssClass="Add" Value="Add" ImageUrl="Images/ToolBar/Save.png" PostBack="false"
                    CommandName="Add" AccessKey="s" ToolTip="Save (Alt+s)" Text="Add">
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
        </telerik:RadToolBar>
        <telerik:RadMenu ID="rdmAttachmentLayouts" Style="float: none; display: inline-block; margin-left: -10px; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
            CollapseAnimation-Type="None" OnItemClick="rdmAttachmentLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack rdmLayouts HideOnMobileToolbar "
            EnableShadows="true" CausesValidation="false"
            Visible="true">
        </telerik:RadMenu>
    </div>
    <div class="PMMainPage">
        <div class="row row-8-4-fit8">
            <div class="col-8 filesGridPane" id="filesGridPane" runat="server" style="z-index: 999">
                <div class="Js-DropZone" style="height: calc(100vh - 177px)" id="dropZone" runat="server">
                    <telerik:RadGrid ID="rdgDocumentAttachments" ClientSettings-EnablePostBackOnRowClick="false" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="false" CssClass="rdgDocumentManager rgHeaderRightBorder"
                        GridLines="None" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true" AutoGenerateEditColumn="false" AutoGenerateDeleteColumn="false" ClientSettings-AllowDragToGroup="true"
                        ShowStatusBar="false" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-AllowColumnsReorder="true"
                        AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="false" ClientSettings-Scrolling-UseStaticHeaders="true" FitPageHeightOffset="5"
                        EnableHeaderContextMenu="false" EnableHeaderContextFilterMenu="false" Height="100%" ClientSettings-Resizing-AllowColumnResize="true" MasterTableView-AllowMultiColumnSorting="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderStyle Font-Size="8pt" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                            CommandItemDisplay="None" DataKeyNames="Id" ClientDataKeyNames="Id,Extension" EnableHeaderContextMenu="false">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" AllowSorting="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="" AllowSorting="false" Groupable="False" UniqueName="Icon"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgRedlining" runat="server">
                                            <span id="spanImg" class="smallIcon" runat="server"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                    <HeaderStyle Width="30px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" SortExpression="FullFileName" Groupable="true" GroupByExpression="FullFileName [GridColumn_FileName] Group By FullFileName ASC"
                                    DataField="FileName" ItemStyle-HorizontalAlign="Left" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("FileOption").ToString() <> "URL" And Eval("FileOption").ToString() <> "Link" And Eval("FileOption").ToString().ToLower() <> "email" And Eval("FileOption").ToString().ToLower() <> "pmwebword", Eval("FileFilterName").ToString().Substring(0, IIf(Eval("FileFilterName").ToString().LastIndexOf("."c) > 0, Eval("FileFilterName").ToString().LastIndexOf("."c), Eval("FileFilterName").ToString().Length)), Eval("FileFilterName").ToString()) %></span>
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
                                        <asp:Label ID="lblFileSize" runat="server" Text='<%#IIf(Container.DataItem("FileSize") = 0, "&nbsp;", FormatByte(ParseInt(Eval("FileSize"))))%>'></asp:Label>
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

                    </telerik:RadGrid>
                    <div class="cardView" style="box-sizing: border-box" id="CardViewContainer" visible="false" runat="server">
                        <div class="filesContainer" id="filesContainer" runat="server">
                            <telerik:RadListView runat="server" ID="rptFilesCardView" ClientDataKeyNames="Id , FullFileName" ItemPlaceholderID="FilesCardViewContainer">
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
                                            <div id="card" runat="server" title='<%# IIf(Eval("FileOption").ToString() = "URL", IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").ToString()), IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").Split("."c)(0).ToString())) %>'>
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
                                                            Text='<%# Eval("Id").ToString() + " - " + IIf(Eval("FileOption").ToString() = "URL", IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").ToString()), IIf(String.IsNullOrWhiteSpace(Eval("FullFileName").ToString()), "", Eval("FullFileName").Split("."c)(0).ToString()))%>'></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadListView>
                        </div>
                    </div>
                    <div id="emptyFolder" runat="server" style="display: table; text-align: center; height: 100%; width: 100%" visible="false">
                        <div style="display: table-cell; vertical-align: middle">
                            <asp:Image ID="imgEmptyFolder" Style="height: 200px; width: 200px; display: inline-block" runat="server" ImageUrl="CSS/Images/FolderManagerIcons/EmptyFolderIcon.png"></asp:Image>
                            <br />
                            <asp:Label ID="lblEmptyFolder" meta:ResourceKey="lblEmptyFolder" runat="server" Text="Drop files here or click the Add button" Style="font-size: 14px; color: #666;"></asp:Label>
                        </div>
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

    <telerik:RadContextMenu ID="cmFileActions" OnClientItemClicking="FileActionsItemClicking" OnClientShowing="FileActionsItemShowing" Skin="Default" runat="server" CssClass="rootMenu">
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
            <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Delete" Text="Delete" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete"></telerik:RadMenuItem>
        </Items>
    </telerik:RadContextMenu>
    <telerik:RadContextMenu Style="display: none" OnClientItemClicking="addContextMenuClick"
        runat="server" ID="addContextMenu" CssClass="rootMenu" ClickToOpen="true" ExpandAnimation-Duration="500">
        <Items>
            <telerik:RadMenuItem Value="FromComputer" meta:ResourceKey="FileContextMenu_Add_FromComputer" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="FromDocumentManager" meta:ResourceKey="FileContextMenu_Add_FromDocumentManager" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkPmwebRecord" meta:ResourceKey="FileContextMenu_Add_LinkPmwebRecord" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkProjectEmail" meta:ResourceKey="FileContextMenu_Add_LinkProjectEmail" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="LinkWebUrl" meta:ResourceKey="FileContextMenu_Add_LinkWebUrl" PostBack="false"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="SharePoint" Text="SharePoint" meta:ResourceKey="FileContextMenu_Add_SharePoint" PostBack="false"></telerik:RadMenuItem>
            <%--<telerik:RadMenuItem Value="Aconex" Text="Aconex" meta:ResourceKey="FileContextMenu_Add_Aconex" PostBack="false"></telerik:RadMenuItem>--%>
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
    </telerik:RadContextMenu>
    <telerik:RadAsyncUpload runat="server" Width="100%" CssClass="ProjectCenterUpload" ID="rauAttachment" Skin="Default" Style="display: none"
        MultipleFileSelection="Automatic" OnFileUploaded="rauAttachment_FileUploaded" OnClientFileUploaded="onClientFileUploaded"  OnClientFileSelected="onDocFileSelected"  OnClientFileUploadFailed="onDocFileUploadFailed" OnClientValidationFailed="ClientDocFileValidationFailed"
        HideFileInput="true" DropZones=".TeamDropZone">
        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
    </telerik:RadAsyncUpload>
    <asp:Button ID="btnRefresh" runat="server" CssClass="Hide Refresh" />
    <asp:Button ID="btnUpload" runat="server" CssClass="Hide btnUpload" />
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
    <asp:FileUpload ID="fileUpload" runat="server" CssClass="Hide inputFile" />
</div>


