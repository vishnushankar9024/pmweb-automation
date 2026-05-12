<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="WorkflowRecordTypesPopup.aspx.vb" Inherits="Website.WorkflowRecordTypesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdbDoNotUseWorkflow">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlBusinessProcess" />
                        <telerik:AjaxUpdatedControl ControlID="rdbDoNotUseWorkflow" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="rdbProgramDefault">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlBusinessProcess" />
                        <telerik:AjaxUpdatedControl ControlID="rdbProgramDefault" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="rdbSystemDefault">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlBusinessProcess" />
                        <telerik:AjaxUpdatedControl ControlID="rdbSystemDefault" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="rdbBusinessProcess">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlBusinessProcess" />
                        <telerik:AjaxUpdatedControl ControlID="rdbBusinessProcess" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="280px">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbDoNotUseWorkflow" Text="Do Not Use Workflow" CssClass="RadioCss" meta:resourcekey="rdbDoNotUseWorkflow" runat="server" GroupName="Action" Checked="true" AutoPostBack="true" />
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbProgramDefault" Text="Program Default" CssClass="RadioCss" meta:resourcekey="rdbProgramDefault" runat="server" GroupName="Action" AutoPostBack="true" /><br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbSystemDefault" Text="System Default" CssClass="RadioCss" meta:resourcekey="rdbSystemDefault" runat="server" GroupName="Action" AutoPostBack="true" /><br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbBusinessProcess" Text="Business Process" CssClass="RadioCss" meta:resourcekey="rdbBusinessProcess" runat="server" GroupName="Action" AutoPostBack="true" /><br />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLevel" runat="server" Text="Level1" meta:resourcekey="lblLevel"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlLevel" Filter="Contains" AllowCustomText="false" runat="server" Skin="Default" NoWrap="true" Width="100%" Height="80px" AutoPostBack="true"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>

                            <td class="labelWidth">
                                <asp:Label ID="lblBPM" runat="server" Text="BPM1" meta:resourcekey="lblBPM"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBusinessProcess" AllowCustomText="false" Filter="Contains" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                <asp:CompareValidator ID="rfvBusinessProcess" ControlToValidate="ddlBusinessProcess" runat="server" ValueToCompare="0" CssClass="Validator"
                                    ForeColor="" Operator="GreaterThan" meta:resourcekey="rfvBusinessProcess" ValidationGroup="Save" Display="Dynamic" ErrorMessage="Required1">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
