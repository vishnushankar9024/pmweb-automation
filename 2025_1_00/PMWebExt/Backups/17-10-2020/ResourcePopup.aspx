<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="ResourcePopup.aspx.vb" Inherits="Website.ResourcePopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script src="JS/EngeneeringForms/ResourcePopup.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlGroups">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvResources" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgResources">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvResources" >
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Office2007" />
        
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Outlook" Width="100%"
            Height="400px" SplitBarsSize="">
            <telerik:RadPane ID="rpnResourceTree" runat="server" Width="30%" CssClass="NormalWhiteBack"
                EnableEmbeddedBaseStylesheet="False"  Index="0" Skin="">
                <table width="100%">
                    <tr>
                        <td valign="top">
                            <asp:Label ID="lblTreeFilter" meta:resourcekey="lblTreeFilter" runat="server" Text="Group By"></asp:Label>
                        </td>
                        <td style="padding-left:5px;" valign="top">
                            <asp:DropDownList ID="ddlGroups" runat="server" Width="150px" AutoPostBack="true">
                            <asp:ListItem Text="<%$Resources: ListItemCompany %>" Value="1"></asp:ListItem>
                               <asp:ListItem Text="<%$Resources: ListItemContact %>" Value="2"></asp:ListItem>
                                <asp:ListItem Text="<%$Resources: ListItemNone %>" Value="0"></asp:ListItem>
                                 <asp:ListItem Text="<%$Resources: ListItemResourceType %>" Value="3"></asp:ListItem>
                                  <asp:ListItem Text="<%$Resources: ListItemResourceGroup %>" Value="4"></asp:ListItem>
                                  <asp:ListItem Text="<%$Resources: ListItemResourceTypeResourceGroup %>" Value="5"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top">
                            <telerik:RadTreeView ID="rtvResources" runat="server" EnableDragAndDrop="True"
                                 OnClientNodeDropping="onNodeDropping"
                                OnClientNodeDragging="onNodeDragging" 
                                Skin="Outlook" MultipleSelect="True" Width="99%" Height="100%">
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                            </telerik:RadTreeView>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False"
                 Index="1" Skin=""/>
            <telerik:RadPane ID="rpnResourceGrid" runat="server" EnableEmbeddedBaseStylesheet="False"
                 Index="2" Skin="">
                <table style="width: 100%;  vertical-align: top;" class="NormalWhiteBack">
                    <tr>
                        <td style="width:600px">
                            <telerik:RadGrid ID="rdgResources" runat="server"  
                                Width="99%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True"
                                GridLines="None">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true">
                                </PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Resource"
                                            UniqueName="Resource">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Resource") = String.Empty, "&nbsp;", Container.DataItem("Resource"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Company"
                                            UniqueName="Company">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Contact"
                                            UniqueName="Contact">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Contact") = String.Empty, "&nbsp;", Container.DataItem("Contact"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgResources.EditIndexes.Count = 0 AND (Not rdgResources.MasterTableView.IsItemInserted) %>">
                                           <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt" />
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <table width="100%" class="NormalWhiteBack">
            <tr>
                <td align="right">
                    <asp:LinkButton ID="lbtSaveAndClose" runat="server" Text="<%$ Resources:PMWeb, SaveClose %>"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Close %>"></asp:LinkButton>&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
