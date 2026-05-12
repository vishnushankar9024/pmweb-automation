/// <reference path="../jQuery-vsdoc.js" />

function OnButtonClicking_Toolbar(sender, args) {
    var comandName = args.get_item().get_commandName();
    if (comandName == "Save") {
    }
}


function DisableWarningTabs() {
    DisableTemplateTab();
    DisableRuleTab();
    DisableAssignmentsTab();
    $("div[id$='pnlWarningPanel']").show();
}

function EnableWarningTabs() {
    EnableTemplateTab();
    EnableAssignmentsTab();
    EnableRuleTab();
    $("div[id$='pnlWarning']").hide();

}

function EnableTemplateTab()
{
    $("a[tabindex='1']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='1']").attr("href", "#");
}

function EnableRuleTab()
{
    $("a[tabindex='3']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='3']").attr("href", "#");
}

function EnableAssignmentsTab()
{
    $("a[tabindex='2']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='2']").attr("href", "#");
}

function DisableAssignmentsTab()
{
    $("a[tabindex='2']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='2']").attr("href", "Javascript:stop(event)");
}

function DisableTemplateTab()
{
    $("a[tabindex='1']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='1']").attr("href", "Javascript:stop(event)");
}

function DisableRuleTab()
{
    $("a[tabindex='3']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='3']").attr("href", "Javascript:stop(event)");
}

function ddlEntities_DropDownTextChange(sender, args) {
    if (sender.get_value()=='') {
        args.set_cancel(true);
    }
}


