function onKeyPress(sender, args) {
    if (args.get_keyCode() == 13) {
        args.get_domEvent().stopPropagation();
        args.get_domEvent().preventDefault();
        performSearch(sender);
        return false;
    }
}



var ReplyDetailsView;
function onToolbarClicked(sender, args) {
 var commandName = args.get_item().get_commandName();
    
 if (commandName == "Layout" || commandName == "SaveLayout" || commandName == "LoadDefaultState" || commandName == "MobileMenu")
    {
    return; 
    }
    var ProjectId = $("input[id$=hdnProjectId]").val();
    
    if (!ProjectId || ProjectId == "") {
        alert(Msg_SelectProjectFirst);
        return false;
    }

   
    if (commandName == "doSearch") {
        var searchTextBox = sender.findButtonByCommandName("searchText").findControl("txtSearchInbox");
        if (searchButton.get_value() == "clear") {
            searchTextBox.set_value("");
           // searchButton.set_imageUrl("images/Email/search.gif");
            searchButton.set_value("search");
        }
        performSearch(searchTextBox);
    } else if (commandName == "ReceiveEmail") {
        OpenEmailPopup('EmailReceive_Popup.aspx?ProjectId=' + $("input[id$=hdnProjectId]").val() + '&Type=1', 430, 240);
    } else if (commandName == "Refresh") {
        refreshEmails();
    } else if (commandName == "EmailReply") {
    ReplyDetailsView = $("[id$=EmailDetailsView]").html();
        showReply();
    } else if (commandName == "NewEmail") {
    showNewEmail();
    ReplyDetailsView = "";
    } else if (commandName == "CancelSendMail") {
    setTimeout(refreshEmails,500);
    }
}


function OnRadEditorClientLoad(editor) {
   
    editor.get_contentArea().style.backgroundColor = "white";
    editor.get_contentArea().style.backgroundImage = "none";

    if (ReplyDetailsView || ReplyDetailsView != "") {
        var appendHtml = "<br/><br/><hr/><br/>"
        if(ReplyDetailsView) editor.set_html(appendHtml + ReplyDetailsView);
    } else {
        editor.set_html("");
    }
}



function OpenEmailPopup(url, Width, Height) {
    var left = (screen.width - Width) / 2;
    var top = (screen.height - Height) / 2;
    window.open(url, 'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + Width + ',height=' + Height + ',top=' + top + ',left=' + left);
}

function addAttach() {
    var wnd = window.radopen('EmailSendAttach.aspx');
    wnd.setSize(480, 440);
    wnd.add_close(refreshAttach);
    wnd.Center();
    return false;
}



function performSearch(searchTextBox) {
       setTimeout(searchEmails, 100);
        return false;
    
}

var selectedItems;

function onGridRowSelected(sender, args) {

    if (rowCheckColClicked) {
        rowCheckColClicked = false;
        return false;
    }
    
    
    if (selectedItems && selectedItems[0].get_id() == args._id) {
        return false;
    }

    selectedItems = grid.get_masterTableView().get_selectedItems();
    
    
    if (selectedItems.length > 0) {
        $("#" + selectedItems[0].get_id()).removeAttr("style");
        EnableGridButton_OnItemSelect();
        setTimeout(showEmail, 100);
        var row = $(sender._overRow)
        row.css({ 'font-weight': '' });
        $("#" + gridId).find("input[type=checkbox]").removeAttr("checked");
        row.find("input[type=checkbox]").attr("checked", "checked");
    } else {
        alert("Nothing selected");
    }
    
    
}

function EnableGridButton_OnItemSelect() {
    if (toolbar.findButtonByCommandName("EmailReply")) {
        toolbar.findButtonByCommandName("EmailReply").enable();
    }
    if (toolbar.findButtonByCommandName("MobileMenu").findControl("MobileRadmen").findItemByValue("EmailReply")) {
        toolbar.findButtonByCommandName("MobileMenu").findControl("MobileRadmen").findItemByValue("EmailReply").enable();
    }
}

function showNewEmail() { __doPostBack('ctl00$CPH1$btnNewEmail', ''); }
function showReply() { __doPostBack('ctl00$CPH1$btnReply', ''); }
function showEmail() {
    var btnRefreshGrid = $("[id$=btnShowEmail]");
    btnRefreshGrid.click();
   
    
}
function refreshEmails() { __doPostBack('ctl00$CPH1$btnRefreshEmails', ''); }
function searchEmails() { __doPostBack('ctl00$CPH1$btnSearchEmails', ''); return false; }
function refreshAttach() { __doPostBack('ctl00$CPH1$EmailSend1$btnRefreshAttach', ''); }

function onWindowLoad(sender, args) { }


function CheckMails(sender, args) {

    var emails = args.Value;
    var emails_array = emails.split(/,|;/);
    
    var reg = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
    
    for (var i = 0; i < emails_array.length; i++) {

        if (reg.test(emails_array[i]) == false) {
            args.IsValid = false;
            return;
        }

    }
    
    args.IsValid = true;
    return;
}


function OpenContactPOPUp(ButtonId) {
    $("input[id$=hdnBtnId]").val(ButtonId);
    return OpenPOPUp('ContactMail.aspx', 400, 405, false);
}

function ManageAttach() {
    document.getElementById("Checkboxes").style.display = "inline";

    // editorObj.set_html('');
    return false;

}




function ddlFrom_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var Email = item.get_attributes().getAttribute("Email");

    sender.set_text(Email);


}

function AttachFileForFileManager(me) {
    var ProjectId = $("input[id$=hdnProjectId]").val();
    var PropertyId = $("input[id$=hdnPropertyId]").val();
    var SelectedEntityId = ""
    if (ProjectId > "0") {
        SelectedEntityId = "1_".concat(ProjectId);
    }
    else if (PropertyId > "0") {
        SelectedEntityId = "9_".concat(PropertyId);
    }

    return OpenPOPUp('FilesLookup.aspx?EntityId=' + SelectedEntityId, 1135, 680, true);
}

function OnClientDropDownClosing_ddlProjects(sender, args) {
    if (IsDirty_ddlProjects()) { $('#ctl00_CPH1_btnGetProjects').click(); ddlProjects_IsDirty = false; }
}

var ddlProjects_IsDirty = false;

function IsDirty_ddlProjects() {
    return ddlProjects_IsDirty;
}
function SetDirty_ddlProjects() {
    ddlProjects_IsDirty = true;
}
//$(function() {
//    $("#chkHeaderAll").find("checkbox").remove();
//   
//});

function appendCheckboxAll() {

   $("#chkHeaderAll").remove();
        var chkHeader = "<input type='checkbox' id='chkHeaderAll' style=''  >";
        $(".tdchkHeader").prepend($(chkHeader));

    $('#chkHeaderAll').click(function() {
        $(".ChkEmail").find("input").attr("checked", $('#chkHeaderAll').attr("checked"));
    });

    $(".ChkEmail").find("input").click(function() {

        if (!$(this).attr("checked")) {
            $('#chkHeaderAll').attr("checked", false);
        } else if ($(".ChkEmail").find("input[checked=true]").length == $(".ChkEmail").length) {
            $('#chkHeaderAll').attr("checked", true);
        }
    });
   
}