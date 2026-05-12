

function DeleteSelectedConditions(gridName, ctrl) {
    var rdgRuleConditions = $("div[id$='" + gridName + "']").find("input[type='checkbox']:checked");

    if (rdgRuleConditions.length > 0) {
        return ConfirmDelete();
    } else

        return false;
}


function Validate_OnNodeClick(sender, eventArgs) {
    
    var rtvRecordTypeRules = $find("ctl00_CPH1_ucRules_rtvRecordTypeRules");
    var node = eventArgs.get_node();

    if (node.get_value().indexOf("R") == -1) {
        eventArgs.set_cancel(true);
    }
}


 function onContextMenuShowing(sender, args) {
     var treeNode = args.get_node();
     treeNode.set_selected(true);
     setMenuItemsState(args.get_menu().get_items(), treeNode);
 }

 function setMenuItemsState(menuItems, treeNode) {
     var tree = $find(treeNode.get_treeView().get_id());
     var nodes = tree.get_selectedNodes();
     if (nodes.length > 1) {
         for (var i = 0; i < menuItems.get_count(); i++) {
             var menuItem = menuItems.getItem(i);
             menuItem.set_enabled(false);
         }
     }
     else {
         for (var i = 0; i < menuItems.get_count(); i++) {
             var menuItem = menuItems.getItem(i);
             switch (menuItem.get_value()) {
                 case "EditRule":
                     menuItem.set_enabled(false);
                     if (nodes[0].get_value().indexOf("R") == 0)
                         menuItem.set_enabled(true);
                     break;
                 case "AddAPMRule":
                     menuItem.set_enabled(false);
                     if (nodes[0].get_value().indexOf("OT") == 0 )
                         menuItem.set_enabled(tree.get_element().getAttribute("Add").toLowerCase() == 'true');
                     break;
                 case "DeleteRule":
                     menuItem.set_enabled(false)
                     if (nodes[0].get_value().indexOf("R") == 0)
                         menuItem.set_enabled(tree.get_element().getAttribute("Delete").toLowerCase() == 'true');
                     break;
                 case "DuplicateAPMRule":
                     menuItem.set_enabled(false)
                     if (nodes[0].get_value().indexOf("R") == 0)
                         menuItem.set_enabled(tree.get_element().getAttribute("Add").toLowerCase() == 'true');
                     break;
             }


         }
     }
 }


 function onClientContextMenuItemClicking(sender, args) {
     var menuItem = args.get_menuItem();
     var treeNode = args.get_node();
     var tree = $find(treeNode.get_treeView().get_id());
     treeNode.set_selected(true);
     menuItem.get_menu().hide();
     var isGrougSelected = false;
     var isItemSelected = false;
     var nodes = tree.get_selectedNodes();
     if (nodes.length > 1)
         return;
     switch (menuItem.get_value()) {
         case "AddAPMRule":
             if (treeNode.get_value().indexOf("OT") == 0 ) {
                 window.setTimeout(function () { AddAPMRule(treeNode.get_treeView().get_id(),"Added",""); }, 200);
                 args.set_cancel(true);
             }

             break;
         case "EditRule":
             if (nodes[0].get_value().indexOf("R") != 0)
                 args.set_cancel(true);
             break;
         case "DeleteRule":
             var result;
             if (nodes[0].get_value().indexOf("R") == 0) {
                 result = confirm(Msg_ConfirmDeleteDocument);
                 args.set_cancel(!result);
             }
             else
                 args.set_cancel(true);
             break;
         case "DuplicateAPMRule":
             if (nodes[0].get_value().indexOf("R") == 0)
                 window.setTimeout(function () { AddAPMRule(treeNode.get_treeView().get_id(), "Copied", nodes[0].get_value().split("R")[1]); }, 200);
             args.set_cancel(true);
             break;
     }
 }

 function click_confirm(sender, args) {

     var result;
     if (args.get_item().get_commandName() == "Delete") {

         result = confirm(Msg_ConfirmDeleteDocument);
         args.set_cancel(!result);
     }

 }



 function AddAPMRule(treeId, type, Id) {
     var nodeText = "";
     var tree = $find(treeId);
     tree.trackChanges();
     var node = new Telerik.Web.UI.RadTreeNode();
     var parent = tree.get_selectedNode() || tree;

     node.set_text(nodeText);
    // node.set_imageUrl("Images/Asset/smallPage.gif")
   
     if (type == "Added") {
         node.set_value("NEWNODE");
         parent.get_nodes().add(node);
     }

     if (type == "Copied") {
         node.set_value("COPIEDNODE_" + Id);
         parent.get_parent().get_nodes().add(node);
     }
     node._addClassToContentElement("trvDocument")
     if (parent != tree && !parent.get_expanded())
         parent.set_expanded(true);
     node.set_selected(true);
     window.setTimeout(function () { node.startEdit(); }, 300);
     parent.set_selected(false);

     tree.commitChanges();
     return node;
 }


 function GridCreated(sender, args) {
     $("[id*='txtLeftBrackets']").keypress(function (e) {
         var intKey = (window.Event) ? e.which : e.keyCode;
         if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
             return false;
         }

     });
     $("[id*='txtRightBrackets']").keypress(function (e) {
         var intKey = (window.Event) ? e.which : e.keyCode;
         if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
             return false;
         }

     });
     $("[id*='txtBrackets']").keypress(function (e) {
         var intKey = (window.Event) ? e.which : e.keyCode;
         if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
             return false;
         }

     });
 }


 function onNodeDropping(sender, args) {
     var dest = args.get_destNode();
     if (dest) {
     }
     else {
         dropOnHtmlElement(args);
     }
 }


 function dropOnHtmlElement(args) {
     if (droppedOnGrid(args))
         return;
 }
 function droppedOnGrid(args) {
     
     var gridId = $("[id$=rdgRuleConditions]")[0].id;
     var target = args.get_htmlElement();
     while (target) {
         if (target.id == gridId) {
             args.set_htmlElement(target);
             return;
         }
         target = target.parentNode;
     }
     args.set_cancel(true);
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

 function EnableTemplateTab() {
     $("a[tabindex='1']").removeClass("rtsDisabled").css("cursor", "");
     $("a[tabindex='1']").attr("href", "#");
 }

 function EnableRuleTab() {
     $("a[tabindex='3']").removeClass("rtsDisabled").css("cursor", "");
     $("a[tabindex='3']").attr("href", "#");
 }

 function EnableAssignmentsTab() {
     $("a[tabindex='2']").removeClass("rtsDisabled").css("cursor", "");
     $("a[tabindex='2']").attr("href", "#");
 }

 function DisableAssignmentsTab() {
     $("a[tabindex='2']").addClass("rtsDisabled").css("cursor", "no-drop");
     $("a[tabindex='2']").attr("href", "Javascript:stop(event)");
 }

 function DisableTemplateTab() {
     $("a[tabindex='1']").addClass("rtsDisabled").css("cursor", "no-drop");
     $("a[tabindex='1']").attr("href", "Javascript:stop(event)");
 }

 function DisableRuleTab() {
     $("a[tabindex='3']").addClass("rtsDisabled").css("cursor", "no-drop");
     $("a[tabindex='3']").attr("href", "Javascript:stop(event)");
 }

 function ddlEntities_DropDownTextChange(sender, args) {
     if (sender.get_value() == '') {
         args.set_cancel(true);
     }
 }