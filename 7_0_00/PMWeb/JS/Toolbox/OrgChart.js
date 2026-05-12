
var orgChart;
var contextMenu;
var GroupId;
var ResourceId;
var node;
var CtrlIsPressed=false;

function pageLoad() {
    if($("[id$=RadOrgChart1]").length == 1){
        orgChart = $find($("[id$=RadOrgChart1]")[0].id);
        contextMenu = $find($("[id$=RadContextMenu1]")[0].id);
        OrgChartsetup();
        //initBreadCrumb();
    }
    if (IsExpanded == 'True') {
        //$("[id$='tblOrgChartHeaderimg']")[0].src = 'Images/Workflow/wMinus.png';
        $("[id$='tblOrgChartHeader']").show();
        $("[id$='lblOrgChartHeader']").html(HideHeader);
    }
    if (IsExpanded == 'False') {
        //$("[id$='tblOrgChartHeaderimg']")[0].src = 'Images/Workflow/wPlus.png';
        $("[id$='tblOrgChartHeader']").hide();
        $("[id$='lblOrgChartHeader']").html(ShowHeader);
    }


}

$(document).keydown(function (e) {
    if (e.which == "17") {
        CtrlIsPressed = true;
    }
})

$(document).keyup(function (e) {
    if (e.which == "17") {
        CtrlIsPressed = false;
    }
})

function OnResourceRowDropping(sender, args) {
    if (args.get_destinationHtmlElement().className.indexOf("rocGroup") != -1 || $(args.get_destinationHtmlElement()).parents(".rocGroup").length > 0) {
        var hierarchicalIndex = orgChart.extractNodeFromDomElement(args.get_destinationHtmlElement()).get_hierarchicalIndex();
        hierarchicalIndex = orgChart.getRealHierarchicalIndex(hierarchicalIndex);
        var draggedItems = args._dragedItems;
        var Ids = '';
        for (i = 0; i < draggedItems.length; i++) {
            Ids = Ids + ';' + draggedItems[i].getDataKeyValue("Id").trim();
        }
        if (Ids != '') {
            Ids = Ids.substring(1);
        }
        var hdnResourcesIds = $("[id$=hdnResourcesIds]")[0]
        $("[id$=hdnResourcesIds]")[0].value = Ids + '-' + hierarchicalIndex;
        var btnResourcesDropped = $("[id$=btnResourcesDropped]");
        btnResourcesDropped.click();
    }
    args.set_cancel(true);
}

function AdjustScoreCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Score
    $("input[id*=" + gridId + "][id$=txtScore]").change(function () {
        var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Score");
    }
    ).focus(function () {
        OldScoreUnitCostVal = $(this).val();
    }
    );

    // On change Points
    $("input[id*=" + gridId + "][id$=txtPointsAvailable]").change(function () {
        var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "PointAvailable");
    }
    ).focus(function () {
        OldScoreQuantityVal = $(this).val();
    }
    );

    // On change Weight
    $("input[id*=" + gridId + "][id$=txtWeight]").change(function () {
        var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Weight");
    }
    ).focus(function () {
        OldScoreTotalCostVal = $(this).val();
    }
    );


}

