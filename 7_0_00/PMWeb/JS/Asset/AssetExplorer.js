

function OpenProjectLinkedAsset(Id) {

    var left = (screen.width - 905) / 2;
    var top = (screen.height - 210) / 2;
    var win = window.open('ProjectLinkedAssetsPopup.aspx?Id='+Id, '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=905,height=210,top=' + top + ',left=' + left);
    return false;
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
    switch (menuItem.get_value()) {
        case "AddProperty":
            if (treeNode.get_value().indexOf("G") < 0) {
                window.setTimeout(function() { AddPropertyNode(treeNode.get_treeView().get_id()); }, 200);
                args.set_cancel(true);
            }
            else {
                treeNode.expand();
                window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "P"); }, 200);
                args.set_cancel(true);
            }
            break;
        case "AddBuilding":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "B"); }, 200);
            args.set_cancel(true);
            break;

        case "AddFloor":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "F"); }, 200);
            args.set_cancel(true);
            break;

        case "AddSpace":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "S"); }, 200);
            args.set_cancel(true);
            break;
        case "AddEquipment":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "E"); }, 200);
            args.set_cancel(true);
            break;
        case "AddUnit":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "U"); }, 200);
            args.set_cancel(true);
            break;
        case "AddProject":
            treeNode.expand();
            window.setTimeout(function() { AddBLFLSPEQ(treeNode.get_treeView().get_id(), "PT"); }, 200);
            args.set_cancel(true);
            break;
        case "Rename":
            var val = treeNode.get_value();
            //                 if (val.indexOf("E") < 0) {
            //                     var text = treeNode.get_text();
            //                     var att = treeNode.get_attributes().getAttribute("Code")
            //                     text = text.substring(text.indexOf( att + "-") + att.length  + 1);
            //                     treeNode.set_text(text);
            //                 }
            treeNode.startEdit();
            args.set_cancel(true);
            break;
        case "Delete":
            var result;
            if (nodes.length >= 1) {

                result = confirm(Msg_ConfirmDelete);
            }
            args.set_cancel(!result);
            break;
        case "Add":
            args.set_cancel(true);
            break;
        case "OpenItem":
            args.set_cancel(false);
            break;


    }


}
function AddPropertyNode(treeId) {
    var tree = $find(treeId);
    tree.trackChanges();
    var node = new Telerik.Web.UI.RadTreeNode();
    node.set_text("");
    node.set_value("NEWNODE")
    //node.set_imageUrl("Images/Asset/smallProperty.png")
    node.get_attributes().setAttribute("NEWPROPERTY", "True")
    tree.get_nodes().add(node);
    node._addClassToContentElement("trvProperty")
    tree.commitChanges();

    node.set_selected(true);
    window.setTimeout(function() { node.startEdit(); }, 100);
    tree.commitChanges();
    return node

}



function AddBLFLSPEQ(treeId, type) {
    var nodeText = "";
    var tree = $find(treeId);
    tree.trackChanges();
    var node = new Telerik.Web.UI.RadTreeNode();
    var parent = tree.get_selectedNode() || tree;
    node.set_text(nodeText);

    switch (type) {
        case "B":
            node.get_attributes().setAttribute("NEWBUILDING", "True")
            //node.set_imageUrl("Images/Asset/smallBuilding.png")
            break;
        case "F":
            node.get_attributes().setAttribute("NEWFLOOR", "True")
            //node.set_imageUrl("Images/Asset/smallFloor1.png")
            break;
        case "S":
            node.get_attributes().setAttribute("NEWSPACE", "True")
            //node.set_imageUrl("Images/Asset/smallSpace1.png")
            break;
        case "E":
            node.get_attributes().setAttribute("NEWEQUIPMENT", "True")
            //node.set_imageUrl("Images/Asset/smallEquipment.png")
            break;
        case "U":
            node.get_attributes().setAttribute("NEWUNIT", "True")
           // node.set_imageUrl("Images/Asset/Unit.png")
            break;
        case "P":
            node.get_attributes().setAttribute("NEWPROPERTY", "True")
            //node.set_imageUrl("Images/Asset/smallProperty.png")
            break;
        case "PT":
            node.get_attributes().setAttribute("NEWPROJECT", "True")
            break;
    }

    node.set_value("NEWNODE");

    parent.get_nodes().add(node);

    switch (type) {
        case "B":
            node._addClassToContentElement("trvBuilding")
            break;
        case "F":
            node._addClassToContentElement("trvFloor")
            break;
        case "S":
            node._addClassToContentElement("trvSpace")
            break;
        case "E":
            node._addClassToContentElement("trvEquipment")
            break;
        case "U":
            node._addClassToContentElement("trvUnit")
            break;
        case "P":
            node._addClassToContentElement("trvProperty")
            break;
    }

    if (parent != tree && !parent.get_expanded())
        parent.set_expanded(true);
    node.set_selected(true);
    window.setTimeout(function() { node.startEdit(); }, 100);
    parent.set_selected(false);

    tree.commitChanges();
    return node;
}
function onClientContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    if (treeNode.get_attributes().getAttribute("DisableContextMenu") == "True") {
        args.set_cancel(true);
        args._domEvent.stopPropagation();
        return;
    }
    if (treeNode.get_category() == "Enabled") {
        treeNode.set_selected(true);
        setMenuItemsState(args.get_menu().get_items(), treeNode);

    }
    else {
        args.set_cancel(true);
    }
}

