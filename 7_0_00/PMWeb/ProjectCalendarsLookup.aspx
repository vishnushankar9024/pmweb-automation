<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCalendarsLookup.aspx.vb" Inherits="Website.ProjectCalendarsLookup"  meta:resourcekey="Page" Title="Select a Calendar"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
    <table style="width: 100%; background-color:White" >
        <tr>
            <td colspan="4">
    <telerik:RadGrid ID="rdgCalendars" runat="server" Skin="Default" HeaderStyle-Font-Size="8"
    Width="99%" AutoGenerateColumns="False" ShowHeader="true">
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Value">
         <Columns>                                    
           <telerik:GridTemplateColumn HeaderText="Calendars" UniqueName="Calendars">
            <ItemTemplate>
                 <asp:LinkButton ID="lbtCalendar" runat="server" Text='<%# Bind("Value") %>' CommandName="CalendarClick" CommandArgument='<%# Bind("Key")%>' ></asp:LinkButton>
            </ItemTemplate>
           </telerik:GridTemplateColumn>           
        </Columns>
        </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true">
    </ClientSettings>
</telerik:RadGrid>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
