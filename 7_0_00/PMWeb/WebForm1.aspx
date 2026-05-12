<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebForm1.aspx.vb" Inherits="Website.WebForm1" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
<%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>

</head>

<body>    
    <form id="form1" runat="server">
   
    <telerik:RadScheduler ID="rdsSchedule" Skin="Default" AllowInsert="False" GroupBy="User"
        Height="600px" DataKeyField="ID" DataStartField="Start"
        DataEndField="End" DataSubjectField="Notes" DisplayRecurrenceActionDialogOnMove="True"
        OnAppointmentCreated="rdsSchedule_AppointmentCreated" DayStartTime="00:00:00"
        DayEndTime="23:00:00" OnClientAppointmentDoubleClick="disableAJAX" OnClientAppointmentClick="Mov"
        runat="server" HoursPanelTimeFormat="htt" 
        meta:resourcekey="rdsScheduleResource1" ValidationGroup="rdsSchedule">
        <ResourceTypes>
            <telerik:ResourceType ForeignKeyField="UserID" KeyField="UserID" Name="User" TextField="Name" />
        </ResourceTypes>

<Localization AdvancedAllDayEvent="All day"></Localization>

<AdvancedForm DateFormat="M/d/yyyy" TimeFormat="h:mm tt"></AdvancedForm>
    </telerik:RadScheduler>  
    </form>
 
</body>
</html>

