<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SharedAssets.aspx.vb" Inherits="Website.SharedAssets" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdScheduler">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdScheduler" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgReservationRequests" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlProperties">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlHead" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlBuildings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlHead" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlFloors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlHead" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="mainToolBar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdScheduler" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgReservationRequests" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdgReservationRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdScheduler" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgReservationRequests" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style>
        .RadScheduler .rsContent .rsSpacerCell div,
        .RadScheduler .rsContent .rsAllDayHeader div,
        .RadScheduler .rsContent .rsVerticalHeaderTable th,
        .RadScheduler .rsContent .rsVerticalHeaderTable th div {
            width: 250px !important;
        }

        a.hplPlanView {
            color: #666666;
            font-size: 9px;
        }

        .RadScheduler .rsCategoryDarkGreen .rsAptContent,
        .RadScheduler .rsCategoryDarkGreen .rsAptMid .rsAptIn,
        .RadScheduler .rsCategoryDarkGreen .rsAptMid,
        .RadScheduler .rsCategoryDarkGreen .rsAptOut {
            background-repeat: repeat-x !important;
            background-color: #8FD21B;
        }

        .RadScheduler .rsCategoryOrange .rsAptContent,
        .RadScheduler .rsCategoryOrange .rsAptMid .rsAptIn,
        .RadScheduler .rsCategoryOrange .rsAptMid,
        .RadScheduler .rsCategoryOrange .rsAptOut {
            background-repeat: repeat-x !important;
            background-color: #EB901B;
        }

        .RadScheduler tr {
            font-family: arial;
            font-size: 11px !important;
        }

        @media screen and (min-width:320px) and (max-width:880px) {
            .MarginTopOnMobile {
                margin-top: 55px;
            }
        }
    </style>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <script language="javascript" type="text/javascript">
            function OpenPlanView(FileGUID) {
                document.location.href = 'PMWebViewer.aspx?FileGUID=' + FileGUID + '&Source=FLOOR';
                return false;
            }
            function CheckChanged(sender) {
                if (sender.id == 'ctl00_CPH1_chkEquipment') {
                    if (sender.checked == true) {
                        var chkSpaces = $("[id$=ctl00_CPH1_chkSpaces]")[0];
                        chkSpaces.checked = false;
                    }
                    if (sender.checked == false) {
                        var chkSpaces = $("[id$=ctl00_CPH1_chkSpaces]")[0];
                        chkSpaces.checked = true;
                    }
                }
                if (sender.id == 'ctl00_CPH1_chkSpaces') {
                    if (sender.checked == true) {
                        var chkEquipments = $("[id$=ctl00_CPH1_chkEquipment]")[0];
                        chkEquipments.checked = false;
                    }
                    if (sender.checked == false) {
                        var chkEquipments = $("[id$=ctl00_CPH1_chkEquipment]")[0];
                        chkEquipments.checked = true;
                    }
                }
            }

            function ReservationRequestRedirect(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();
                if (appointment.get_attributes()._data.ReservationRequestId > 0) {
                    appointment.set_allowEdit(false)
                    window.location = "ReservationRequest.aspx?Id=" + appointment.get_attributes()._data.ReservationRequestId + '&ModuleId=5&PageId=228';
                }
            }

            function isPartOfSchedulerAppointmentArea(htmlElement) {
                return $telerik.$(htmlElement).parents().is("div.rsAllDay") ||
                                    $telerik.$(htmlElement).parents().is("div.rsContent")
            }

            function rowDropping(sender, eventArgs) {
                var htmlElement = eventArgs.get_destinationHtmlElement();
                var scheduler = $find('<%= rdScheduler.ClientID %>');
                if (isPartOfSchedulerAppointmentArea(htmlElement)) {
                    var timeSlot = scheduler._activeModel.getTimeSlotFromDomElement(htmlElement);
                    document.getElementById('ctl00_CPH1_TargetSlotHiddenField').value = timeSlot.get_index();
                    document.getElementById('ctl00_CPH1_TargetSlotResourceHiddenField').value = timeSlot._resource._key;
                    eventArgs.set_destinationHtmlElement("TargetSlotHiddenField");
                }
                else {
                    eventArgs.set_cancel(true);
                }
            }

        </script>
    </telerik:RadScriptBlock>
    <telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Scheduler.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Window.css" />
        </StyleSheets>
    </telerik:RadStyleSheetManager>
    <div>
        <input type="hidden" runat="server" id="TargetSlotHiddenField" />
        <input type="hidden" runat="server" id="TargetSlotResourceHiddenField" />

        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Office2007"
                        AutoPostBack="True">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                CommandName="Save" AccessKey="s">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <%--   <asp:Panel ID="pnlHead" runat="server">--%>
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProperties" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Vista" CloseDropDownOnBlur="true" OnItemsRequested="ddl_ItemsRequested"
                                    EmptyMessage="Choose a Location..." Width="100%" AutoPostBack="True" NoWrap="true"
                                    CausesValidation="False" Height="200px"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                    EnableVirtualScrolling="True" meta:resourcekey="ddlProperties">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFloor" meta:resourcekey="lblFloor" runat="server" Text="Floor"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlFloors" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Vista" CloseDropDownOnBlur="true" OnItemsRequested="ddl_ItemsRequested"
                                    EmptyMessage="Choose a Floor..." Width="100%" AutoPostBack="True" NoWrap="true"
                                    CausesValidation="False" Height="200px"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:resourcekey="ddlFloors"
                                    EnableVirtualScrolling="True">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBuilding" meta:resourcekey="lblBuilding" runat="server" Text="Building"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBuildings" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Vista" CloseDropDownOnBlur="true" OnItemsRequested="ddl_ItemsRequested"
                                    EmptyMessage="Choose a Building..." Width="100%" AutoPostBack="True" NoWrap="true"
                                    CausesValidation="False" Height="200px" meta:resourcekey="ddlBuildings"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                    EnableVirtualScrolling="True">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSpace" meta:resourcekey="lblSpace" runat="server" Text="Space"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlSpaces" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Vista" CloseDropDownOnBlur="true" OnItemsRequested="ddl_ItemsRequested"
                                    EmptyMessage="Choose a Space..." Width="100%" AutoPostBack="True" NoWrap="true"
                                    CausesValidation="False" Height="200px"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:resourcekey="ddlSpaces"
                                    EnableVirtualScrolling="True">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblStartTime" meta:resourcekey="lblStartTime" runat="server" Text="Start Time"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTimePicker ID="tpStart" runat="server" Skin="Metro"></telerik:RadTimePicker>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEndTime" meta:resourcekey="lblEndTime" runat="server" Text="End Time"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTimePicker ID="tpEnd" runat="server" Skin="Outlook"></telerik:RadTimePicker>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:CheckBox ID="chkSpaces" Text="Spaces" meta:resourcekey="chkSpaces" runat="server" onClick="CheckChanged(this);" />
                                <asp:CheckBox runat="server" ID="chkEquipment" meta:resourcekey="chkEquipment" Text="Equipment" onClick="CheckChanged(this);" />
                            </td>
                        </tr>
                    </table>
                </div>


                <%-- </asp:Panel>--%>
            </div>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        <div style="width: 100%; overflow-x: auto; height: auto; overflow-y: hidden;">
                            <telerik:RadScheduler runat="server" ID="rdScheduler" SelectedView="TimelineView" Skin="Outlook" style="height:auto"
                                AppointmentContextMenuSettings-EnableDefault="True" DayStartTime="08:00:00" DayEndTime="19:00:00"
                                DataKeyField="ID" DataSubjectField="Subject" DataStartField="Start" DataEndField="End" Width="100%"
                                DataRecurrenceField="RecurrenceRule" OverflowBehavior="Scroll" DataRecurrenceParentKeyField="RecurrenceParentID"
                                Localization-HeaderMultiDay="Work Week" OnNavigationComplete="rdScheduler_NavigationComplete"
                                OnClientAppointmentDoubleClick="ReservationRequestRedirect">
                                <AdvancedForm Modal="true" />
                                <ResourceTypes>
                                    <telerik:ResourceType KeyField="UniqueID" ForeignKeyField="UniqueID" />
                                </ResourceTypes>
                                <ResourceHeaderTemplate>
                                    <asp:Panel ID="pnlEquipment" runat="server" Width="300px">
                                        <table style="width: 300px; height: 40px; text-align: left">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnEquipment" runat="server" CssClass="EquipmentButton">
                                                        <span class="Icon" style="padding-right: 0px !important; margin-top: 3px;"></span>
                                                        <asp:Label ID="lblEquipmentName" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlSpace" runat="server">
                                        <table style="width: 250px; height: 40px; text-align: left">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnSpace" runat="server" CssClass="SpaceButton">
                                                        <span class="Icon" style="padding-right: 0px !important; margin-top: 3px;"></span>
                                                        <asp:Label ID="lblSpaceName" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </td>
                                                <td style="color: #666666; font-size: 9px; padding-top: 5px" valign="baseline">&nbsp;<asp:Label ID="lblCap" meta:resourcekey="lblCap" Text="" runat="server"></asp:Label>
                                                    &nbsp;<asp:Label ID="lblCapacityValue" runat="server"></asp:Label>
                                                    <asp:HyperLink ID="hplPlanView" runat="server" CssClass="hplPlanView">&nbsp;&nbsp;<img src="Images/ToolBar/SmallPlanViewIcon.png"/></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ResourceHeaderTemplate>
                                <TimelineView UserSelectable="true" GroupingDirection="Vertical" />
                                <DayView UserSelectable="false" GroupingDirection="Vertical" />
                                <WeekView UserSelectable="true" GroupingDirection="Vertical" />
                                <MonthView UserSelectable="true" GroupingDirection="Vertical" />
                            </telerik:RadScheduler>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid ID="rdgReservationRequests" runat="server" Width="100%" AllowPaging="True"
                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" AppendMenus="true"
                            AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                            <HeaderContextMenu EnableViewState="false">
                            </HeaderContextMenu>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" TableLayout="Fixed" Width="100%">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Subject" UniqueName="Subject">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Subject") = String.Empty, "&nbsp;", Container.DataItem("Subject"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Space" UniqueName="Space">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Equipment" UniqueName="Equipment">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Start Date" UniqueName="StartDate">
                                        <ItemTemplate>
                                            <%#FormatDate(CDate(Container.DataItem("StartDate"))) + " " + CDate(Container.DataItem("StartDate")).ToString("HH:mm")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Finish Date" UniqueName="FinishDate">
                                        <ItemTemplate>
                                            <%#FormatDate(CDate(Container.DataItem("FinishDate"))) + " " + CDate(Container.DataItem("FinishDate")).ToString("HH:mm")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>


                                </Columns>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ClientSettings>
                                <%--AllowRowsDragDrop="True"--%>
                                <%--           <Resizing AllowColumnResize="True"></Resizing>
                                                        <Scrolling UseStaticHeaders="true" />
                                                        <Selecting AllowRowSelect="True" />
                                                         <ClientEvents OnRowDropping="rowDropping" ></ClientEvents>--%>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
