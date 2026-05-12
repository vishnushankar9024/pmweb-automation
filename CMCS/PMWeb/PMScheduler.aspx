<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PMScheduler.aspx.vb" Inherits="Website.PMScheduler" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
        .RadScheduler .rsAptContent,
        .RadScheduler .rsAptIn,
        .RadScheduler .rsAptMid,
        .RadScheduler .rsAptOut {
            background-image: none !important;
        }

        div.RadScheduler .rsAptContent,
        div.RadScheduler .rsAptIn,
        div.RadScheduler .rsAptMid,
        div.RadScheduler .rsAptOut {
            background: none;
            margin: 0;
            padding: 0;
            right: auto;
            bottom: auto;
        }

        div.RadScheduler .rsAptOut {
            padding-bottom: 0px;
        }

        div.RadScheduler .rsAptMid {
            border: 1px solid gray;
            padding-bottom: 0px;
        }

        div.RadScheduler .rsWrap {
            z-index: auto !important;
        }
        @media screen and (min-width: 320px) and (max-width: 843px) {
         /*  .divContentHolder {
               margin-top: 60px !important;
              
           }*/
        }          
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function rowDropping(sender, eventArgs) {
                // Fired when the user drops a grid row
                var htmlElement = eventArgs.get_destinationHtmlElement();
                var scheduler = $find('<%= RadScheduler1.ClientID %>');

                if (isPartOfSchedulerAppointmentArea(htmlElement)) {
                    // The row was dropped over the scheduler appointment area
                    // Find the exact time slot and save its unique index in the hidden field
                    var timeSlot = scheduler._activeModel.getTimeSlotFromDomElement(htmlElement);

                    document.getElementById("<%= TargetSlotHiddenField.ClientID %>").value = timeSlot.get_index();

                    // The HTML needs to be set in order for the postback to execute normally
                    eventArgs.set_destinationHtmlElement("TargetSlotHiddenField");
                }
                else {
                    // The node was dropped elsewhere on the document
                    eventArgs.set_cancel(true);
                }
            }

            function isPartOfSchedulerAppointmentArea(htmlElement) {
                // Determines if an html element is part of the scheduler appointment area
                // This can be either the rsContent or the rsAllDay div (in day and week view)
                return $telerik.$(htmlElement).parents().is("div.rsAllDay") ||
                        $telerik.$(htmlElement).parents().is("div.rsContent")
            }

            function RedirectToDocument(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();

                var ObjectTypeId = appointment.get_attributes()._data.ObjectTypeId;
                var ObjectId = appointment.get_attributes()._data.ObjectId;
                if (ObjectTypeId > 0 || ObjectId > 0) {
                    appointment.set_allowEdit(false)
                    $("input[id$=ObjectTypeId]").val(ObjectTypeId);
                    $("input[id$=ObjectId]").val(ObjectId);
                    $("input[id$=btnRedirectToDoc]").click();
                }
            }
            function appointmentContextMenu(sender, eventArgs) {
                selectedAppointment = eventArgs.get_appointment();
                if (selectedAppointment != null) {
                    var ObjectTypeId = selectedAppointment.get_attributes()._data.ObjectTypeId;
                    var ObjectId = selectedAppointment.get_attributes()._data.ObjectId;
                    if (ObjectTypeId > 0 || ObjectId > 0) {
                        eventArgs.get_domEvent().preventDefault();
                    }
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <input type="hidden" runat="server" id="TargetSlotHiddenField" />
    <asp:HiddenField ID="hdnObjectTypeId" runat="server" Value="" />
    <asp:HiddenField ID="hdnObjectId" runat="server" Value="" />
    <asp:Button ID="btnRedirectToDoc" runat="server" CssClass="Hide" Text="Redirect" />
    <table style="width: 100%" cellpadding="0" cellspacing="0">
        <tr>
            <td width="100%">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>


    <div class="PMMainPage">
        <div class="row row-8-4" >
            <div class="col-4">
                <fieldset>
                    <legend>
                        <asp:Label runat="server" ID="lblEvents" Text="Events" meta:resourcekey="lblEvents"></asp:Label>
                    </legend>
                    <telerik:RadGrid ID="rdgSchedulerEvents" AllowMultiRowSelection="false" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        Width="99%" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="250" FitParentContainer="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Display by Default" UniqueName="DefaultDisplay"
                                    HeaderStyle-Width="140px" ItemStyle-Wrap="false" SortExpression="DefaultDisplay"
                                    HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" AutoPostBack="true" OnCheckedChanged="ChkboxSelected_Changed" Checked='<%# CBool(IIf(Eval("DefaultDisplay") Is System.DBNull.Value, 0, Eval("DefaultDisplay")))%>'
                                            runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-Width="160px"
                                    SortExpression="EventName">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(Container.DataItem("EventName").ToString = String.Empty, "&nbsp;", Container.DataItem("EventName").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="80px">
                                    <ItemTemplate>
                                        <asp:Label Text="&nbsp;" Width="100%" runat="server" ID="lblColor"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true" Resizing-AllowColumnResize="False">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <ClientEvents OnRowDropping="rowDropping" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>
                </fieldset>
                <fieldset>
                    <legend>
                        <asp:Label runat="server" ID="lblOptions" Text="Options" meta:resourcekey="lblOptions"></asp:Label>
                    </legend>
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblProject" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProject" runat="server" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                    Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                    CausesValidation="False" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class="controlWidth">
                                <table class="TableNoSpacingNoBorder">
                                    <tr>
                                        <td>
                                            <asp:CheckBox runat="server" AutoPostBack="True" ID="chkDisplayMyAssignments"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDisplayMyAssignments" runat="server" meta:ResourceKey="chkDisplayMyAssignments" Text="Display My Assignments" Style="padding-left: 8px;"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
            <div class="col-8" style="padding-bottom: 24px;">
                <telerik:RadScheduler runat="server" Height="" ID="RadScheduler1" Style="width: 100%"
                    Skin="Default"
                    DayStartTime="08:00:00" DayEndTime="20:00:00"
                    DataKeyField="IndexId" DataSubjectField="Subject" OnClientAppointmentDoubleClick="RedirectToDocument"
                    DataStartField="Start" DataEndField="End" DataRecurrenceField="RecurrenceRule" EnableAdvancedForm="true" DataDescriptionField="Description"
                    DataRecurrenceParentKeyField="RecurrenceParentID" OnClientAppointmentContextMenu="appointmentContextMenu">
                    <TimelineView HeaderDateFormat="MMM-dd-yyyy" ColumnHeaderDateFormat="MMM-dd-yyyy" />
                    <WeekView HeaderDateFormat="MMM-dd-yyyy" />
                    <AdvancedForm Modal="true" />
                    <AppointmentContextMenus>
                        <telerik:RadSchedulerContextMenu runat="server" ID="SchedulerAppointmentContextMenu">
                            <Items>
                                <telerik:RadMenuItem Text="<%$Resources: ContextMenuEdit %>" Value="CommandEdit" />
                                <telerik:RadMenuItem IsSeparator="True" />
                                <telerik:RadMenuItem Text="<%$Resources: ContextMenuDelete %>" Value="CommandDelete" EnableImageSprite="true" CssClass="MenuDelete" />
                            </Items>
                        </telerik:RadSchedulerContextMenu>
                        <telerik:RadSchedulerContextMenu Visible="false" runat="server" ID="RadSchedulerContextMenu2">
                            <Items>
                            </Items>
                        </telerik:RadSchedulerContextMenu>
                    </AppointmentContextMenus>
                    <TimeSlotContextMenus>
                        <telerik:RadSchedulerContextMenu runat="server" ID="SchedulerTimeSlotContextMenu">
                            <Items>
                                <telerik:RadMenuItem Text="<%$Resources: ContextMenuNewEvent %>" Value="CommandAddAppointment" EnableImageSprite="true" CssClass="MenuAdd" />
                                <telerik:RadMenuItem Text="<%$Resources: ContextMenuNewReccuringevent %>" ImageUrl="Images/Scheduler/recurring.gif" Value="CommandAddRecurringAppointment" />
                                <telerik:RadMenuItem IsSeparator="true" />
                                <%-- Custom command --%>
                                <telerik:RadMenuItem Text="<%$Resources: ContextMenuGoToDay %>" Value="CommandGoToToday" />
                            </Items>
                        </telerik:RadSchedulerContextMenu>
                    </TimeSlotContextMenus>
                    <ResourceTypes>
                        <telerik:ResourceType KeyField="Id" Name="<%$Resources: EVENT_Name %>" TextField="EventName" ForeignKeyField="EventId" />
                        <telerik:ResourceType KeyField="Id" Name="<%$Resources: lblProject.Text %>" TextField="ProjectName" ForeignKeyField="ProjectId" />
                    </ResourceTypes>
                    <TimelineView ColumnHeaderDateFormat="MMM-dd-yyyy" HeaderDateFormat="MMM-dd-yyyy" />
                    <WeekView HeaderDateFormat="MMM-dd-yyyy" />
                </telerik:RadScheduler>
            </div>
        </div>
    </div>

</asp:Content>
