<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="WorkflowActionsPopup.aspx.vb" Inherits="Website.WorkflowActionsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadScriptBlock ID="rsbDocument" runat="server">
        <script language="javascript" type="text/javascript">
            var currActionType = '';
            var arrActionsSettings = [];
            var blnShowReturnPopup = '<%= IIF(PM.Workflow.DocumentInfo.ReturnToStepId = -1 ,1,0)%>';
        var intReturnToStepId = '<%= PM.Workflow.DocumentInfo.ReturnToStepId %>';


            var blnShowDelegatePopup = '<%= IIF(PM.Workflow.DocumentInfo.DelegateTo = 0 ,1,0)%>';
            var intDelegateTo = '<%= PM.Workflow.DocumentInfo.DelegateTo %>';

            var isCommentsRequired = false;

            function CheckRequireCommentsInfo(target) {
                if (blnShowReturnPopup == 1 && target == 'Return') {
                    var wnd = window.radopen("WorkflowReturnToPopup.aspx?DocumentId=0");
                    wnd.setSize(320, 150);
                    wnd.add_close(ReturnClosed);
                    wnd.Center();

                    return false;
                }

                if (blnShowDelegatePopup == 1 && target == 'Delegate') {
                    var wnd = window.radopen("WorkflowDelegateStepPopup.aspx");
                    wnd.setSize(470, 360);
                    wnd.add_close(DelegateClosed);
                    wnd.Center();
                    return false;
                }
                arrActionsSettings = BuildArrayActionsSettings();
                for (var i = 0; i < arrActionsSettings.length; i++) {
                    var objActionSettings = arrActionsSettings[i];
                    if (objActionSettings.Action == target) {
                        isCommentsRequired = false;
                        if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                    }
                }

            }

            function BuildArrayActionsSettings() {
                var arrActions = $("[id$=hdnAction]").val().split('$$SplitValueHere$$');
                var arrRequireComments = $("[id$=hdnRequireComments]").val().split('$$SplitValueHere$$');
                for (var i = 0; i < arrActions.length - 1; i++) {
                    arrActionsSettings.push({ 'Action': arrActions[i], 'RequireComments': arrRequireComments[i] });
                }
                return arrActionsSettings;
            }

            function ReturnClosed(Opener) {
                $("#WorkflowActions input[id$='rdbReturn']")[0].checked = (intReturnToStepId > 0);
                if (intReturnToStepId > 0) {
                    arrActionsSettings = BuildArrayActionsSettings();
                    for (var i = 0; i < arrActionsSettings.length; i++) {
                        var objActionSettings = arrActionsSettings[i];
                        if (objActionSettings.Action == 'Return') {
                            isCommentsRequired = false;
                            if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                        }
                    }
                }
            }
            function DelegateClosed(Opener) {
                $("#WorkflowActions input[id$='rdbDelegate']")[0].checked = (intDelegateTo > 0);
                if (intDelegateTo > 0) {
                    arrActionsSettings = BuildArrayActionsSettings();
                    for (var i = 0; i < arrActionsSettings.length; i++) {
                        var objActionSettings = arrActionsSettings[i];
                        if (objActionSettings.Action == 'Delegate') {
                            isCommentsRequired = false;
                            if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
                        }
                    }
                }
            }


            function cvComments_validate(sender, args) {
                if (isCommentsRequired == true) {
                    if ($("#WorkflowDocument textarea[id$='txtComments']").val() == '') {
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
                    args.IsValid = false;
                }
                catch (e) { /*error throw true just to break the each itiration*/ }
            }

            function WorkflowAjaxRequest(sender, args) { args.EnableAjax = false; }

        </script>
    </telerik:RadScriptBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxPanel ID="WorkflowRadAjaxPanel1" runat="server" Width="100%" ClientEvents-OnRequestStart="WorkflowAjaxRequest">
            <asp:PlaceHolder ID="plcActionsSettings" runat="server"></asp:PlaceHolder>
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar" style="width: 100%;">
                    <td>
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px">
                            <Items>
                                <telerik:RadToolBarButton ImageUrl="Images/Global/Save.png" CommandName="Save" Text="Save" meta:resourcekey="RadToolBarButton_Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton ImageUrl="Images/Toolbar/SmallCancel.png" CommandName="Cancel" Text="Cancel" meta:resourcekey="RadToolBarButton_Cancel"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <table id="WorkflowActions">
                <tr>
                    <td id="tdAction" valign="top">
                        <fieldset style="width: 170px;">
                            <legend>
                                <asp:Label ID="lblActions" runat="server" Text="Actions" meta:resourcekey="lblActions"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <asp:CustomValidator ID="cvWorkflowAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validate"
                                            ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvWorkflowAction">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 18px">
                                        <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                    </td>
                                    <td style="width: 150px">
                                        <asp:RadioButton ID="rdbApprove" runat="server" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('Approve');" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Approve%>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                        <div class="WorkflowReturnButton"><span class="Icon"></span></div>
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rdbReturn" runat="server" GroupName="Approve" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('Return');" Text="<%$ Resources:Workflow, Action_Return %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="WorkflowRejectButton"><span class="Icon"></span></div>
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rdbReject" runat="server" GroupName="Approve" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('Reject');" Text="<%$ Resources:Workflow, Action_Reject %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="WorkflowWithdrawButton"><span class="Icon"></span></div>
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rdbWithdraw" runat="server" GroupName="Approve" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('Withdraw');" Text="<%$ Resources:Workflow, Action_Withdraw %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rdbFinalApprove" runat="server" GroupName="Approve" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('FinalApprove');" Text="<%$ Resources:Workflow, Action_FinalApprove %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="UserGroupButton"><span class="Icon"></span></div>
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="rdbDelegate" runat="server" GroupName="Approve" CssClass="RadioCss" onclick="Javascript:CheckRequireCommentsInfo('Delegate');" Text="<%$ Resources:Workflow, Action_Delegate %>" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <td valign="top">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblComments"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td valign="top">
                                        <div style="height: 12px">
                                            <asp:CustomValidator ID="cvComments" runat="server" CssClass="Validator" ClientValidationFunction="cvComments_validate" ErrorMessage="Comments are required111"
                                                ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvComments" Display="Dynamic"></asp:CustomValidator>
                                        </div>
                                        <asp:TextBox ID="txtComments" MaxLength="500" runat="server" CausesValidation="True" Height="124px" Width="350px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </telerik:RadAjaxPanel>
    </form>
    <asp:HiddenField ID="hdnAction" runat="server" />
    <asp:HiddenField ID="hdnRequireComments" runat="server" />
</body>
</html>
