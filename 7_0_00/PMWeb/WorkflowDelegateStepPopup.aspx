<%@ Page Language="vb" meta:resourcekey="Page" Title="Delegate Step" AutoEventWireup="false" CodeBehind="WorkflowDelegateStepPopup.aspx.vb" Inherits="Website.WorkflowDelegateStepPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
        <script type="text/javascript">

            function OnClientLoad(sender, args) {
                window.parent.DelegateToIds = '<%= PM.Workflow.DocumentInfo.DelegateToIds %>';
                var txt = window.parent.jQuery("textarea[id$='txtComments']").val()
                if (txt == 'Comments...') txt = '';
                $("textarea[id$='txtMessage']").val(txt);
            }

            function CloseDelegatePopup() {
                if (!(querySt('DocumentId') > 0)) {
                    window.parent.DelegateToIds = '<%= PM.Workflow.DocumentInfo.DelegateToIds %>';
                    window.parent.jQuery("textarea[id$='txtComments']").val($("textarea[id$='txtMessage']").val());
                    UpdateDelegateAction();
                }
                CloseRadWnd();
            }

            function ValidateCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value > 0 || value == '') {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                else
                    args.IsValid = true;
            }


            var allowdropdownClose;
            function GetValueToReturn(combobox, eventArgs) {
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + 'hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }

            function OnClientSelectedIndexChanging(combobox, eventArgs) {
                allowdropdownClose = false;
                eventArgs.set_cancel(true);
            }
            function OnClientDropDownClosing(combobox, eventArgs) {
                if (allowdropdownClose == false) {
                    eventArgs.set_cancel(true);
                }
                allowdropdownClose = true;
            }

            function OnClientDropDownClosed(sender, args) {
                var btn = $("[id$=btnDelegateTo]");
                btn.click();
            }

            function check(sender, ddl, resultId, ResultName) {
                var combo = $find(ddl);
                var hdnNames = $("[id$=hddnNames]")[0];
                var hdnField = $("[id$=hddnIds]")[0];

                var vlue = hdnField.value;
                if (sender.checked) {
                    if (vlue.indexOf("0") == 0 && resultId != "0") {
                        hdnField.value = ""
                        hdnNames.value = "";
                        vlue = "";
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() == "0") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                                break;
                            }
                        }
                    }
                    if (hdnField.value == '')
                        hdnField.value = resultId;
                    else
                        hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                    if (resultId == "0") {
                        hdnField.value = resultId;
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() != "0") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                            }
                        }
                    }
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId) {
                            if (newVal == '') {
                                newVal = results[i];
                            }
                            else {
                                newVal = newVal + ',' + results[i];
                            }
                        }
                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            if (newNames == '') {
                                newNames = resultNames[i];
                            }
                            else {
                                newNames = newNames + ',' + resultNames[i];
                            }
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
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
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientLoad="OnClientLoad">
                        <Items>
                            <%--<telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <%--<telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDelegate" CommandName="Delegate" ValidationGroup="Save"></telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage" style="padding-left:24px !important;">
            <div class="row row-8-4 documentSinglePage">
                <div class="col-6">
                    <table class="colTable" style="width: 400px !important;">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblStep" runat="server" Text="Step" meta:resourcekey="lblStep"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <asp:TextBox ID="txtStep" runat="server" ReadOnly="True" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblApprover" runat="server" Text="Approver" meta:resourcekey="lblApprover"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtApprover" runat="server" Width="100%" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrentDelegate" runat="server" Text="Current Delegate" meta:resourcekey="lblCurrentDelegate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrentDelegate" runat="server" Width="100%" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <table class="colTable" style="width: 400px !important">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblDelegateTo" runat="server" Text="Delegate To" meta:resourcekey="lblDelegateTo"></asp:Label>
                            </td>
                            <td class="controlWidth" style="min-width: 240px !important;">
                                <telerik:RadComboBox ID="ddlDelegateTo" Height="150px" runat="server" meta:resourcekey="ddlDelegateTo" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    AllowCustomText="True" Width="100%" Skin="Default" EnableItemCaching="false" OnClientDropDownClosing="OnClientDropDownClosing"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientDropDownClosed="OnClientDropDownClosed" Style="font-size: 11px">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApply" />
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <%--<telerik:RadComboBox ID="ddlDelegateTo" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="244px"></telerik:RadComboBox>--%>
                                <%--<asp:CustomValidator ID="csvDelegateTo" runat="server" ControlToValidate="ddlDelegateTo" 
                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"           
                        CssClass="Validator" ErrorMessage="Delegate is required."></asp:CustomValidator>--%>
                                <asp:Label ID="lblMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>

                                <asp:HiddenField runat="server" ID="hddnIds" />
                                <asp:HiddenField runat="server" ID="hddnNames" />
                                <asp:Button runat="server" CssClass="Hide" ID="btnDelegateTo" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDelegateAllSteps" runat="server" Text="Delegate All of My Steps" meta:resourcekey="lblDelegateAllSteps"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkDelegateAllSteps" runat="server" class="mobile-switch" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAlertDelegate" runat="server" Text="Alert Delegate" meta:resourcekey="lblAlertDelegates"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkAlertDelegate" runat="server" class="mobile-switch" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMessage" runat="server" Text="Alert Message" meta:resourcekey="lblAlertMessage"></asp:Label>
                                <asp:Label ID="lblRequired" runat="server" CssClass="Validator" Text="Required" meta:resourcekey="lblRequired" Visible="false"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="200px" InputType="Text" Text=""></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