function RadContextMenu_ClientItemClicking(sender, args) {
    switch (args.get_item().get_value()) {
        case 'AddGroup':
            args.set_cancel(true);
            sender.hide();
            return OpenOrgChartPOPUp('OrgChartGroupsPopup.aspx?GroupId=' + GroupId + '&AppendGroup=1', 400, 200, false);
            break;
        case 'EditGroup':
            args.set_cancel(true);
            sender.hide();
            return OpenOrgChartPOPUp('OrgChartGroupsPopup.aspx?GroupId=' + GroupId + '&AppendGroup=0', 400, 200, false);
            break;
        case 'DeleteGroup':
            sender.trackChanges();
            args.get_item().get_attributes().setAttribute("groupid", GroupId);
            sender.commitChanges();
            break;
        case 'AddResource':
            args.set_cancel(true);
            sender.hide();
            return OpenOrgChartPOPUp('OrgChartResourcesPopup.aspx?GroupId=' + GroupId + '&ResourceId=0', 400, 230, false);
            break;
        case 'EditResource':
            args.set_cancel(true);
            sender.hide();
            return OpenOrgChartPOPUp('OrgChartResourcesPopup.aspx?GroupId=' + GroupId + '&ResourceId=' + ResourceId, 400, 230, false);
            break;
        case 'SelectAllResources':
            args.set_cancel(true);
            sender.hide();
            $(node.get_element().getElementsByClassName("rocGroup")[0].getElementsByClassName("rocItemWrap")).addClass("ResourceItemSeleted");
            break;
        case 'DeleteSelectedResources':
            var hdnResourcesIds = $("[id$=hdnResourcesIds]")[0];
            var ResourceIds = '';
            $(".ResourceItemSeleted").each(function () {
                var CurrentNode = orgChart.extractNodeFromDomElement(this);
                if (CurrentNode.getId() == GroupId) {
                    ResourceIds = ResourceIds + ';' + orgChart.extractGroupItemFromDomElement(this.getElementsByClassName("rocItem")[0]).getId();
                }
            });
            if (ResourceIds != '') {
                ResourceIds = ResourceIds.substring(1);
            }
            hdnResourcesIds.value = ResourceIds;
            break;
        default:
            //                        eventArgs.set_cancel(false);
            break;
    }
}
var fontSize = 12;
var Height = 35;
var MaxHeight = 200;
function OrgChartsetup() {
    //to fix a bug on scroll for rocListItem
    $(".RadOrgChart").css("font-size", fontSize + "px");
    $(".rocToolbar").css("font-size", fontSize + "px");
    $(".rocItem").css("height", Height + "px", "!important");
    $(".rocItemList").css("max-height", MaxHeight + "px", "!important");
    var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
    var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_OrgChartDetails1_LeftPane');
    var SlidingPane = $find('ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
    var sidingzone = $find('ctl00_CPH1_OrgChartDetails1_SlidingZone1');
    if (!SlidingPane._isDocked) {
        sidingzone.collapsePane('ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
        TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
    }

    orgChart._mouseDownOnNode = function () {
    };
    $('.foo').bind('DOMMouseScroll mousewheel', function (event) {
        if (event.originalEvent.wheelDelta > 0 || event.originalEvent.detail < 0) {
            fontSize++;
            Height ++;
            MaxHeight = 200 * fontSize / 12;
            $(".RadOrgChart").css("font-size", fontSize + "px");
            $(".rocToolbar").css("font-size", fontSize + "px");
            $(".rocItem").css("height", Height + "px", "!important");
            $(".rocItemList").css("max-height", MaxHeight + "px", "!important");
        }
        else {
            if (fontSize > 1) {
                fontSize--;
                Height --;
                MaxHeight = 200 * fontSize / 12;
                $(".RadOrgChart").css("font-size", fontSize + "px");
                $(".rocToolbar").css("font-size", fontSize + "px");
                $(".rocItem").css("height", Height + "px", "!important");
                $(".rocItemList").css("max-height", MaxHeight + "px", "!important");
           }
        }
        event.preventDefault();
    });

    $(orgChart.get_element()).delegate(".rocItem", $telerik.isTouchDevice ? "touchend" : "contextmenu", function (e) {
        var target = $telerik.getTouchTarget(e);
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        if (!$(target).hasClass("rocEmptyItem")) {
            $($(target).parents('.rocItemWrap')[0]).addClass('ResourceItemSeleted');
            var item = orgChart.extractGroupItemFromDomElement(target);
            ResourceId = item.getId();
            ShowOrgChartMenu(e, false);
        } else {
            contextMenu.get_items().getItem(0).set_visible(false);
            contextMenu.get_items().getItem(1).set_visible(false);
            contextMenu.get_items().getItem(2).set_visible(false);
            contextMenu.get_items().getItem(3).set_visible(true);
            contextMenu.get_items().getItem(4).set_visible(false);
            contextMenu.get_items().getItem(5).set_visible(false);
            contextMenu.get_items().getItem(6).set_visible(false);
            contextMenu.show(e);
            e.preventDefault();
        }
    })
    .delegate(".rocItemWrap", $telerik.isTouchDevice ? "touchend" : "contextmenu", function (e) {
        var Wraptarget = $telerik.getTouchTarget(e);
        var target = Wraptarget.getElementsByClassName("rocItem")[0];
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        if (!$(target).hasClass("rocEmptyItem")) {
            $(Wraptarget).addClass('ResourceItemSeleted');
            var item = orgChart.extractGroupItemFromDomElement(target);
            ResourceId = item.getId();
            ShowOrgChartMenu(e, false);
        } else {
            contextMenu.get_items().getItem(0).set_visible(false);
            contextMenu.get_items().getItem(1).set_visible(false);
            contextMenu.get_items().getItem(2).set_visible(false);
            contextMenu.get_items().getItem(3).set_visible(true);
            contextMenu.get_items().getItem(4).set_visible(false);
            contextMenu.get_items().getItem(5).set_visible(false);
            contextMenu.get_items().getItem(6).set_visible(false);
            contextMenu.show(e);
            e.preventDefault();
        }
    })
    .delegate(".rocItemList", $telerik.isTouchDevice ? "touchend" : "contextmenu", function (e) {
        var target = $telerik.getTouchTarget(e);
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        contextMenu.get_items().getItem(0).set_visible(false);
        contextMenu.get_items().getItem(1).set_visible(false);
        contextMenu.get_items().getItem(2).set_visible(false);
        contextMenu.get_items().getItem(3).set_visible(true);
        contextMenu.get_items().getItem(4).set_visible(false);
        contextMenu.get_items().getItem(5).set_visible(true);
        contextMenu.get_items().getItem(6).set_visible(true);
        contextMenu.show(e);
        e.preventDefault();
    })
    .delegate(".rocGroup", $telerik.isTouchDevice ? "touchend" : "contextmenu", function (e) {
        var target = $telerik.getTouchTarget(e);
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        ShowOrgChartMenu(e, true);
    })
    .delegate(".rocItem", $telerik.isTouchDevice ? "touchend" : "dblclick", function (e) {
                var target = $telerik.getTouchTarget(e);
                node = orgChart.extractNodeFromDomElement(target);
                GroupId = node.getId();
                if (!$(target).hasClass("rocEmptyItem")) {
                    $($(target).parents('.rocItemWrap')[0]).addClass('ResourceItemSeleted');
                    var item = orgChart.extractGroupItemFromDomElement(target);
                    ResourceId = item.getId();
                    return OpenOrgChartPOPUp('OrgChartResourcesPopup.aspx?GroupId=' + GroupId + '&ResourceId=' + ResourceId, 400, 230, false);
                }
                return false;
    })
    .delegate(".rocItemWrap", $telerik.isTouchDevice ? "touchend" : "dblclick", function (e) {
        var Wraptarget = $telerik.getTouchTarget(e);
        var target = Wraptarget.getElementsByClassName("rocItem")[0];
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        if (!$(target).hasClass("rocEmptyItem")) {
            $(Wraptarget).addClass('ResourceItemSeleted');
            var item = orgChart.extractGroupItemFromDomElement(target);
            ResourceId = item.getId();
            return OpenOrgChartPOPUp('OrgChartResourcesPopup.aspx?GroupId=' + GroupId + '&ResourceId=' + ResourceId, 400, 230, false);
        }
        return false;
    })
    .delegate(".rocGroup", $telerik.isTouchDevice ? "touchend" : "dblclick", function (e) {
        var target = $telerik.getTouchTarget(e);
        node = orgChart.extractNodeFromDomElement(target);
        GroupId = node.getId();
        return OpenOrgChartPOPUp('OrgChartGroupsPopup.aspx?GroupId=' + GroupId + '&AppendGroup=0', 400, 200, false);
    })
;

    //$(orgChart.get_element()).delegate(".rocItem", $telerik.isTouchDevice ? "touchend" : "click", function (e) {
    //    var target = $telerik.getTouchTarget(e);
    //    if (!$(target).hasClass("rocEmptyItem")) {
    //        $(target)[0].parentNode.parentElement.style.backgroundColor = "red";
    //    }
    //})
    $(".rocItemWrap").click(function ItemClick(e) {
        if (this.getElementsByClassName("rocEmptyItem").length > 0) return;
        var HasClass = false;
        if ($(this).hasClass('ResourceItemSeleted')) {
            HasClass = true;
        }
        if (!CtrlIsPressed){
            $(".ResourceItemSeleted").removeClass("ResourceItemSeleted");
        }
        if (HasClass) {
            $(this).removeClass('ResourceItemSeleted');
        } else {
            $(this).addClass('ResourceItemSeleted');
        }
        //var index = orgChart.extractGroupItemFromDomElement(e.target).get_index();
    });
   
}

function ShowOrgChartMenu(e, IsGroup) {
    contextMenu.get_items().getItem(0).set_visible(IsGroup);
    contextMenu.get_items().getItem(1).set_visible(IsGroup);
    contextMenu.get_items().getItem(2).set_visible(IsGroup);
    contextMenu.get_items().getItem(3).set_visible(!IsGroup);
    contextMenu.get_items().getItem(4).set_visible(!IsGroup);
    contextMenu.get_items().getItem(5).set_visible(!IsGroup);
    contextMenu.get_items().getItem(6).set_visible(!IsGroup);
    contextMenu.show(e);
    e.preventDefault();
}

function OpenAddGroupPopup(sender, eventArgs) {
    var value = eventArgs.get_item().get_commandName();
    if (value == 'AddGroup') {
        return OpenOrgChartPOPUp('OrgChartGroupsPopup.aspx?GroupId=0&AppendGroup=1', 400, 200, false);
    }
    return false;
}

function OpenAddFirstGroupPopup() {
    return OpenOrgChartPOPUp('OrgChartGroupsPopup.aspx?GroupId=0&AppendGroup=1');
}


function OrgChartWindowClosed() {
    var btnRefreshOrgChart = $("[id$=btnRefreshOrgChart]");
    btnRefreshOrgChart.click();
}

function OpenOrgChartPOPUp(URL) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.33, browserHeight * 0.9);
        wnd.Center();
    }

    wnd.add_close(OrgChartWindowClosed);
    return false;
}

