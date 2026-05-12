function onContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    treeNode.set_selected(true);
    setMenuItemsState(args.get_menu().get_items(), treeNode);
}
function RuleNodeClicking(sender, args) {
    var node = args.get_node();
    if (node.get_value().indexOf("R") < 0)
        args.set_cancel(true);
}
function setMenuItemsState(menuItems, treeNode) {
    var tree = $find(treeNode.get_treeView().get_id());
    var nodes = tree.get_selectedNodes();
    if (nodes.length > 1) {
         for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
             menuItem.set_enabled(false);}}
         else
                {
                  for (var i = 0; i < menuItems.get_count(); i++)
                 {   var menuItem = menuItems.getItem(i);
                      switch (menuItem.get_value()) {
                    case "EditRule":
                      menuItem.set_enabled(false);
                       if (nodes[0].get_value().indexOf("R")==0 )
                        menuItem.set_enabled(true);
                   break;
                   case "AddRule":
                        menuItem.set_enabled(false);
                        if (nodes[0].get_value().indexOf("R") < 0 && nodes[0].get_value() != "0" && nodes[0].get_value().indexOf("NEWNODE") < 0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Add").toLowerCase() == 'true');
                        break;
                    case "DeleteRule":
                    menuItem.set_enabled(false)
                     if (nodes[0].get_value().indexOf("R")==0)
                         menuItem.set_enabled(tree.get_element().getAttribute("Delete").toLowerCase() == 'true');
                           break;
                     case "RenameRule":     
                            menuItem.set_enabled(false)
                     if (nodes[0].get_value().indexOf("R")==0)
                         menuItem.set_enabled(true);
                           break;
                   } 
                   
                   
                   }
                }
        }
function conditionaltoolbarclick(sender, args) {
    if (args.get_item().get_commandName() == 'Delete') {
        var result;
            result = confirm(Msg_ConfirmDeleteDocument);
            args.set_cancel(!result);
       
    }
}
function onmobileclick() {

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
        case "AddRule":
            if (treeNode.get_value().indexOf("R")<0 && treeNode.get_value()!="0") {
                window.setTimeout(function() { AddRule(treeNode.get_treeView().get_id()); }, 200);
                args.set_cancel(true);
            }
          
            break;
          case "EditRule":
          if (nodes[0].get_value().indexOf("R")!=0)
           args.set_cancel(true);
           break;
             case "DeleteRule":
             var result;
               if (nodes[0].get_value().indexOf("R")==0){
               result=confirm(Msg_ConfirmDeleteDocument);
                args.set_cancel(!result);}
                else 
                   args.set_cancel(true);
                 break;
           case "RenameRule":
            if (nodes[0].get_value().indexOf("R")==0)
            treeNode.startEdit();
            args.set_cancel(true);
            break;
    }
}
      function AddRule(treeId) {
    var nodeText = "";
    var tree = $find(treeId);
    tree.trackChanges();
    var node = new Telerik.Web.UI.RadTreeNode();
    var parent = tree.get_selectedNode() || tree;
    node.set_text(nodeText);

    node.set_value("NEWNODE");

    parent.get_nodes().add(node);

    if (parent != tree && !parent.get_expanded())
        parent.set_expanded(true);
    node.set_selected(true);
    window.setTimeout(function() { node.startEdit(); }, 300);
    parent.set_selected(false);

    tree.commitChanges();
    return node;
}
 
       
         
         
               
                   