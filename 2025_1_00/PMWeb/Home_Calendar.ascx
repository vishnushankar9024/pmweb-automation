<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_Calendar.ascx.vb" Inherits="Website.Home_Calendar" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
   
 <telerik:RadScheduler RowHeight="60px" ColumnWidth="104px" runat="server" ID="rscHomeCalendar" Skin="Default" Width="100%" Height="245px" DayStartTime="08:00"
 DayEndTime="08:01"  DataKeyField="ID" DataSubjectField="Subject" DataStartField="StartDate" DataEndField="EndDate" 
                    DataRecurrenceField="RecurrenceRule" DataRecurrenceParentKeyField="RecurrenceParentID"  OnClientAppointmentClick="RedirectToDocument"
                    DisplayDeleteConfirmation="true" CssClass="HomeAssignment"  AllowEdit="false" AllowDelete="false" AllowInsert="false" SelectedView="WeekView" ShowFooter="false" ShowHoursColumn="false"  >
                    <AdvancedForm Modal="true" />
     <WeekView   HeaderDateFormat="MMM-dd-yyyy" />
     <TimelineView HeaderDateFormat ="MMM-dd-yyyy" SlotDuration="2" NumberOfSlots="7"   ColumnHeaderDateFormat ="MMM-dd-yyyy"/>
 </telerik:RadScheduler>
       <asp:HiddenField ID="hdnObjectTypeId" runat="server" Value="" />
   <asp:HiddenField ID="hdnObjectId" runat="server" Value="" />
   <asp:Button ID="btnRedirectToDoc" runat="server" CssClass="Hide" Text="Redirect" />            
                


<telerik:RadCodeBlock runat="server">
    <script language="javascript" type="text/javascript">

    function pageLoad() {
        var count = 0;
        var rscHomeCalendar = $find('<%=rscHomeCalendar.ClientId%>');
        if ((rscHomeCalendar.get_selectedView() == '<%=Telerik.Web.UI.SchedulerViewType.MonthView%>') || (rscHomeCalendar.get_selectedView() == '<%=Telerik.Web.UI.SchedulerViewType.TimelineView%>')) {
            $('.rsContentWrapper').show();
            $('.rsContentWrapper').height(190);
            $('.rsContentScrollArea').height(190);
        }
        else
            $('.rsContentWrapper').hide();

        var Rows = document.getElementsByTagName('Div');
        for (var i = 0; i < Rows.length; i++) {
            if (Rows[i].className == "rsInnerFix") {
                if (rscHomeCalendar.get_selectedView() == '<%=Telerik.Web.UI.SchedulerViewType.WeekView%>') {
                    if (count == 1) {
                        Rows[i].style.overflow = 'auto';
                        Rows[i].style.height = '190px';
                    }
                    Rows[i].style.marginRight = "0px";
                    count++;
                }
                else if (rscHomeCalendar.get_selectedView() == '<%=Telerik.Web.UI.SchedulerViewType.DayView%>') {
                    Rows[i].style.overflow = 'auto';
                    Rows[i].style.height = '215px';
                    Rows[i].style.marginRight = "0px";
                }
                 
            }
        }
    }

    function RedirectToDocument(sender, eventArgs) {
        var appointment = eventArgs.get_appointment();
        appointment.set_allowEdit(false)
        var ObjectTypeId = appointment.get_attributes()._data.ObjectTypeId;
        var ObjectId = appointment.get_attributes()._data.ObjectId;
        $("input[id$=ObjectTypeId]").val(ObjectTypeId);
        $("input[id$=ObjectId]").val(ObjectId);
        $("input[id$=btnRedirectToDoc]").click();
        
    }
</script>
   <style type="text/css" >
       .HomeAssignment .rsAptContent{width:93%!important;cursor: pointer;height:56px;background-color: #f7f4f4  !important;border:1px solid #949494 !important;}
       .RadScheduler .rsTopWrap {overflow:visible !important;}
       .HomeAssignment .rsAptIn{width:100% !important;border:0 !important}
       .HomeAssignment .rsAptMid{width:100% !important;border:0 !important}
       .HomeAssignment .rsApt{margin-top:3px !important;}
       .HomeAssignment .rsSelectedSlot{background-color:inherit !important}
       .HomeAssignment .rsAptCreate{background-image:none !important}
       .HomeAssignment .rsAptCreate{background-color:inherit!important}
       .HomeAssignment .rsDayView .rsAptContent {width: 99% !important;}
   </style>
</telerik:RadCodeBlock>