function setMenuItemsState(menuItems, treeNode) {
    var tree = $find(treeNode.get_treeView().get_id());
    var nodes = tree.get_selectedNodes();
    if (nodes.length >= 1) {
        var containsProperties = false;
        var containsBuildings = false;
        var containsFloors = false;
        var containsSpaces = false;
        var containsEquipments = false;
        var containsGroup = false;
        var containsUnits = false;
        var containsProject = false;
        var containsProjectEntity = false;
        var containsOccupants = false;
        var containsOccupantEntity = false;
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].get_value().indexOf("P") > 0 && nodes[i].get_value().indexOf("PT") < 0 && nodes[i].get_value().indexOf("PR") < 0) {
                containsProperties = true;
            }
            else if (nodes[i].get_value().indexOf("B") > 0) {
                containsBuildings = true;
            }
            else if (nodes[i].get_value().indexOf("F") > 0) {
                containsFloors = true;
            }
            else if (nodes[i].get_value().indexOf("S") > 0) {
                containsSpaces = true;
            }
            else if (nodes[i].get_value().indexOf("E") > 0) {
                containsEquipments = true;
            }
            else if (nodes[i].get_value().indexOf("U") > 0) {
                containsUnits = true;
            }

            else if (nodes[i].get_value().indexOf("G") > 0) {
                containsGroup = true;
            }
            else if (nodes[i].get_value().indexOf("PR") > 0) {
                containsProject = true;
            }
            else if (nodes[i].get_value().indexOf("PT") > 0) {
                containsProjectEntity = true;
            }
            else if (nodes[i].get_value().indexOf("O") > 0 && nodes[i].get_value().indexOf("OC") < 0) {
                containsOccupants = true;

            }
            else if (nodes[i].get_value().indexOf("OC") > 0) {
                containsOccupantEntity = true;

            }
            else if (containsOccupantEntity && containsOccupant && scontainsProjectEntity && containsProject && containsProperties && containsGroup && containsBuildings && containsFloors && containsSpaces && containsUnits && containsEquipments) break;

        }

        for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
            switch (menuItem.get_value()) {
                case "Rename":
                    menuItem.set_enabled(false);
                    if (nodes.length == 1 && !containsGroup && !containsProject && !containsOccupants && !containsOccupantEntity) {

                        if (containsProperties)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditProperty").toLowerCase() == 'true');
                        else if (containsBuildings)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditBuilding").toLowerCase() == 'true');
                        else if (containsFloors)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditFloor").toLowerCase() == 'true');
                        else if (containsSpaces)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditSpace").toLowerCase() == 'true');
                        else if (containsUnits)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditUnit").toLowerCase() == 'true');
                        else if (containsEquipments)
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditEquipment").toLowerCase() == 'true' && tree.get_element().getAttribute("GroupId").toLowerCase()!='4');
                        else if (containsProjectEntity)
                            menuItem.set_enabled(false)
                        else
                            menuItem.set_enabled(tree.get_element().getAttribute("CanEditProject").toLowerCase() == 'true');

                    }
                    break;

                case "Add":

                    var PMenuItem = menuItems.getItem(i).get_items().getItem(0)
                    PMenuItem.set_enabled(false)
                    if (nodes.length == 1 && containsGroup) {
                        PMenuItem.set_enabled(tree.get_element().getAttribute("CanAddProperty").toLowerCase() == 'true' && tree.get_element().getAttribute("GroupId").toLowerCase()!='4');

                    }
                    if (nodes.length >= 1 && !containsGroup) {
                        PMenuItem.set_enabled(tree.get_element().getAttribute("CanAddProperty").toLowerCase() == 'true' && tree.get_element().getAttribute("GroupId").toLowerCase() != '4');

                    }
                    var BMenuItem = menuItems.getItem(i).get_items().getItem(1)
                    BMenuItem.set_enabled(false);
                    if (nodes.length == 1 && containsProperties) {
                        BMenuItem.set_enabled(tree.get_element().getAttribute("CanAddBuilding").toLowerCase() == 'true');

                    }
                    var FMenuItem = menuItems.getItem(i).get_items().getItem(2)
                    FMenuItem.set_enabled(false);
                    if (nodes.length == 1 && containsBuildings) {
                        FMenuItem.set_enabled(tree.get_element().getAttribute("CanAddfloor").toLowerCase() == 'true');

                    }
                    var SMenuItem = menuItems.getItem(i).get_items().getItem(3)
                    SMenuItem.set_enabled(false);
                    if (nodes.length == 1 && containsFloors) {
                        SMenuItem.set_enabled(tree.get_element().getAttribute("CanAddSpace").toLowerCase() == 'true');

                    }
                    var EMenuItem = menuItems.getItem(i).get_items().getItem(4)
                    EMenuItem.set_enabled(false);
                    if (nodes.length == 1 && !containsEquipments && !containsGroup && !containsProject && !containsProjectEntity && !containsOccupants && !containsOccupantEntity && !containsUnits) {
                        EMenuItem.set_enabled(tree.get_element().getAttribute("CanAddEquipment").toLowerCase() == 'true');

                    }

                    break;

                case "Delete":
                    menuItem.set_enabled(false)
                    if (!containsGroup && !containsProject && !containsOccupants && !containsOccupantEntity) {
                        menuItem.set_enabled(true);
                        if (containsProperties && tree.get_element().getAttribute("CanDeleteProperty").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsBuildings && tree.get_element().getAttribute("CanDeleteBuilding").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsFloors && tree.get_element().getAttribute("CanDeleteFloor").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsSpaces && tree.get_element().getAttribute("CanDeleteSpace").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsUnits && tree.get_element().getAttribute("CanDeleteUnit").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsEquipments && tree.get_element().getAttribute("CanDeleteEquipment").toLowerCase() == 'false')
                            menuItem.set_enabled(false);
                        else if (containsProjectEntity)
                            menuItem.set_enabled(false)
                        else
                            menuItem.set_enabled(tree.get_element().getAttribute("CanDeleteProject").toLowerCase() == 'true');
                    }
                    break;
                case "OpenItem":
                    menuItem.set_enabled(false);
                    if (nodes.length == 1 && !containsGroup && !containsProject && !containsOccupants && !containsOccupantEntity) {
                        menuItem.set_enabled(true);
                    }
                    break;

            }
        }
    }
}