function OnOrgChartClientBeforeExpand(sender, eventArgs) {
    var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
    TabPane.style.visibility = 'hidden';
}

function OnOrgChartClientCollapsed(sender, eventArgs) {
    var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
    TabPane.style.visibility = 'visible';
}

function UpdatePanelSettings(sender) {
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/UpdateOrgChartPanelSettings",
        contentType: "application/json; charset=utf-8",
        data: "{'isPinned':'" + sender.get_docked() + "','Width':'" + sender.get_width()  +"' }",
        dataType: "json",
        async: true
    });
    if (!sender.get_docked()) {
        sender.set_dockOnOpen(false)
        var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
        var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_OrgChartDetails1_LeftPane');
        TabPane.style.visibility = 'visible';
        TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
    }
    else {
        sender.set_dockOnOpen(true)
        var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_OrgChartDetails1_RadSlidingPane1');
        var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_OrgChartDetails1_LeftPane');
        TabPane.style.visibility = 'hidden';
        TabPane1.className = '';
    }
    var LeftPanewidth = $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_OrgChartDetails1_LeftPane").width();
    var argheight = $("#ctl00_CPH1_OrgChartDetails1_RadSplitter1").height();
    var argwidth = $("#ctl00_CPH1_OrgChartDetails1_RadSplitter1").width() - LeftPanewidth;

    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_OrgChartDetails1_OrgChartPane").width(argwidth - 4).height(argheight - 4);
   // $("#divZoomer").width(argwidth - 8).height(argheight - 8);
    return false;
}

