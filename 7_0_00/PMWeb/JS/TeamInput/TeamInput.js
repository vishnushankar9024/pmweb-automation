
function SetTeamSection(section, Expand) {
    if ($("[id$='" + section + "img']").length > 0) {
        if (Expand == 'True') {
            $("[id$='" + section + "img']")[0].src = 'CSS/Images/ResponsiveIcons/MinusWorkflow.png';
            $("[id$='" + section + "']").show();
            if (section == 'tblLog') {
                var TeamLogGrid = $('[id$=rdgTeamLog]');
                if (TeamLogGrid.length>0)
                    ResetGridSettings(TeamLogGrid[0].id);
            }
        }
        if (Expand == 'False') {
            $("[id$='" + section + "img']")[0].src = 'CSS/Images/ResponsiveIcons/PlusWorkflow.png';
            $("[id$='" + section + "']").hide();
        }
    }
}

function ToggleTeamSection(sender, section) {
    if (sender.src.indexOf("Plus") > 0) {
        sender.src = 'CSS/Images/ResponsiveIcons/MinusWorkflow.png';
        $("[id$='" + section + "']").show(200, function () {
            this.style.display = '';
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/ToggleDocumentTeamSections",
                contentType: "application/json; charset=utf-8",
                data: "{'strSection':'" + section + "', 'blnVisible':" + true + "}",
                dataType: "json",
                async: true
            });

        });
        if (section == 'tblLog') {
            var TeamLogGrid = $('[id$=rdgTeamLog]');
            if (TeamLogGrid.length > 0)
                ResetGridSettings(TeamLogGrid[0].id);
        }
    } else {
        sender.src = 'CSS/Images/ResponsiveIcons/PlusWorkflow.png';
        $("[id$='" + section + "']").hide(200, function () {
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/ToggleDocumentTeamSections",
                contentType: "application/json; charset=utf-8",
                data: "{'strSection':'" + section + "', 'blnVisible':" + false + "}",
                dataType: "json",
                async: true
            });
        });
    }
    return false;
}

function cvAction_validateTeamAction(sender, args) {
    try {
        $("#tblrdbActions").find("input[type='radio']").each(function () {
            if (this.checked == true) { args.IsValid = true; throw true; }
        });
        args.IsValid = false;
    }
    catch (e) { /*error throw true just to break the each itiration*/ }
}

function cvComments_validateTeamAction(sender, args) {
    if ($("textarea[id$='txtComments']").val() == '' && $("#tblrdbActions input[id$='rdbComment']")[0].checked == true) {
        args.IsValid = false;
    } else {
        args.IsValid = true;
    }
}

function OpenActionAttachmentsPopup(ActionId) {
    OpenPOPUp('DocumentTeamAttachmentsPopup.aspx?ActionId=' + ActionId, 825, 300, false);
    return false;
}

function OpenDocumentTeamManagerPopup(ObjectType, CanAddTeam) {
    if (CanAddTeam == "True") {
       
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('DocumentTeamManagerPopup.aspx?ObjectType=' + ObjectType);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(450, browserHeight * 0.9);
            wnd.Center();
        }
        //wnd.add_close(RedirectAfterClosed);
        return false;
        //OpenPOPUpToRedirect('DocumentTeamManagerPopup.aspx?ObjectType=' + ObjectType, 825, 450, false);
    }
    else {
        alert(unescape(Msg_LatestRevisionCreateTeam));
    }

    return false;
}

function OpenDocumentTeamClosePopup(ObjectType) {
    OpenPOPUpToRedirect('DocumentTeamClosePopup.aspx?ObjectType=' + ObjectType, 825, 350, false);
    return false;
}

function OpenMessagesPopupFromLine(ActionId) {
    return OpenPOPUp("DocumentTeamResendMessages.aspx?ActionId=" + ActionId, 950, 570, false, "");
}

function ConfirmRemoveTeamMember() { return confirm(unescape(Msg_ConfirmRemoveTeamMember)); }

function rdgTeamInput_RowSelected(sender, args) {
    var grid = $find($("[id$=rdgTeamInput]")[0].id);
    var btnEdit = $("[id*=" + sender.get_id() + "][id$=btnEditSelected]");
    var btnRemove = $("[id*=" + sender.get_id() + "][id$=btnRemove1]");
    var HideBtn = false;
    var selectedRows = 0;
    selectedRows = selectedRows + 1;
    for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {

        var row = grid.MasterTableView.get_selectedItems()[i];
        var WasRemoved = row.getDataKeyValue("WasRemoved");

        if (WasRemoved == "True") {
            HideBtn = true;
        }
    }

    //if (selectedRows <= 1) {
    //    if (ActivatedDate != '' && DeactivatedDate == '') {
    //        HidebtnActivate = true
    //    }
    //}

    if (HideBtn) {
        btnEdit.hide();
        btnRemove.hide();
    }
    else {
        btnEdit.show();
        btnRemove.show();
    }
}
function ClientDocFileValidationFailed(sender, args) {
    alert(WarningMsg_InvalidFile);
}