function onClientDoubleClick(sender, args) {
    if (dirty && dirtyEnabled) {
        if (confirm(Msg_PromptToSave) == false) { return false; }
        //dirtyMessage
    } 
    var treeNode = args.get_node();
    var nodeValue = treeNode.get_value();
    if (nodeValue.indexOf("LPTO") > 0) {
        OpenProjectLinkedAsset(nodeValue.replace(" LPTO", ""));
        return false;
       
    }
    if (nodeValue.indexOf("G") < 0  && nodeValue.indexOf("PR") < 0 && nodeValue.indexOf(" O") < 0 && nodeValue.indexOf("OC") < 0 ){
        if (treeNode.get_category() == "Enabled") {
            __doPostBack("NodeDoubleClicked", nodeValue);
        }

    }

}

function ClientNodeExpanding(sender, eventArgs) {
    if (eventArgs._domEvent.type == 'dblclick') {
        eventArgs.set_cancel(true);
    }
}


function droppedOnGroup(sender, args) {
    var dest = args.get_destNode();
    var nodes = args.get_sourceNodes();
    var target = args.get_htmlElement();
    if (dest) {
        args.set_cancel(true);
    }
}
function OnClientNodeEditStartHandler(sender, eventArgs) {
    var node = eventArgs.get_node();
    var textInput = node.get_inputElement();
    textInput.maxLength = 50;
} 

function ShowAssetTreeToolbar() {
   // var ConfigureAssetTreeDiv = $('#ConfigureAssetTreeDiv');
    var AssetTreeToolBarDiv = $('#AssetTreeToolBarDiv');
    var flyoutBackdrop = $('#flyoutBackdrop')[0];
    var assetExplrerTree = $('#ctl00_ctl00_CPH1_AssetExplorer_rdvAssetExplorer');
    //ConfigureAssetTreeDiv.addClass('Hide');
    AssetTreeToolBarDiv.removeClass('Hide');
    flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
    //assetExplrerTree.addClass('paddingTop');
    return false;
}

