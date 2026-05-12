<%@ Page Language="vb" meta:resourcekey="Page" Title="Confirm Activate" AutoEventWireup="false" CodeBehind="WorkflowDelegateActivationPopup.aspx.vb" Inherits="Website.WorkflowDelegateActivationPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript" src="JS/workflow/roles.js"></script>
        <script type="text/javascript">

            function click_handler(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'Save':
                        var chkEmail = $(window.parent.document).find("[id$='hdnEmail']");
                        chkEmail.val($("[id$='chkEmail']")[0].checked);
                        var chkOnScreen = $(window.parent.document).find("[id$='hdnOnScreen']");
                        chkOnScreen.val($("[id$='chkOnscreen']")[0].checked);
                        window.parent.ExecuteActivate();
                        //window.parent[0].ExecuteActivate();
                        break;
                    case 'SaveAndExit':
                        var chkEmail = $(window.parent.document).find("[id$='hdnEmail']");
                        chkEmail.val($("[id$='chkEmail']")[0].checked);
                        var chkOnScreen = $(window.parent.document).find("[id$='hdnOnScreen']");
                        chkOnScreen.val($("[id$='chkOnscreen']")[0].checked);
                        window.parent.ExecuteActivate();
                        //window.parent[0].ExecuteActivate();
                        window.close();
                        break;

                    default:
                        break;
                }
            }

        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="False" Width="100%" OnClientButtonClicking="click_handler">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" Value="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <div class="Warning" style="float: left; width: 24px !important;">
                                    <span class="Icon"></span>
                                </div>
                                <div style="padding-left: 35px;">
                                    <asp:Label ID="lblCaution" runat="server" Text="Caution!" meta:resourcekey="lblCaution"></asp:Label>
                                </div>
                            </td>
                            <td class="controWidth"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top:20px">
                                <asp:Label ID="lblUser" runat="server" meta:resourcekey="lblUser"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblReplacedBPMSteps" runat="server" meta:resourcekey="lblReplacedBPMSteps" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblReplacedActiveSteps" runat="server" meta:resourcekey="lblReplacedActiveSteps" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDelegateBPMSteps" runat="server" meta:resourcekey="lblDelegateBPMSteps" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDelegateActiveSteps" runat="server" meta:resourcekey="lblDelegateActiveSteps"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top:15px;">
                                <asp:Label ID="lblProcess" runat="server" Text="This process cannot be undone. Are you sure you wish to continue?" meta:resourcekey="lblProcess"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <fieldset style="margin-top: 24px;">
                        <legend>
                            <asp:Label runat="server" Text="Send Messages" meta:resourcekey="lblDelegate" Width="100%"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td colspan="2" width="100%">
                                    <table class="colTable">
                                        <tr>
                                            <td width="95%" style="color: #666666;">
                                                <asp:Label ID="lblEmail" runat="server" Text="Email" meta:resourcekey="chkEmail"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkEmail" runat="server" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" width="100%">
                                    <table class="colTable">
                                        <tr>
                                            <td width="95%" style="color: #666666;">
                                                <asp:Label ID="lblOnscreen" runat="server" Text="Onscreen" meta:resourcekey="chkOnscreen"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkOnscreen" runat="server" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="Hide">
                                <td colspan="2" width="100%">
                                    <table class="colTable">
                                        <tr>
                                            <td width="95%" style="color: #666666;">
                                                <asp:Label ID="lblSMS" runat="server" Text="Text (SMS)" meta:resourcekey="chkSMS"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkSMS" runat="server" Text="Text (SMS)" meta:resourcekey="chkSMS" CssClass="Hide" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
