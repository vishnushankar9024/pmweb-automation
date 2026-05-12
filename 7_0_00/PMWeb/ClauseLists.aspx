<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ClauseLists.aspx.vb" Inherits="Website.ClauseLists" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script type="text/ecmascript" >
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
      
              case "Delete":
                  if (nodes.length > 0) {
                      for (var i = 0; i < nodes.length; i++) {
                          var nodeValue = nodes[i].get_value();
                          if (nodeValue.indexOf("D") > 0 || nodeValue.indexOf("T") > 0) {
                              isItemSelected = true;
                          }
                         
                      }
                  }
                 
                      result = confirm(Msg_DeleteItems);
                
                  args.set_cancel(!result);
                  break;
                  
                  
          }

      }
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
              for (var i = 0; i < nodes.length; i++) {
               
                  if (nodes[i].get_value().indexOf("S") > 0) {
                      ContainsSystemList = true;
                  }
                  if (nodes[i].get_value().indexOf("D")>0 || nodes[i].get_value().indexOf("T") > 0) {
                      containsItem = true;
                  }
                
                  else if (containsItem  && ContainsSystemList) break;
              }
             for (var i = 0; i < menuItems.get_count(); i++) {
                  var menuItem = menuItems.getItem(i);
                  switch (menuItem.get_value()) {
                      case "MakeInactive":
                          menuItem.set_visible(false);
                          var Exit = 0;
                          for (var k = 0; k < nodes.length; k++) {
                              if (nodes[k].get_checked() == false) {
                                  Exit = 1;
                                  break;
                              }
                          }
                          if (Exit == 0)
                              menuItem.set_visible(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                          break;
                      case "MakeActive":
                          menuItem.set_visible(false);
                          var Exit = 0;
                          for (var k = 0; k < nodes.length; k++) {
                              if (nodes[k].get_checked() == true) {
                                  Exit = 1;
                                  break;
                              }
                          }
                          if (Exit == 0)
                              menuItem.set_visible(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                          break;

                      case "Rename":
                          menuItem.set_enabled(false);
                          if (nodes.length == 1 &&  containsItem) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true')
                          }
                          break;
                      case "NewItem":
                          menuItem.set_enabled(false);
                          if (nodes.length == 1 && (ContainsSystemList)) {
                              menuItem.set_enabled(true);
                              menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                          }

                          break;
                      case "Delete":
                          menuItem.set_enabled( !ContainsSystemList && tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true');

                          break;
                          
                         
                  }
              }
          }
      }
        function OnClientNodeEditStartHandler(sender, eventArgs) {
          var node = eventArgs.get_node();
          var textInput = node.get_inputElement();
          textInput.maxLength = 100;
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
      
    </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%" LoadingPanelID="ldpPM">
                  <asp:HiddenField ID="hfNode" runat="server" />
                <telerik:radtreeview ID="treeList" CheckBoxes="true" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onClientContextMenuShowing" runat="server" EnableDragAndDrop="True" MultipleSelect="true"
                    OnClientNodeEditStart="OnClientNodeEditStartHandler"  CssClass="CheckBoxesTreeview">
                    <ContextMenus>
                           <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu" >
                                    <Items>
                                        <telerik:RadMenuItem Value="Rename" meta:Resourcekey="MenuItem_Rename" Text="Rename" EnableImageSprite="true"  CssClass="MenuRename" >
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="MakeInactive" meta:Resourcekey="MenuItem_MakeInactive" Text="New Item"
                                          EnableImageSprite="true" CssClass="MenuCheckedInDisabled">
                                        </telerik:RadMenuItem>
                                         <telerik:RadMenuItem Value="MakeActive" meta:Resourcekey="MenuItem_MakeActive" Text="New Item"
                                          EnableImageSprite="true" CssClass="MenuCheckedIn">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="NewItem" meta:Resourcekey="MenuItem_NewItem" Text="New Item" EnableImageSprite="true" CssClass="MenuAdd">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="Delete" meta:Resourcekey="MenuItem_Delete" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete"
                                           OnClientContextMenuShowing="onClientContextMenuShowing">
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
             </telerik:radtreeview>
                 </telerik:RadAjaxPanel>
  
    </form>
</body>
</html>
