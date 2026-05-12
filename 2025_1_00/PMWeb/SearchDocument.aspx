<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SearchDocument.aspx.vb" Inherits="Website.SearchDocument" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RDG1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                    <telerik:AjaxUpdatedControl ControlID="hfIsClearCommand" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveAsLayout">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSaveAsLayout" />
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnProjectFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnProjectFilter" />
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnProgramFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnProgramFilter" />
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnActiveFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnActiveFilter" />
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFolder">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnFolder" />
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnGoToBookmarks">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnGoToBookmarks" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpPM2" runat="server" Skin="Default" />
    <style type="text/css">
        @media (max-width: 768px) {
             .pwamanagerpage.managerLayoutOpen {
           position:fixed;
           top:-58px;
           z-index:9999;
        height: Calc(100vh) !important;
      
    }
        }     
@media screen and (min-width: 320px) and (max-width: 843px) {
    .pwamanagerpage {
        margin-top: 58px !important;
        height: Calc(100vh - 60px) !important;
    }
}
        .ToolbarImport {
            padding-left: 0 !important;
        }
        /*.rtbOuter ,.rtbMiddle {
background-image: none !important; 
border-style : none !important;
}

 .RadMenu_PM .rmRootGroup {

}
.rmSized ul.rmRootGroup {
float: none;
background-image: none; 
}
.rmLink 
{   
    display:inline-block !important;
    float: none !important;
    }
       .Icon1 .rmLeftImage {
margin: 4px 6px 0 -3px !important;
padding-bottom: 4px;
}*/
        .rtbSlide {
            z-index: 1 !important;
        }

        Table.rgMasterTable {
            overflow: visible !important;
        }

        #ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_rdmLayouts.RadMenu {
            position: static;
        }

        /*       .SearchDoctdRecent {
            padding-left: 24px;
        }*/

        .SearchDocumentGrid .trvSearchDocContextMenu {
            line-height: 24px;
        }

        .AngularSGD .trvSearchDocContextMenu {
            line-height: 24px;
        }

        .AngularSGD .RadGrid_Default .rgGroupPanel td td {
            padding: 0;
            height: 50px;
            font-family: 'Roboto', sans-serif
        }

        a.BreadCrumbLabel:active {
            font-size: 16px;
        }

        .LowerCaseTitle .rwTitleRow em {
            text-transform: none !important;
        }
    </style>
    <%--<script  runat="server" >
     Private Sub RDG1_ItemDataBound1(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RDG1.ItemDataBound
         If TypeOf e.Item Is GridCommandItem Then
             Dim PageId As Integer = GetPageId(SourceObjectType)
             If PageId = 10014 Then
                 Dim rtbInitiative As RadToolBar = DirectCast(e.Item.FindControl("rtbInitiative"), RadToolBar)
                 Dim lblPrograms As Label = DirectCast(e.Item.FindControl("lblPrograms"), Label)
                 Dim lblProjects As Label = DirectCast(e.Item.FindControl("lblProjects"), Label)
                 lblProjects.Visible = False
                 lblPrograms.Visible = False
                 Dim ddlPrograms As RadComboBox = DirectCast(e.Item.FindControl("ddlPrograms"), RadComboBox)
                 Dim ddlProjects As RadComboBox = DirectCast(e.Item.FindControl("ddlProjects"), RadComboBox)
                 Dim ddlActive As RadComboBox = DirectCast(e.Item.FindControl("ddlActive"), RadComboBox)
                 Dim btnAdd As LinkButton = DirectCast(e.Item.FindControl("btnAdd"), LinkButton)
                 rtbInitiative.Attributes.Add("pageId", PageId.ToString)
                 rtbInitiative.Visible = False
                 ddlPrograms.Visible = False
                 ddlProjects.Visible = False
                 ddlActive.Visible = False
                 If btnAdd.Visible Then
                     btnAdd.Visible = False
                     rtbInitiative.Visible = True
                 End If
             End If
            
         End If
     End Sub
 </script>--%>
    <script type="text/javascript">
        var Grid;
        var btnDelete;
        var ClientID;
        function createIframeUrl(url) {
            if (window.location.href.toLowerCase().includes('isiframe')) {
                url += url.includes('?') ? '&isIframe=1' : '?isIframe=1';
                return url;
            }
            return url;
        }
        window.addEventListener('message', function (event) {
            if (event.data.event_id === 'GoToURL')
                window.location = createIframeUrl(event.data.recordurl);

            if (event.data.event_id == 'InitNewRecord')
            {
                var btnInitNewRecord = $("[id$=btnInitNewRecord]");
                if (btnInitNewRecord)
                    btnInitNewRecord.click();
                return;

            }
            if (event.data.event_id == "ImportRecords")
            {
                switch (event.data.objecttype) {
                    case 'PORTFOLIOPLANS':
                        OpenPOPUpImport('PortfolioPlanning_Import.aspx?SourceId=Plans_Import', 710, 590, true);
                        break;
                    case 'ITEM':
                        OpenPOPUpImport("ObjectImport.aspx?ObjectType=ITEM&EntityID=-1", 800, 550, true);
                        break;
                    case 'SUBMITTALITEMS':
                        OpenPOPUpImport('ImportPopup.aspx?SourceId=SUBMITTALITEMS', 710, 590, true);
                        break;
                    case 'DRAWINGLISTS':
                        OpenPOPUpImport('ImportPopup.aspx?SourceId=DRAWINGLISTS', 800, 445, true);
                        break;
                    case 'COMPANY':
                        OpenPOPUpImport('Companies_Import.aspx?SourceId=Companies_Import', 710, 590, true);
                        break;
                    case 'Estimate_Records':
                        OpenPOPUpImport("ObjectImport.aspx?ObjectType=ESTIMATE", 800, 500, true);
                        break;
                    case 'Estimate_Details':
                        OpenPOPUpImport("ObjectImport.aspx?ObjectType=ESTIMATE_DETAILS", 800, 550, true);
                        break;
                }
            }
            if (event.data.event_id == "AddFromTemplate" && event.data.objecttype == "BUDGETINITIATIVES")
            {
                var PageId = currPageId;
                return OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?PageId=' + PageId, 1020, 520);

            }
            if (event.data.event_id == "GoToBookMarks") {
                var btnGoToBookmarks = $("[id$=btnGoToBookmarks]");
                if (btnGoToBookmarks)
                    btnGoToBookmarks.click();
            }
            if (event.data.event_id == "OpenLayoutPopup") {
                $("#ctl00_CPH1_ngFrame").addClass("managerLayoutOpen");
 
            }
            if (event.data.event_id == "CloseSegmants") {
                $("#ctl00_CPH1_ngFrame").removeClass("managerLayoutOpen");

            }
          
        });
     
        function OpenManagerPageLayoutPopup(URL) {
            $("#ctl00_CPH1_ngLayout").attr("src", URL);
            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            $("#nglayoutPopup").css({
                'position': 'fixed', 'left': '77px', 'top': '39px','z-index':'9999'
            });
      
            if (isMobileScreen()) {
                $("#nglayoutPopup").css({
                    'left': '0;', 'top': '0', 'width': browserWidth + 'px', 'height': browserHeight + 'px'
                });
                //wnd.setSize(browserWidth - 10, browserHeight);
                //wnd.moveTo(0, 0);
            }
            else {
                var width = (browserWidth * 0.9);
                var height = (browserHeight * 0.9);
                $("#nglayoutPopup").css({
                    'width': width + 'px', 'height': height +'px'
                });
                //wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                //wnd.Center();
            }
            //wnd.get_popupElement().className = wnd.get_popupElement().className + " managerpagePopup"
           
            $("#nglayoutPopup").show();
            return false;
        }
        function WindowImportClosed(Opener) {
            //var btnRefreshId;
            //if (GridToRebind != "") {
            //    btnRefreshId = $("a[id*=" + GridToRebind + "][id$=btnRefresh]")[0];
            //} else {
            //    btnRefreshId = $("a[id$=btnRefresh]")[0];
            //}
            //if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
            const targetWindow = document.getElementById('ctl00_CPH1_ngFrame');
            if (targetWindow) {
                const messageData = {
                    event_id: 'RebindGrid',
                    data: ''
                };
                targetWindow.contentWindow.postMessage(messageData, '*');
              
            }
        }
        function OpenPOPUpImport(URL, Width, Height, AddClose, gridId) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
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
            if (AddClose == true) {
                wnd.add_close(WindowImportClosed);
                if (gridId) { GridToRebind = gridId; }
            }
            wnd.get_popupElement().className = wnd.get_popupElement().className + " LowerCaseTitle"
            return false;
        }

        function OpenImportPopup(sender, args) {
            var cmd = args.get_item().get_commandName()
            if (cmd == 'Import') {
                switch (SourceObjectType) {
                    case 'PORTFOLIOPLANS':
                        OpenPOPUpImport('PortfolioPlanning_Import.aspx?SourceId=Plans_Import', 710, 590);
                        break;
                    case 'ITEM':
                        OpenPOPUpImport("ObjectImport.aspx?ObjectType=ITEM&EntityID=-1", 800, 550, true);
                        break;
                    case 'SUBMITTALITEMS':
                        OpenPOPUpImport('ImportPopup.aspx?SourceId=SUBMITTALITEMS', 710, 590, false);
                        break;
                    case 'DRAWINGLISTS':
                        OpenPOPUpImport('ImportPopup.aspx?SourceId=DRAWINGLISTS', 800, 445, false);
                        break;
                    case 'COMPANY':
                        OpenPOPUpImport('Companies_Import.aspx?SourceId=Companies_Import', 710, 590);
                        break;
                }
            }
            else {
                if (cmd == 'ImportHeader') {
                    switch (SourceObjectType) {
                        case 'ESTIMATE':
                            OpenPOPUpImport("ObjectImport.aspx?ObjectType=ESTIMATE", 800, 500, true);
                            break;
                    }



                }
                else if (cmd == 'ImportDetail') {
                    switch (SourceObjectType) {
                        case 'ESTIMATE':
                            OpenPOPUpImport("ObjectImport.aspx?ObjectType=ESTIMATE_DETAILS", 800, 550, true);
                            break;
                    }

                }
            }
        }
        function GridCreated(sender, args) {
            Grid = $find($("[id$=RDG1]")[0].id);
            btnDelete = $($("a[id$=btnDelete]")[0]);
            ClientID = sender.ClientID;

        }


        function GoToDocument(sender, eventArgs) {
            window.location = createIframeUrl(eventArgs.getDataKeyValue("PostBackUrl"));
        }

        function commandRowAnimation() {
            var rowCommandElement = document.querySelector('.AngularSGD .rgCommandRow td');
            var rowCommandElementUL = document.querySelector('.AngularSGD .rgCommandRow .rtbUL');

            rowCommandElement.style.transition = 'background-color 0.5s ease';
            rowCommandElementUL.style.transition = 'background-color 0.5s ease';

            rowCommandElement.style.backgroundColor = '#E2EBF7';
            rowCommandElementUL.style.backgroundColor = '#E2EBF7';

            setTimeout(function () {
                rowCommandElement.style.backgroundColor = 'rgba(187, 212, 242, 1)';
                rowCommandElementUL.style.backgroundColor = 'rgba(187, 212, 242, 1)';
            }, 300);
        }

        function SearchDocument_Deselect(sender, eventArgs) {
            var rowSelected = sender.get_masterTableView().get_selectedItems();
            if (rowSelected.length > 0) {
                btnDelete.css("display", "block");
            }
            else if (rowSelected.length === 0) {
                commandRowAnimation();
                btnDelete.css("display", "none");
            }
        }


        function SearchDocument_EnableDelBtn(sender, eventArgs) {
            commandRowAnimation();
            btnDelete.css("display", "block");
        }

        function SearchDocument_DisableDelBtn(sender, eventArgs) {
            commandRowAnimation();
            btnDelete.css("display", "hidden");
        }

        function SearchDocument_OnRowSelected(sender, eventArgs) {
            if (SearchDocObjectTypeId == 19) {
                var grid = $find($("[id$=RDG1]")[0].id);
                var selectedCount = grid.get_masterTableView().get_selectedItems().length
                if (selectedCount == 1) {
                    btnDelete.removeClass("GridCmdDeleteRecordss_disabled").addClass("GridCmdDeleteRecords");
                    btnDelete.attr("onclick", "ConfirmSearchDelete()");
                }
                else {
                    disablebtnDeleteCompany()
                }
            }
        }

        function disablebtnDeleteCompany() {
            btnDelete.removeClass("GridCmdDeleteRecords").addClass("GridCmdDeleteRecordss_disabled");
            btnDelete.attr("onclick", "return false;");
        }

        function SearchDocument_OnRowSelecting(sender, eventArgs) {
            var IsSystemMap = $("#" + eventArgs.get_id())[0].getAttribute("IsSystemMap")
            var IsUsedMap = $("#" + eventArgs.get_id())[0].getAttribute("IsUsedMap")
            var IsUseWorkFlow = $("#" + eventArgs.get_id())[0].getAttribute("IsUseWorkFlow")
            var IsLatestRevision = $("#" + eventArgs.get_id())[0].getAttribute("IsLatestRevision")
            var IsUseDocumentTeam = $("#" + eventArgs.get_id())[0].getAttribute("IsUseDocumentTeam")
            var IsInSession = $("#" + eventArgs.get_id())[0].getAttribute("IsInSession")
            if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
                return;
            if (Grid.get_masterTableView().get_selectedItems().length === 0) {
                commandRowAnimation();
            }
            if (Grid.get_masterTableView().get_selectedItems().length > 0) {         
                if (btnDelete.is(":visible") == true) {
                    if (IsUseWorkFlow == "true" || IsLatestRevision == 0) { btnDelete.hide(); }
                    if (IsSystemMap == "true" || IsUsedMap == "true") { btnDelete.hide(); }
                    if (IsUseDocumentTeam == "true") { btnDelete.hide(); }
                    if (IsInSession == "true") { btnDelete.hide(); }
                }
            }
            else {
                if (IsUseWorkFlow == "true" || IsLatestRevision == 0 || IsSystemMap == "true" || IsUsedMap == "true" || IsUseDocumentTeam == "true" || IsInSession == "true") {
                    //eventArgs.set_cancel(true);
                    btnDelete.hide();
                } else {
                    btnDelete.show();
                }
            }

        }
        function OpenAddInitiativeTemplatePopup(sender, eventArgs) {
            var value = eventArgs.get_item().get_commandName();
            if (value == 'NewInitiativeFromTemplate') {
                var PageId = sender.get_attributes().getAttribute("pageId");
                return OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?PageId=' + PageId, 1020, 520);
            }

            if (value == 'NewInitiative') {
                window.location = createIframeUrl("InitiativesBudget.aspx?Id=0&ModuleId=1&PageId=190");
                return;
            }

            //if (value != 'Add') {
            //    sender.collapse();
            //}
            return false;

        }

        function openSaveCustomLayoutPopup(sender, eventArgs) {


            var item = eventArgs.get_item().get_value();
            if (item == -7) {

                var wnd = window.radopen('SaveCustomLayoutPopup.aspx?SourceId=SearchDocument');
                wnd.setSize(450, 125);
                wnd.add_close(ClickHiddenButton);
                wnd.Center();
                var iframe = $(document).find('iframe')[0];

                iframe.onload = function () {
                    var pageName = $(document).find('iframe').contents().find("form").attr('action');
                    if (pageName.indexOf('SaveCustomLayoutPopup') > -1) {
                        $(document).find('iframe').css('height', 125);

                    }
                }
                sender.close();
                eventArgs.set_cancel(true);


                return false;

            }
            if (item == -8) {
                var result;
                result = confirm(Msg_ConfirmDeleteLayout);
                eventArgs.set_cancel(!result);
                return false;
            }
            eventArgs.set_cancel(false);
            return true;
        }

        function ClickHiddenButton(Opener) {

            var btnHiddenButton = $("[id$=btnSaveAsLayout]");
            var hfSaveAsLayout = $("[id$=hfSaveAsLayout]")[0];

            if (hfSaveAsLayout.value == "1") {
                $(window.document).find("[id$=hfSaveAsLayout]").val(0);
                btnHiddenButton.click();
            }


        }
        function ddlProjectsIndexChanged(sender, eventArgs) {
            var value = sender.get_value();
            if (value == '')
                value = 0;
            var btnProjectFilter = $("[id$=btnProjectFilter]");
            var hfProjectFilter = $("[id$=hfProjectFilter]")[0];
            hfProjectFilter.value = value;
            btnProjectFilter.click();

        }
        function ddlProgramsIndexChanged(sender, eventArgs) {
            var value = sender.get_value();
            if (value == '')
                value = 0;
            var btnProgramFilter = $("[id$=btnProgramFilter]");
            var hfProgramFilter = $("[id$=hfProgramFilter]")[0];
            hfProgramFilter.value = value;
            btnProgramFilter.click();

        }
        function ddlActiveIndexChanged(sender, eventArgs) {
            var value = sender.get_value();
            if (value == '')
                value = 0;
            var btnActiveFilter = $("[id$=btnActiveFilter]");
            var hfActiveFilter = $("[id$=hfActiveFilter]")[0];
            hfActiveFilter.value = value;
            btnActiveFilter.click();

        }
        function ddlFolderSelection_IndexChanged(sender, eventArgs) {
            var value = sender.get_value();
            if (value == '')
                value = 0;
            var btnFolder = $("[id$=btnFolder]");
            var hfFolder = $("[id$=hfFolder]")[0];
            hfFolder.value = value;
            btnFolder.click();

        }
        function OnCommand(sender, args) {


        }
        function exportExcelClicking(sender) {
            if ($("[id=" + sender.id.replace('btnSearchDocumentExportExcel', 'btnRefresh') + "]").length == 0) return;
            var btnRefresh = "[id=" + sender.id.replace('btnSearchDocumentExportExcel', 'btnRefresh') + "]";
            setTimeout(() => { __doPostBack(btnRefresh.replace('_', '$'), '');},100)
        }

        function ConfirmSearchDelete() {
            var grid = $find($("[id$=RDG1]")[0].id);
            var hfdeletedIds = $("[id$=hfdeletedIds]")[0];
            hfdeletedIds.value = '';
            for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
                var row = grid.MasterTableView.get_selectedItems()[i];
                hfdeletedIds.value = hfdeletedIds.value + "," + row.getDataKeyValue("Id")
            }
        }

        function OpenPOPUpAngular(URL) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            $(".rwBodyLeft").remove();
            $(".rwBodyRight").remove();
            $(".rwFooterRow").remove();
            $(".rwTitleRow").remove();
            $(".rwWindowContent").css("width", "100%");
            $(".rwWindowContent").css("border-radius", "20px");
            $('iframe').css("border-radius", "20px");
            $('iframe').css("box-shadow", "0 0 15px 0 rgba(0, 0, 0, 0.5)");
            $('.TelerikModalOverlay').css('opacity', '0');
            wnd.set_behaviors('true');
            wnd.GetTitlebar().parentElement.hidden = true;
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }

            else if (URL === 'SearchDocumentDeleteRecordsConfirmationPopUp.aspx') {
                wnd.setSize(300, 240);
                wnd.center();
            }

            else if (browserWidth > 600) {
                wnd.setSize(600, 400);
                wnd.Center();
            }

            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }

            var popupElement = $(wnd.get_popupElement());
            popupElement.css({
                opacity: 0,
            });

            popupElement.animate({
                opacity: 1
            }, 500, function () {
            });
            return false;
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

        function pageLoad() {
            if (querySt("O") == 59) {
                document.getElementsByClassName("NoWrap SearchDoctdTreeView")[2].style.paddingLeft = "14px";
                document.getElementsByClassName("NoWrap SearchDoctdRecent")[0].style.paddingLeft = "10px";
                document.getElementsByClassName("NoWrap SearchDoctdTreeView")[3].style.paddingLeft = "10px";
                document.getElementsByClassName("NoWrap SearchDoctdTreeView")[3].firstElementChild.style.paddingRight = "0px";
                document.getElementsByClassName("NoWrap SearchDoctdRecent")[1].style.paddingLeft = "14px";
            }

            if (querySt("O") == 9000 || querySt("O") == 9001 || querySt("O") == 9002 || querySt("O") == 9003 || querySt("O") == 9004)
                $("#ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_tblDropDownLists").hide();
            if (querySt("O") == 134) {
                $("#ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_tblAddNewRecord").attr("width", "50");
            }

            var tFind = $telerik.$;
            tFind("[id$=HCFMClearFilterButton]").on("click", function (e) {
                var hfIsClearCommand = tFind("[id$=hfIsClearCommand]")[0];
                hfIsClearCommand.value = 1;
            });

          
        };

        function changeCurrentWorkingFolderId(sender) {
            var folderId = sender.getAttribute("btnId");
            var hfFolderId = $("[id$=hfFolderId]");
            hfFolderId.val(folderId);
            var btnChangeFolderId = $("[id$=btnChangeFolderId]");
            btnChangeFolderId.click();
        }

        function hideLoading() {
            $("#DisableAllControlsOnPostback").css('display', 'none;');
        }
         
    </script>

   <iframe runat="server" id="ngFrame" style="width:calc(100%); height:100%;z-index:7000; position:relative; background-color: white;border:0;" frameborder="0"></iframe>
   
    <div id="nglayoutPopup"  style="display:none;background-color:#fff;">
    <iframe runat="server" id="ngLayout" width="100%" style="height: Calc(100vh); padding: 0px; margin: 0px;border:0"></iframe>
    </div>
   <%-- <table style="width: 100%" cellspacing="0" cellpadding="0" border="0">
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>--%>
    <telerik:RadGrid ID="RDG1" CssClass="AngularSGD" runat="server" ShowGroupPanel="true" Skin="Default" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        AllowPaging="true" PageSize="250" AutoGenerateColumns="false" ShowStatusBar="False" OnFilterCheckListItemsRequested="CheckListItemsRequested" SetWidth="true" AppendMenus="true" IsSearchDoc="true"
        AllowMultiRowEdit="True" AllowSorting="true" AllowMultiRowSelection="true" GridLines="None" EnableViewState="true" Width="99.5%">
        <PagerStyle EnableAllOptionInPagerComboBox="true" AlwaysVisible="true"></PagerStyle>
        <MasterTableView GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EnableColumnsViewState="False"
            DataKeyNames="Id,PostBackUrl" ClientDataKeyNames="Id,PostBackUrl" CommandItemDisplay="Top"
            InsertItemDisplay="Top" EnableHeaderContextMenu="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" TableLayout="Fixed" AllowMultiColumnSorting="true" Width="1px" AllowFilteringByColumn="true">
            <CommandItemTemplate>
                <div style="padding: 2px" style="width: 100%">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="NoWrap SearchDoctdTreeView">
                                <asp:LinkButton ID="btnItemsTreeView" runat="server" CausesValidation="False" CommandName="ItemsTreeView" CssClass="GridCmdTreeView"
                                    SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td class="NoWrap SearchDoctdTreeView">
                                <asp:LinkButton ID="btnPmwebReportingTreeView" runat="server" Visible="false" CausesValidation="False" CommandName="PmwebReportingTreeView" CssClass="GridCmdTreeView"
                                    SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td class="NoWrap SearchDoctdTreeView" id="tdOpenCurrFolder" runat="server">
                                <asp:LinkButton ID="btnCurrentFolder" runat="server" CausesValidation="False" OnClientClick="" CommandName="OpenCurrentFolder" CssClass="GridCmdOpenCurrentFolder"
                                    SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td class="NoWrap">
                                <table id="tblGridStates" runat="server" style="padding: 0px; border: 0px transparent none; height: 15px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td id="tblAddNewRecord" runat="server" class="NoWrap SearchDoctdAdd">
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRecord" CssClass="SearchDocGridCmdInitNewRecord"
                                                SecurityButtonType="ItemMode_Add">
                                                <div>
                                                    <span >Add</span>
                                                     &nbsp;&nbsp;
                                                </div>
                                            </asp:LinkButton>

                                            <telerik:RadToolBar ID="rtbInitiative" runat="server" AutoPostBack="true" Style="z-index: 0; border: 0px transparent none; position: static"
                                                OnClientButtonClicked="OpenAddInitiativeTemplatePopup">
                                                <Items>
                                                    <telerik:RadToolBarSplitButton EnableImageSprite="true" CssClass="ToolbarButtonNewInitiative"
                                                        EnableDefaultButton="false" PostBack="false" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative">
                                                        <Buttons>
                                                            <telerik:RadToolBarButton PostBack="false" Width="120px" EnableImageSprite="true" meta:resourcekey="ContextMenu_NewInitiative"
                                                                CommandName="NewInitiative" CssClass="ToolbarButtonNewInitiative">
                                                            </telerik:RadToolBarButton>
                                                            <telerik:RadToolBarButton PostBack="false" Width="150px" EnableImageSprite="true" meta:resourcekey="ContextMenu_NewInitiativeFromTemplate"
                                                                CommandName="NewInitiativeFromTemplate" CssClass="ToolbarButtonNewInitiative">
                                                            </telerik:RadToolBarButton>
                                                        </Buttons>
                                                    </telerik:RadToolBarSplitButton>
                                                </Items>
                                            </telerik:RadToolBar>

                                        </td>

                                        
                                        <td class="NoWrap SearchDoctdDelete">
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick=" return OpenPOPUpAngular('SearchDocumentDeleteRecordsConfirmationPopUp.aspx', 300, 240, false);"
                                                SecurityButtonType="ItemMode_Delete"
                                                runat="server" CssClass="GridCmdDeleteRecords" Style="display: none;">
                                                <asp:label runat="server">Delete</asp:label>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td class="NoWrap SearchDoctdTreeView" id="tdBookMarks" runat="server">
                                            <asp:LinkButton ID="btnBookMarks" runat="server" CausesValidation="False" OnClientClick="" CommandName="OpenBookMarks" CssClass="GridCmdOpenBookMark"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <%--      <td class="NoWrap SearchDoctdRecent">
                                            <telerik:RadToolBar ID="RadToolBar1" runat="server" Style="z-index: 0; border: 0px transparent none; position: static">
                                                <Items>
                                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                                </Items>
                                            </telerik:RadToolBar>
                                        </td>--%>
                                        <td id="tblDropDownLists" runat="server" class="NoWrap" style="display: none;">
                                            <table style="display: inline; padding: 0px; border: 0px transparent none; border-spacing: 10px 0;" cellpadding="0"
                                                cellspacing="0">
                                                <tr>
                                                    <td class="NoWrap" orderindex="0" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblPrograms" meta:resourcekey="lblPrograms" runat="server" Text="Program" Width="50px"></asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                       <telerik:RadComboBox ID="ddlPrograms" OnClientSelectedIndexChanged="ddlProgramsIndexChanged"
                                           runat="server" AutoPostBack="false" AllowCustomText="true" Style="font-size: 11px" Width="205px"
                                           Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                           EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                       </telerik:RadComboBox>
                                                    </td>
                                                    <td class="NoWrap" orderindex="1" style="padding-left: 10px;" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblProjects" meta:resourcekey="lblProjects" runat="server" Text="Project" Width="50px"></asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                       <telerik:RadComboBox ID="ddlProjects" runat="server" OnClientSelectedIndexChanged="ddlProjectsIndexChanged"
                                           Width="205px" AutoPostBack="false" AllowCustomText="true" Height="400px"
                                           Style="font-size: 11px"
                                           EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                           EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                       </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="NoWrap" orderindex="2" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblLocationTypes" meta:resourcekey="lblLocationTypes" runat="server"
                                                                Text="Location Types">
                                                            </asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                              <telerik:RadComboBox ID="ddlLocationTypes" OnSelectedIndexChanged="ddlLocationTypes_SelectedIndexChanged"
                                                  runat="server" AutoPostBack="true" Filter="Contains" AllowCustomText="true" EnableLoadOnDemand="true"
                                                  ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                                  Style="font-size: 11px" Height="180px">
                                              </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td></td>
                                                    <td class="NoWrap" orderindex="3" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblLocations" meta:resourcekey="lblLocations" runat="server" Text="Locations">
                                                            </asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                              <telerik:RadComboBox ID="ddlLocations" runat="server" OnSelectedIndexChanged="ddlLocations_SelectedIndexChanged"
                                                  Width="180px" AutoPostBack="true" AllowCustomText="true"
                                                  Style="font-size: 11px" EnableLoadOnDemand="true" Height="400px"
                                                  ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                              </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="NoWrap" orderindex="4" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblProgress" meta:resourcekey="lblProgress" runat="server" Text="Progress">
                                                            </asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                             <telerik:RadComboBox ID="ddlProgress" runat="server" OnSelectedIndexChanged="ddlProgress_SelectedIndexChanged"
                                                 Width="150px" AutoPostBack="true" Filter="Contains" AllowCustomText="true" EnableLoadOnDemand="true"
                                                 ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                                 Style="font-size: 11px" Height="180px">
                                             </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="NoWrap" orderindex="5" runat="server">
                                                        <telerik:RadComboBox ID="ddlWorkOrderStatus" runat="server" OnSelectedIndexChanged="ddlWorkOrderStatus_SelectedIndexChanged"
                                                            Width="90px" AutoPostBack="true" Style="font-size: 11px">
                                                        </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="NoWrap" orderindex="6" runat="server">
                                                        <b>
                                                            <asp:Label ID="lblCurrency" meta:resourcekey="lblCurrency" Text="Currency" runat="server"></asp:Label>
                                                        </b>
                                                        &nbsp;&nbsp;
                                           <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100px" AutoPostBack="true" Height="300px"
                                               EmptyMessage="Select Currency" Style="font-size: 11px" EnableLoadOnDemand="true"
                                               ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                               OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                           </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td id="tblActive" runat="server" class="NoWrap SearchDoctdComboFilters">
                                            <telerik:RadComboBox ID="ddlActive" runat="server" OnClientSelectedIndexChanged="ddlActiveIndexChanged"
                                                Width="90px" AutoPostBack="false" Style="font-size: 11px"
                                                DropDownWidth="120px">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td class="NoWrap SearchDoctdRecent">
                                            <asp:LinkButton ID="btnSearchDocRecent" CausesValidation="False" OnClientClick="" Style="padding-left: 0 !important"
                                                SecurityButtonType="ItemMode" runat="server" CommandName="RecentRecords" CssClass="GridCmdRecentRecords">
                                                <span>View Recent</span>                                
                                            </asp:LinkButton>

                                        </td>

                                        <td class="NoWrap SearchDoctdLayout">

                                            <telerik:RadMenu ID="rdmLayouts" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                CollapseAnimation-Type="None" CssClass="trvContextMenu trvSearchDocContextMenu"
                                                runat="server" EnableSelection="true"
                                                EnableShadows="true"
                                                OnItemClick="rdmLayouts_ItemClick"
                                                OnClientItemClicking="openSaveCustomLayoutPopup" Visible="true" DataValueField="Layout">
                                            </telerik:RadMenu>
                                            <span style="margin-left: -36px; padding-right: 11px;">Layout</span>
                                        </td>
                                        <td id="tblImport" class="NoWrap" runat="server">
                                            <telerik:RadToolBar ID="ImportToolbar" EnableImageSprites="true" runat="server" Style="z-index: 0; border: 0px transparent none; position: static" OnClientButtonClicked="OpenImportPopup">
                                                <Items>
                                                    <telerik:RadToolBarButton SecurityButtonType="Add" PostBack="false" CssClass="ToolbarImport" Visible="false"
                                                        CommandName="Import" Value="Import">
                                                    </telerik:RadToolBarButton>
                                                    <telerik:RadToolBarSplitButton Visible="false" CommandName="CmdImport" SecurityButtonType="Edit" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarImport" ToolTip="Import">
                                                        <Buttons>
                                                            <telerik:RadToolBarButton PostBack="false" CommandName="ImportHeader" Value="ImportHeader" Text="<%$Resources:PMWeb, RadToolBarButton_ImportHeader %>">
                                                            </telerik:RadToolBarButton>
                                                            <telerik:RadToolBarButton PostBack="false" CommandName="ImportDetail" Value="ImportDetail" Text="<%$Resources:PMWeb, RadToolBarButton_ImportDetail %>">
                                                            </telerik:RadToolBarButton>
                                                        </Buttons>
                                                    </telerik:RadToolBarSplitButton>
                                                </Items>
                                            </telerik:RadToolBar>
                                        </td>

                                        <td class="NoWrap SearchDoctdRefresh" style="display: none">
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode">
                                                <span>Refresh</span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <%--      <td class="NoWrap">
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState">
                                        <asp:Label ID="Label3" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState">
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="label4" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </td>--%>

                                        <td class="NoWrap SearchDoctdClearProjectFilter">
                                            <asp:LinkButton ID="btnClearFilter" runat="server" CausesValidation="False" CommandName="ClearFilter" CssClass="GridCmdClearFilerGrid"
                                                SecurityButtonType="ItemMode" ToolTip="Clear Filter">
                                                <span style="font-weight: bold">Project: </span>
                                                <asp:Label ID="lblProjectFilter" runat="server" CssClass="SDProjectFilter"></asp:Label>
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                           <td>
                                            <asp:LinkButton ID="btnSearchDocumentExportToPdf" runat="server" CausesValidation="False" CommandName="ExportToPdf" 
                                                SecurityButtonType="ItemMode" ToolTip="<%$Resources: ExportToPDF_Tooltip %>">
                                                          <span>PDF</span>
                                           &nbsp;&nbsp;

                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnSearchDocumentExportExcel" runat="server" CausesValidation="False" CommandName="ExportToExcel" CssClass="GridCmdTreeView GridCmdExportToExcel"
                                                SecurityButtonType="ItemMode" ToolTip="<%$Resources: ExportToExcel_Tooltip %>"  OnClientClick="return exportExcelClicking(this);">
                                                          <span>Excel</span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="NoWrap SearchDoctdRecent">
                                            <telerik:RadToolBar ID="RadToolBar2" runat="server" Style="z-index: 0; border: 0px transparent none; position: static">
                                                <Items>
                                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                                </Items>
                                            </telerik:RadToolBar>
                                        </td>
                                    </tr>
                                </table>
                            </td>

                            <td id="fileManagerDropDownList" runat="server">
                                <table class="TableNoSpacingNoBoder">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblShowFilesIn" runat="server" Text="Show Files In"></asp:Label></td>
                                        <td style="padding-left: 24px">
                                            <telerik:RadComboBox PostBack="true" ID="ddlFolderSelection" OnClientSelectedIndexChanged="ddlFolderSelection_IndexChanged" Width="240px" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="All Folders" Value="1" />
                                                    <telerik:RadComboBoxItem Text="Selected Folder" Value="2" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </CommandItemTemplate>

        </MasterTableView>
        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowGroupExpandCollapse="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="True">
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                AllowColumnResize="True"></Resizing>
            <ClientEvents OnCommand="OnCommand" OnGridCreated="GridCreated" OnRowDblClick="GoToDocument" OnRowDeselected="SearchDocument_Deselect" OnRowSelecting="SearchDocument_OnRowSelecting" OnRowSelected="SearchDocument_OnRowSelected" />
            <Scrolling UseStaticHeaders="true" AllowScroll="true" />
            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />

        </ClientSettings>
        <GroupingSettings ShowUnGroupButton="true" />
        <ExportSettings IgnorePaging="false" ExportOnlyData="true" OpenInNewWindow="true">
            <Csv EnableBomHeader="true" />
            <Pdf PageHeight="527mm" PageWidth="527mm" DefaultFontFamily="Arial Unicode" BorderStyle="Medium" BorderColor="#666666"></Pdf>
            <Word Format="Docx" />
            <Excel Format="Xlsx" />
        </ExportSettings>
    </telerik:RadGrid>
    <asp:Button ID="btnInitNewRecord" runat="server" CssClass="Hide" />
    <asp:Button ID="btnSaveAsLayout" runat="server" CssClass="Hide" />
     <asp:Button ID="btnGoToBookmarks" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hfSaveAsLayout" runat="server" Value="0" />
    <asp:Button ID="btnProjectFilter" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hfProjectFilter" runat="server" Value="0" />
    <asp:Button ID="btnProgramFilter" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hfProgramFilter" runat="server" Value="0" />
    <asp:Button ID="btnActiveFilter" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hfActiveFilter" runat="server" Value="0" />
    <asp:HiddenField ID="hfFolder" runat="server" Value="0" />
    <asp:Button ID="btnFolder" runat="server" CssClass="Hide" />
    <asp:HiddenField ID="hfdeletedIds" runat="server" Value="0" />
    <asp:HiddenField ID="hfIsClearCommand" runat="server" Value="0" />
    <asp:HiddenField ID="hfFolderId" runat="server" Value="0" />
    <asp:Button ID="btnChangeFolderId" runat="server" CssClass="Hide" />
    <asp:Button ID="btnDeleteAfterConfirmation" CausesValidation="false" CssClass="Hide" runat="server" OnClientClick="return ConfirmSearchDelete()" />
</asp:Content>