function onOrgChartClientSearch(sender, args) {
        var value = args.get_value();
 
        if (value) {
            orgChart.drillDownOnNode(value);
            sender.clear();
        } else {
            alert("Please select a person from the search results.");
        }
    }
 
    function initBreadCrumb() {
 
        var $ = $telerik.$,
            drilledNodeIndex = orgChart.get_drilledNodeHierarchicalIndex();
 
        $(".rocBreadCrumb").html("<ul class=\"rocBCWrap\" />");
        bcWrap = $(".rocBreadCrumb").find(".rocBCWrap").get(0);
 
        if (drilledNodeIndex != null) {
            var indexes, currentHierarchicalIndex, bcWrap, bcItem;
 
            indexes = drilledNodeIndex.split(":");
 
            currentHierarchicalIndex = "";
 
            for (var j = 0; j < indexes.length - 1; j++) {
 
                if (currentHierarchicalIndex == "") {
                    currentHierarchicalIndex = indexes[j];
                }
                else {
                    currentHierarchicalIndex = currentHierarchicalIndex + ":" + indexes[j];
                }
 
                // parentNames variable is registered from the server side!
                $(bcWrap).append("<li class='rocBCItem rocBCLevel" + j + "' title=\"Navigate to parent\">" + parentNames[j] + "<span class=\"rocBCLine\"></span></li>");
 
                bcItem = $(bcWrap).find(".rocBCItem").get(j);
                bcItem._item = {};
                bcItem._item.hierarchicalIndex = currentHierarchicalIndex;
            }
 
            $(bcWrap).delegate(".rocBCItem", {
                click: function (event) {
                    if (this._item) {
                        orgChart.drillDownOnNode(this._item.hierarchicalIndex)
                    }
                }
            });
        }
 
        var text = $(".rocRootNode .rocItemText").html().trim();
        var lastIndex = null;
        if (drilledNodeIndex)
            lastIndex = drilledNodeIndex.split(":").length - 1;
        else
            lastIndex = 0;
 
        $(bcWrap).append("<li class='rocBCItem rocBCItemCurrent rocBCLevel" + lastIndex + "'>" + text + "</li>");
    }
    function onClientDropping(sender, args) {
        var inetmText = args.get_sourceItem().get_text().trim();
    }

   