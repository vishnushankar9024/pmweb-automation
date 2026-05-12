<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentTasks.ascx.vb" Inherits="Website.DocumentTasks" %>

<asp:PlaceHolder ID="phTasks" runat="server"></asp:PlaceHolder>

<script type="text/javascript">

    delete Number.prototype._toFormattedString;
    delete Number.prototype.format;
    delete Number.prototype.localeFormat;

    function RefreshTasks() {
        __doPostBack("ddlTaskSheets", 'CopyTaskSheet');
    }

    function OpenTaskSheetsPopUp() {
        var wnd = window.radopen('TaskSheetsLookup.aspx');
        wnd.setSize(570, 450);
        wnd.add_close(RefreshTasks);
        wnd.Center();
        return false;
    }

    function ProjectScheduleChecked() {
        var callBackFn = function (arg) {
            chkProjectSchedule.checked = arg;
        }
        if ((IsOtherTaskSheetsLinked == 1) && (chkProjectSchedule.checked == true)) {
            radconfirm(unescape(NotificationMessage), callBackFn, 600, 200, null, "", "42");
        }
    }

    function CloseTaskSchedulePopup() {
        var btnFillControls = $("[id$=btnFillControls]");
        btnFillControls.click();
    }

    function OpenTaskSchedulePopUp() {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('TasksSchedulePopup.aspx');
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        wnd.add_close(CloseTaskSchedulePopup);
        return false;
    }

    function ConfirmUnlink() { return confirm(Msg_ConfirmUnlink); }

    function GetDefaultCalendar() {
    }

    function CycleDetected(argCycle) {

    }
</script>
<script src="Utilities/TreeGrid/GridE.js" type="text/javascript"> </script>
<script src="JS/Scheduling/TaskDetails.js" type="text/javascript"> </script>

<table cellspacing="0" cellpadding="0" style="width: 100%; padding: 0px;">
    <tr style="background-color: RGB(237,237,237);background-image: none;">
        <td class="Padding7" style="height: 30px; width:400px; padding-left: 24px !important;">
            <table class="TableNoSpacingNoBorder">
                <tr>
                    <td class="labelWidth"  style="background:none"> 
                         <asp:Label ID="lblLinkSchedule" runat="server" Text="Link Schedule" style="width:100% !important;" meta:resourcekey="lblLinkSchedule"></asp:Label>
                      <%--  <asp:LinkButton ID="btnLinkSchedule" CausesValidation="False" OnClientClick="return OpenTaskSchedulePopUp();" CssClass="GridCmdLinkSchedule Link"
                runat="server" CommandName="LinkSchedule" meta:resourcekey="btnLinkSchedule">
                <span class="Icon"></span>
            </asp:LinkButton>--%>
                    </td>
                    <td class="controlWidth">
                         <telerik:RadComboBox ID="ddlProjects" runat="server" Width="240px" AutoPostBack="true"></telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            
        </td>
       <td></td>
    </tr>
</table>

          <%--  <asp:Panel ID="pnlHeader" Width="100%" runat="server" GroupingText="Linked Schedule1" meta:resourcekey="pnlHeader">--%>
            <div class="PMMainPage JustifyContent">
                <div class="row" style="padding-bottom: 15px;padding-top:15px;"> 
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project*1"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProject" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="lblStatus"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtStatus" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatusDate" meta:resourcekey="lblStatusDate"
                                        runat="server" Text="Status Date1"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtStatusDate" runat="server"  style="text-align:right" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="lblDescription"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDescription" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblType" meta:resourcekey="lblType"
                                        runat="server" Text="lblType"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtType" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCategory" meta:resourcekey="lblCategory"
                                        runat="server" Text="lblCategory"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCategory" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-right">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStart" meta:resourcekey="lblStart"
                                        runat="server" Text="Start1"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtStart" runat="server" style="text-align:right" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFinish" meta:resourcekey="lblFinish"
                                        runat="server" Text="lblFinish"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtFinish" runat="server" style="text-align:right" Width="100%" ReadOnly="true"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
         <%--    </asp:Panel>--%>

<div style="width: 99%; height: 630px;" id="TreeGanttContainer">
    <treegrid debug="0"
        data_url="InitiativesBudget.aspx?Req=ScheduleData"
        data_timeout="300"
        text_url='<%= IIf(IO.File.Exists(PM.Parameters.PM_WEBSITE_PHYSICAL_PATH + "\Utilities\TreeGrid\Text." & PM.UserInfo.Language & ".xml"), "Utilities/TreeGrid/Text." & PM.UserInfo.Language & ".xml", "Utilities/TreeGrid/Text.xml") %>'
        upload_url="InitiativesBudget.aspx?Req=Save1"
        upload_format="Internal"
        upload_data="TGData"
        export_url="Utilities/TreeGrid/Export.aspx"
        export_data="TGData"
        export_param_file="Table.xls">
         </treegrid>
</div>
<div style="height: 1000px;"></div>
<asp:Button ID="btnFillControls" runat="server" CssClass="Hide" />