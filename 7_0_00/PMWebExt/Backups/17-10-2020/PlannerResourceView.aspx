<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PlannerResourceView.aspx.vb" Inherits="Website.PlannerResourceView" %>

 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 



<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <style type="text/css" >
        /*.rsVerticalHeaderTable tr.rsMainHeader, .rsContentTable tr.rsAllDayRow {
            display:table-row !important;
            height:100px !important;
       }
        .rsVerticalHeaderTable tr,.rsContentTable tr {
           display:none !important ;
           height:0 
        }*/

       .rsTimelineView .rsAllDayRow {
            background:#fff !important;
        }
   </style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy134" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRequirements">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRequirements" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="rdsPlanner"  LoadingPanelID="ldpPM"/>
            </UpdatedControls>
         </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rdsPlanner">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRequirements" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="rdsPlanner" LoadingPanelID="ldpPM" />
            </UpdatedControls>
         </telerik:AjaxSetting>
    </AjaxSettings>
   </telerik:RadAjaxManagerProxy>
 
<telerik:RadAjaxLoadingPanel ID="ldpPlanner" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var Resource = -1;
            function Mov(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();
                appointment.set_allowEdit(true)


            }

            function rowDropping(sender, eventArgs) {
                // Fired when the user drops a grid row
                var htmlElement = eventArgs.get_destinationHtmlElement();
                var scheduler = $find('<%= rdsPlanner.ClientID%>');

                if (isPartOfSchedulerAppointmentArea(htmlElement)) {
                    // The row was dropped over the scheduler appointment area
                    // Find the exact time slot and save its unique index in the hidden field
                    var timeSlot = scheduler._activeModel.getTimeSlotFromDomElement(htmlElement);

                    document.getElementById("<%= hfSlot.ClientID%>").value = timeSlot.get_index();

                    // The HTML needs to be set in order for the postback to execute normally
                    eventArgs.set_destinationHtmlElement("TargetSlotHiddenField");
                }
                else {
                    // The node was dropped elsewhere on the document
                    eventArgs.set_cancel(true);
                }
            }

            function isPartOfSchedulerAppointmentArea(htmlElement) {
                return $telerik.$(htmlElement).parents().is("div.rsAllDay") ||
                        $telerik.$(htmlElement).parents().is("div.rsContent")
            }


        </script>
