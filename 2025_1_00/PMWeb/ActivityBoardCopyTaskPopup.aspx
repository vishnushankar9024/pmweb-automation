<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardCopyTaskPopup.aspx.vb" Inherits="Website.ActivityBoardCopyTaskPopup"
    meta:resourcekey="Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function ValidateCombo(source, args) {
                var combo = $find(source.controltovalidate);
                var comboValue = combo.get_value();
                var combotext = combo.get_text();

                if (comboValue == '0') {
                    args.IsValid = true;
                    return args.IsValid = true;
                }

                if (comboValue == '-1') {
                    args.IsValid = false;
                    return;
                }

                if (comboValue != '0' && comboValue != '') {
                    args.IsValid = true;
                } else {

                    if (combotext == '' && combotext == null) {
                        args.IsValid = false;
                    }

                    else {

                        var node = combo.findItemByText(combotext);

                        if (node) {
                            //var value = node.get_value();
                            if (node.get_value().length > 0) {
                                args.IsValid = true;
                            } else {
                                args.IsValid = false;
                            }

                        }
                        else {

                            args.IsValid = false;
                        }
                    }
                }
            }
        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
<%--                <telerik:AjaxSetting AjaxControlID="copyTable">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="copyTable" LoadingPanelID="ldpActivity" />
                    </UpdatedControls>
                </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpActivity" runat="server" Skin="Default" />

         <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage R24SidePadding TitleToolbarTop">
            <div class="row">
                <div class="col-4">
                    <table class="colTable" id="copyTable" runat="server">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblName" runat="server" Text="Name*" meta:resourcekey="lblName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxtName" runat="server" ControlToValidate="txtName"
                                    CssClass="Validator" Display="Dynamic" ValidationGroup="Save" ForeColor="" meta:resourcekey="rfvtxtName">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblBoards" runat="server" Text="Board" meta:resourcekey="lblBoard"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBoards" AllowCustomText="true"
                                    runat="server" Skin="Default" NoWrap="true" EnableLoadOnDemand="true"
                                    ShowMoreResultsBox="True" AutoPostBack="true" OnItemsRequested="ddl_ItemsRequested"
                                    EnableVirtualScrolling="True" Height="300px">
                                </telerik:RadComboBox>
                                 <asp:RequiredFieldValidator ID="rfvBoards" runat="server" ControlToValidate="ddlBoards"
                                     CssClass="Validator" InitialValue="" ValidationGroup="Save" meta:resourcekey="rfvBoards"
                                     Display="Dynamic" ForeColor="">
                                 </asp:RequiredFieldValidator>
                                 <asp:CustomValidator ID="csvBoards" runat="server" ControlToValidate="ddlBoards" ValidationGroup="Save" meta:resourcekey="rfvBoards"
                                     ClientValidationFunction="ValidateCombo" Display="Dynamic" CssClass="Validator">
                                 </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblColumns" runat="server" Text="Column" meta:resourcekey="lblColumn"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlColumns" AllowCustomText="true"
                                    runat="server" Skin="Default" NoWrap="true" EnableLoadOnDemand="true"
                                    ShowMoreResultsBox="True" AutoPostBack="true" OnItemsRequested="ddl_ItemsRequested"
                                    EnableVirtualScrolling="True" Height="300px">
                                </telerik:RadComboBox>
                                 <asp:RequiredFieldValidator ID="rfvColumns" runat="server" ControlToValidate="ddlColumns"
                                     CssClass="Validator" InitialValue="" ValidationGroup="Save" meta:resourcekey="rfvColumns"
                                     Display="Dynamic" ForeColor="">
                                 </asp:RequiredFieldValidator>
                                 <asp:CustomValidator ID="csvColumns" runat="server" ControlToValidate="ddlColumns" ValidationGroup="Save" meta:resourcekey="rfvColumns"
                                     ClientValidationFunction="ValidateCombo" Display="Dynamic" CssClass="Validator">
                                 </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblSequence" runat="server" Text="Sequence" meta:resourcekey="lblSequence"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlSequence" AllowCustomText="true"
                                    runat="server" Skin="Default" NoWrap="true" EnableLoadOnDemand="true"
                                    ShowMoreResultsBox="True" AutoPostBack="false" OnItemsRequested="ddl_ItemsRequested"
                                    EnableVirtualScrolling="True" Height="300px">
                                </telerik:RadComboBox>
                                 <asp:RequiredFieldValidator ID="rfvSequence" runat="server" ControlToValidate="ddlSequence" meta:resourcekey="rfvSequence"
                                     CssClass="Validator" InitialValue="" ValidationGroup="Save"
                                     Display="Dynamic" ForeColor="">
                                 </asp:RequiredFieldValidator>
                                 <asp:CustomValidator ID="csvSequence" runat="server" ControlToValidate="ddlSequence" ValidationGroup="Save" meta:resourcekey="rfvSequence"
                                     ClientValidationFunction="ValidateCombo" Display="Dynamic" CssClass="Validator">
                                 </asp:CustomValidator>
                            </td>
                        </tr>
                    </table>
                    <fieldset>
                        <legend class="legend">
                            <asp:Label runat="server" ID="lblCopy" Text="Copy" meta:Resourcekey="lblCopy"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label runat="server" ID="lblAssignments" Text="Assignments" meta:Resourcekey="lblAssignments"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <label class="switch" id="lblAssignmentSwitch" runat="server">
                                            <input id="chkAssignments" runat="server" type="checkbox" checked="checked"  />
                                            <span class="slider round"></span>
                                        </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label runat="server" ID="lblDueDates" Text="Due Dates" meta:Resourcekey="lblDueDates"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <label class="switch">
                                            <input id="chkDueDates" runat="server" type="checkbox" checked="checked" />
                                            <span class="slider round"></span>
                                        </label>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label runat="server" ID="lblSubtasks" Text="Subtasks" meta:Resourcekey="lblSubtasks"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <label class="switch">
                                            <input id="chkSubtasks" runat="server" type="checkbox" checked="checked" />
                                            <span class="slider round"></span>
                                        </label>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label runat="server" ID="lblAttachments" Text="Attachments" meta:Resourcekey="lblAttachments"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                     <label class="switch">
                                            <input id="chkAttachments" runat="server" type="checkbox" checked="checked" />
                                            <span class="slider round"></span>
                                        </label>
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
