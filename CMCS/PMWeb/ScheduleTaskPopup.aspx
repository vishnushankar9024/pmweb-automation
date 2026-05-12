<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ScheduleTaskPopup.aspx.vb" Inherits="Website.ScheduleTaskPopup" Title="Task Details"  meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register Src="TaskDetailsGeneral.ascx" TagName="TaskDetailsGeneral" TagPrefix="uc1" %> 
<%@ Register Src="TaskDependencies.ascx" TagName="TaskDependencies" TagPrefix="uc2" %> 
<%@ Register Src="ngDocChecklists.ascx" tagname="DocumentCheckList" tagprefix="uc3" %>
<%@ Register Src="TaskProjectCodes.ascx" TagName="TaskProjectCodes" TagPrefix="uc4" %> 
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="TaskResources.ascx" TagName="TaskResources" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
 <script src="JS/Scheduling/TaskAdvancedDetails.js" type="text/javascript"> </script>
</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
            <asp:PlaceHolder ID="phVariables" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="phCalendars" runat="server"></asp:PlaceHolder>
         
        <telerik:RadCodeBlock ID="CodeBlock2" runat="server">
             <style>
                 .PopupTab{padding-top:8px;position:fixed;background-color:white;z-index:999;}
                 .PopupToolbarUnderTabs {background-color:RGB(237,237,237) ;background-image:none;position:fixed;z-index:999;}
                 .PopupMutiPageUnderTabsToolbar{margin-top:41px}
             </style>
            <script type="text/javascript">   
                function OpenviewAttachmentPopup(DocumentType, LineId, DocumentId, EntityTypeId, EntityId, IsLastRevision) {
                    var wnd = window.radopen('ViewAttachments.aspx?DocumentType=' + DocumentType + '&LineId=' + LineId + '&DocumentId=' +
                                             DocumentId + '&EntityTypeId=' + EntityTypeId + '&EntityId=' + EntityId +
                                              '&IsLastRevision=' + IsLastRevision);
                    wnd.setSize(920, 500);
                    wnd.add_close(RefreshTask);
                    wnd.Center();
                    return false;
                }

                function RefreshTask() {
                    var btnRefreshTask = $("input[id$=btnRefreshTask]")[0];
                    btnRefreshTask.click();
                }

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
                function pageLoad() {
                    AdjustDateCalculation();
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
            </script>
        </telerik:RadCodeBlock>
             <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="tbsTaskPopup">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbsTaskPopup" />
                <telerik:AjaxUpdatedControl ControlID="mlpTaskPopup" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="DetailsToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="DetailsToolBar" />
                <telerik:AjaxUpdatedControl ControlID="tbsTaskPopup"  />
                <telerik:AjaxUpdatedControl ControlID="mlpTaskPopup"  LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
               <telerik:AjaxSetting AjaxControlID="ddlTasks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlTasks" />
                <telerik:AjaxUpdatedControl ControlID="tbsTaskPopup"  />
                <telerik:AjaxUpdatedControl ControlID="mlpTaskPopup"  LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
                <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" />     
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>
    <div>
    <table style="width: 100%; table-layout: fixed;"  class="PopupTabStripTable"  cellpadding="0" cellspacing="0" >
            <tr>
                <td>
                    <telerik:RadTabStrip ID="tbsTaskPopup" SelectedIndex="0"  ScrollChildren="true" ScrollButtonsPosition="Left"
                        runat="server" MultiPageID="mlpTaskPopup" Width="100%" EnableViewState="true" CssClass="PopupTab" 
                        CausesValidation="False">
                        <Tabs>
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_General%>" Value="General"  Selected="True" />
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Dependencies%>" Value="Dependencies" />
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Resources%>" Value="Resources" />
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Checklists%>" Value="Checklists"  />
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_ProjectCodes%>" Value="ProjectCodes" />
                            <telerik:RadTab Text="<%$Resources:PMWeb, tab_Notes%>"  Value="Notes"  /> 
                        </Tabs>
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMultiPage ID="mlpTaskPopup" runat="server" SelectedIndex="0" Width="100%" CssClass="PopupMutiPageUnderTabsToolbar"
                        RenderSelectedPageOnly="true" >
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
                        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
