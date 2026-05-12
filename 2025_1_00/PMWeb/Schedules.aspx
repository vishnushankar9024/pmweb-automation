<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Schedules.aspx.vb" Inherits="Website.Schedules"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <link href="CSS/TimeLineScheduler.css" rel="stylesheet" type="text/css" />
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
   <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnDay">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnWeek">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnMonth">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnQuarter">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnYear">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
   </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadScriptBlock ID="scriptBlock1" runat="server">
    <script type="text/javascript">
            
        function Redirect(sender, eventArgs)
        {
            alert(eventArgs.get_appointment().get_subject());
        }
        
        function onRowSelected(sender, args)
        {
            $find("<%= ddlProjectStatuses.ClientID %>").set_text("");
            //$find("<%= ddlProjectStatuses.ClientID %>").showDropDown();
        }
        
        function OnDDLLoad(sender, args)
        {
            $find("<%= ddlProjectStatuses.ClientID %>").set_text("");
            //alert( $find("<%= ddlProjectStatuses.ClientID %>").get_text());
            //$find("<%= ddlProjectStatuses.ClientID %>").showDropDown();
        }

    </script>
</telerik:RadScriptBlock>

    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" style="height:20px;"></td>
        </tr>
        <tr>
            <td style="" >
                <asp:RadioButtonList ID="rblChart" runat="server" RepeatLayout="Table" 
                        RepeatColumns="1" RepeatDirection="Horizontal" CssClass="RadioCss RadioPadding">
                    <asp:ListItem Selected="True" Text="Gant Chart" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Calendar" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td align="left">
                <asp:Button ID="btnDay" runat="server" Text="Day" CssClass="ScheduleButton" />
                <asp:Button ID="btnWeek" runat="server" Text="Week" CssClass="ScheduleButton"/>
                <asp:Button ID="btnMonth" runat="server" Text="Month" CssClass="ScheduleButton"/>
                <asp:Button ID="btnQuarter" runat="server" Text="Quarter" CssClass="ScheduleButton"/>
                <asp:Button ID="btnYear" runat="server" Text="Year" CssClass="ScheduleButton"/>
            </td>
            <td align="right" style="padding-right:10px;">
                  <asp:Label ID="Label1" runat="server" Text="Project Status" style="margin-right:5px;" ></asp:Label>             
                 <%--<telerik:RadComboBox ID="ddl1" runat="server" Width="210px" DropDownWidth="210px"
                    ShowToggleImage="True" ShowDropDownOnTextboxClick="false" Text="" AutoCompleteSeparator=";" MarkFirstMatch="false" 
                        Skin="Default" CloseDropDownOnBlur="true">
                    <ItemTemplate>
                        <div id="div3">
                            <asp:ListBox ID="lstStatuses1" runat="server" SelectionMode="Multiple" Width="210px" Height="90px" style="overflow:hidden;border:1px transparent none; outline:0;">
                                <asp:ListItem Selected="true" Text="In Negotiation" Value="1" />
                                <asp:ListItem Selected="false" Text="Signed" Value="2" />
                                <asp:ListItem Selected="false" Text="Rejected" Value="3" />
                                <asp:ListItem Selected="false" Text="Construction" Value="4" />
                                <asp:ListItem Selected="false" Text="Completed" Value="5" /> 
                                 
                            </asp:ListBox>
                        </div>
                    </ItemTemplate>
                    <Items>
                        <telerik:RadComboBoxItem Selected="True"></telerik:RadComboBoxItem>
                    </Items>
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>--%>
                
                 <%--<telerik:RadComboBox ID="ddlProjectStatuses" runat="server" Width="210px" DropDownWidth="210px"
                    ShowToggleImage="True" ShowDropDownOnTextboxClick="true" Text="" 
                        Skin="Default" CloseDropDownOnBlur="true" >
                    <ItemTemplate>
                        <div id="div3">
                            <telerik:RadGrid runat="server" ID="rdgProjectStatuses" ShowFooter="false" Skin="Default" 
                                ShowHeader="false" ShowGroupPanel="false" ShowStatusBar="false"
                                AutoGenerateColumns="false" AllowMultiRowSelection="true" GridLines="None">
                                <MasterTableView ClientDataKeyNames="ProjectStatusId" GridLines="None">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="ProjectStatus" ItemStyle-BorderStyle="None">
                                        </telerik:GridBoundColumn>                                        
                                    </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <ClientEvents OnRowSelected="onRowSelected" OnRowClick="onRowSelected" />
                                </ClientSettings>
                            </telerik:RadGrid>                           
                        </div>
                    </ItemTemplate>
                    
                    <Items>
                        <telerik:RadComboBoxItem Selected="True"></telerik:RadComboBoxItem>
                    </Items>--%>
                    <%--<CollapseAnimation Type="OutQuint" Duration="50"></CollapseAnimation>--%>
                <%--</telerik:RadComboBox>--%>
                <telerik:RadComboBox ID="ddlProjectStatuses" runat="server" Width="100px" DropDownWidth="100px"
                    ShowToggleImage="True" ShowDropDownOnTextboxClick="true" Text="" 
                        Skin="Default" CloseDropDownOnBlur="true" >                    
                    <Items>                        
                        <telerik:RadComboBoxItem Selected="True" Text="In Negotiation" Value="1" />
                        <telerik:RadComboBoxItem Selected="False" Text="Signed" Value="2" />
                        <telerik:RadComboBoxItem Selected="False" Text="Rejected" Value="3" />
                        <telerik:RadComboBoxItem Selected="False" Text="Construction" Value="4" />
                        <telerik:RadComboBoxItem Selected="False" Text="Completed" Value="5" /> 
                    </Items>
                    <CollapseAnimation Type="OutQuint" Duration="50"></CollapseAnimation>
                </telerik:RadComboBox>
                

            </td>
        </tr>
        <tr>
            <td colspan="3" style="height:20px;"></td>
        </tr>
        <tr>
            <td colspan="3">
                 <telerik:RadScheduler ID="rdsSchedule" Skin="Default" Width="99%" Height="600px"
                    DataKeyField="Id" DataStartField="ProjectStart" DataEndField="ProjectEnd" DataSubjectField="Subject"
                    GroupBy="Project" GroupingDirection="Vertical" SelectedView="TimelineView" DayStartTime="00:00:00" DayEndTime="23:59:59" 
                    AllowDelete="false" AllowEdit="true" AllowInsert="false" CustomAttributeNames="ProjectStart"
                    runat="server"  ShowHeader="true" EnableAjaxSkinRendering="true" OverflowBehavior="Scroll"
                    OnClientAppointmentClick="Redirect" TimeLabelRowSpan="1"  >
                    <TimelineView NumberOfSlots="12" SlotDuration="31" HeaderDateFormat="MMM" ShowDateHeaders="true"  />
                    
                    <ResourceTypes>   
                        <telerik:ResourceType ForeignKeyField="Id" KeyField="Id" Name="Project" TextField="ProjectName" />   
                        <telerik:ResourceType ForeignKeyField="Id" KeyField="Id" Name="ProjectSchedule1" TextField="ProjectStart" />    
                        <telerik:ResourceType ForeignKeyField="Id" KeyField="Id" Name="ProjectSchedule2" TextField="ProjectEnd" /> 
                    </ResourceTypes>
                    <%--<AppointmentTemplate>
                        <div style="white-space:normal; white-space:nowrap; font-size:smaller;">
                           <%# Eval("Subject") %>
                        </div>
                    </AppointmentTemplate>--%>

                </telerik:RadScheduler>
                <%--<asp:Panel ID="pnlSchedule" runat="server">
                    
                </asp:Panel>--%>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxLoadingPanel ID="ldpSchedule" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>


</asp:Content>
