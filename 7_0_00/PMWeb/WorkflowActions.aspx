<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="WorkflowActions.aspx.vb" Inherits="Website.WorkflowActions" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/MainCss.css" rel="stylesheet" type="text/css" />
    <telerik:RadScriptBlock ID="rsbDocument" runat="server">

        <script language="javascript" type="text/javascript">
            var isCommentsRequired = false;
            var isTeamInputPopup = false;
            var currActionType = '';
            var arrActionsSettings = [];
            var blnShowReturnPopup = '<%= IIf(tmpPM.Workflow.DocumentInfo.ReturnToStepId = -1, 1, 0)%>';
            var intReturnToStepId = '<%= tmpPM.Workflow.DocumentInfo.ReturnToStepId%>';
            var IsWFActionsExpanded = '<%= tmpPM.HomeInfo.IsWFActionsExpanded%>';
            var IsWFStepsExpanded = '<%= tmpPM.HomeInfo.IsWFStepsExpanded%>';
            var IsWFLogsExpanded = '<%= tmpPM.HomeInfo.IsWFLogsExpanded%>';
            var IsWFImageExpanded = '<%= tmpPM.HomeInfo.IsWFImageExpanded%>';
            var TeamInputPopup = false;
            var TeamInputCount = '<%= tmpPM.Workflow.DocumentInfo.TeamInputCount%>';
            var blnShowDelegatePopup = '<%= IIf(tmpPM.Workflow.DocumentInfo.DelegateToIds = "0", 1, 0)%>';
            var DelegateToIds = '<%= tmpPM.Workflow.DocumentInfo.DelegateToIds%>';

           window.onbeforeunload = function () {
                var btnRefereshReportViewer = window.opener.$("[id$=btnRefereshReportViewer]");
                if (btnRefereshReportViewer.length > 0) {
                    var btn = btnRefereshReportViewer[0];
                    btn.click();
                }
            };



            function ReturnClosed(Opener) {
                $("input[id$='rdbReturn']")[0].checked = (intReturnToStepId > 0);
                if (intReturnToStepId > 0) {
                    for (var i = 0; i < arrActionsSettings.length; i++) {
                        var objActionSettings = arrActionsSettings[i];
                        if (objActionSettings.Action == 'Return') {
                            $("input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                            $("[id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                            isCommentsRequired = false;
                            if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                        }
                    }
                }
            }

            function DelegateClosed(Opener) {
                $("input[id$='rdbDelegate']")[0].checked = (DelegateToIds.length > 0);
                if (DelegateToIds.length > 0 && DelegateToIds != '0') {
                    for (var i = 0; i < arrActionsSettings.length; i++) {
                        var objActionSettings = arrActionsSettings[i];
                        if (objActionSettings.Action == 'Delegate') {
                            $("input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                            $("[id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                            isCommentsRequired = false;
                            if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                        }
                    }
                }
            }



            /////////////////////////////////////////////////////

            function TeamInputConfirmAction() {

                if (TeamInputCount > 0) {
                    var tdActions = $("#tdAction").find("input[type='radio']");
                    var checked = false;
                    for (var i = 0; i < tdActions.length; i++) {
                        if (tdActions[i].checked == true) {
                            checked = true
                        }
                    }
                    var rdbReviewComplete = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbReviewComplete");
                    var rdbComment = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbComment");
                    var rdbDelegate = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbDelegate");

                    if (rdbDelegate == null && rdbComment != null && rdbReviewComplete != null) {
                        if (checked == false || (checked == true && (rdbReviewComplete.checked || rdbComment.checked))) {
                            return;
                        }
                    }

                    if (rdbDelegate != null && rdbComment == null && rdbReviewComplete == null) {
                        if (checked == false || (checked == true && rdbDelegate.checked)) {
                            return;
                        }
                    }

                    if (isTeamInputPopup) {
                        return;
                    }

                    var answer = confirm(unescape(WarningMsg_TeamInput));
                    if (!answer) {
                        return false;
                    }

                }
                return true;
            }


            function cvComments_validate(sender, args) {
                if (isCommentsRequired == true) {
                    if ($("textarea[id$='txtComments']").val() == '') {
                        args.IsValid = false;
                    } else {
                        args.IsValid = true;
                    }

                } else {
                    args.IsValid = true;
                }
            }


            function cvAction_validate(sender, args) {
                try {
                    $("#tdAction").find("input[type='radio']").each(function () {
                        if (this.checked == true) { args.IsValid = true; throw true; }
                    });
                    if (isTeamInputPopup == true) { args.IsValid = true; throw true; }
                    args.IsValid = false;
                }
                catch (e) { /*error throw true just to break the each itiration*/ }
            }

            function SubmitWorkflowError(errorMsg, url) {
                alert("'" + errorMsg + "'");
                window.location = url;
            }


            //function OpenTeamInputPopup() {
            //    var tdActions = $("#tdAction").find("input[type='radio']");
            //    for (var i = 0; i < tdActions.length; i++) {
            //        tdActions[i].checked = false;
            //    }
            //    UpdateArrActions();
            //    var wnd = window.radopen("WorkflowActionsTeamInput.aspx");
            //    wnd.setSize(800, 400);
            //    wnd.add_close(TeamInputClosed);
            //    wnd.Center();
            //    return false;
            //}
            function OpenTeamInputPopup() {
                var tdActions = $("#tdAction").find("input[type='radio']");
                for (var i = 0; i < tdActions.length; i++) {
                    tdActions[i].checked = false;
                }
                UpdateArrActions();
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen("WorkflowTeamInput.aspx");
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(TeamInputClosed);
                return false;
            }
            function TeamInputClosed(Opener) {
                for (var i = 0; i < arrActionsSettings.length; i++) {
                    var objActionSettings = arrActionsSettings[i];
                    if (objActionSettings.Action == 'TeamInput') {
                        $("input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                        $("[id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                        isCommentsRequired = false;
                        if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                    }
                }
                isTeamInputPopup = false;
                if (TeamInputPopup == 'True') isTeamInputPopup = true;
            }


            function FillEmailInfo(target) {
                UpdateArrActions();
                if (blnShowReturnPopup == 1 && target == 'Return') {
                    $("input[id$='txtSubject']").val(''); $("[id$=dvEmailBody]").html('');
                    var wnd = window.radopen("WorkflowActionsReturnToPopup.aspx?DocumentId=0");
                    wnd.setSize(320, 180);
                    wnd.add_close(ReturnClosed);
                    wnd.Center();

                    return false;
                }

                if (target == 'Comment') {
                    $("input[id$='txtSubject']").val(''); $("[id$=dvEmailBody]").html('');
                    return false;
                }

                if (blnShowDelegatePopup == 1 && target == 'Delegate') {
                    $("input[id$='txtSubject']").val(''); $("[id$=dvEmailBody]").html('');
                    var wnd = window.radopen("WorkflowActionsDelegateStepPopup.aspx?DocumentId=0");
                    wnd.setSize(470, 400);
                    wnd.add_close(DelegateClosed);
                    wnd.Center();
                    return false;
                }
                for (var i = 0; i < arrActionsSettings.length; i++) {
                    var objActionSettings = arrActionsSettings[i];
                    if (objActionSettings.Action == target) {
                        $("input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                        $("[id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                        isCommentsRequired = false;
                        if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                    }
                }

            }

            function DeleteWorkflowConfirmaction() {
                return confirm(WarningMsg_ConfirmDeleteWorkflow);
            }

        </script>
    </telerik:RadScriptBlock>

</head>
<body>
    <form id="form1" runat="server">
        <asp:PlaceHolder ID="plcScript" runat="server"></asp:PlaceHolder>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSaveWorkflow">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlWorklfowActions" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadWindowManager ID="tmpPMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" meta:resourcekey="tmpPMWindowManagerResource1"
            Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" meta:resourcekey="ldpPMResource1" />

        <table width="100%">
            <tr>
                <td>
                    <asp:Panel ID="pnlWorklfowActions" runat="server">
                        <table cellpadding="5" style="width: 100%; padding-top: 0px!important" border="0" id="tblWorklfowActions">
                            <tr>
                                <td id="tdAction" valign="top" style="height: 259px; width: 180px">
                                    <fieldset style="height: 259px; width: 170px; padding-top: 0px">
                                        <legend>
                                            <asp:Label ID="lblActions" runat="server" Text="Actions11" meta:resourcekey="lblActions"></asp:Label></legend>
                                        <asp:CustomValidator ID="cvWorkflowAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validate"
                                            ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvWorkflowAction"></asp:CustomValidator>
                                        <div id="dvActions" runat="server">
                                            <table cellpadding="0" cellspacing="0" style="width: 168px">
                                                <tr>
                                                    <td style="width: 18px">
                                                        <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td style="width: 150px">
                                                        <asp:RadioButton ID="rdbApprove" runat="server" onclick="Javascript:FillEmailInfo('Approve');" CssClass="RadioCss"
                                                            GroupName="Approve" Text="<%$ Resources:Workflow, Action_Approve%>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowReturnButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdbReturn" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                            onclick="Javascript:FillEmailInfo('Return');" Text="<%$ Resources:Workflow, Action_Return %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowRejectButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdbReject" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                            onclick="Javascript:FillEmailInfo('Reject');" Text="<%$ Resources:Workflow, Action_Reject %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowWithdrawButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdbWithdraw" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                            onclick="Javascript:FillEmailInfo('Withdraw');" Text="<%$ Resources:Workflow, Action_Withdraw %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdbFinalApprove" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                            onclick="Javascript:FillEmailInfo('FinalApprove');" Text="<%$ Resources:Workflow, Action_FinalApprove %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="UserGroupButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdbDelegate" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                            onclick="Javascript:FillEmailInfo('Delegate');" Text="<%$ Resources:Workflow, Action_Delegate %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <%--<asp:LinkButton ID="lbtTeamInput" CausesValidation="false" runat="server"></asp:LinkButton>--%>
                                                        <asp:LinkButton ID="lbtTeamInput" CausesValidation="false" runat="server" OnClientClick="javascript:return OpenTeamInputPopup();"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="dvTeamInput" runat="server">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td style="width: 150px">
                                                        <asp:RadioButton ID="rdbReviewComplete" runat="server" onclick="Javascript:FillEmailInfo('ReviewComplete');"
                                                            GroupName="TeamInput" Text="<%$ Resources:Workflow, Action_ReviewComplete%>" CssClass="RadioCss" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="WorkflowReturnButton"><span class="Icon"></span></div>
                                                    </td>
                                                    <td style="width: 150px">
                                                        <asp:RadioButton ID="rdbComment" runat="server" onclick="Javascript:FillEmailInfo('Comment');"
                                                            GroupName="TeamInput" Text="<%$ Resources:Workflow, Action_Comment%>" CssClass="RadioCss" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 120px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table border="0" cellpadding="1" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton runat="server" ID="btnSubmit" Style="width: 100px;" CssClass="lnkButtonAnchor" OnClientClick="javascript:return CheckDirtyWorkflow();"
                                                        ValidationGroup="Save">
                                                        <div style="width: 100px;" class="lnkButton" runat="server">
                                                            <asp:Label runat="server" ID="lblSubmit" meta:resourcekey="btnSubmit"></asp:Label>
                                                        </div>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="btnSaveWorkflow" Style="width: 100px;" CssClass="lnkButtonAnchor" OnClientClick="javascript:return TeamInputConfirmAction();"
                                                        ValidationGroup="Submit">
                                                        <div id="Div1" style="width: 100px;" class="lnkButton" runat="server">
                                                            <asp:Label runat="server" ID="lblSave" meta:resourcekey="btnSave"></asp:Label>
                                                        </div>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlOkCancel" runat="server">
                                                        <asp:Button ID="btnOk" runat="server" ValidationGroup="Submit" Text="Save11" meta:resourcekey="btnSave" /><br />
                                                        <br />
                                                        <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources: btnCancel %>" />
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlDeleteWorkflow" runat="server">
                                                        <asp:LinkButton runat="server" ID="btnDeleteWorkflow" Style="width: 100px;" CssClass="lnkButtonAnchor" OnClientClick="javascript:return DeleteWorkflowConfirmaction();">
                                                            <div id="Div2" style="width: 100px;" class="lnkButton" runat="server">
                                                                <asp:Label runat="server" ID="lblDeleteWorkflow"
                                                                    meta:resourcekey="btnDeleteWorkflow"></asp:Label>
                                                            </div>
                                                        </asp:LinkButton>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>

                                    </fieldset>
                                </td>
                                <td id="tdEmailPreview" valign="top" style="height: 255px; width: 660px">
                                    <fieldset style="height: 100%; width: 650px; padding-top: 0px">
                                        <legend>
                                            <asp:Label ID="lblEmailPreview" runat="server" Text="Email Preview11" meta:resourcekey="lblEmailPreview"></asp:Label></legend>
                                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td valign="middle">
                                                    <asp:Label ID="lblSubject" runat="server" Text="Subject11" meta:resourcekey="lblSubject"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSubject" runat="server" autocomplete="off" Style="background-color: #f1f1f1" Width="300px"></asp:TextBox>
                                                </td>
                                                <td rowspan="3" class="Top" style="padding: 0px 4px 3px 10px">
                                                    <asp:Label ID="lblComments" runat="server" Text="Comments11" meta:resourcekey="lblComments"></asp:Label>
                                                    <div style="height: 12px">
                                                        <asp:CustomValidator ID="cvComments" runat="server" CssClass="Validator" ClientValidationFunction="cvComments_validate" ErrorMessage="Comments are required111"
                                                            ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvComments" Display="Dynamic"></asp:CustomValidator>
                                                    </div>
                                                    <telerik:RadTextBox ID="txtComments" runat="server"
                                                        InputType="Text" CausesValidation="True" Height="195px" Width="255px" TextMode="MultiLine">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="NoWrap">
                                                    <asp:Label ID="lblEmailBody" runat="server" meta:resourcekey="lblEmailBody" Text="Email Body11"></asp:Label>&nbsp;
                                                </td>
                                                <td style="padding-top: 4px">
                                                    <div id="dvEmailBody" style="display: block; border: solid 1px #cbe9ff; padding: 4px; background-color: #f1f1f1; width: 295px; height: 150px; overflow: auto"
                                                        runat="server">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblAddCc" runat="server" meta:resourcekey="lblAddCc" Text="Add CC11"></asp:Label>
                                                </td>
                                                <td>
                                                    <%--<asp:TextBox ID="txtAddCc" runat="server" autocomplete="off" Style="background-color:#f1f1f1" Width="300px"></asp:TextBox>--%>
                                                    <asp:TextBox ID="txtAddCc" runat="server" autocomplete="off" Style="background-color: #f1f1f1" Width="300px"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="rfvEmailValidatorCcTo" runat="server"
                                                        ControlToValidate="txtAddCc" CssClass="Validator" Display="Dynamic" ForeColor=""
                                                        meta:resourcekey="rfvEmailValidator" ValidationGroup="Submit"
                                                        ValidationExpression="((\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*([;])*)*">
                                                    </asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                                <td id="tdInstruction" valign="top" align="left">
                                    <fieldset style="height: 255px; width: 200px;">
                                        <legend>
                                            <asp:Label ID="lblInstructions" runat="server" Text="Instructions11" meta:resourcekey="lblInstructions"></asp:Label></legend>
                                        <div style="height: 240px; width: 200px; overflow: auto; word-wrap: break-word;">
                                            <asp:Label ID="lblInstructionsValue" runat="server" Width="200px"></asp:Label>
                                        </div>
                                    </fieldset>
                                </td>
                            </tr>

                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlError" runat="server" Width="100%">
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
