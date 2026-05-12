<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkflowDocument.ascx.vb" Inherits="Website.WorkflowDocument" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>

<telerik:RadScriptBlock ID="rsbDocument" runat="server">
    <script language="javascript" type="text/javascript">
        var currActionType = '';
        var arrActionsSettings = [];
        var blnShowReturnPopup = '<%= IIF(PM.Workflow.DocumentInfo.ReturnToStepId = -1 ,1,0)%>';
        var intReturnToStepId = '<%= PM.Workflow.DocumentInfo.ReturnToStepId %>';
        var IsWFActionsExpanded = '<%= PM.HomeInfo.IsWFActionsExpanded %>';
        var IsWFStepsExpanded = '<%= PM.HomeInfo.IsWFStepsExpanded %>';
        var IsWFLogsExpanded = '<%= PM.HomeInfo.IsWFLogsExpanded %>';
        var IsWFImageExpanded = '<%= PM.HomeInfo.IsWFImageExpanded %>';
        var TeamInputPopup = false;
        var TeamInputCount = '<%= PM.Workflow.DocumentInfo.TeamInputCount%>';
        
        $(document).ready(function () {
            SetWorkflowSection('tblWorklfowActions', IsWFActionsExpanded);
            SetWorkflowSection('pnlStepActions', IsWFStepsExpanded);
            SetWorkflowSection('rdgWorkflowLog', IsWFLogsExpanded);
            SetWorkflowSection('tblImage', IsWFImageExpanded);

        });




        function SetWorkflowSection(section, Expand) {
            if ($("[id$='" + section + "img']").length > 0) {
                if (Expand == 'True') {
                    $("[id$='" + section + "img']")[0].src = 'CSS/Images/ResponsiveIcons/MinusWorkflow.png';
                    $("[id$='" + section + "']").show();
                }
                if (Expand == 'False') {
                    $("[id$='" + section + "img']")[0].src = 'CSS/Images/ResponsiveIcons/PlusWorkflow.png';
                    $("[id$='" + section + "']").hide();
                }
            }
        }

        var blnShowDelegatePopup = '<%= IIF(PM.Workflow.DocumentInfo.DelegateToIds = "0" ,1,0)%>';
        var DelegateToIds = '<%= PM.Workflow.DocumentInfo.DelegateToIds %>';
        var WorkflowDocumentGrid = '<%= rdtStepActions.ClientID %>';
        var workflowLogGrid = '<%= rdgWorkflowLog.ClientID %>';

        function ReturnClosed(Opener) {
            $("#WorkflowDocument input[id$='rdbReturn']")[0].checked = (intReturnToStepId > 0);
            if (intReturnToStepId > 0) {
                for (var i = 0; i < arrActionsSettings.length; i++) {
                    var objActionSettings = arrActionsSettings[i];
                    if (objActionSettings.Action == 'Return') {
                        $("#WorkflowDocument input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                        $("#WorkflowDocument [id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                        isCommentsRequired = false;
                        if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                    }
                }
            }
        }
        function DelegateClosed(Opener) {
            $("#WorkflowDocument input[id$='rdbDelegate']")[0].checked = (DelegateToIds.length > 0);
            if (DelegateToIds.length > 0 && DelegateToIds != '0') {
                for (var i = 0; i < arrActionsSettings.length; i++) {
                    var objActionSettings = arrActionsSettings[i];
                    if (objActionSettings.Action == 'Delegate') {
                        $("#WorkflowDocument input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                        $("#WorkflowDocument [id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                        isCommentsRequired = false;
                        if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                    }
                }
            }
        }

        function WorkflowAjaxRequest(sender, args) {
            if ((args.EventTarget.indexOf("$btnOk") + args.EventTarget.indexOf("$btnDeleteWorkflow") + args.EventTarget.indexOf("$btnSaveWorkflow")) >= 0) {
                args.EnableAjax = false;
                return;
            }
        }

        function ToggleWorkflowSection(sender, section) {
            if (sender.src.indexOf("Plus") > 0) {
                sender.src = 'CSS/Images/ResponsiveIcons/MinusWorkflow.png';
                $("[id$='" + section + "']").show(200, function () {
                    this.style.display = '';
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/ToggleWorkflowSections",
                        contentType: "application/json; charset=utf-8",
                        data: "{'strSection':'" + section + "', 'blnVisible':" + true + "}",
                        dataType: "json",
                        async: true
                    });
                    if (section == 'rdgWorkflowLog') ResetGridSettings($("[id$=rdgWorkflowLog]")[0].id, true);
                });
            } else {
                sender.src = 'CSS/Images/ResponsiveIcons/PlusWorkflow.png';
                $("[id$='" + section + "']").hide(200, function () {
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/ToggleWorkflowSections",
                        contentType: "application/json; charset=utf-8",
                        data: "{'strSection':'" + section + "', 'blnVisible':" + false + "}",
                        dataType: "json",
                        async: true
                    });
                });
            }
            return false;
        }

        function CloseDesigner() {
            //used by the pop from the Workflow image
        }

        function rdgWorkflowLog_OnRowSelecting(sender, eventArgs) {
            var checkEmail = $("#" + eventArgs.get_id())[0].getAttribute("CheckEmail");
            if (checkEmail == "False") {
                eventArgs.set_cancel(true);
            }


        }

        function ClientDocFileValidationFailed(sender, args) {
            alert(WarningMsg_InvalidFile);
        }

        function cvTeamComments_validateTeamAction(sender, args) {
            if ((($("#WorkflowDocument input[id$='rdbApproverComment']").length == 1 && $("#WorkflowDocument input[id$='rdbApproverComment']")[0].checked == true) || ($("#WorkflowDocument input[id$='rdbComment']").length == 1 && $("#WorkflowDocument input[id$='rdbComment']")[0].checked == true)) && $("textarea[id$='txtTeamComments']").val() == '') {
                args.IsValid = false;
            } else {
                args.IsValid = true;
            }
        }

        function OpenStepActionAttachmentsPopup(StepActionId) {
            OpenPOPUp('WorkflowStepActionAttachmentsPopup.aspx?ActionId=' + StepActionId, 825, 300, false);
            return false;
        }


        function OpenPOPUpToRefreshByHref(URL, Width, Height) {
            var left = (screen.width - Width) / 2;
            var top = (screen.height - Height) / 2;
            window.open(URL, '', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + Width + ',height=' + Height + ',top=' + top + ',left=' + left);
            return false;
        }


        function RefreshAfterClosedByHref(Opener) {
            alert('RefreshAfterClosedByHref');
            location.href = location.href
        }

       
        function TeamInputClosed(Opener) {
            for (var i = 0; i < arrActionsSettings.length; i++) {
                var objActionSettings = arrActionsSettings[i];
                if (objActionSettings.Action == 'TeamInput') {
                    $("#WorkflowDocument input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
                    $("#WorkflowDocument [id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
                    isCommentsRequired = false;
                    if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                }
            }
            isTeamInputPopup = false;
            if (TeamInputPopup == 'True') isTeamInputPopup = true;
        }
    </script>
</telerik:RadScriptBlock>
<style type="text/css">
    .ProjectCenterUpload input.ruButton {
        height: 26px !important;
    }

    .ProjectCenterUpload {
        box-sizing: border-box;
        height: 56px !important;
    }

    .RadTreeList .rtlAdd {
        display: none !important;
    }

    .CssInstructions {
        padding-left: 5px !important;
    }

    .RadTreeList .rtlAdd {
        display: none !important;
    }

    .RadUpload .ruInputs{
        max-height:48px;
        overflow: auto;
    }

    input[type="button"]:hover, input[type="submit"]:hover {
    background-color: transparent !important;
}

    .RadUpload.ProjectCenterUpload .ruFileWrap{
        color:white;
    }

    .RadUpload.ProjectCenterUpload .ruFileWrap {
    height: 16px !important;
}

    @media screen and (max-width:1195px) {
    }

    textarea#ctl00_CPH1_WorkflowDocument_txtComments {
        height: 150px !important;
    }

    .SelectButtonStyle {
        text-align: center;
        height: 32px;
        text-transform: uppercase !important;
        background-color: #FFFFFF;
        padding-top: 4px;
        color: #666666;
        border: 1px solid #666666;
        border-radius: 6px;
        margin: 4px;
        width: 80px;
    }

    input.ruButton.ruBrowse {
        text-transform: uppercase !important;
    }

    span.ruButton.ruBrowse {
        background: none !important;
        border: none !important;
    }

    .RadUpload_Default .ruButton {
        background-image: none !important;
    }

    a#ctl00_CPH1_WorkflowDocument_btnDeleteWorkflow {
        text-decoration: none !important;
    }

    .lnkButton span {
        font-size: 13px !important;
    }

    /*#ctl00_CPH1_pvWorkflow input[type="button"], #ctl00_CPH1_pvWorkflow input[type="submit"], #ctl00_CPH1_pvWorkflow input[type="text"] {
        width: unset;
    }*/
    td#ctl00_CPH1_WorkflowDocument_tdCommandBar{
        padding: 4px;
        padding-top: 6px !important;
    }
    div#ctl00_CPH1_WorkflowDocument_rdtStepActions{
        border-left: none !important;
    }
