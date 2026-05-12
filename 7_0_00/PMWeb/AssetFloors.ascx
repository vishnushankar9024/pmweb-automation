<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetFloors.ascx.vb" Inherits="Website.AssetFloors" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
  <table style="width:100%" cellpadding="0" cellspacing="0" >
    <tr>
        <td>
            <telerik:RadGrid ID="rdgFloors" runat="server"   HeaderStyle-Font-Size="8" 
                Width="100%" AutoGenerateColumns="False" AllowPaging="true" PageSize="10" AllowSorting="true" ShowStatusBar="true" >
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="ID">
                            <ItemTemplate>
                                 <%#Container.DataItem("BuildingCode") + "-" + Container.DataItem("BuildingName")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                            
                        <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="15%" SortExpression="ID">
                            <ItemTemplate>
                                 <%#Container.DataItem("Id")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Code">
                            <ItemTemplate>
                                 <%#Container.DataItem("Code")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                        <telerik:GridTemplateColumn HeaderText="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40%" SortExpression="Name">
                            <ItemTemplate>
                                 <%#Container.DataItem("Name")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                    </Columns>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true" >
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
                    <ClientEvents OnRowClick="PropertyFloorsRowClick" />
                </ClientSettings>
            </telerik:RadGrid>
            
        </td>
    </tr>
</table>