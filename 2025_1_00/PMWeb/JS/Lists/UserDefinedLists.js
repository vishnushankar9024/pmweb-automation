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
              var ContainsSystemList = false;
              var ContainCList = false;
              var containSpecialCaseItem = false;

              for (var i = 0; i < nodes.length; i++) {
                  if (isSpecialCaseItem(nodes[i])) {
                      containSpecialCaseItem = true;
                  }
                  if (nodes[i].get_value().indexOf("N") > 0) {
                      ContainCList = true;
                  }
                  if (nodes[i].get_value().indexOf("S") > 0) {
                      ContainsSystemList = true;
                  }
                  if ((nodes[i].get_value().indexOf("D") > 0 || nodes[i].get_value().indexOf("T") > 0)) {
                      containsItem = true;
                  }
                  else if (nodes[i].get_value().indexOf("L") > 0) {
                      containsGroup = true;
                  }
                  else if (nodes[i].get_value().indexOf("C") > 0) {
                  containsCustomList = true;
                  }
                  else if (containsGroup && containsItem && containsCustomList && ContainCList && ContainsSystemList) break;
              }
             for (var i = 0; i < menuItems.get_count(); i++) {
                  var menuItem = menuItems.getItem(i);
                  switch (menuItem.get_value()) {
                      case "Rename":
                          menuItem.set_enabled(false);
                          if (nodes.length == 1 && !containSpecialCaseItem && (containsCustomList || containsItem)) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                          }
                          break;
                      case "MakeInactive":
                          menuItem.set_visible(false);
                         // if (!containsGroup && !ContainCList && !ContainsSystemList && !containsCustomList && containsItem) {
                              var Exit = 0;
                              for (var k = 0; k < nodes.length; k++) {
                                  if (nodes[k].get_checked() == false) {
                                      Exit = 1;
                                      break;
                                  }
                              }
                              if (Exit == 0)
                                 menuItem.set_visible(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                        //  }
                          break;
                      case "MakeActive":
                          menuItem.set_visible(false);
                        //  if (!containsGroup && !ContainCList && !ContainsSystemList && !containsCustomList && containsItem) {
                              var Exit = 0;
                              for (var k = 0; k < nodes.length; k++) {
                                  if (nodes[k].get_checked() == true) {
                                      Exit = 1;
                                      break;
                                  }
                              }

                                 if(Exit==0)
                                  menuItem.set_visible(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                        //  }
                          break;
                      case "NewItem":
                          menuItem.set_enabled(false);
                          if (nodes.length == 1 && (containsGroup || containsCustomList)) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                          }

                          break;
                      case "Delete":
                          menuItem.set_enabled(!containsGroup && !ContainCList && !ContainsSystemList && tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' && !containSpecialCaseItem);
                          break;
                          
                     case "NewList":
                          menuItem.set_enabled((nodes.length >= 1 && ContainCList) && tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                          break;
                  }
              }
          }
      }

      function isSpecialCaseItem(node) {
          try {
              var parentId = node.get_parent().get_value();
              var childId = node.get_value();
              if (parentId.indexOf("L") > 0 && parentId.split(' ')[0] == '76') {
                  if ((childId.indexOf("T") > 0 || childId.indexOf("D") > 0)  && (childId.split(' ')[0] == '1' || childId.split(' ')[0] == '2')) {
                    return true;
                }
              }
          } catch (e) { }
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
              case "Rename":
                  treeNode.startEdit();
                  args.set_cancel(true);
                  break;
              case "NewItem":
                  treeNode.expand();
                  window.setTimeout(function() { addGroupNode(treeNode.get_treeView().get_id()); }, 230);
                  args.set_cancel(true);
                  break;
              case "NewList":
//                  treeNode.expand();
                  window.setTimeout(function() { addListNode(treeNode.get_treeView().get_id()); }, 230);
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
                      //selected Custom Lists
                      result = confirm(Msg_DeleteCustomLists);
                  }
                  else if (isGrougSelected) {
                  //selected Custom Lists and their sub-items
                  result = confirm(Msg_DeleteCustomFormWithSubs);
                  }
                  else {
                      //selected items
                      result = confirm(Msg_DeleteItems);
                  }
                  args.set_cancel(!result);
                  break;
                  
                  
          }

      }

      function addListNode(treeId) {
          var nodeText = "";
          var tree = $find(treeId);
          tree.trackChanges();

          var node = new Telerik.Web.UI.RadTreeNode();
          var parent = tree.get_selectedNode() || tree;
          var ParNode = tree.findNodeByValue("2 N");
          if (ParNode != null) {
              parent = ParNode;
          
          }
         
          node.set_value("NEWLIST")
          
          //node.set_imageUrl("Images/Global/folder.png")
          node.get_attributes().setAttribute("IsNewList", "True")
          node.set_text(nodeText);
          parent.get_nodes().add(node);
          node.className = "trvFolder"
          node.set_checkable(false);
          //Expand the parent if it is not the treeview
          if (parent != tree && !parent.get_expanded())
              parent.set_expanded(true);
          node.set_selected(true);
          window.setTimeout(function() { node.startEdit(); }, 100);
          parent.set_selected(false);
          tree.commitChanges();
          return node;
          
          
          
      }


      function addGroupNode(treeId) {
          var nodeText = "";
          var tree = $find(treeId);
          tree.trackChanges();

          //Instantiate a new client node
          var node = new Telerik.Web.UI.RadTreeNode();
          var parent = tree.get_selectedNode() || tree;
          //Set its value, text and image
          node.set_value("NEWITEM")
          node.set_text(nodeText);
          node.set_checkable(false);
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


      function OnClientNodeEditStartHandler(sender, eventArgs) {
          var node = eventArgs.get_node();
          var textInput = node.get_inputElement();
          textInput.maxLength = 100;
      } 


      function OnClientLoad(sender, args) {
          var topNodeList = sender.get_nodes();
          for (var i = 0; i < topNodeList.get_count() ; i++) {
              var firstNodeList = topNodeList.getNode(i).get_nodes();
                for (var i = 0; i < firstNodeList.get_count() ; i++) {
                    var node = firstNodeList.getNode(i);
                    if (node.get_attributes().getAttribute("HasInactiveChild") == "1") {
                        var elements = node._element.firstChild.getElementsByTagName("span");
                        for (var j = 0; j < elements.length; j++) {
                            if (elements[j].className == "rtUnchecked" || elements[j].className == "rtchecked")
                                elements[j].className = "rtIndeterminate";
                        }
                    }
                }  
          }
      }