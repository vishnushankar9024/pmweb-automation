<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProjectsLookup.aspx.vb" Inherits="Website.ProjectsLookup" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <%-- <link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
     
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
         <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <ClientEvents OnRequestStart="RequestStart" />
             <AjaxSettings>
                  <telerik:AjaxSetting AjaxControlID="rdgProjects">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
             </AjaxSettings>
             </telerik:RadAjaxManager>
         <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

    <telerik:RadGrid ID="rdgProjects" runat="server"   AllowFilteringByColumn="True"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
     AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250" ShowFooter="false"
    AllowPaging="True" ShowGroupPanel="false" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
    AllowSorting="True" GridLines="None">
            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                DataKeyNames="Id"  EnableHeaderContextMenu="true"     TableLayout="Fixed">
                 <Columns>                                    
                   <telerik:GridTemplateColumn  HeaderText="Project" SortExpression="ProjectName"  Groupable="false" AutoPostBackOnFilter="true" 
                 UniqueName="ProjectName" CurrentFilterFunction="Contains" DataField="ProjectName" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                         <asp:LinkButton ID="lbtPrjLkup" runat="server" Text='<%# Bind("ProjectName") %>' CommandName="ProjectClick" CommandArgument='<%# Bind("Id")%>' ></asp:LinkButton>
                    </ItemTemplate>
                   </telerik:GridTemplateColumn>           
                </Columns>
                </MasterTableView>
            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="false" AllowColumnsReorder="false" AllowColumnHide="false" AllowRowsDragDrop="false" AllowRowHide="false">
            </ClientSettings>
        </telerik:RadGrid>
    </form>
</body>
</html>
