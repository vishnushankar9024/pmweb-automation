
/******************** AssembliesSearch ***************/


function onClientDoubleClick(sender, args) {
    var treeNode = args.get_node();
    var nodeValue = treeNode.get_value();
    if (nodeValue.indexOf("_I") > 0) {
        window.location = "Assemblies.aspx?Id=" + nodeValue.replace(/\s/g, "").replace("_I", "");
    }
    else if (nodeValue.indexOf("_G") > 0) {
        if (treeNode.get_expanded() == false)
            treeNode.expand();
    }
}

function AddFirstAssemblyNode(sender, args) {
    switch (args.get_item().get_value()) {
        case "AddRootNode":
            var tree = $find($("[id$=treeGroupsAndAssemblies]")[0].id);
            tree.trackChanges();
            //Instantiate a new client node
            var node = new Telerik.Web.UI.RadTreeNode();

            //Set its value, text and image
            node.set_value("_G");
            node.set_text("");

            //Set IsNew attribute for checking on server side
            node.get_attributes().setAttribute("IsNew", "True")

            tree.get_nodes().add(node);
            tree.commitChanges();
            node.set_selected(true);
            window.setTimeout(function() { node.startEdit(); }, 100);

            tree.commitChanges();
            return node;
            break;
    }
}

function onClientContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    treeNode.set_selected(true);
    setMenuItemsState(args.get_menu().get_items(), treeNode);
}

function onClientContextMenuItemClicking(sender, args) {

    var menuItem = args.get_menuItem();
    var treeNode = args.get_node();
    var tree = $find(treeNode.get_treeView().get_id());
    treeNode.set_selected(true);
    menuItem.get_menu().hide();
    var isGrougSelected = false;
    var isAssemblySelected = false;
    var nodes = tree.get_selectedNodes();

    switch (menuItem.get_value()) {
        case "Rename":
            treeNode.startEdit();
            args.set_cancel(true);
            break;
        case "OpenAssembly":
            var nodeValue = treeNode.get_value();
            if (nodeValue.indexOf("_I") > 0)
                window.location = "Assemblies.aspx?Id=" + nodeValue.replace(/\s/g, "").replace("_I", "");
            args.set_cancel(true);
            break;
        case "NewGroup":
            treeNode.expand();
            window.setTimeout(function() { addGroupNode(treeNode.get_treeView().get_id()); }, 200);
            args.set_cancel(true);
            break;
        case "NewAssembly":
            var nodeValue = treeNode.get_value();
            window.location = "Assemblies.aspx?IsNew=true&GroupId=" + nodeValue.replace(/\s/g, "").replace("_G", "");
            args.set_cancel(true);
            break;
        case "Delete":
            if (nodes.length > 0) {
                for (var i = 0; i < nodes.length; i++) {
                    var nodeValue = nodes[i].get_value();
                    if (nodeValue.indexOf("_G") >= 0) {
                        isGrougSelected = true;
                    }
                    else if (nodeValue.indexOf("_I") > 0) {
                        isAssemblySelected = true;
                    }
                    else if (isGrougSelected && isAssemblySelected) break;
                }
            }
            var result;
            if (isGrougSelected && isAssemblySelected) {
                //"You are about to delete the selected groups, their sub-groups and all of the items within those groups, and the selected assemblies. This process cannot be undone.\nAre you sure you wish to continue?"
                result = confirm(Msg_DeleteGroup_SubGroup_Items);
            } //"You are about to delete the selected groups, their sub-groups and all of the items within those groups. This process cannot be undone.\nAre you sure you wish to continue?"
            else if (isGrougSelected) {
            result = confirm(Msg_DeleteGroup_SubGroup);
            }//"You are about to delete the selected assemblies. This process cannot be undone.\nAre you sure you wish to continue?"
            else {
                result = confirm(Msg_DeleteSelectedItems);
            }
            args.set_cancel(!result);
            break;
    }
}

function addGroupNode(treeId) {
    var nodeText = "";
    var tree = $find(treeId);
    tree.trackChanges();

    //Instantiate a new client node
    var node = new Telerik.Web.UI.RadTreeNode();
    var parent = tree.get_selectedNode() || tree;
    //Set its value, text and image
    node.set_value(parent.get_value() + nodeText + "_G");
    node.set_text(nodeText);
    //node.set_imageUrl(parent.get_imageUrl())
    //Set IsNew attribute for checking on server side
    node.get_attributes().setAttribute("IsNew", "True")
    //Add the new node as the child of the selected node or the treeview if no node is selected
    //parent.expand();
    parent.get_nodes().add(node);
    node._addClassToContentElement("trvFolder")
    //Expand the parent if it is not the treeview
    if (parent != tree && !parent.get_expanded())
        parent.set_expanded(true);
    node.set_selected(true);
    window.setTimeout(function() { node.startEdit(); }, 100);
    parent.set_selected(false);

    tree.commitChanges();
    return node;
}


