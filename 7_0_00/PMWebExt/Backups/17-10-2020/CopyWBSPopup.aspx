<%@ Page Language="vb" meta:Resourcekey="Page" AutoEventWireup="false" CodeBehind="CopyWBSPopup.aspx.vb" Inherits="Website.CopyWBSPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style>
     .RadTreeView .rtLines .rtMid {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtFirst {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtLI {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtBot {
            background-image: none !important;
        }
        .RadTreeView_Default {max-width: 408px;}
        .ProjectExplorerTree{height: calc(100vh - 60px) !important;}

</style>
<body>
  
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        
                    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
                        <tr>
                            <td style="width: 210px; padding-right: 5px" class="ToolbarTd">
                                <telerik:RadComboBox ID="ddlEntities" runat="server" CloseDropDownOnBlur="true"
                                    EmptyMessage="Select Entity..." Width="200px" AutoPostBack="True" AllowCustomText="true"
                                    CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:Resourcekey="ddlEntities"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave"
                                            CommandName="Copy" AccessKey="s" Value="Copy">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td style="width:100%"></td>
                        </tr>
                    </table>
         
        <table  class="tblcontainer" style="padding-top:20px;padding-left:10px;padding-right:10px">
            <tr>
               <td class="controlWidth" colspan="2" style="padding-top:30px">
                   <div style="width:100%;">
                    <telerik:RadTreeView ID="rdvLocation" runat="server" EnableDragAndDrop="True" cssclass="ProjectExplorerTree"
                        MultipleSelect="false"  Height="540px" Width="100%" Style="overflow:auto !important;">
                        <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                        <ExpandAnimation Duration="100"></ExpandAnimation>
                    </telerik:RadTreeView>
                       </div>
                </td>
            </tr>
        </table>
    </form>
  
</body>
</html>
