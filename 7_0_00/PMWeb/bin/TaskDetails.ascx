<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TaskDetails.ascx.vb" Inherits="Website.TaskDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="TaskDetailsGeneral.ascx" TagName="TaskDetailsGeneral" TagPrefix="uc1" %>
<%@ Register Src="TaskDependencies.ascx" TagName="TaskDependencies" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="TaskProjectCodes.ascx" TagName="TaskProjectCodes" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="TaskResources.ascx" TagName="TaskResources" TagPrefix="uc6" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc7" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnTaskClicked">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnTaskClicked" />
                <telerik:AjaxUpdatedControl ControlID="tblTaskDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="tblTaskDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblTaskDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="btnDeleteSelectedTasks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnDeleteSelectedTasks" />
                <telerik:AjaxUpdatedControl ControlID="tblTaskDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldsetRecap" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshDetails" />
                <telerik:AjaxUpdatedControl ControlID="tblTaskDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldsetRecap" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
    <StyleSheets>
        <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Grid.css" />
        <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Grid.Office2007.css" />
        <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Metro.Grid.Metro.css" />
    </StyleSheets>
</telerik:RadStyleSheetManager>

<script src="JS/Scheduling/TaskAdvancedDetails.js" type="text/javascript"> </script>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function click_handler_Details(sender, args) {
            var comandName = args.get_item().get_commandName();
            if (comandName == "Delete") {
                if (!confirm(Msg_ConfirmDeleteDocument)) {
                    args.set_cancel(true);
                    return false;
                }
                args.set_cancel(false);
                return true;
            }
        }

        function ResetCombos(combobox, eventArgs) {

            if (combobox.get_id().indexOf('ddlProjects') > 0) {
                var ddlSchedules = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlSchedules');
                ddlSchedules.trackChanges();
                ddlSchedules.clearItems();
                ddlSchedules.set_text('');
                ddlSchedules.set_value('');
                ddlSchedules.commitChanges();
                var ddlTasks = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlTasks');
                ddlTasks.trackChanges();
                ddlTasks.clearItems();
                ddlTasks.set_text('');
                ddlTasks.set_value('');
                ddlTasks.commitChanges();
            }
            if (combobox.get_id().indexOf('ddlSchedules') > 0) {
                var ddlTasks = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlTasks');
                ddlTasks.trackChanges();
                ddlTasks.clearItems();
                ddlTasks.set_text('');
                ddlTasks.set_value('');
                ddlTasks.commitChanges();
            }

        }

        function ComboBlur(combobox, eventArgs) {
            if (combobox.get_text() == "") {
                ResetCombos(combobox, null);
            }
        }



        function GetValueToReturnFromCombobox(combobox, eventArgs) {
            var SelectedValue;
            if ((combobox.get_id().indexOf('ddlSchedules') > 0)) {
                var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                SelectedValue = ddlProjects.get_value();
                var context = eventArgs.get_context();
                context["ProjectFilterString"] = SelectedValue;
            }
            if ((combobox.get_id().indexOf('ddlTasks') > 0)) {
                var ddlSchedules = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlSchedules');
                SelectedValue = ddlSchedules.get_value();
                var context = eventArgs.get_context();
                context["TaskSheetFilterString"] = SelectedValue;
            }
            eventArgs.set_cancel(false);
        }

        //function Collapsed(sender, args) {
        //    var x = document.getElementById("RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_TaskDetails1_RPGantt").style.height = "0";
        //}

        //function Expanded(sender, args) {
        //    var x = document.getElementById("RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_TaskDetails1_RPGantt").style.height = "0";
        //}
        <%-- function ToggleScheduleMenu() {
            var tdTaskDetails = document.getElementById('<%=tdTaskDetails.ClientID %>');
            if (tdTaskDetails.style.display == 'none') {
                tdTaskDetails.style.display = '';
                setCookie('ScheduleMenuStatus', 'inline');
                FloatDivs(false,true);
                ResizeAllGrids();
            } else {
                tdTaskDetails.style.display = 'none';
                setCookie('ScheduleMenuStatus', 'none');
                ResizeAllGrids();
            }
            return false;
        }--%>
    </script>
</telerik:RadCodeBlock>
<script src="JS/Scheduling/TaskDetails.js" type="text/javascript"> </script>
<style>
    @media screen and (max-width: 843px) and (min-width: 320px) {
        .VerticalTabs {
            margin-top: 0px !important;
        }

        #ctl00_CPH1_TaskDetails1_tbsDocumentDetails {
            height: 32px !important;
        }
    }

    @media screen and (min-width:843px) {
        #ctl00_CPH1_TaskDetails1_tbsDocumentDetails .rtsScroll {
            left: 0 !important;
            width: 100% !important;
        }
    }