//this method disables the appropriate context menu items
function setMenuItemsState(menuItems, treeNode) {
    var tree = $find(treeNode.get_treeView().get_id());
    var nodes = tree.get_selectedNodes();
    if (nodes.length > 1) {
        var containsAssembly = false;
        var containsGroup = false;
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].get_value().indexOf("_I") > 0) {
                containsAssembly = true;
            }
            if (nodes[i].get_value().indexOf("_G") >= 0) {
                containsGroup = true;
            }
            if (containsGroup && containsAssembly) break;
        }
        for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
            //alert(menuItem.get_value());
            switch (menuItem.get_value()) {
                case "Rename":
                    menuItem.set_enabled(false);
                    break;
                case "OpenAssembly":
                    menuItem.set_visible(containsAssembly && !containsGroup);
                    if (!(containsAssembly && !containsGroup)) {
                        menuItem.get_element().style.display = "none";
                    }

                    menuItem.set_enabled(false);
                    break;
                case "NewGroup":
                    menuItem.set_visible(!containsAssembly && containsGroup);
                    if (!(!containsAssembly && containsGroup))
                    {
                        menuItem.get_element().style.display = "none";
                    }
                    menuItem.set_enabled(false);
                    break;
                case "NewAssembly":
                    menuItem.set_visible(!containsAssembly && containsGroup);
                    if (!(!containsAssembly && containsGroup))
                    {
                        menuItem.get_element().style.display = "none";
                    }
                    menuItem.set_enabled(false);
                    break;
                case "Delete":
                    menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true');
                    break;
            }
        }
    } else {
        for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
            switch (menuItem.get_value()) {
                case "Rename":
                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true');
                    break;
                case "OpenAssembly":
                    menuItem.set_visible(treeNode.get_value().indexOf("_I") > 0);
                    if (!(treeNode.get_value().indexOf("_I") > 0))
                    {
                        menuItem.get_element().style.display = "none";
                    }
                    menuItem.set_enabled(true);
                    break;
                case "NewGroup":
                    menuItem.set_visible(treeNode.get_value().indexOf("_G") >= 0);
                    if (!(treeNode.get_value().indexOf("_G") >= 0))
                    {
                        menuItem.get_element().style.display = "none";
                    }
                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                    break;
                case "NewAssembly":
                    menuItem.set_visible(treeNode.get_value().indexOf("_G") >= 0);
                    if (!(treeNode.get_value().indexOf("_G") >= 0))
                    {
                        menuItem.get_element().style.display = "none";
                    }
                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                    break;
                case "Delete":
                    menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true');
                    break;
            }
        }
    }

}

/************************ Assemblies **********************/

function comboLoad(sender, eventArgs) {
    var tree = sender.get_items().getItem(0).findControl("treeAssemblyGroups");
    var text = "";
    var selectedNode = tree.get_selectedNode();
    if (selectedNode != null) {
        text = selectedNode.get_text();
        selectedNode = selectedNode.get_parent();
        while (selectedNode != null) {
            if (selectedNode.expand) {
                selectedNode.expand();
            }
            selectedNode = selectedNode.get_parent();
        }
    }

    sender.set_text(text);
}


function nodeClicking(sender, args) {
    var comboBox = $find($("[id$='ddlAssemblyGroup']")[0].id);
    var node = args.get_node()
    comboBox.set_text(node.get_text());
    comboBox.trackChanges();
    comboBox.get_items().getItem(0).set_value(node.get_text());
    comboBox.commitChanges();
    comboBox.hideDropDown();
}

function StopPropagation(e) {
    if (!e) {
        e = window.event;
    }
    e.cancelBubble = true;
}

function OnClientDropDownOpenedHandler(sender, eventArgs) {
    var tree = sender.get_items().getItem(0).findControl("treeAssemblyGroups");
    var selectedNode = tree.get_selectedNode();
    if (selectedNode) {
        selectedNode.scrollIntoView();
    }
}


