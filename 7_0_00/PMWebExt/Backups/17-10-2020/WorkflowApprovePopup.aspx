<%@ Page Language="vb" meta:resourcekey="Page" Title="Approve Workflow" AutoEventWireup="false" CodeBehind="WorkflowApprovePopup.aspx.vb" Inherits="Website.WorkflowApprovePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function cvAction_validate(sender, args) {
            try {
                $("#tdAction").find("input[type='radio']").each(function () {
                    if (this.checked == true) { args.IsValid = true; throw true; }
                });
                args.IsValid = false;
            }
            catch (e) { /*error throw true just to break the each itiration*/ }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" meta:resourcekey="RadToolBarButton_Save" Text="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" meta:resourcekey="RadToolBarButton_Cancel" Text="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable" id="tblWorklfowActions">
                        <tr>
                            <td id="tdAction" class="labelWidth" valign="top">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblActions" runat="server" Text="Actions" meta:resourcekey="lblActions"></asp:Label>
                                    </legend>
                                    <table border="0">
                                        <tr>
                                            <td colspan="2">
                                                <asp:CustomValidator ID="cvWorkflowAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validate"
                                                    ValidationGroup="Save" ForeColor="" meta:resourcekey="cvWorkflowAction" Display="Dynamic">
                                                </asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 18px">
                                                <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbApprove" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Approve%>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="WorkflowReturnButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbReturn" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Return %>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="WorkflowRejectButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbReject" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Reject %>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="WorkflowWithdrawButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbWithdraw" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Withdraw %>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="WorkflowApproveButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbFinalApprove" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_FinalApprove %>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="UserGroupButton"><span class="Icon"></span></div>
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdbDelegate" runat="server" GroupName="Approve" Text="<%$ Resources:Workflow, Action_Delegate %>" CssClass="RadioCss" />
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                            <td class="controlWidth">
                                <table width="99%" border="0" style="vertical-align: top;">
                                    <tr>
                                        <td>
                                            <fieldset style="vertical-align: top;">
                                                <legend>
                                                    <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblComments"></asp:Label>
                                                </legend>
                                                <asp:TextBox ID="txtComments" runat="server" Style="height: 160px; width: 99%" TextMode="MultiLine"></asp:TextBox>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
