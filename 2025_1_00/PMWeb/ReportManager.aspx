<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ReportManager.aspx.vb" Inherits="Website.ReportManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ReportManagerPermissions.ascx" TagName="ReportManagerPermissions" TagPrefix="uc1" %>
<%@ Register Src="ReportPrintingSetup.ascx" TagName="ReportPrintingSetup" TagPrefix="uc2" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">

            function CheckMails(sender, args) {

                var emails = args.Value;
                var emails_array = emails.replace(/(\r\n|\n|\r)/gm, ';').split(";");
                var reg = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;

                for (var i = 0; i < emails_array.length; i++) {
                    if (emails_array[i].replace(/\s/g, '') != '' && reg.test(emails_array[i]) == false) {
                        args.IsValid = false;
                        return;
                    }

                }


                args.IsValid = true;
                return;


            }
            function RemoveUserBox(argId) {
                var hfdeletedUser = $("[id$=hfdeletedUser]")[0];
                hfdeletedUser.value = argId;
                var btnRemoveUsers = $("[id$=btnRemoveUsers]");
                btnRemoveUsers.click();

            }
            function RemoveContactBox(argId) {
                var hfdeletedContact = $("[id$=hfdeletedContact]")[0];
                hfdeletedContact.value = argId;
                var btnRemoveContact = $("[id$=btnRemoveContact]");
                btnRemoveContact.click();
            }
            function AddContacts() {
                var btnAddContacts = $("[id$=btnAddContacts]");
                btnAddContacts.click();

            }
            function AddUsers() {
                var btnAddContacts = $("[id$=btnAddUsers]");
                btnAddContacts.click();
            }

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
               var showmenu= setMenuItemsState(args.get_menu().get_items(), treeNode);
               if (showmenu == false) {
                   var evt = args.get_domEvent();
                   evt.preventDefault()
                   args._cancel = true;
                   document.querySelector(".trvContextMenu").style.display = "none";
                   
               }
            }

            function SaveFolder(treeView) {
                if (event.keyCode == 13) {
                    var tree = $find($(treeView)[0].id);
                    var editNode = tree._editNode;
                    var NodeText = "";

                    if (editNode && editNode.get_inputElement() && editNode.get_inputElement().value == 'New Power BI Report Folder' && editNode.get_attributes()._data["IsNew"] === 'True' && editNode._parent) {
                        var parentId = editNode._parent.get_value();
                        document.getElementById('<%= hdnParentNodeId.ClientID %>').value = parentId
                        $("[id$='btnAddPowerBIFolder']")[0].click();
                        $("[id$='btnRefreshTree']")[0].click();
                        
                    }
                       

                  //  tree.commitChanges();
                }
              
              
        }

     <%--       var tree = $find("<%= treeReports.ClientID %>");
            tree.AddEventListener("keyup", function (event) {
                if (event.keyCode == 13) {
                    var selectedNode = tree.selectedNodes[0];
                    tree.beginEdit(selectedNode);
                }
            });--%>

            function onClientContextMenuItemClicking(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();
                var tree = $find("<%= treeReports.ClientID %>");
                //tree.onKeyUp = SaveFolder(event,args);
                treeNode.set_selected(true);
                menuItem.get_menu().hide();
                var isGrougSelected = false;
                var isItemSelected = false;
                var nodes = tree.get_selectedNodes();
                
                switch (menuItem.get_value()) {
                    case "Rename":
                        treeNode.startEdit();
                        args.set_cancel(true);
                        break;
                    case "NewFolder":
                        treeNode.expand();
                        window.setTimeout(function () { addGroupNode(''); }, 200);
                        args.set_cancel(true);
                        break;
                    case "AddFolder":
                        treeNode.expand();
                        window.setTimeout(function () { addGroupNode('New Power BI Report Folder'); }, 200);
                        args.set_cancel(true);
                        treeNode.startEdit();
                        break;
                    case "NewFile":
                        var nodeValue = treeNode.get_value();
                        args.set_cancel(false);
                        break;

                    case 'AddServerReport':
                        var nodeValue = treeNode.get_value();
                        var win = OpenPOPUp('ReportsAddReportToServer.aspx?FolderId=' + nodeValue, 610, 500)
                        //var left = (screen.width - 900) / 2;
                        //var top = (screen.height - 500) / 2;
                        //var win = window.open('ReportsAddReportToServer.aspx?FolderId=' + nodeValue, '',
                        //        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=610,height=500,top=' + top + ',left=' + left);
                        var timer = setInterval(function () {
                            if (win.closed) {
                                clearInterval(timer);
                                window.location.href = window.location.href;
                                //window.location.reload();
                            }
                        }, 1000);
                        args.set_cancel(true);
                        break;

                    case "Delete":
                    case "DeleteFolder":
                    case "DeletePowerBIReport":
                        var isFile = false;

                        if (tree.get_selectedNode().get_value().indexOf("R_") > -1)
                            isFile = true;
                        var result;
                        if (!isFile)
                            result = confirm(Msg_ConfirmDeleteFolder);
                        else
                            result = confirm(Msg_ConfirmDeleteReport);

                        args.set_cancel(!result);
                        break;

                    case "AddPowerBIReport":
                        var nodeValue = treeNode.get_value();
                        var FolderId = nodeValue.replace(/^[F_]+/, '');
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var wnd = window.radopen('AddEditpowerBIReportPopUp.aspx?ReportId=' + 0 + '&FolderId=' + FolderId + '&IsNew=' + 1);
                        var divWindow = wnd._popupElement;
                        wnd.set_visibleTitlebar(false);
                        wnd._topResizer.parentElement.className = "";
                        divWindow.classList.add("rwFolderManager");
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.5);
                            wnd.Center();
                        }
                        wnd.add_close(RefreshTree);
                        return false;
                        break;

                    case "BrowsePowerrBI":
                        var nodeValue = treeNode.get_value();
                        var FolderId = nodeValue.replace(/^[F_]+/, '');
                        var wnd = window.radopen('BrowsePowerBIPopUP.aspx?FolderId=' + FolderId);
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var divWindow = wnd._popupElement;
                        wnd.set_visibleTitlebar(false);
                        wnd._topResizer.parentElement.className = "";
                        divWindow.classList.add("rwFolderManager");
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.5);
                            wnd.Center();
                        }
                        wnd.add_close(RefreshTree);
                        return false;
                        break;
                    case "EditPeowerBIReport":
                        var nodeValue = treeNode.get_value();
                        var FolderId = treeNode._parent.get_value().replace(/^[F_]+/, '')
                        var ReportId = nodeValue.replace(/^[R_]+/, '');
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var wnd = window.radopen('AddEditpowerBIReportPopUp.aspx?ReportId=' + ReportId + '&IsNew=' + 0 + '&FolderId=' + FolderId);
                        var divWindow = wnd._popupElement;
                        wnd.set_visibleTitlebar(false);
                        wnd._topResizer.parentElement.className = "";
                        divWindow.classList.add("rwFolderManager");
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight - 10);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.5);
                            wnd.Center();
                        }
                        wnd.add_close(RefreshTree);
                        //CloseAndSelectNode(nodeValue)
                        return false;
                        break;

                    case "RunPowerBIReport":
                        var NodeValue = treeNode.get_value();
                        RunPowerBIReport(NodeValue)
                        
                        
                        break;
                }
            }
            function RefreshTree() {
                $("[id$='btnRefreshTree']")[0].click();
               
            }
            function CloseAndSelectNode() {
               
                var tree = $find("<%= treeReports.ClientID %>");
                var NodeId = '<%=PM.ReportInfo.Id%>';
                var NodeValue = 'R_' + NodeId;
                var SelectedNode = tree.findNodeByValue(NodeValue);
                if (SelectedNode) {
                    SelectedNode.set_selected(true);
                }
                return
            }

            function AddFolder(e){
                 $("[id$='btnAddFolder']")[0].click(e);
            }

            function RunPowerBIReport(NodeValue) {
                var ReportId = 0
                var RootNodeValue=document.getElementById('<%= hdnRootNode.ClientID %>').value
                if (NodeValue == '') {
                    ReportId='<%=PM.ReportInfo.Id%>'
                }
                else {
                    ReportId = NodeValue.replace(/^[R_]+/, '');
                }               
                var left = (screen.width - 890) / 2;
                var top = (screen.height - 430) / 2;
                window.open('SamplePowerBIReport.aspx?ReportId=' + ReportId + '&RootNode=' + RootNodeValue, 'welcome', 'width=890,height=430,top=' + top + 'left=' + left);

            }
            function addGroupNode(nodeText) {

                var tree = $find("<%= treeReports.ClientID %>");
                tree.trackChanges();

                //Instantiate a new client node
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode();
                //Set its value, text and image
                node.set_value(parent.get_value);
                if (nodeText !== '') {
                    node.innerText = nodeText
                } 
                node.set_text(nodeText);
                //node.set_imageUrl(parent.get_imageUrl())
                //Set IsNew attribute for checking on server side
                node.get_attributes().setAttribute("IsNew", "True")
                //Add the new node as the child of the selected node or the treeview if no node is selected
                //parent.expand();

                parent.get_nodes().add(node);
                node._addClassToContentElement("trvFolderWhite")
                //Expand the parent if it is not the treeview
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 100);
                parent.set_selected(false);

                tree.commitChanges();
                return node;
            }


            //this method disables the appropriate context menu items
            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find("<%= treeReports.ClientID %>");   
                var nodes = tree.get_selectedNodes();
                var IsPowerBIReport = tree.get_selectedNode()._attributes._data.IsPowerBI
                var IsPowerBIFolder = tree.get_selectedNode()._attributes._data.IsPowerBIFolder
                var isFile = false;
               

                if (tree.get_selectedNode().get_level() == 0) {
                    for (var i = 0; i < menuItems.get_count() ; i++) {
                        menuItems.getItem(i).set_visible(false);
                    }
                    return false;
                }

                if (tree.get_selectedNode().get_value().indexOf("R_") > -1)
                    isFile = true;
                var ShowMenu = false;
                for (var i = 0; i < menuItems.get_count() ; i++) {
                    var menuItem = menuItems.getItem(i);
                    
                    //alert(menuItem.get_value());
                    switch (menuItem.get_value()) {
                        case "Rename":
                            if (nodes.length > 1 || IsPowerBIFolder== "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                               
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                 
                                } else {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');
                                    ShowMenu=true;
                                    menuItem.set_visible(tree.get_selectedNode().get_level() != 1);
                                    if (!(tree.get_selectedNode().get_level() != 1))
                                        menuItem.get_element().style.display = "none";
                                }
                            }


                            break;
                        case "NewFolder":
                            if (nodes.length > 1 || IsPowerBIFolder == "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                                
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    ShowMenu=true;
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "NewFile":
                            if (nodes.length > 1 || IsPowerBIFolder == "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                           
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    ShowMenu=true;
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("AddReports").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "AddServerReport":
                            if (nodes.length > 1 || IsPowerBIFolder == "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                               
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    ShowMenu=true;
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("AddReports").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "Delete":
                           
                            if (isFile) {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("DeleteReports").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                                ShowMenu = true;
                            } else {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                                ShowMenu = true;
                            }

                            menuItem.set_visible(tree.get_selectedNode().get_level() != 1);
                            if (!(tree.get_selectedNode().get_level() != 1) || IsPowerBIFolder == "1" || IsPowerBIReport == "1") {
                                menuItem.get_element().style.display = "none";
                                ShowMenu=false;
                            }

                            break;
                        case "EditPermissions":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                               
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    ShowMenu=true;
                                    menuItem.set_enabled(
                                    tree.get_selectedNode().get_attributes().getAttribute("EditPermissions").toLowerCase() == 'true');
                                }
                            }
                            break;

                        case "EditPeowerBIReport":                       
                            if (nodes.length > 1 || IsPowerBIReport !== "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                              
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(
                                tree.get_selectedNode().get_attributes().getAttribute("EditReports").toLowerCase() == 'true');
                            }
                            break;

                        case "RunPowerBIReport":
                            if (nodes.length > 1 || IsPowerBIReport !== "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                             
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(
                               tree.get_selectedNode()._parent._attributes.getAttribute("ViewOnly").toLowerCase() == 'true');
                            }
                            break;

                        case "DeletePowerBIReport":
                            if (IsPowerBIReport !== "1") {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                                
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                   tree.get_selectedNode().get_attributes().getAttribute("DeleteReports").toLowerCase() == 'true' &&
                                   tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                            }
                            break;

                        case "DeleteFolder":
                            if (IsPowerBIFolder !== "1"  || tree.get_selectedNode().get_level()==1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                               
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                   tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true' &&
                                   tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                            }
                            break;
                        
                      
                        case "AddFolder":                       
                            if (nodes.length > 1 || IsPowerBIFolder !== "1" || tree.get_selectedNode().get_text() == 'POWER BI REPORTS') {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";

                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');
                                   
                            }
                    
                            break;

                        case "AddPowerBIReport":
                            if (nodes.length > 1 || IsPowerBIFolder !== "1" || tree.get_selectedNode().get_text() == 'POWER BI REPORTS') {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                   tree.get_selectedNode().get_attributes().getAttribute("AddReports").toLowerCase() == 'true');

                            }

                            break;

                        case "BrowsePowerrBI":
                            if (nodes.length > 1 || IsPowerBIFolder !== "1" || tree.get_selectedNode().get_text() == 'POWER BI REPORTS') {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            }
                            else {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                ShowMenu=true;
                                menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true');

                            }

                            break;

                            

                    }   
                }
              
                return ShowMenu;
               

            }
            function DisplayMessage(innerText) {
                alert(innerText);
            }

            ////////Report Schedules/////////////////
            function OpenSelectUserPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 568) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                //if (querySt("ObjectTypeId") == '94') {
                //    Bidder = 1;
                //}
                var wnd = window.radopen('SelectUserPopup.aspx?&Bidder=' + Bidder + '&Source=Report', '');
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

            function OpenReminderMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                //if (querySt("ObjectTypeId") == '94') {
                //    Bidder = 1;
                //}
                var wnd = window.radopen('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source, '');
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

            function ParamValuesDropped(sender, args) {
                let destEl = args.get_htmlElement();
                while (!destEl.id.includes("rlbParameterValues")) {
                    destEl = destEl.parentElement;
                }
                if (sender.get_id() == destEl.id) return false;

                let btnTransfer
                switch (sender.get_id().slice(sender.get_id().lastIndexOf("_") + 1)) {
                    case "rlbParameterValuesFrom":
                        btnTransfer =$("[id$=btnTransferFrom]");
                        break;
                    case "rlbParameterValuesTo":
                        btnTransfer = $("[id$=btnTransferTo]");
                        break;
                }
                btnTransfer.click();
            }

            function OnTransferClick(sender, args) {
                if (Boolean(sender.getAttribute("disabled")) === true ) {
                    return false;
                }
                let hdnTransferIds = document.getElementById('<%= hdnTransferIds.ClientID %>')
                let rlbParameterValuesFrom = $find("<%=rlbParameterValuesFrom.ClientID%>");
                let rlbParameterValuesTo = $find("<%=rlbParameterValuesTo.ClientID%>");
                hdnTransferIds.value = ""
                switch (sender.id.slice(sender.id.lastIndexOf("_") + 1)) {
                    case "btnTransferFrom":
                        if (getListBoxValues(rlbParameterValuesFrom).length <= 0) {
                            return false;
                        }
                        hdnTransferIds.value = getListBoxValues(rlbParameterValuesFrom).join(",");
                        break;
                    case "btnTransferAllFrom":
                        if (getListBoxValues(rlbParameterValuesFrom, true).length <= 0) {
                            return false;
                        }
                        //hdnTransferIds.value = getListBoxValues(rlbParameterValuesFrom, true).join(",");
                        break;
                    case "btnTransferTo":
                        if (getListBoxValues(rlbParameterValuesTo).length <= 0) {
                            return false;
                        }
                        hdnTransferIds.value = getListBoxValues(rlbParameterValuesTo).join(",");
                        break;
                    case "btnTransferAllTo":
                        if (getListBoxValues(rlbParameterValuesTo, true).length<= 0) {
                            return false;
                        }
                        //hdnTransferIds.value = getListBoxValues(rlbParameterValuesTo, true).join(",");
                        break;
                }
                disableTransferButton(sender.id);
                return true;
            }
            function getListBoxValues(listbox, isAll) {
                if (isAll == true) {
                    return listbox.get_items().toArray().map((x) => x.get_value())
                }
                return listbox.get_selectedItems().map((x) =>x.get_value());
            }

            function ParamValuesItemsRequested(sender, args) {
                if (sender.get_items().get_count() <= 0) {
                    return false;
                }
                switch (sender.get_id().slice(sender.get_id().lastIndexOf("_") + 1)) {
                    case "rlbParameterValuesFrom":
                        enableTransferButton($("[id$=btnTransferAllFrom]")[0].id);
                        break;
                    case "rlbParameterValuesTo":
                        enableTransferButton($("[id$=btnTransferAllTo]")[0].id);
                        break;
                }
                return true;
            }

            function ParamValuesSelectionChanged(sender, args) {
                switch (sender.get_id().slice(sender.get_id().lastIndexOf("_") + 1)) {
                    case "rlbParameterValuesFrom":
                        enableTransferButton($("[id$=btnTransferFrom]")[0].id);
                        break;
                    case "rlbParameterValuesTo":
                        enableTransferButton($("[id$=btnTransferTo]")[0].id);
                        break;
                }
                return true;

            }
            function disableTransferButton(btnId) {
                let btn = $(`[id$=${btnId}]`)
                if (!btn.hasClass("Disabled")) {
                    btn.addClass("Disabled");
                }
                btn.prop("disabled", true)
            }
            function enableTransferButton(btnId) {
                let btn = $(`[id$=${btnId}]`)
                if (btn.hasClass("Disabled")) {
                    btn.removeClass("Disabled");
                }
                btn.prop("disabled", false)
            }
        </script>

    </telerik:RadCodeBlock>
    <script type="text/javascript">
        var UserPos;
        var ContPos;

        function ScheduleResponseEnd(sender, eventArgs) {
            try {
                document.getElementById("dvUser").scrollTop = UserPos;
                document.getElementById("dvContact").scrollTop = ContPos;
            }
            catch (e) {

            }
        }
        function ScheduleRequestStart(sender, eventArgs) {
            try {
                UserPos = document.getElementById("dvUser").scrollTop;
                ContPos = document.getElementById("dvContact").scrollTop;
            }
            catch (e) {

            }

        }
function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                if (sender.get_parent() != null)
                    var splitter = sender.get_parent();
                else
                    var splitter = sender;
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
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
        }
        function OnClientCollapsed(sender, ags) {
            $("#ctl00_CPH1_Splitter").addClass("removeLeft");
            setTimeout(FloatDivs, 100);
            setCookie('ReportManagerStatus', 'inline', 60);
        }
        function OnClientExpanded(sender, ags) {
            $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
        }
        var mainsplitter = null;
        function onResized(sender, ags) {
            ////var NewWidth = sender._panes[1].get_width() - 20;
            ////sender._panes[1].set_width(NewWidth);
            ////return false;
            fixSplitterSize();
            mainsplitter = sender;

        }
        function AssetSplitterResized(sender, ags) {
            setTimeout(FloatDivs, 100);
        }
        //function fixSplitterSize(isRail) {
        //    if (mainsplitter == null) return;
        //    var sender = mainsplitter._panes[1];
        //    var browserWidth = $telerik.$(window).width();
        //    if (isRail) {
        //        sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
        //    }
        //    else {
        //        sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
        //    }
        //    if (browserWidth <= 843) {
        //        sender.set_width(browserWidth - 20);
        //        return;
        //    }
        //    $(document).scrollLeft(1);
        //    while ($(document).scrollLeft() != 0) {
        //        var NewWidth = sender.get_width() - 5
        //        sender.set_width(NewWidth);
        //        $(document).scrollLeft(1);
        //        if (NewWidth <= 100) break;
        //    }


        //}

        <%--        function ToggleAssetMenu() {
            var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
            var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>');
            var tdAssetrestofpage = document.getElementById('<%=tdAssetrestofpage.ClientID %>');
            var tdtbsDocument = document.getElementById('<%=tdtbsDocument.ClientID %>');
            var form = $('form')[0]
            var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
              if (tdAssetMenu.style.display == 'none') {
                  tdAssetMenu.style.display = '';
                  tdAssetExplorerBar.style.left = "285px";
                  tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBar'
                  btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                  setCookie('AssetMenuStatus', 'inline', 60);
                  // form.className = form.className + ' ReportManagerTabsvisible';
                  tdtbsDocument.className = 'ReportManagerTabs'
              } else {
                  tdAssetMenu.style.display = 'none';
                  tdAssetExplorerBar.style.left = "0px";
                  tdAssetExplorerBar.style.width = "4px";
                  tdAssetrestofpage.style.width = "100%";
                  tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBarClosed'
                  btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                  setCookie('AssetMenuStatus', 'none', 60);
                  // form.className = form.className.replace(' ReportManagerTabsVisiible', '')
                  tdtbsDocument.className = 'ReportManagerTabstreehidden'

              }
              return false;
          }--%>
    </script>
    <style type="text/css">
        .ContactBox {
            float: left;
        }

        .removeLeft {
            left: 0 !important;
        }

        body, html, form {
            height: 100%;
            margin: 0px;
            padding: 0px;
        }

        .AssetSplitterPane {
            background-color: #666666;
        }
          .ReportColTable{
                width: 100%;
                table-layout: fixed;
                border-spacing: 0;
            }

        @media screen and (max-width: 1323px) and (min-width: 844px) {
            .ReportManagerTree {
                height: calc(100vh - 77px);
            }
        }

       /* @media screen and (max-width: 843px) and (min-width: 320px) {
            .Selected.AssetSplitterPane {
                margin-top: 33px !important;
                height: calc(100vh - 71px) !important;
            }

            .ReportManagerTree {
                height: calc(100vh - 0px) !important;
                max-height: calc(100vh - 0px) !important;
            }

            .Selected.AssetSplitter {
                margin-top: 33px !important;
                height: calc(100vh - 70px) !important;
                height: calc(100vh - 70px) !important;
            }
            .divContentHolder {
                margin-top: 25px !important;
            }
            .AssetSplitterRightPane {
                height: calc(91vh - 2px) !important;
                width: calc(100vw - 5px) !important;
                padding-top: 34px;
    }
        }*/

        .ReportManagerTabs .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .ReportManagerTabs {
            padding-top: 0px !important;
        }

            .ReportManagerTabs li {
                width: calc(50% - 8px) !important;
            }

        .trvNewFolderWhite .rtSp {
            margin-right: -14px;
        }

        .trvNewFolderWhite .rtIn {
            margin-left: 14px;
        }


        .btnTransfer {
            position: relative;
            width: 22px;
            height: 22px;
            border: 1px solid transparent;
            background: linear-gradient(0deg, #C5C5C5 0%, #E1E1E1 100%) padding-box, linear-gradient(0deg, #9D9D9D 0%, #C5C5C5 100%) border-box;
            border-radius: 3px;
            cursor: pointer;
            margin: 0px 3px 2px 3px;
        }

            .btnTransfer input[type=button] {
                width: 100%;
                height: 100%;
                all: unset;
                z-index: 1000;
                position: absolute;
            }

            .btnTransfer::after {
                content: '';
                display: block;
                position: absolute;
                background-image: url('./CSS/Images/ListBox/rlbSprite.png');
                width: 22px;
                height: 22px;
                top: 0;
                left: 0;
            }

            .btnTransfer:hover {
                background: linear-gradient(0deg, #828282 0%, #959595 100%) padding-box, 
                            linear-gradient(0deg, #6B6B6B 0%, #8E8E8E 100%) border-box;
            }

            .btnTransfer.Disabled {
                opacity: 0.5;
                cursor: default;
            }

                .btnTransfer.Disabled:hover {
                    background: linear-gradient(0deg, #C5C5C5 0%, #E1E1E1 100%) padding-box, 
                                linear-gradient(0deg, #9D9D9D 0%, #C5C5C5 100%) border-box;
                }

            .btnTransfer.btnTransferFrom::after {
                background-position: 0 -75px;
            }

            .btnTransfer.btnTransferFrom:hover::after {
                background-position: -400px -75px;
            }

            .btnTransfer.btnTransferFrom.Disabled::after,
            .btnTransfer.btnTransferAllFrom.Disabled:hover::after {
                background-position: -200px -75px;
            }

            .btnTransfer.btnTransferTo::after {
                background-position: 0 -100px;
            }

            .btnTransfer.btnTransferTo:hover::after {
                background-position: -400px -100px;
            }

            .btnTransfer.btnTransferTo.Disabled::after,
            .btnTransfer.btnTransferTo.Disabled:hover::after {
                background-position: -200px -100px;
            }

            .btnTransfer.btnTransferAllFrom::after {
                background-position: 0 -125px;
            }

            .btnTransfer.btnTransferAllFrom:hover::after {
                background-position: -400px -125px;
            }

            .btnTransfer.btnTransferAllFrom.Disabled::after,
            .btnTransfer.btnTransferAllFrom.Disabled:hover::after {
                background-position: -200px -125px;
            }


            .btnTransfer.btnTransferAllTo::after {
                background-position: 0 -150px;
            }

            .btnTransfer.btnTransferAllTo:hover::after {
                background-position: -400px -150px;
            }

            .btnTransfer.btnTransferAllTo.Disabled::after,
            .btnTransfer.btnTransferAllTo.Disabled:hover::after {
                background-position: -200px -150px;
            }

        .customTreeViewHeight {
            height: calc(100vh - 93px) !important;
        }
        .RDLeftPane {
            background-color: #666;
            color: #fff;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpReportManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
        <tr>

            <td></td>
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True"
                    meta:resourcekey="mainToolBarResource1" Visible="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s"
                            ToolTip="Save (Alt+s)" Visible="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" CommandName="Preview"
                            AccessKey="p" ToolTip="Preview (Alt+p)" Visible="false">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="RDSplitter" SplitBarsSize="" >
        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" CssClass="RDLeftPane" Width="30%" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" >

            <telerik:RadTreeView ID="treeReports" runat="server" CssClass="ReportManagerTree WhitePlusMinus" Style="height: calc(100% - 24px); padding: 24px 0 0 24px;"
                MultipleSelect="true" EnableDragAndDrop="true"  AllowNodeEditing="false" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" onKeydown="SaveFolder(this)"
                OnClientContextMenuShowing="onClientContextMenuShowing" EnableEmbeddedSkins="false" CausesValidation="false">
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu" Style="display:none !important">
                        <Items>
                            <telerik:RadMenuItem Value="Rename" Text="Rename" meta:ResourceKey="MenuItem_Rename" EnableImageSprite="true" CssClass="MenuRename">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="NewFile" Text="New Report" meta:ResourceKey="MenuItem_NewFile"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="AddServerReport" Text="Add Server Report" meta:ResourceKey="MenuItem_AddServerReport"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="NewFolder" meta:ResourceKey="MenuItem_NewFolder" Text="New Folder"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="Delete" Text="Delete" meta:ResourceKey="MenuItem_Delete" EnableImageSprite="true" CssClass="MenuDelete">
                            </telerik:RadMenuItem>                           
                             <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuPowerBI" meta:ResourceKey="MenuItem_AddPowerBIReport"
                                Text="Add Power BI report" Value="AddPowerBIReport" PostBack="false">
                            </telerik:RadMenuItem>
                             <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuBrowsePowerrBI" meta:ResourceKey="MenuItem_BrowsePowerBI"
                                Text="Browse Power BI" Value="BrowsePowerrBI" PostBack="false">
                            </telerik:RadMenuItem>
                             <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuAddFolder" meta:ResourceKey="MenuItem_AddFolder"
                                Text="Add Folder" Value="AddFolder">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuPermission" meta:ResourceKey="MenuItem_EditPermissions"
                                Text="Permissions" Value="EditPermissions">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                             <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuDeleteFolder" meta:ResourceKey="MenuItem_DeleteFolder"
                                Text="Delete Folder" Value="DeleteFolder">
                            </telerik:RadMenuItem>
                              <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuEditPowerBIReport" meta:ResourceKey="MenuItem_EditPowerBIReport"
                                Text="Edit Power BI Report" Value="EditPeowerBIReport" PostBack="false">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuRunPowerBIReport" meta:ResourceKey="MenuItem_RunPowerBIReport" 
                                 Value="RunPowerBIReport" PostBack="false">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                             <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuDeletePowerBIReport" meta:ResourceKey="MenuItem_DeletePowerBIReport"
                                Text="Delete Power BI Report" Value="DeletePowerBIReport">
                            </telerik:RadMenuItem>
                            
                           
                        </Items>
                    </telerik:RadTreeViewContextMenu>
                </ContextMenus>
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
            </telerik:RadTreeView>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="" CollapseMode="Forward" />
        <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="RDRightPane">
            <telerik:RadTabStrip ID="tbsDocument" runat="server" CausesValidation="False" EnableViewState="true" CssClass="ReportManagerTabs"
                meta:resourcekey="tbsDocumentResource1" MultiPageID="mlpReportManager"
                OnTabClick="tbsDocument_TabClick" SelectedIndex="0" Skin="Default" Width="100%">
                <Tabs>
                    <telerik:RadTab meta:resourcekey="tab_General" Text="General" Value="General" />
                    <telerik:RadTab meta:resourcekey="tab_PrintingSetup" Text="Printing Setup" Value="PrintingSetup" />
                    <telerik:RadTab meta:resourcekey="tab_Permissions" Text="Permissions" Value="Permissions" />
                   
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="mlpReportManager" runat="server" meta:resourcekey="mlpReportManagerResource1"
                RenderSelectedPageOnly="True" SelectedIndex="0">
                <telerik:RadPageView ID="pvReportManager" runat="server" meta:resourcekey="pvReportManagerResource1">
                    <asp:Panel ID="pnlInput" runat="server">
                        <div class="PMMainPage">
                            <div class="row">
                                <div class="col-4 col-4-left">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblReportName" meta:resourcekey="lblReportName" runat="server" Text="Report Name*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtReportName" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtReportName" runat="server" ID="rfvReportName"
                                                    ErrorMessage="Required" Enabled="true" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblReportType" meta:resourcekey="lblReportType" runat="server" Text="Report Type"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlReportType" OnClientSelectedIndexChanged="DisplayReportType"
                                                    runat="server" AllowCustomText="true" MarkFirstMatch="True" Skin="Default" CloseDropDownOnBlur="true"
                                                    Height="100" Width="100%">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblFullFilePath" meta:resourcekey="lblFullFilePath" runat="server"
                                                    Text="Folder Path"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:HyperLink ID="hlifullFilePath" meta:resourcekey="hlifullFilePath" runat="server"
                                                    SecurityButtonType="Edit" Target="_blank"></asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblIsSystem" meta:resourcekey="lblIsSystem" runat="server"
                                                    Text="Is System"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <img src="Images/Global/<%=CStr(IIf(PM.ReportInfo.IsSystem, "checked.png", "unchecked.png"))%>" alt="" />
                                            </td>
                                        </tr>
                                        <tr id="trCrystalReport" runat="server">
                                            <td colspan="2">
                                                <table style="width: 100%" cellpadding="1" cellspacing="0">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblUploadFile" meta:Resourcekey="lblUploadFile" runat="server" Text="Upload File"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <input type="file" style="width: 100%" runat="server" id="flReportFile" />

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblFileName" meta:resourcekey="lblFileName" runat="server" Text="File Name"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtFileName" ReadOnly runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDatabase" meta:resourcekey="lblDatabase" runat="server" Text="Database Name"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlDatabaseName" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                                                Skin="Default" CloseDropDownOnBlur="true" Height="100" Width="100%">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:CheckBox ID="chkEnableParameterPrompt" meta:Resourcekey="chkEnableParameterPrompt"
                                                                Text="Enable Parameter Prompt" runat="server" />
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:CheckBox ID="chkEnableDatabaseLogonPrompt" meta:Resourcekey="chkEnableDatabaseLogonPrompt"
                                                                Text="Enable Database Logon Prompt" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trSqlReport" runat="server">
                                            <td class="labelWidth">
                                                <asp:Label ID="lblServerURL" meta:resourcekey="lblServerURL" runat="server" Text="Server URL*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtServerURL" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtServerURL" runat="server" ID="rfvServerURL"
                                                    ErrorMessage="Required" Enabled="true" meta:resourcekey="rfvServerURL" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPath" runat="server" meta:Resourcekey="lblPath" Text="Path*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPath" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtPath" runat="server" ID="rfvPath"
                                                    ErrorMessage="Required" Enabled="true" meta:resourcekey="rfvPath" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-4 col-4-right" style="width: 400px !important;">
                                    <table class="colTable" style="width: 400px !important;">
                                        <tr id="trParameters" runat="server">
                                            <td colspan="2">
                                                <asp:Panel ID="pnlParameters" runat="server">
                                                    <fieldset>
                                                        <legend>
                                                            <asp:Label ID="lblProjectParameters" runat="server" Text="Projects" meta:Resourcekey="lblProjectParameters"></asp:Label>
                                                        </legend>
                                                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpPM">
                                                        <table cellpadding="0" cellspacing="0" width="400px">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <telerik:RadListBox ID="rlbParameterValuesFrom" runat="server" CssClass="ParameterValuesFrom" Height="248px" Skin="Default"
                                                                            SelectionMode="Multiple" EnableLoadOnDemand="true" AllowReorder="false" AutoPostBackOnReorder="false"
                                                                            OnClientSelectedIndexChanged="ParamValuesSelectionChanged" OnClientItemsRequested="ParamValuesItemsRequested"
                                                                            EnableDragAndDrop="true" Width="186px" DataTextField="ProjectName" DataValueField="Id" OnClientDropped="ParamValuesDropped">
                                                                        </telerik:RadListBox>
                                                                    </td>
                                                                    <td>
                                                                        <button runat="server" id="btnTransferFrom" class="btnTransfer btnTransferFrom Disabled" title="To Right"
                                                                            type="button" onserverclick="btnTransferFrom_Click" onclick="OnTransferClick(this);" disabled="disabled"/>
                                                                        <button runat="server" id="btnTransferTo" class="btnTransfer btnTransferTo Disabled" title="To Left"
                                                                            type="button" onserverclick="btnTransferTo_Click" onclick="OnTransferClick(this);" disabled="disabled"/>
                                                                        <button runat="server" id="btnTransferAllFrom" class="btnTransfer btnTransferAllFrom Disabled" title="All to Right"
                                                                            type="button" onserverclick="btnTransferAllFrom_Click" onclick="OnTransferClick(this);" disabled="disabled"/>
                                                                        <button runat="server" id="btnTransferAllTo" class="btnTransfer btnTransferAllTo Disabled" title="All to Left"
                                                                            type="button" onserverclick="btnTransferAllTo_Click" onclick="OnTransferClick(this);" disabled="disabled"/>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadListBox ID="rlbParameterValuesTo" runat="server" OnClientLoad="rlbParameterValuesTo_Load" CssClass="ParameterValuesTo"
                                                                            Height="248px" Skin="Default" SelectionMode="Multiple" AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true"
                                                                            OnItemDataBound="rlbParameterValuesTo_ItemDataBound" OnClientItemsRequested="ParamValuesItemsRequested" Width="184"
                                                                            DataTextField="ProjectName" DataValueField="Id" EnableLoadOnDemand="true" OnClientDropped="ParamValuesDropped"
                                                                            OnClientSelectedIndexChanged="ParamValuesSelectionChanged" >
                                                                        </telerik:RadListBox>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                            </telerik:RadAjaxPanel>
                                                        <input type="hidden" id="hdnTransferIds" runat="server" />
                                                    </fieldset>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table style="width: 100%; margin-top: 22px;">
                                                    <tr>
                                                        <td width="50%" valign="top" style="padding-right: 26px">
                                                            <asp:Panel ID="pnlPreviewButton" runat="server">
                                                                <asp:Button ID="btnPreview" runat="server" meta:Resourcekey="btnPreview" Text="Preview" OnClientClick="return openReport();" Width="184px" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td width="50%" align="top">
                                                            <asp:Button ID="btnSave" meta:Resourcekey="btnSave" runat="server" Text="Save" Width="184px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="50%" valign="top">
                                                            <asp:Panel ID="pnlRegenerateParametersButton" runat="server" Visible="false">
                                                                <asp:Button ID="btnRegenerateParameters" meta:Resourcekey="btnRegenerateParameters"
                                                                    CssClass="LargeButton" runat="server" Text="Regenerate Parameters" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td width="50%" valign="top"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblError" runat="server" Text="" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </telerik:RadPageView>
             
                <telerik:RadPageView ID="pvPrinting" Visible="false" runat="server">
                    <uc2:ReportPrintingSetup ID="ReportPrintingSetup1" runat="server" />
                </telerik:RadPageView>
                <telerik:RadPageView ID="pvPermissions" runat="server">
                    <uc1:ReportManagerPermissions ID="ReportManagerPermissions" runat="server" />
                </telerik:RadPageView>
                   <telerik:RadPageView ID="pvRunPowerBIReport" runat="server" meta:resourcekey="pvReportManagerResource1">
                    <asp:Panel ID="pnlBIReport" runat="server">
   <%--                     <table class="ToolBar"  style="width: 100%; margin-top: 50px; background-color: transparent !important" cellpadding="0" cellspacing="0">
            <tr>
             <asp:Image ID="imglogo" ImageUrl="Images/ToolBar/Post.png" runat="server" Style="height: 80px; width: 240px" />
            </tr> 
        </table>--%>
                        <div class="PMMainPage">
                            <div class="row">
                                <div class="col-12">
                                    
                                        <table class="ReportColTable">
                                        <tr>
                                          <td >
                                          <asp:Image ID="Image1" ImageUrl="Images/ToolBar/PBIReportsToolbar.png" runat="server"/>
                                          </td>
                                          
                  
                                        </tr>
                                            <tr style="display: contents !important">
                                                <td colspan="2">
                                                    <hr />

                                                </td>
                                            </tr>
                                            </table>
                                      <table class="colTable">
                                        <tr>
                                            
                                            <td class="labelWidth" style="width:30px !important" >
                                                <asp:Label ID="BIReportName" meta:resourcekey="lblBIReportName" runat="server" Text="Name"></asp:Label>
                                            </td>
                                            <td class="labelWidth">
                                                <asp:Label ID="BIReportNameText"  runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth" style="width:30px !important">
                                                <asp:Label ID="URL" meta:resourcekey="lblURL" runat="server" Text="URL"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                               <asp:Label ID="URlText"  runat="server" Text="URL"></asp:Label>
                                            </td>
                                        </tr>
                                       
                                             <tr>
                                            <td class="labelWidth" style="width:30px !important"></td>
                                            <td class="controlWidth" style="padding-top:25px">
                                              
                                                            <asp:Button ID="btnRun" meta:Resourcekey="btnRun" runat="server" Text="Run" Width="245px" onclientclick="RunPowerBIReport('')" />
                                                        
                                            </td>
                                        </tr>
                                     
                                       
                                    </table>

                                     <table class="" style="padding-top:30px">
                                         <tr>
                                             <td colspan="2">
                                                 
                                                  <asp:Image ID="PBIReportImage" ImageUrl="Images/Global/WhiteDot.gif" runat="server" Style="width:600px;height:200px"/>
                                             </td>
                                         </tr>
                                         </table>   
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </telerik:RadPane>
    </telerik:RadSplitter>
    <%--      
            <td id="tdAssetExplorerBar" runat="server" class="ReportManagerBar MobileAssetExplorerBar">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="return ToggleAssetMenu();" />
            </td>--%>






    <telerik:RadWindowManager ID="radWindowMgr" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" ShowContentDuringLoad="false" IconUrl="Images/Global/favicon.ico"
        VisibleOnPageLoad="false" Behavior="Default" InitialBehavior="None" Left="" Top="">
        <Windows>
            <telerik:RadWindow ID="wndPreview" ShowContentDuringLoad="false" Modal="true" Skin="Default"
                runat="server" Title="Preview">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <input type="hidden" id="hdnRootNode" runat="server" />
    <input type="hidden" id="hdnParentNodeId" runat="server" />
    <input type="hidden" id="hdSelectedReport" runat="server" />
     <asp:Button runat="server" ID="btnAddPowerBIFolder" CssClass="Hide" />
     <asp:Button runat="server" ID="btnRefreshTree" CssClass="Hide" />
    <asp:Button runat="server" ID="btnAddFolder" CssClass="Hide" />
    <telerik:RadAjaxLoadingPanel ID="ldpReportManager" runat="server" Skin="Default" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" src="JS/TelerikUtilities.js"></script>
        <script language="javascript" type="text/javascript">
            function openReport() {
                //           var projects = GetProjectIds();
                //            var wnd = window.radopen('ReportPreview.aspx?projects=' + projects);
                //            wnd.setSize(900, 500);
                //            wnd.Center();
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 900) / 2;
                var top = (screen.height - 500) / 2;
                var Id = '<%=PM.ReportInfo.Id%>';
                var wnd = OpenReportViewerPOPUp('ReportPreview.aspx?reportId='+Id, "");
                wnd.add_close(fixSplitterSize)
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


            function fixSplitterSize(isRail) {
                window.setTimeout(function () {
                    var drawer = $('form')[0];
                     isRail = false;
                    if (drawer.className.indexOf("rail") >= 0)
                        isRail = true;
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
                },500)

            }
            function pageLoad() {
                DisplayReportType();
            }
            function DisplayReportType() {
                var crystal = document.getElementById('<%= trCrystalReport.ClientID %>');
                var sql = document.getElementById('<%= trSqlReport.ClientID %>');

                if (crystal == null || sql == null)
                    return;

                var combo = document.getElementById('<%= ddlReportType.ClientID %>');

                crystal.style.display = 'none';
                sql.style.display = 'none';

                switch (combo.value) {
                    case 'Crystal Report':
                        crystal.style.display = '';
                        break;
                    case 'SQL Report':
                        sql.style.display = '';
                        break;
                    default:
                        switch (document.getElementById('<%= hdSelectedReport.ClientID %>').value) {
                            case 'Crystal Report':
                                crystal.style.display = '';
                                combo.value = document.getElementById('<%= hdSelectedReport.ClientID %>').value;
                                break;
                            case 'SQL Report':
                                sql.style.display = '';
                                combo.value = document.getElementById('<%= hdSelectedReport.ClientID %>').value;
                            break;
                    }
                    break;
            }
        }



        function CheckViewRight(chkViewOnly) {
            var tr = $(chkViewOnly).parents(".rgEditForm:first");
            if (!tr || tr.length == 0)
                tr = $(chkViewOnly).parents("tr:first");
            if (!chkViewOnly.checked) {
                tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                tr.find("input[id $= 'chkManageFolder']")[0].checked = false;
                tr.find("input[id $= 'chkAddReports']")[0].checked = false;
                tr.find("input[id $= 'chkDeleteReports']")[0].checked = false;
                tr.find("input[id $= 'chkEditReports']")[0].checked = false;
                tr.find("input[id $= 'chkEditPermissions']")[0].checked = false;

            }
        }


        function CheckRight(chkRight) {
            var tr = $(chkRight).parents(".rgEditForm:first");
            if (!tr || tr.length == 0)
                tr = $(chkRight).parents("tr:first");
            var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
            var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
            var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
            var chkAddReports = tr.find("input[id $= 'chkAddReports']")[0];
            var chkEditReports = tr.find("input[id $= 'chkEditReports']")[0];
            var chkDeleteReports = tr.find("input[id $= 'chkDeleteReports']")[0];
            var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
            if (chkRight.checked) {
                chkViewOnly.checked = true;
                if (chkManageFolder.checked && chkAddReports.checked && chkEditReports.checked && chkDeleteReports.checked && chkEditPermissions.checked)
                    chkFullControl.checked = true;
            } else {
                chkFullControl.checked = false;
            }
        }

        function CheckFullControlRight(chkFullControl) {
            var tr = $(chkFullControl).parents(".rgEditForm:first");
            if (!tr || tr.length == 0)
                tr = $(chkFullControl).parents("tr:first");
            var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
            var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
            var chkAddReports = tr.find("input[id $= 'chkAddReports']")[0];
            var chkEditReports = tr.find("input[id $= 'chkEditReports']")[0];
            var chkDeleteReports = tr.find("input[id $= 'chkDeleteReports']")[0];
            var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
            if (chkFullControl.checked) {
                chkViewOnly.checked = true;
                chkManageFolder.checked = true;
                chkAddReports.checked = true;
                chkEditReports.checked = true;
                chkDeleteReports.checked = true;
                chkEditPermissions.checked = true;
            } else {
                chkViewOnly.checked = false;
                chkManageFolder.checked = false;
                chkAddReports.checked = false;
                chkEditReports.checked = false;
                chkDeleteReports.checked = false;
                chkEditPermissions.checked = false;
            }
        }


        var rlbParameterValuesTo;
        function rlbParameterValuesTo_Load(sender, args) {
            rlbParameterValuesTo = sender;
        }


        function GetProjectIds() {
            var projects = '';
            if (rlbParameterValuesTo) {
                var items = rlbParameterValuesTo.get_items();
                for (var i = 0; i < items.get_count() ; i++) {
                    var value = items.getItem(i).get_value();
                    if (value != null && value != "")
                        projects += value + ',';
                }

                if (projects.endsWith(","))
                    projects = projects.substring(0, projects.length - 1);
            }
            return projects;
        }

        </script>

    </telerik:RadCodeBlock>

</asp:Content>
