var TreePosition = -1;

function Layout_onClientNodeClicking(sender, args) {
    //TreePosition = document.getElementById("dvlayoutTree").scrollTop;
}
function Layout_onClientButtonClicking(sender, args) {
    var command = args.get_item().get_commandName();
    if (command == "ToggleFlyoutTree") {
        var treeDiv = document.querySelector(".flyoutTreeList");
        if (treeDiv.style.display == "none")
            treeDiv.style.display = "block";
        else
            treeDiv.style.display = "none";
    }
}

function Layout_onClientLayoutTreeLoad(sender, args) {

    //if (TreePosition != -1)
    //{ document.getElementById("dvlayoutTree").scrollTop = TreePosition;
    var tree = $find($("[id$=rtvLayouts]")[0].id);
    if (tree != null) {
        var Node = tree.get_selectedNode();
        if (Node != null) {
            Node.scrollIntoView(false);
        }}
    }
//}

function Layout_onClientContextMenuItemClicking(sender, args) {
    TreePosition = document.getElementById("dvlayoutTree").scrollTop;
    var menuItem = args.get_menuItem();
    var treeNode = args.get_node();
    var tree = $find(treeNode.get_treeView().get_id());
    treeNode.set_selected(true);
    menuItem.get_menu().hide();
    var nodes = tree.get_selectedNodes();
    if (nodes.length > 1)
        return;
    switch (menuItem.get_value()) {
        case "AddLayout":
            if (treeNode.get_value().indexOf("Grid") == 0) {
                window.setTimeout(function () { Layout_AddLayout(treeNode.get_treeView().get_id()); }, 200);
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
        case "DuplicateLayout":
            if (nodes[0].get_value().indexOf("L") == 0) {
                treeNode.set_selected(false);

                break;
            }
    }
}

function Layout_AddLayout(treeId) {
  
        var nodeText = "";
        var tree = $find(treeId);
      
        var node = new Telerik.Web.UI.RadTreeNode();
        var parent = tree.get_selectedNode();

        if (!parent.get_expanded())
            parent.set_expanded(true);

        node.set_text(nodeText);
        node.set_value("NEWNODE");


        parent.set_selected(false);
        
        window.setTimeout(function () { tree.trackChanges(); parent.get_nodes().add(node); node.set_selected(true); node.startEdit(); tree.commitChanges(); }, 100);
 
        return node;
    }

    function Layout_onContextMenuShowing(sender, args) {
        var treeNode = args.get_node();
        treeNode.set_selected(true);
        Layout_setMenuItemsState(args.get_menu().get_items(), treeNode);
    }


    function Layout_setMenuItemsState(menuItems, treeNode) {
        var tree = $find(treeNode.get_treeView().get_id());
        var nodes = tree.get_selectedNodes();
        if (nodes.length > 1) {
            for (var i = 0; i < menuItems.get_count() ; i++) {
                var menuItem = menuItems.getItem(i);
                menuItem.set_enabled(false);
            }
        }
        else {
            for (var i = 0; i < menuItems.get_count() ; i++) {
                var menuItem = menuItems.getItem(i);
                switch (menuItem.get_value()) {
                    case "EditLayout":
                        menuItem.set_enabled(false);
                        if (nodes[0].get_value().indexOf("L") == 0)
                            menuItem.set_enabled(nodes[0]._attributes.getAttribute("Edit").toLowerCase() == 'true');
                        break;
                    case "AddLayout":
                        menuItem.set_enabled(false);
                        if (nodes[0].get_value().indexOf("Grid") == 0)
                            menuItem.set_enabled(nodes[0]._attributes.getAttribute("Add").toLowerCase() == 'true');
                        break;
                    case "DeleteLayout":
                        menuItem.set_enabled(false)
                        if (nodes[0].get_value().indexOf("L") == 0)
                            menuItem.set_enabled(nodes[0]._attributes.getAttribute("Delete").toLowerCase() == 'true');
                        break;
                    case "DuplicateLayout":
                        menuItem.set_enabled(false)
                        if (nodes[0].get_value().indexOf("L") == 0)
                            menuItem.set_enabled(nodes[0]._attributes.getAttribute("Duplicate").toLowerCase() == 'true');
                        break;
                }


            }
        }
    }

    //function LayoutSetFocus() {
    //    setTimeout(function () {
    //        var tree = $find(treeNode.get_treeView().get_id());
    //        if (tree != null) {
    //            var Node = tree.get_selectedNode();
    //            if (Node != null) {
    //                Node.scrollIntoView(false);
    //            }
    //        }
    //    }, 1)

    //}


    function Layout_OnClientNodeEditStartHandler(sender, eventArgs) {
        var node = eventArgs.get_node();
        var textInput = node.get_inputElement();
        textInput.maxLength = 100;
    }
    function Layout_ClientNodeEdited(sender, args) {
        var node = args.get_node();
        if (node.get_value() == "NEWNODE") {
            $("[id$=hdnNodeText]").val(node.get_text());
            if (node.get_text() == "") {
                var tree = $find(node.get_treeView().get_id());
                tree.trackChanges();
                var Parent = node._parent;
                Parent.get_nodes().remove(node);
                tree.commitChanges();
                alert(unescape(WarningMsg_EmptyTextNotAllowed));
            }
        }
    }


