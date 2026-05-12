<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DispatchBoard.aspx.vb" Inherits="Website.DispatchBoard1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
        /* .rsToday
        {display: block;
float: left;
text-indent: 47px;
margin-top: 0px;
position: absolute;
        }
        .RadScheduler .rsHeader .rsDatePickerActivator
        {margin-left:45px; 
        }*/
        .RadScheduler .rsTopWrap {
            z-index: 2;
        }
        #ctl00_CPH1_rdsSchedule_SelectedDateCalendar{
            z-index:2
        }
    </style>
   <%-- <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy134" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgWorkOrders">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgWorkOrders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdsSchedule">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgWorkOrders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdsSchedule" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>

    <telerik:RadAjaxLoadingPanel ID="ldpDispatchBoard" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var Resource = -1;
            function Mov(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();
                appointment.set_allowEdit(true)


            }

            function disableAJAX(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();
                appointment.set_allowEdit(false)
                window.location = "WorkOrders.aspx?Id=" + appointment.get_attributes()._data.WorkOrderId;

            }

            function rowDropping(sender, eventArgs) {
                // Fired when the user drops a grid row
                var htmlElement = eventArgs.get_destinationHtmlElement();
                var scheduler = $find('<%= rdsSchedule.ClientID%>');

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
            //function onNodeDropping(sender,args) {
            //if (droppedOnTarget(args)) {
            //    var tree = $find(trvWorkers.ClientID %>");
            //      var node = tree.get_selectedNode();
            //      if (node) {
            //          document.getElementById(hfSlot.ClientID %>").value = document.getElementById( hfSlot.ClientID %>").value + ";;" + node.get_value()
            //          document.getElementById(hfNodeValue.ClientID %>").value = node.get_value()
            //          if (Resource > 1) {
            //              node.set_imageUrl("Images/Global/file.png")
            //          }
            //          Resource = -1;
            //      }
            //
            //      var updatepanel = $find( RadAjaxPanel1.ClientID %>')
            //      __doPostBack( RadAjaxPanel1.ClientID %>');        
            //  }
            // 
            // }

            //function droppedOnTarget(args) {
            //var htmlElement = args.get_htmlElement();
            //var scheduler = $find( rdsSchedule.ClientID );

            //while (htmlElement) {
            //if (isPartOfSchedulerAppointmentArea(htmlElement)) {
            //args.set_htmlElement(htmlElement);
            //var timeSlot = scheduler._activeModel.getTimeSlotFromDomElement(htmlElement);
            //document.getElementById( hfSlot.ClientID ).value = timeSlot.get_index();
            //args.set_htmlElement( hfSlot.ClientID);
            //Resource = timeSlot.get_resource()._key
            //return true
            //}
            //htmlElement = htmlElement.parentNode;
            //}
            //args.set_cancel(true);
            //}

            function isPartOfSchedulerAppointmentArea(htmlElement) {
                return $telerik.$(htmlElement).parents().is("div.rsAllDay") ||
                        $telerik.$(htmlElement).parents().is("div.rsContent")
            }

            function GMapsClicked() {
                var scheduler = $find('<%= rdsSchedule.ClientID %>');
                var ToDate, FromDate;
                var FromDate = scheduler.get_firstDayStart();
                FromDate.setUTCDate(FromDate.getDate());
                FromDate = FromDate.getTime();
                FromDate = FromDate; //+ (3600000 * 24);
                if (scheduler.get_selectedView() == 0) {
                    ToDate = FromDate;
                }
                if (scheduler.get_selectedView() == 1) {
                    ToDate = FromDate + (3600000 * 24) * 6;
                }
                if (scheduler.get_selectedView() == 2) {
                    ToDate = FromDate + (3600000 * 24) * 31;
                }
                if (scheduler.get_selectedView() == 4) {
                    ToDate = FromDate + (3600000 * 24) * 2;
                }
                OpenPOPUp('WorkOrdersMapViewPopup.aspx?FromDate=' + FromDate + '&ToDate=' + ToDate, 520, 430, false);
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolBar">
        <tr>
            <td class="ToolbarTd">
                <asp:Label meta:resourceKey="lblBoardName" ID="lblBoardName" runat="server" Text="Board"></asp:Label>
            </td>
            <td class="ToolbarTd">
                <asp:LinkButton ID="btnGMaps" runat="server" CausesValidation="False" CssClass="CmdGMapsButton" OnClientClick="return GMapsClicked()">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlBoards" runat="server"
                    Skin="Default" Width="240px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="400px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" DropDownWidth="320px"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td></td>
        </tr>
    </table>

    <div class="PMMainPage documentSinglePage">
        <div class="row">
            <div class="col-12">
                <div style="overflow: auto; width: 100% !important;">
                    <telerik:RadScheduler ID="rdsSchedule" Skin="Default" AllowInsert="false" GroupBy="User" Height="100%" EnableAdvancedForm="true" Width="100%"
                        DataKeyField="ID" DataStartField="Start" DataEndField="End" DataSubjectField="Notes" DisplayRecurrenceActionDialogOnMove="true"
                        OnAppointmentCreated="rdsSchedule_AppointmentCreated" DayStartTime="00:00:00" DayEndTime="00:00:00" OnClientAppointmentDoubleClick="disableAJAX" OnClientAppointmentClick="Mov"
                        runat="server">
                        <%--<ResourceHeaderTemplate>
                                    <table>
                                    <tr>
                                    <td>
                                    <asp:Image runat="server" ID="imgResImage" Width="50px" ImageUrl="" />
                                    </td>
                                    <td>
                                    <%# Eval("Text")%>
                    
                                    </td>
                    
                                    </tr>
                                    </table>
                    
                                    </ResourceHeaderTemplate>--%>
                        <ResourceTypes>
                            <telerik:ResourceType ForeignKeyField="UserID" KeyField="UserID" Name="User" TextField="Name" />
                        </ResourceTypes>

                    </telerik:RadScheduler>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <telerik:RadGrid ID="rdgWorkOrders" runat="server"
                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                    ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
                    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                        EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="RecordNumber"
                                SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="RecordNumber">
                                <ItemTemplate>
                                    <span>
                                        <asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                            Text='<%#Eval("RecordNumber").ToString%>'></asp:HyperLink></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location"
                                SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Location">
                                <ItemTemplate>
                                    <span>
                                        <asp:HyperLink ID="hliLocation" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                            Text='<%#Eval("Location").ToString%>'></asp:HyperLink></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project"
                                SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Project">
                                <ItemTemplate>
                                    <span>
                                        <asp:HyperLink ID="hliProject" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                            Text='<%#Eval("Project").ToString%>'></asp:HyperLink>
                                    </span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Work Request" UniqueName="TenantRequest"
                                SortExpression="TenantRequest" GroupByExpression="TenantRequest [GridColumn_TenantRequest] Group By TenantRequest ASC"
                                Groupable="true" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="TenantRequest">
                                <ItemTemplate>
                                    <span>
                                        <asp:HyperLink ID="hliWorkRequest" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                            Text='<%#Eval("TenantRequest").ToString%>'></asp:HyperLink>
                                    </span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="left" UniqueName="Description"
                                HeaderStyle-Width="190px" SortExpression="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description"
                                GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-HorizontalAlign="left" UniqueName="Type"
                                HeaderStyle-Width="190px" SortExpression="Type" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Type"
                                GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Category" HeaderStyle-HorizontalAlign="left" UniqueName="Category"
                                HeaderStyle-Width="190px" SortExpression="Category" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Category"
                                GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Priority" HeaderStyle-HorizontalAlign="left" UniqueName="Priority"
                                HeaderStyle-Width="190px" SortExpression="Priority" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Priority"
                                GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Priority").ToString = String.Empty, "&nbsp;", Container.DataItem("Priority"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location Type" HeaderStyle-HorizontalAlign="left" UniqueName="LocationType"
                                HeaderStyle-Width="190px" SortExpression="LocationType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LocationType"
                                GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("LocationType").ToString = String.Empty, "&nbsp;", Container.DataItem("LocationType"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="EstimatedHours" HeaderText="Estimated Hours" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="80px" SortExpression="EstimatedHours" GroupByExpression="EstimatedHours [GridColumn_EstimatedHours] Group By EstimatedHours ASC"
                                Reorderable="true" Groupable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="EstimatedHours">
                                <ItemTemplate>
                                    <span><%#FormatNumber(Eval("EstimatedHours"))%> </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="DispatchedHours" HeaderText="Dispatched Hours" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="80px" SortExpression="DispatchedHours" GroupByExpression="DispatchedHours [GridColumn_DispatchedHours] Group By DispatchedHours ASC"
                                Reorderable="true" Groupable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="DispatchedHours">
                                <ItemTemplate>
                                    <span><%#FormatNumber(Eval("DispatchedHours")) %> </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="ActualHours" HeaderText="Actual Hours" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="80px" SortExpression="ActualHours" GroupByExpression="ActualHours [GridColumn_ActualHours] Group By ActualHours ASC"
                                Reorderable="true" Groupable="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="ActualHours">
                                <ItemTemplate>
                                    <span><%#FormatNumber(Eval("ActualHours")) %> </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Approximate Duration" HeaderStyle-HorizontalAlign="left" UniqueName="ApproximateDuration"
                                HeaderStyle-Width="190px" SortExpression="ApproximateDuration" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ApproximateDuration"
                                GroupByExpression="ApproximateDuration [GridColumn_ApproximateDuration] Group By ApproximateDuration ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("ApproximateDuration").ToString = String.Empty, "&nbsp;", Container.DataItem("ApproximateDuration"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Workflow Status" HeaderStyle-HorizontalAlign="left" UniqueName="WorkflowStatus"
                                HeaderStyle-Width="190px" SortExpression="WorkflowStatus" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="WorkflowStatus"
                                GroupByExpression="WorkflowStatus [GridColumn_WorkflowStatus] Group By WorkflowStatus ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("WorkflowStatus").ToString = String.Empty, "&nbsp;", Container.DataItem("WorkflowStatus"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Progress" HeaderStyle-HorizontalAlign="left" UniqueName="Progress"
                                HeaderStyle-Width="190px" SortExpression="Progress" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Progress"
                                GroupByExpression="Progress [GridColumn_Progress] Group By Progress ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Progress").ToString = String.Empty, "&nbsp;", Container.DataItem("Progress"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Submitted By" HeaderStyle-HorizontalAlign="left" UniqueName="SubmittedBy"
                                HeaderStyle-Width="190px" SortExpression="SubmittedBy" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="SubmittedBy"
                                GroupByExpression="SubmittedBy [GridColumn_SubmittedBy] Group By SubmittedBy ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("SubmittedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("SubmittedBy"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Contact Name" HeaderStyle-HorizontalAlign="left" UniqueName="ContactName"
                                HeaderStyle-Width="190px" SortExpression="ContactName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ContactName"
                                GroupByExpression="ContactName [GridColumn_ContactName] Group By ContactName ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("ContactName").ToString = String.Empty, "&nbsp;", Container.DataItem("ContactName"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Closed" HeaderStyle-HorizontalAlign="left" UniqueName="Closed"
                                HeaderStyle-Width="190px" SortExpression="Closed" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Closed"
                                GroupByExpression="Closed [GridColumn_Closed] Group By Closed ASC">
                                <ItemTemplate>
                                    <img src='Images/Global/<%# CStr(IIf(Eval("Closed"), "checked.png", "unchecked.png")) %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="WBS" HeaderStyle-HorizontalAlign="left" UniqueName="WBS"
                                HeaderStyle-Width="190px" SortExpression="WBS" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="WBS"
                                GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("WBS").ToString = String.Empty, "&nbsp;", Container.DataItem("WBS"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Maintenance Contract" HeaderStyle-HorizontalAlign="left" UniqueName="MaintenanceContract"
                                HeaderStyle-Width="190px" SortExpression="MaintenanceContract" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="MaintenanceContract"
                                GroupByExpression="MaintenanceContract [GridColumn_MaintenanceContract] Group By MaintenanceContract ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("MaintenanceContract").ToString = String.Empty, "&nbsp;", Container.DataItem("MaintenanceContract"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Cell" HeaderStyle-HorizontalAlign="left" UniqueName="Cell"
                                HeaderStyle-Width="190px" SortExpression="Cell" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Cell"
                                GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Cell").ToString = String.Empty, "&nbsp;", Container.DataItem("Cell"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Revision" HeaderStyle-HorizontalAlign="left" UniqueName="Revision"
                                HeaderStyle-Width="190px" SortExpression="Revision" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="Revision"
                                GroupByExpression="Revision [GridColumn_Revision] Group By Revision ASC">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("Revision")%>&nbsp; </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Reported Date" HeaderStyle-HorizontalAlign="left" UniqueName="ReportedDate"
                                HeaderStyle-Width="190px" SortExpression="ReportedDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="ReportedDate"
                                GroupByExpression="ReportedDate [GridColumn_ReportedDate] Group By ReportedDate ASC" DataType="System.DateTime">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatDate(Container.DataItem("ReportedDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Email" HeaderStyle-HorizontalAlign="left" UniqueName="Email"
                                HeaderStyle-Width="190px" SortExpression="Email" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Email"
                                GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Phone (Night)" HeaderStyle-HorizontalAlign="left" UniqueName="NightPhone"
                                HeaderStyle-Width="190px" SortExpression="NightPhone" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="NightPhone"
                                GroupByExpression="NightPhone [GridColumn_NightPhone] Group By NightPhone ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("NightPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("NightPhone"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Phone (Night) Ext." HeaderStyle-HorizontalAlign="left" UniqueName="NightPhoneExt"
                                HeaderStyle-Width="190px" SortExpression="NightPhoneExt" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="NightPhoneExt"
                                GroupByExpression="NightPhoneExt [GridColumn_NightPhoneExt] Group By NightPhoneExt ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("NightPhoneExt").ToString = String.Empty, "&nbsp;", Container.DataItem("NightPhoneExt"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Created By" HeaderStyle-HorizontalAlign="left" UniqueName="CreatedBy"
                                HeaderStyle-Width="190px" SortExpression="CreatedBy" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CreatedBy"
                                GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CreatedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("CreatedBy"))%> </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Create Date" HeaderStyle-HorizontalAlign="left" UniqueName="CreateDate"
                                HeaderStyle-Width="190px" SortExpression="CreateDate" CurrentFilterFunction="EqualTo" DataType="System.DateTime" FilterListOptions="VaryByDataType" DataField="CreateDate"
                                GroupByExpression="CreateDate [GridColumn_CreateDate] Group By CreateDate ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatDate(Container.DataItem("CreateDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="right" />
                        <CommandItemTemplate>
                            <div style="padding: 2px; height: 30px;">
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                    Visible='<%# rdgWorkOrders.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton><span style="width: 100%; text-align: right">
                                    <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkUnderDispatched_OnChekedChanged" ID="chkUnderDispatched" Text="Under-dispatched Only" meta:resourcekey="chkUnderDispatched" SecurityButtonType="ItemMode_Edit" />
                                </span>
                                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                    EnableShadows="true" CausesValidation="false"
                                    Visible="true">
                                </telerik:RadMenu>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true"></Scrolling>
                        <ClientEvents OnRowDropping="rowDropping" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfSlot" runat="server" />

</asp:Content>
