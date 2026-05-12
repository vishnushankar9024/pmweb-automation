<%@ Page Language="vb" Title="Contacts" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="Contacts.aspx.vb" Inherits="Website.Contacts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        body
        {
            background: white none !important;
            color: #000000;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

        var gridId = "RadContentPane";
        function isMouseOverGrid(target)
        {
            parentNode = target;
            while (parentNode != null)
            {                    
                if (parentNode.id == gridId)
                {
                    return parentNode;
                }
                parentNode = parentNode.parentNode;
            }

            return null;
        }


        function onNodeDragging(sender, args)
        {
            var target = args.get_htmlElement();    
            
            if(!target) return;
            
            if (target.tagName == "INPUT")
            {        
                target.style.cursor = "hand";
            }

            var grid = isMouseOverGrid(target);
            if (grid)
            {
                grid.style.cursor = "hand";
            }
        }


        function droppedOnGrid(args)
        {
             var target = args.get_htmlElement();
             
             while(target)
             {
             if(target.id == gridId)
             {
             args.set_htmlElement(target);
             return;                                                   
             }
             
             target = target.parentNode;
             }
             args.set_cancel(true);
        }


        function onNodeDropping(sender, args){            
            if(droppedOnGrid(args))return;  
        }
        
        function CloseWindow()
        {
            var oWindow = GetRadWindow();
            oWindow.Close();
            oWindow.BrowserWindow.refreshGrid();
        }
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server" EnableScriptGlobalization="True">
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rtvContacts" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rdgContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
    <table width="100%" cellspacing="0px" cellpadding="0px" border="0">
        <tr>
            <td>
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default"
                    Width="500px" Height="380px">
                    <telerik:RadPane ID="rpContacts" runat="server" CssClass="NormalWhiteBack" Width="300px"
                        Height="560px">
                        <telerik:RadTreeView ID="rtvContacts" runat="server" EnableDragAndDrop="True" OnNodeDrop="rtvContacts_NodeDrop"
                            Skin="Default" MultipleSelect="true" OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                        </telerik:RadTreeView>
                    </telerik:RadPane>
                    <telerik:RadSplitBar ID="Splitter" runat="server" />
                    <telerik:RadPane ID="RadContentPane" runat="server" Width="450px" Height="560px">
                        <div id="ContactsPane" style="vertical-align: top;" class="NormalWhiteBack">
                            <telerik:RadGrid ID="rdgContacts" runat="server" Skin="Default" AutoGenerateColumns="False"
                                ShowStatusBar="true" HeaderStyle-Font-Size="8" AllowMultiRowSelection="True">
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="CompanyName" UniqueName="CompanyName" HeaderStyle-Width="180px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Contact Name" UniqueName="ContactName" HeaderStyle-Width="120px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblContactName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                      <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows" 
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows">
                    <span class="Icon"></span>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                 <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" 
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
        
            </div>
        </CommandItemTemplate>
                                </MasterTableView>
                                     <ClientSettings >
                                <Selecting AllowRowSelect="true"  />
                                        
                                    </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </telerik:RadPane>
                </telerik:RadSplitter>
            </td>
        </tr>
        <tr>
            <td align="right">
            <br />
                <asp:Button ID="btnSave" runat="server" Text="<%$ Resources:PMWeb, SaveToRecord %>" />&nbsp;&nbsp;
                <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
