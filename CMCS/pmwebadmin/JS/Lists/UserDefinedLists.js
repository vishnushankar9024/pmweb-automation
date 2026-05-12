function onClientContextMenuShowing(sender, args) {
          var treeNode = args.get_node();
          treeNode.set_selected(true);
          setMenuItemsState(args.get_menu().get_items(), treeNode);
      }

      function setMenuItemsState(menuItems, treeNode) {
          var tree = $find(treeNode.get_treeView().get_id());
          var nodes = tree.get_selectedNodes();
          if (nodes.length >= 1) {
              var containsItem = false;
              var containsGroup = false;
              var containsCustomList = false;
              for (var i = 0; i < nodes.length; i++) {
                  if (nodes[i].get_value().indexOf("D")>0 || nodes[i].get_value().indexOf("T") > 0) {
                      containsItem = true;
                  }
                  else if (nodes[i].get_value().indexOf("L") > 0) {
                      containsGroup = true;
                  }
                  else if (nodes[i].get_value().indexOf("C") > 0) {
                  containsCustomList = true;
                  }
                  else if (containsGroup && containsItem && containsCustomList) break;
              }
             for (var i = 0; i < menuItems.get_count(); i++) {
                  var menuItem = menuItems.getItem(i);
                  //alert(menuItem.get_value());
                  switch (menuItem.get_value()) {
                      case "Rename":
                          menuItem.set_enabled(false);
                          if (nodes.length == 1 && !containsGroup) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                          }
                          break;
                      case "NewItem":
                          menuItem.set_enabled(false);
                          if (((nodes.length == 1) && (containsGroup == true)) || ((nodes.length == 1) && (containsCustomList == true))) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                          }

                          break;
                      case "Delete":
                          menuItem.set_enabled(!containsGroup && tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true');

                          break;
                          
                          case "NewList":
                           menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
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
          switch (menuItem.get_value()) {
              case "Rename":
                  treeNode.startEdit();
                  args.set_cancel(true);
                  break;
              case "NewItem":
                  treeNode.expand();
                  window.setTimeout(function() { addGroupNode(treeNode.get_treeView().get_id()); }, 200);
                  args.set_cancel(true);
                  break;
              case "NewList":
//                  treeNode.expand();
                  window.setTimeout(function() { addListNode(treeNode.get_treeView().get_id()); }, 200);
                  args.set_cancel(true);
                  break;

              case "Delete":
                  if (nodes.length > 0) {
                      for (var i = 0; i < nodes.length; i++) {
                          var nodeValue = nodes[i].get_value();
                          if (nodeValue.indexOf("C") > 0) {
                              isGrougSelected = true;
                          }
                          if (nodeValue.indexOf("D") > 0 || nodeValue.indexOf("T") > 0) {
                              isItemSelected = true;
                          }
                          if (isGrougSelected && isItemSelected) break;
                      }
                  }
                  var result;
                  if (isGrougSelected && isItemSelected) {
                      result = confirm("You are about to delete the selected Custom Lists, their sub-Items and all the selected items. This process cannot be undone.\nAre you sure you wish to continue?");
                  }
                  else if (isGrougSelected) {
                  result = confirm("You are about to delete the selected Custom Lists and their sub-items . This process cannot be undone.\nAre you sure you wish to continue?");
                  }
                  else {
                      result = confirm("You are about to delete the selected items. This process cannot be undone.\nAre you sure you wish to continue?");
                  }
                  args.set_cancel(!result);
                  break;
                  
                  
          }

      }

      function addListNode(treeId) {
          var tree = $find(treeId);
          tree.trackChanges();
          var node = new Telerik.Web.UI.RadTreeNode();
          node.set_text("");
          node.set_value("NEWLIST")
          node.set_imageUrl("Images/Global/folder.gif")
          node.get_attributes().setAttribute("IsNewList", "True")
          tree.get_nodes().add(node);
          tree.commitChanges();
        
          node.set_selected(true);
          window.setTimeout(function() { node.startEdit(); }, 100);
          tree.commitChanges();
          return node
          
      }




      function addGroupNode(treeId) {
          var nodeText = "";
          var tree = $find(treeId);
          tree.trackChanges();

          //Instantiate a new client node
          var node = new Telerik.Web.UI.RadTreeNode();
          var parent = tree.get_selectedNode() || tree;
          //Set its value, text and image
          //node.set_value(parent.get_value() + nodeText + "D");
          node.set_value("NEWITEM")
          node.set_text(nodeText);
       //   node.set_imageUrl("Images/Global/file.gif")
          //Set IsNew attribute for checking on server side
          node.get_attributes().setAttribute("IsNew", "True")
          //Add the new node as the child of the selected node or the treeview if no node is selected
          //parent.expand();
          parent.get_nodes().add(node);
          //Expand the parent if it is not the treeview
          if (parent != tree && !parent.get_expanded())
              parent.set_expanded(true);
          node.set_selected(true);
          window.setTimeout(function() { node.startEdit(); }, 100);
          parent.set_selected(false);

          tree.commitChanges();
          return node;
      }