</style>
<table class="TableNoSpacingNoBorder" style="width: 100%">
    <tr>
        <td>
            <div style="width: 100% !important; height: 413px; margin-bottom: -5px;" id="TreeGanttContainer">
                <telerik:RadCodeBlock ID="CodeBlock" runat="server">
                    <treegrid width="98%" debug="0"
                        data_url="Tasks.aspx?Req=Data"
                        data_timeout="300"
                        text_url='<%= IIf(IO.File.Exists(PM.Parameters.PM_WEBSITE_PHYSICAL_PATH + "\Utilities\TreeGrid\Text." & PM.UserInfo.Language & ".xml"), "Utilities/TreeGrid/Text." & PM.UserInfo.Language & ".xml", "Utilities/TreeGrid/Text.xml") %>'
                        upload_url="Tasks.aspx?Req=Save"
                        upload_format="Internal"
                        upload_data="TGData"
                        upload_flags="AllCols"
                        upload_timeout="300"
                        upload_repeat="0"
                        export_url="Utilities/TreeGrid/Export.aspx"
                        export_data="TGData"
                        export_param_file="Table.xls">
         </treegrid>

                </telerik:RadCodeBlock>


            </div>
        </td>
    </tr>
    <tr>
        <td>
            <table id="tblTaskDetails" runat="server" style="width: 100%; table-layout: fixed; margin-top: 24px; border-top: 1px solid #999999;" class="TableNoSpacingNoBorder">
                <%-- <tr style="height: 7px;">
        <td style="height: 7px; width: 100%;" class="ScheduleBar">
            <input type="button" value=" " onclick="return ToggleScheduleMenu();" style="height: 5px; width: 25px;" />
        </td>
    </tr>--%>
                <tr>
                    <td id="tdTaskDetails" runat="server">
                        <div class="PMHead">
                            <div class="row">
                                <div class="col-2">
                                    <telerik:RadTabStrip ID="tbsDocumentDetails" SelectedIndex="0" Visible="True" ScrollChildren="true" ScrollButtonsPosition="Left"
                                        runat="server" MultiPageID="mlpTaskDetails" Width="100%" EnableViewState="true">

                                        <Tabs>
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Details%>" Value="Details" Selected="True" />
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Dependencies%>" Value="Dependencies" />
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Resources%>" Value="Resources" />
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Checklists%>" Value="Checklists" />
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_ProjectCodes%>" Value="ProjectCodes" />
                                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Notes%>" Value="Notes" />
                                            <%-- <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>--%>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                </div>
                                <div class="col-10 SpecificationPadding">
                                    <telerik:RadMultiPage ID="mlpTaskDetails" runat="server" SelectedIndex="0" Width="100%"
                                        RenderSelectedPageOnly="true" Visible="True">
                                        <telerik:RadPageView ID="pvGeneral" runat="server">
                                            <uc1:TaskDetailsGeneral ID="TaskDetailsGeneral1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvDependencies" runat="server">
                                            <uc2:TaskDependencies ID="TaskDependencies1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvResources" runat="server">
                                            <uc6:TaskResources ID="TaskResources1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvChecklist" runat="server">
                                            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvProjectCodes" runat="server">
                                            <uc4:TaskProjectCodes ID="TaskProjectCodes1" runat="server" />
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False" Style="padding-top: 24px;">
                                            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
                                        </telerik:RadPageView>
                                        <%-- <telerik:RadPageView ID="pvAttacvhments" runat="server" Visible="False">
                            <uc7:DocumentAttachments ID="DocumentAttachments1" runat="server" />
                        </telerik:RadPageView>--%>
                                    </telerik:RadMultiPage>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>






<%--<telerik:RadSplitter ID="RadSplitter1" CssClass="TaskSplitter" RenderMode="Lightweight" runat="server" Skin="Outlook" Width="100%" Height="500px" Orientation="Horizontal">
    <telerik:RadPane ID="RPGantt" runat="server" Width="100%" Height="0px" CssClass="Invisible" PersistScrollPosition="true" Scrolling="Y">
    </telerik:RadPane>
    <telerik:RadSplitBar ID="rdsbTask" runat="server" CollapseMode="Backward" RenderMode="Lightweight" CollapseExpandPaneText="Collapse/Expand" ResizeStep="10" />
    <telerik:RadPane ID="RPTaskTabs" runat="server" Width="100%" PersistScrollPosition="true" Collapsed="true" Height="0px" CssClass="Invisible"></telerik:RadPane>
</telerik:RadSplitter>--%>

<asp:Button ID="btnTaskClicked" runat="server" CssClass="Hide" />
<asp:HiddenField ID="hfTaskId" runat="server" Value="0" />
<asp:Button ID="btnDeleteSelectedTasks" runat="server" CssClass="Hide" />
<asp:HiddenField ID="hfSelectedTasksIds" runat="server" Value="" />
<asp:Button ID="btnRefreshDetails" runat="server" CssClass="Hide" />
<asp:HiddenField ID="hfTaskPopupClosed" runat="server" Value="0" />



