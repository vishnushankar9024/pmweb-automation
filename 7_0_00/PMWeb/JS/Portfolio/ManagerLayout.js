var TreePosition=-1;
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
                case "EditLayout":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value().indexOf("L") == 0)
                        menuItem.set_enabled(true);
                    break;
                case "AddLayout":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value().indexOf("L") < 0 && nodes[0].get_value() != "0" && nodes[0].get_value().indexOf("NEWNODE")<0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Add").toLowerCase() == 'true');
                    break;
                case "DeleteLayout":
                    menuItem.set_enabled(false)
                    if (nodes[0].get_value().indexOf("L") == 0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Delete").toLowerCase() == 'true');
                    break;
                case "RenameLayout":
                    menuItem.set_enabled(false)
                    if (nodes[0].get_value().indexOf("L") == 0)
                        menuItem.set_enabled(true);
                    break;
            }


        }
    }
}

function onClientContextMenuItemClicking(sender, args) {
    TreePosition = document.getElementById("dvlayoutTree").scrollTop;
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
        case "AddLayout":
            if (treeNode.get_value().indexOf("L") < 0 && treeNode.get_value() != "0") {
                window.setTimeout(function() { AddLayout(treeNode.get_treeView().get_id()); }, 200);
                args.set_cancel(true);
            }

            break;
        case "EditLayout":
            if (nodes[0].get_value().indexOf("L") != 0)
                args.set_cancel(true);
            break;
        case "DeleteLayout":
            var result;
            if (nodes[0].get_value().indexOf("L") == 0) {
                result = confirm(Msg_ConfirmDeleteDocument);
                args.set_cancel(!result);
            }
            else
                args.set_cancel(true);
            break;
        case "RenameLayout":
            if (nodes[0].get_value().indexOf("L") == 0)
                treeNode.startEdit();
            args.set_cancel(true);
            break;
    }
}
function AddLayout(treeId) {
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
function onClientNodeClicking(sender, args) {
    TreePosition = document.getElementById("dvlayoutTree").scrollTop;
}
function OnClientButtonClicking(sender, args) {
    var command = args.get_item().get_commandName();
    if (command == "ToggleFlyoutTree") {
        var treeDiv = document.getElementById("dvFlyoutTree");
        if (treeDiv.style.display == "none")
            treeDiv.style.display = "block";
        else
            treeDiv.style.display = "none";
    }
}


function onClientLayoutTreeLoad(sender, args) {
     var Node = sender.get_selectedNode();
        if (Node != null) {
            Node.scrollIntoView(false);
        }


}


                  