</telerik:RadCodeBlock>


    <table width="100%"  cellpadding="0" cellspacing="0">
        <tr>
            <td> 
                <telerik:RadScheduler ID="rdsPlanner" Skin="Default" AllowInsert="false" GroupBy="User" Height="100%" EnableAdvancedForm="true" Width="1500px"
                    DataKeyField="ID" DataStartField="Start" DataEndField="End" DataSubjectField="Notes" DisplayRecurrenceActionDialogOnMove="true" RowHeight="60px"
                    DayStartTime="00:00:00" DayEndTime="00:00:00" OnClientAppointmentClick="Mov" WeekView-GroupingDirection="Vertical" WeekView-DayStartTime="00:00:00" WeekView-DayEndTime="00:00:00"
                    TimelineView-GroupingDirection="Vertical" TimelineView-NumberOfSlots="7" TimelineView-TimeLabelSpan="1" TimelineView-SlotDuration="7.00:00:00"
                    runat="server">
                    <ResourceHeaderTemplate>
                        <table>
                            <tr>
                                <td align="left">
                                    <asp:Image runat="server" ID="imgResImage" Width="50px" ImageUrl="~/Images/Global/ButtonLogout.png" />
                                </td>
                                <td align="left">
                                    <%# Eval("Text")%>
                    
                                </td>

                            </tr>
                        </table>

                    </ResourceHeaderTemplate>
                    <ResourceTypes>
                        <telerik:ResourceType ForeignKeyField="UserID" KeyField="UserID" Name="User" TextField="Name" />
                    </ResourceTypes>

                </telerik:RadScheduler>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rdgRequirements" runat="server" 
                     AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                    ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
                    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                        EditMode="InPlace" EnableHeaderContextMenu="true" >
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Requirement ID*" UniqueName="RecordNumber"
                                SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC"
                                Groupable="true" Reorderable="true"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="RecordNumber">
                                <ItemTemplate>
                                    <span><asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                            Text='<%#Eval("RecordNumber").ToString%>'></asp:HyperLink></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Classification" UniqueName="Classification"
                                SortExpression="Classification" GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Classification">
                                <ItemTemplate>
                                     &nbsp;<span><%#Container.DataItem("Classification")%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                                SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description">
                                <ItemTemplate>
                                     <span><%#Container.DataItem("Description")%> </span>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="200px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Start" UniqueName="Start"
                                SortExpression="Start" GroupByExpression="Start [GridColumn_Start] Group By Start ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Start">
                                <ItemTemplate>
                                     <span><%#FormatDate(Container.DataItem("Start"))%> </span>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="Finish"
                                SortExpression="Finish" GroupByExpression="Finish [GridColumn_Finish] Group By Finish ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Finish">
                                <ItemTemplate>
                                     <span><%#FormatDate(Container.DataItem("Finish"))%> </span>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Hours" UniqueName="Hours"
                                SortExpression="Hours" GroupByExpression="Hours [GridColumn_Hours] Group By Hours ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Hours">
                                <ItemTemplate>
                                     <span><%#FormatNumber(Container.DataItem("Assigned"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Assigned" UniqueName="Assigned"
                                SortExpression="Assigned" GroupByExpression="Assigned [GridColumn_Assigned] Group By Assigned ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Assigned">
                                <ItemTemplate>
                                     <span><%#FormatNumber(Container.DataItem("Assigned"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="% Assigned" UniqueName="PctAssigned"
                                SortExpression="PctAssigned" GroupByExpression="PctAssigned [GridColumn_PctAssigned] Group By PctAssigned ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="PctAssigned">
                                <ItemTemplate>
                                     <span><%#FormatPercent(Container.DataItem("PctAssigned"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Remaining" UniqueName="Remaining"
                                SortExpression="Remaining" GroupByExpression="Remaining [GridColumn_Remaining] Group By Remaining ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Remaining">
                                <ItemTemplate>
                                     <span><%#FormatNumber(Container.DataItem("Remaining"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="% Remaining" UniqueName="PctRemaining"
                                SortExpression="PctRemaining" GroupByExpression="PctRemaining [GridColumn_PctRemaining] Group By PctRemaining ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="PctRemaining">
                                <ItemTemplate>
                                     <span><%#FormatPercent(Container.DataItem("PctRemaining"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Skills" UniqueName="Skills"
                                SortExpression="Skills" GroupByExpression="Skills [GridColumn_Skills] Group By Skills ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Skills">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Skills").ToString = String.Empty, "&nbsp;", Container.DataItem("Skills"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Based On*" UniqueName="BasedOn"
                                SortExpression="BasedOn" GroupByExpression="BasedOn [GridColumn_BasedOn] Group By BasedOn ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="BasedOn">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("BasedOn").ToString = String.Empty, "&nbsp;", Container.DataItem("BasedOn"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Program*" UniqueName="Program"
                                SortExpression="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Program">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Program").ToString = String.Empty, "&nbsp;", Container.DataItem("Program"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location"
                                SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Location">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project"
                                SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Project">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Project").ToString = String.Empty, "&nbsp;", Container.DataItem("Project"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Linked To" UniqueName="LinkedTo"
                                SortExpression="LinkedTo" GroupByExpression="LinkedTo [GridColumn_LinkedTo] Group By LinkedTo ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LinkedTo">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("LinkedTo").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedTo"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Link Type" UniqueName="LinkType"
                                SortExpression="LinkType" GroupByExpression="LinkType [GridColumn_LinkType] Group By LinkType ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LinkType">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("LinkType").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkType"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode"
                                SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CostCode">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("CostCode").ToString = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Hours per Day" UniqueName="HoursPerDay"
                                SortExpression="HoursPerDay" GroupByExpression="HoursPerDay [GridColumn_HoursPerDay] Group By HoursPerDay ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="HoursPerDay">
                                <ItemTemplate>
                                     <span><%#FormatNumber(Container.DataItem("HoursPerDay"))%> </span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Default Start Time" UniqueName="DefaultStartTime"
                                SortExpression="DefaultStartTime" GroupByExpression="DefaultStartTime [GridColumn_DefaultStartTime] Group By DefaultStartTime ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="DefaultStartTime">
                                <ItemTemplate>
                                      <span><%#CultureFormatTime(Eval("DefaultStartTime"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Default End Time" UniqueName="DefaultEndTime"
                                SortExpression="DefaultEndTime" GroupByExpression="DefaultEndTime [GridColumn_DefaultEndTime] Group By DefaultEndTime ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="DefaultEndTime">
                                <ItemTemplate>
                                      <span><%#CultureFormatTime(Eval("DefaultEndTime"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>    
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="right" />
                        <CommandItemTemplate>
                            <div style="padding: 2px; height: 30px;">
                                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                       meta:resourcekey="btnRefreshResource1">
                                       <span class="Icon"></span>
                                       <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                       &nbsp;&nbsp;
                                   </asp:LinkButton>
                                  <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                     CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                                     runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                                     EnableShadows="true" CausesValidation="false"
                                     Visible="true">                                 
                                 </telerik:RadMenu> 
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="true"  AllowColumnsReorder="true" AllowDragToGroup="true"  AllowRowsDragDrop="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <Selecting AllowRowSelect="true"/>  
                    <Scrolling AllowScroll="true" UseStaticHeaders="true"></Scrolling>
                    <ClientEvents OnRowDropping="rowDropping"/>
                    </ClientSettings>
                </telerik:RadGrid> 
            </td>
        </tr>
    </table>       
  <asp:HiddenField ID="hfSlot" runat="server" />
</asp:Content>