</style>
    <asp:PlaceHolder ID="plcActionsSettings" runat="server"></asp:PlaceHolder>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <div class="PMMainPage" id="WorkflowDocument">
        <div class="row row-8-4-fit8">
            <div class="col-4" id="pnlWorklfowActions" runat="server">
                <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;" id="tblWorklfowActions">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblActions" runat="server" CssClass="legend" Text="Actions11" meta:resourcekey="lblActions"></asp:Label>
                                </legend>
                                <table width="100%">
                                    <tr>
                                        <td id="tdAction">
                                            <asp:CustomValidator ID="cvWorkflowAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validate"
                                                ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvWorkflowAction"></asp:CustomValidator>
                                            <div id="dvActions" runat="server">
                                                <table cellpadding="0" cellspacing="0" style="float:left !important;">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbApprove" runat="server" onclick="Javascript:FillEmailInfo('Approve');" GroupName="Approve" CssClass="RadioCss" />
                                                        </td>
                                                        <td class="controlWidth" rowspan="7" id="tdInstruction" style="vertical-align: top;">
                                                            <fieldset style="border: none !important;">
                                                                <%-- <legend>
                                                                    <asp:Label ID="lblInstructions"  runat="server" Text="Instructions11" Visible="false" meta:resourcekey="lblInstructions"></asp:Label>
                                                                </legend>--%>
                                                                <div style="height: 170px; width: 100%; overflow: auto; word-wrap: break-word; color: #666666;">
                                                                    <asp:Label ID="lblInstructionsValue" runat="server" Width="100%"></asp:Label>
                                                                </div>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbReturn" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('Return');" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbReject" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('Reject');" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbWithdraw" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('Withdraw');" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbFinalApprove" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('FinalApprove');" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbDelegate" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('Delegate');" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:RadioButton ID="rdbApproverComment" runat="server" GroupName="Approve" CssClass="RadioCss"
                                                                onclick="Javascript:FillEmailInfo('ApproverComment');" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                            </div>
                                            <div id="dvTeamInput" runat="server">
                                                <table id="tblrdbActions" border="0">
                                                    <tr>
                                                        <td>
                                                            <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                                        </td>
                                                        <td style="width: 150px">
                                                            <asp:RadioButton ID="rdbReviewComplete" runat="server" onclick="Javascript:FillEmailInfo('ReviewComplete');" CssClass="RadioCss"
                                                                GroupName="TeamInput" Text="<%$ Resources:Workflow, Action_ReviewComplete%>" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="WorkflowReturnButton"><span class="Icon"></span></div>
                                                        </td>
                                                        <td style="width: 150px; padding-top: 10px;">
                                                            <asp:RadioButton ID="rdbComment" runat="server" onclick="Javascript:FillEmailInfo('Comment');" CssClass="RadioCss"
                                                                GroupName="TeamInput" Text="<%$ Resources:Workflow, Action_Comment%>" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 120px;">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" cellspacing="0" width="99%">
                                                <tr>
                                                    <td style="width: 155px; padding-right: 10px; padding-top: 8px; margin-right: 8px;" class="ButtonsDesignOnMobile">
                                                        <asp:LinkButton runat="server" ID="btnSaveWorkflow" CssClass="lnkButton" OnClientClick="javascript:return TeamInputConfirmAction();"
                                                            ValidationGroup="Submit" Width="155px">
                                                            <span runat="server" class="Icon btnSaveWorkflow"></span>
                                                            <span runat="server">
                                                                <asp:Label runat="server" ID="lblSaveWorkflow" meta:resourcekey="btnSave"></asp:Label>
                                                            </span>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td style="width: 50%; padding-top: 8px;" class="ButtonsDesignOnMobile">
                                                        <asp:Panel ID="pnlDeleteWorkflow" runat="server">
                                                            <asp:LinkButton runat="server" ID="btnDeleteWorkflow" CssClass="lnkButton"
                                                                OnClientClick="javascript:return DeleteWorkflowConfirmaction();" Width="155px">
                                                                <span runat="server" class="Icon btnDeleteWorkflow"></span>
                                                                <span runat="server">
                                                                    <asp:Label runat="server" ID="lblDeleteWorkflow" meta:resourcekey="btnDeleteWorkflow"></asp:Label>
                                                                </span>
                                                            </asp:LinkButton>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="width: 100%; padding-top: 16px;">
                                                        <div style="height: 1px; background-color: #999999; width: 100%;" id="divLine" runat="server"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 16px; width: 50%;" class="ButtonsDesignOnMobile">
                                                        <%--<asp:LinkButton ID="lbtTeamInput" CausesValidation="false" runat="server"></asp:LinkButton>--%>
                                                        <asp:LinkButton ID="btnTeamInput" CausesValidation="false" CssClass="lnkButton" runat="server"
                                                            OnClientClick="javascript:return OpenTeamInputPopup();" Width="155px">
                                                            <span runat="server" class="Icon btnTeamInput"></span>
                                                            <span runat="server">
                                                                <asp:Label runat="server" ID="lbtTeamInput" meta:resourcekey="lbtTeamInput"></asp:Label>
                                                            </span>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td class="ButtonsDesignOnMobile" style="width: 50%;">

                                                    </td>
                                                </tr>
                                            </table>
                                            <table border="0" cellpadding="1" cellspacing="1">
                                                <tr>
                                                    <td class="controlWidth">
                                                        <asp:LinkButton runat="server" ID="btnSubmit" CssClass="lnkButton" OnClientClick="javascript:return CheckDirtyWorkflow();"
                                                            ValidationGroup="Save" Width="80px">
                                                            <span class="Icon btnSubmitWorkflow" id="icnSubmit" runat="server"></span>
                                                            <span>
                                                                <asp:Label runat="server" ID="lblSubmit" Visible="true" meta:resourcekey="btnSubmit"></asp:Label>
                                                            </span>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="pnlOkCancel" runat="server" Width="100%">
                                                            <asp:LinkButton ID="btnOk" runat="server" CssClass="lnkButton" ValidationGroup="Submit" Width="80px">
                                                                 <span runat="server" class="Icon btnSaveWorkflow"></span>
                                                                <span>
                                                                    <asp:Label runat="server" ID="lblSave" Visible="true" meta:resourcekey="lblSave"></asp:Label>
                                                                </span>
                                                            </asp:LinkButton>
                                                            <br />
                                                            <br />
                                                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="lnkButton" Width="80px">
                                                                <span class="Icon btnCancelWorkflow"></span>
                                                                <span>
                                                                    <asp:Label runat="server" ID="lblCancel" Visible="true" Text="<%$ Resources: btnCancel %>"></asp:Label>
                                                                </span>
                                                            </asp:LinkButton>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-8" id="dvWorklfowActions" runat="server">
                <div id="dvTeamMemberView" runat="server" style="vertical-align: top;">
                    <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                        <tr>
                            <td style="height: 255px; vertical-align: top">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblTeamComments" runat="server" CssClass="legend" Text="Comments11" meta:resourcekey="lblTeamComments"></asp:Label>
                                    </legend>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%" border="0">
                                        <tr>
                                            <td>
                                                <div>
                                                    <asp:CustomValidator ID="cvTeamComments" runat="server" CssClass="Validator" ClientValidationFunction="cvTeamComments_validateTeamAction" ErrorMessage="Comments are required"
                                                        ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvTeamComments" Display="Dynamic"></asp:CustomValidator>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtTeamComments" runat="server" ValidationGroup="Submit"
                                                    InputType="Text" CausesValidation="True" Height="217px" Width="100%" TextMode="MultiLine">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
                <table id="dvApproversView" runat="server" class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblEmailPreview" runat="server" Text="Email Preview11" meta:resourcekey="lblEmailPreview"></asp:Label>
                                </legend>
                                <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                                    <tr>
                                        <td style="width: 20% !important; padding-left: 3px;">
                                            <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSubject" runat="server" autocomplete="off" Style="background-color: #f1f1f1" Width="99%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" width="100%">
                                            <table width="100%" style="padding-top: 12px; padding-bottom: 12px;">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:Label ID="lblComments1" runat="server" meta:resourcekey="lblComments"></asp:Label>
                                                        <div style="height: 12px">
                                                            <asp:CustomValidator ID="cvComments" runat="server" CssClass="Validator" ClientValidationFunction="cvComments_validate" ErrorMessage="Comments are required111"
                                                                ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvComments" Display="Dynamic"></asp:CustomValidator>
                                                        </div>
                                                    </td>
                                                    <td style="width: 50%;">
                                                        <asp:Label ID="lblEmailBody" runat="server" meta:resourcekey="lblEmailBody" Text="Email Body"></asp:Label>
                                                        <div style="height: 12px"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 50%; padding-right: 15px;">
                                                        <telerik:RadTextBox ID="txtComments" runat="server" Style="max-width: 300px !important;"
                                                            InputType="Text" CausesValidation="True" Height="150px" Width="100%" TextMode="MultiLine">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="width: 50%;">
                                                        <div id="dvEmailBody" style="display: block; border: solid 1px #666666; background-color: #f1f1f1; width: 100%; height: 150px; overflow: auto; box-sizing: border-box;" runat="server">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20% !important; padding-left: 3px;">
                                            <asp:Label ID="lblAddCc" runat="server" meta:resourcekey="lblAddCc" Text="Add CC"></asp:Label>
                                        </td>
                                        <td>
                                            <%--<asp:TextBox ID="txtAddCc" runat="server" autocomplete="off" Style="background-color:#f1f1f1" Width="300px"></asp:TextBox>--%>
                                            <asp:TextBox ID="txtAddCc" runat="server" autocomplete="off" Style="background-color: #f1f1f1" Width="99%"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="rfvEmailValidatorCcTo" runat="server"
                                                ControlToValidate="txtAddCc" CssClass="Validator" Display="Dynamic" ForeColor=""
                                                meta:resourcekey="rfvEmailValidator" ValidationGroup="Submit"
                                                ValidationExpression="((\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*([;])*)*">
                                            </asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <br />
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlQuickFileUpload" runat="server">
                    <fieldset style="padding: 0px; border: 0px; width: 100%">
                        <div id="TeamAttachmentContainer" runat="server">
                            <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="center">
                                        <table border="0" style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadAsyncUpload runat="server" Width="100%" CssClass="ProjectCenterUpload" ID="rauAttachments" Skin="Default"
                                                        HideFileInput="true" MultipleFileSelection="Automatic" DropZones=".TeamDropZone" OnClientValidationFailed="ClientDocFileValidationFailed">
                                                        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                                    </telerik:RadAsyncUpload>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </asp:Panel>

            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <asp:Panel ID="pnlWaitingDocuSign" runat="server" Style="margin: 20px 0px 35px 24px;">
                <asp:Label ID="lblDocuSignEnvelopeStatus" Style="text-transform: uppercase; color: #666666; padding-left: 4px;" runat="server" Text="Waiting for DocuSign1" meta:resourcekey="lblDocuSignEnvelopeStatus"></asp:Label>
                <p style="margin-top: 12px;" />
                <asp:LinkButton runat="server" ID="btnCancelDocuSign" CssClass="lnkButton" ValidationGroup="Submit" Text="Cancel Docusign1" meta:resourcekey="btnCancelDocuSign" Width="125px">
                    <span runat="server" class="Icon btnDocuSign"></span>
                    <span runat="server">
                        <asp:Label runat="server" ID="lblCancelDocuSign" meta:resourcekey="btnCancelDocuSign"></asp:Label>
                    </span>
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="btnCompleteDocuSign" CssClass="lnkButton" ValidationGroup="Submit" Text="Complete Docusign1" meta:resourcekey="btnCompleteDocuSign" Width="144px" style="margin-left:24px;"
                     OnClientClick="javascript:return OpenPOPUp2('CompleteDocuSignPopup.aspx',  500, 270, true,'rdgWorkflowLog' );">
                    <span runat="server" class="Icon btnDocuSign"></span>
                    <span runat="server">
                        <asp:Label runat="server" ID="lblCompleteDocuSign" meta:resourcekey="btnCompleteDocuSign"></asp:Label>
                    </span>
                </asp:LinkButton>
            </asp:Panel>
            <asp:Panel ID="pnlDocuSign" runat="server" Style="margin: 20px 0px 35px 24px;">
                <asp:Label ID="lblDocuSignErrorMessage" Style="text-transform: uppercase; color: #666666;" runat="server" Text="Waiting for DocuSign1" meta:resourcekey="lblDocuSignErrorMessage"></asp:Label>
                <p />
                <asp:LinkButton runat="server" ID="btnBeginDocSign" Width="155px" CssClass="lnkButton" OnClientClick="javascript:return OpenPOPUpToRefreshByHref('WorkflowDocuSignPopup.aspx',  1400, 700);"
                    ValidationGroup="Submit" Text="Begin DocuSign1" meta:resourcekey="btnBeginDocSign">
                    <span runat="server" class="Icon btnDocuSign"></span>
                    <span runat="server">
                        <asp:Label runat="server" ID="lblBeginDocuSign" meta:resourcekey="btnBeginDocSign"></asp:Label>
                    </span>
                </asp:LinkButton>
            </asp:Panel>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                            <img src="CSS/Images/ResponsiveIcons/MinusWorkflow.png" id="pnlStepActionsimg" onclick="return ToggleWorkflowSection(this,'pnlStepActions');" height="12" style="cursor:pointer !important;" />
                            <span style="color: #999999;">
                                <asp:Label ID="lblBusinessProcess" runat="server" meta:resourcekey="lblBusinessProcess"></asp:Label></span>
                            <%-- <img alt="" src="Images/Workflow/wSperator.png" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdStepActions">
                            <div style="background-color: #FFF; overflow-x: auto; width:calc(100% - 2px); border:1px solid;" id="pnlStepActions" runat="server">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr style="background-color: RGB(237,237,237);">
                                        <td>
                                            <table cellpadding="0" cellspacing="0" style="border-style: none none solid none; border-width: 1px; border-color: #688caf; width: 100vw; height:29px;">
                                                <tr>
                                                    <td id="tdCommandBar" runat="server" style="padding-left: 5px;">
                                                        <asp:LinkButton ID="lbtRefresh" runat="server" CausesValidation="False" Style="text-decoration: none !important;padding-left:10px !important;"
                                                             CommandName="Refresh" CssClass="GridCmdRefresh" SecurityButtonType="ItemMode" Visible="True">
                                                            <span class="Icon"></span>
                                                            <span class="lnkButtonAnchor" style="color:#666666; font-size:11px; font-weight:400 !important;">
                                                                <asp:Label ID="lblRefresh" runat="server" meta:resourcekey="lblRefresh" Text="Refresh1"></asp:Label>
                                                            </span>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div>
                                                <telerik:RadTreeList ID="rdtStepActions" runat="server" AllowMultiItemEdit="False" EnableEmbeddedScripts="false" ExpandCollapseMode="Client"
                                                    AutoGenerateColumns="False" AllowMultiItemSelection="False" ShowTreeLines="False" EditMode="InPlace" CssClass="StepActionsColor"
                                                    DataKeyNames="StepId" ParentDataKeyNames="ParentId" Width="99.8%" SetWidth="true" FitParentContainer="true" HeaderStyle-HorizontalAlign="Center">
                                                    <ClientSettings AllowItemsDragDrop="False" Selecting-AllowItemSelection="False">
                                                        <Selecting AllowItemSelection="True"></Selecting>
                                                        <Scrolling AllowScroll="False" ScrollHeight="253px" UseStaticHeaders="false" />
                                                        <ClientEvents></ClientEvents>
                                                    </ClientSettings>
                                                    <Columns>
                                                        <telerik:TreeListEditCommandColumn UniqueName="EditCommandColumn" ButtonType="ImageButton" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Center"></telerik:TreeListEditCommandColumn>
                                                        <telerik:TreeListTemplateColumn UniqueName="StepNumber" HeaderText="Step #" HeaderStyle-Width="40px" meta:resourcekey="GC_StepNumber" ItemStyle-HorizontalAlign="Right">
                                                            <ItemTemplate>
                                                                <%#IIf(Eval("StepNumber") = "0", "&nbsp;", Eval("StepNumber"))%>
                                                            </ItemTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn UniqueName="IsBranch" HeaderText="Type" HeaderStyle-Width="40px" meta:resourcekey="GC_IsBranch" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <div class="<%#CStr(IIf(CBool(Eval("IsBranch")), "BranchButton", "CheckedInButton"))%>"><span class="Icon"></span></div>
                                                            </ItemTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn HeaderStyle-Width="100px" UniqueName="AllMustApprove" HeaderText="All Must <br/> Approve1" meta:resourcekey="GC_AllMustApprove"
                                                            ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Image ID="imgAllMustApprove" runat="server" />&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn HeaderText="Due Date" HeaderStyle-Width="100px" UniqueName="DueDate" SortExpression="DueDate" meta:resourcekey="GC_DueDate"
                                                            ItemStyle-HorizontalAlign="Right">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDueDate" runat="server"/>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtDueDate" onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                                                    runat="server" Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn HeaderText="Role" ItemStyle-CssClass="NoWrap" HeaderStyle-Width="120px" SortExpression="Role" UniqueName="Role" meta:resourcekey="GC_Role">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRoleName" runat="server"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlRoles" runat="server" Width="100%" Height="300px"></telerik:RadComboBox>
                                                                <asp:HiddenField ID="hdnCurrStepRoleId" runat="server" />
                                                                <asp:HiddenField ID="hdnCurrRoleId" runat="server" />
                                                            </EditItemTemplate>
                                                            <ItemStyle CssClass="NoWrap"></ItemStyle>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn HeaderText="User" meta:resourcekey="GC_User" ItemStyle-CssClass="NoWrap" HeaderStyle-Width="170px"
                                                            SortExpression="User" UniqueName="User">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUser" runat="server"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                &nbsp;
                                                            </EditItemTemplate>
                                                            <ItemStyle CssClass="NoWrap"></ItemStyle>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn HeaderText="Delegate" meta:resourcekey="GC_Delegate" ItemStyle-CssClass="NoWrap" HeaderStyle-Width="150px"
                                                            SortExpression="Delegate" UniqueName="Delegate">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDelegate" runat="server"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                            <ItemStyle CssClass="NoWrap"></ItemStyle>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn UniqueName="Instructions" HeaderText="Instructions1" HeaderStyle-Width="200px" meta:resourcekey="GC_Instructions">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInstructions" runat="server"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtInstructions" runat="server" Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemStyle CssClass="CssInstructions"></ItemStyle>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn UniqueName="RAM" HeaderText="RAM" HeaderStyle-Width="200px" meta:resourcekey="GC_RAM" SortExpression="RAM">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRAM" runat="server"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                            </EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                        <telerik:TreeListTemplateColumn UniqueName="UseDocuSign" HeaderText="DocuSign" HeaderStyle-Width="100px" meta:resourcekey="GC_DocuSign">
                                                            <ItemTemplate>
                                                                <asp:Image ID="imgDocuSign" runat="server" />&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate></EditItemTemplate>
                                                        </telerik:TreeListTemplateColumn>
                                                    </Columns>
                                                </telerik:RadTreeList>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <br />
            </div>
        </div>
        <div class="row" style="overflow:visible !important;">
            <div class="col-12">
                <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                            <img src="CSS/Images/ResponsiveIcons/MinusWorkflow.png" onclick="return ToggleWorkflowSection(this,'rdgWorkflowLog');" id="rdgWorkflowLogimg" height="12" style="cursor:pointer !important;" />
                            <span style="color: #999999; text-transform: uppercase;">
                                <asp:Label ID="lblWorkflowLog" runat="server" meta:resourcekey="lblWorkflowLog"></asp:Label></span>
                            <%--<img alt="" src="Images/Workflow/wSperator.png" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdWorkflowLog">
                            <telerik:RadGrid ID="rdgWorkflowLog" runat="server" CssClass="rdgLog"
                                ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left" EnableViewState="true" SetWidth="true" FitParentContainer="true"
                                Width="100%" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="true" ClientSettings-Scrolling-AllowScroll="true"
                                ShowStatusBar="true" ShowGroupPanel="True" OnFilterCheckListItemsRequested="CheckListItemsRequested"
                                AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="ActionId,StepId,HasEmail"
                                    CommandItemDisplay="Top" ClientDataKeyNames="ActionId,StepId,HasEmail" TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridTemplateColumn UniqueName="Email" HeaderText="Email" DataField="HasEmail" HeaderStyle-Width="35px"
                                            SortExpression="HasEmail" GroupByExpression="HasEmail [GridColumn_Email] Group By HasEmail ASC">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="imgEmail" Visible='<%# Eval("HasEmail") %>' onmouseover="this.style.cursor='hand'" ImageUrl="~/Images/Global/SmallEmail.png" Style="cursor:pointer !important;"/>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="Generated" HeaderText="Generated" DataField="Generated" HeaderStyle-Width="60px"
                                            SortExpression="Generated" GroupByExpression="Generated [GridColumn_Generated] Group By Generated ASC">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="imgGenerated" onmouseover="this.style.cursor='hand'" ImageUrl="~/Images/Toolbar/Generate.png" />&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="StepNumber" HeaderText="Step" DataField="StepNumber" HeaderStyle-Width="90px" Groupable="true"
                                            SortExpression="StepNumber" GroupByExpression="StepNumber [GridColumn_StepNumber] Group By StepNumber ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStepNumber" runat="server" Text='<%#IIf(Eval("StepNumber") = "0", "&nbsp;", Eval("StepNumber")) %>' />&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right"/>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DueDate" HeaderStyle-Width="100px" DataField="ActionDueDate" Groupable="true"
                                            SortExpression="ActionDueDate" GroupByExpression="ActionDueDate [GridColumn_DueDate] Group By ActionDueDate ASC"
                                            CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDueDate" runat="server" Text='<%# FormatDate(Eval("ActionDueDate"))%>' />&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Attachments" UniqueName="AttachmentsCount" HeaderStyle-Width="80px" DataField="AttachmentsCount"
                                            SortExpression="AttachmentsCount" GroupByExpression="AttachmentsCount [GridColumn_AttachmentsCount] Group By AttachmentsCount ASC">
                                            <ItemTemplate>
                                                <asp:HyperLink runat="server" CssClass="Link" ID="hplAttachments" Height="16px"></asp:HyperLink>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Role" UniqueName="RoleName" HeaderStyle-Width="120px" DataField="TranslatedRoleName"
                                            SortExpression="TranslatedRoleName" GroupByExpression="TranslatedRoleName [GridColumn_RoleName] Group By TranslatedRoleName ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRole" runat="server" Text=""></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="Image" HeaderStyle-Width="50px" DataField="Image" AllowFiltering="false" AllowSorting="false"
                                            Groupable="false">
                                            <ItemTemplate>
                                                <asp:Image ID="imgUserImage" runat="server" />&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="left" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="User" UniqueName="User" HeaderStyle-Width="120px" DataField="TranslatedUserName"
                                            SortExpression="TranslatedUserName" GroupByExpression="TranslatedUserName [GridColumn_User] Group By TranslatedUserName ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action Date" UniqueName="ActionDate" HeaderStyle-Width="100px" DataField="ActionDate"
                                            SortExpression="ActionDate" GroupByExpression="ActionDate [GridColumn_ActionDate] Group By ActionDate ASC"
                                            CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblActionDate" runat="server" Text='<%# FormatDate(Eval("ActionDate"))%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action Time" UniqueName="ActionTime" HeaderStyle-Width="100px" DataField="ActionTime"
                                            SortExpression="ActionTime" GroupByExpression="ActionTime [GridColumn_ActionTime] Group By ActionTime ASC"
                                            CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblActionTime" runat="server" Text='<%# CDATE(Eval("ActionTime")).ToString("hh:mm:ss tt") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right"/>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" HeaderStyle-Width="90px" DataField="TranslatedActionType"
                                            SortExpression="TranslatedActionType" GroupByExpression="TranslatedActionType [GridColumn_Action] Group By TranslatedActionType ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAction" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Delegate" UniqueName="Delegate" HeaderStyle-Width="120px" DataField="DelegateName"
                                            SortExpression="DelegateName" GroupByExpression="DelegateName [GridColumn_Delegate] Group By DelegateName ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDelegate" runat="server" Text=""></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Team Input" UniqueName="TeamInput" HeaderStyle-Width="120px" DataField="TeamInputNames"
                                            SortExpression="TeamInputNames" GroupByExpression="TeamInputNames [GridColumn_TeamInput] Group By TeamInputNames ASC">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTeamInput" runat="server" Text=""></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Document Value" UniqueName="DocValue" HeaderStyle-Width="80px" DataField="DocValue"
                                            SortExpression="DocValue" GroupByExpression="DocValue [GridColumn_DocValue] Group By DocValue ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDocValue" runat="server" Text='<%# if(FormatNumber(Eval("DocValue")) =0,"",FormatNumber(Eval("DocValue")))%>'></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Signature" UniqueName="Signature" AllowFiltering="false" DataField="Signature"
                                            SortExpression="Signature" Groupable="false">
                                            <ItemTemplate>
                                                <asp:Image ID="imgSignature" Height="22px" Width="120px" runat="server" />&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Wrap="false" />
                                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Comments" UniqueName="Comments" HeaderStyle-Width="100px" DataField="Comments"
                                            SortExpression="Comments" GroupByExpression="Comments [GridColumn_Comments] Group By Comments ASC"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="server" Width="100%"
                                                    Style="display: inline-block; white-space: pre-wrap !important; word-wrap: break-word !important;"
                                                    Text='<%#Eval("Comments")%>'></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Wrap="true" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 4px">
                                            <asp:LinkButton ID="btnResendMessage" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode_Edit" CommandName="ResendMessage" CssClass="GridCmdResendMessage"
                                                OnClientClick="javascript:return OpenResendMessagesPopup();" Visible="true">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                Visible='<%# rdgWorkflowLog.EditIndexes.Count = 0 And (Not rdgWorkflowLog.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true"
                                                EnableAutoScroll="true" CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack" EnableShadows="true" CausesValidation="false" Visible="true">
                                            </telerik:RadMenu>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true"
                                    EnableRowHoverStyle="false" Selecting-AllowRowSelect="true">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="True" />
                                    <ClientEvents OnRowSelecting="rdgWorkflowLog_OnRowSelecting" />
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <asp:Panel runat="server" ID="pnlImage">
                    <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                        <tr>
                            <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                                <img src="CSS/Images/ResponsiveIcons/MinusWorkflow.png" onclick="return ToggleWorkflowSection(this,'tblImage');" id="tblImageimg" height="12" style="cursor:pointer !important;" />
                                <span style="color: #999999; text-transform: uppercase;">
                                    <asp:Label ID="lblTemplate" Text="Template1" runat="server"></asp:Label></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="width: 100%; overflow: auto">
                                    <table style="width: 100%" id="tblImage">
                                        <tr>
                                            <td>
                                                <iframe id="frameImage" frameborder="0" scrolling="yes" src="WorkflowDocumentImageGenerator.aspx" width="100%" height="300px" style="padding: 0px; margin: 0px"></iframe>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </div>
    </div>
<asp:Button runat="server" ID="btnReloadWorkflowDoc" CssClass="Hide" />