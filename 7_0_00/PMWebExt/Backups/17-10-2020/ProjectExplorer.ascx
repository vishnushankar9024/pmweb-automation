<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectExplorer.ascx.vb" Inherits="Website.ProjectExplorer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style>
    .ProjectExplorerTree {max-width:423px;}
    .ProjectExplorerTree{height:calc(100vh - 240px) !important}
</style>
<table class="tblcontainer" style="padding-top:20px;padding-left:10px;padding-right:10px">
    <tr>
        <td colspan="2" class="tdProgramprojectLogin">
             <asp:Label ID="lblProgramprojectLogin"  runat="server" meta:Resourcekey="lblProgramprojectLogin" Text="Program / Project Login"></asp:Label>
            
            
           </td>
    </tr>
    <tr>
        <td class="labelWidth">
            <asp:Label ID="lblSearch" runat="server" meta:Resourcekey="lblSearch" Text="Filter"></asp:Label>
        </td>
        <td class="controlWidth">
            <telerik:RadTextBox ID="txtSearch" runat="server" Width="100%"
                meta:resourcekey="txtSearch" MaxLength="500" AutoPostBack="true">
            </telerik:RadTextBox>
        </td>
    </tr>
 <tr>
      <td class="labelWidth">
            <asp:Label ID="lblView" runat="server" meta:Resourcekey="lblView" Text="Select a View"></asp:Label>
        </td>
        <td class="controlWidth">
            <telerik:RadComboBox runat="server" Id="ddlViews" Width="100%" AutoPostBack="true"></telerik:RadComboBox>
        </td>
    </tr>
 <tr>
      <td class="labelWidth">
            <asp:Label ID="lblStatuses" runat="server" meta:Resourcekey="lblStatuses" Text="Select a Project Status"></asp:Label>
        </td>
        <td class="controlWidth">
          <telerik:RadComboBox ID="ddlProjectStatus" runat="server" CssClass="ProjectStatusStyle"
                Skin="Default" CloseDropDownOnBlur="true" OnClientDropDownClosed="ProjectExplorerStatusddlClosed" OnClientDropDownOpened="ProjectExplorerStatusddlOpened"
            NoWrap="True" AllowCustomText="true" DropDownCssClass="MultiSelectCombo" Width="100%" 
            Style="font-size: 11px" Height="250px" >
            <ItemTemplate>
                <div onclick="StopPropagation(event)" class="combo-item-template" >
                    <asp:CheckBox runat="server" ID="chkApply" Text='<%#Eval("Status")%>' />
                </div>
            </ItemTemplate>
        </telerik:RadComboBox> 
             <asp:HiddenField runat="server" ID="hddnIds" />
             <asp:HiddenField runat="server" ID="hddnNames" />
        </td>
    </tr>
    <tr>
        <td class="controlWidth" colspan="2" style="padding-top:30px">
            <div style="width:100%;">
                <telerik:RadTreeView ID="rtvProjectExplorer" runat="server"  MultipleSelect="True" Skin="Default"  CssClass="ProjectExplorerTree WhiteTree"
                    ShowLineImages="False"   CausesValidation="False" Height="540px" Width="100%" OnClientNodeClicking="OnProjectExplorerClientNodeClicking">
                    <ExpandAnimation Duration="100" />
                    <CollapseAnimation Duration="100" Type="OutQuint" />
                </telerik:RadTreeView>
            </div>
            
        </td>
    </tr>
</table>
<asp:button ID="btnddlStatusChanged" runat="server" CssClass="Hide" />





