<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="WorkflowDefineRoleStep.aspx.vb"
    Inherits="Website.WorkflowDefineRoleStep" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadScriptBlock ID="rsbTemplate" runat="server">
        <script type="text/javascript">

            var allowdropdownClose;
            function GetValueToReturn(combobox, eventArgs) {

                var hdnField = $("[id$=hddnIds]")[0];
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

            function check(sender, ddl, resultId, ResultName) {
                var combo = $find(ddl);


                var hdnNames = $("[id$=hddnNames]")[0];
                var hdnField = $("[id$=hddnIds]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {

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


            function OnClientDropDownClosed(sender, args) {
                var btn = $("[id$=btnApprover]");
                btn.click();
            }

            function AddUsersAndRolesToCC() {
                var btnAddCCs = $("[id$=btnAddCCs]");
                btnAddCCs.click();
            }

            function RemoveUserBox(argId) {

                var hfdeletedCCs = $("[id$=hfdeletedCCs]")[0];
                hfdeletedCCs.value = argId;
                var btnRemoveCCs = $("[id$=btnRemoveCCs]");
                btnRemoveCCs.click();

            }
            function isMobileScreen() {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }

            function OpenSelectUserPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('SelectUserPopup.aspx?&Bidder=0&Source=WorkflowTemplateStep&ShowRoles=1&IsSingleSelect=0');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function CheckMails(sender, args) {
                var emails = args.Value;
                var emails_array = emails.split(";");
                var reg = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
                for (var i = 0; i < emails_array.length; i++) {
                    if (reg.test(emails_array[i]) == false) {
                        args.IsValid = false;
                        return;
                    }
                }
                args.IsValid = true;
                return;
            }

            function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }

            function CheckParent(node) {
                var ParentNode = node.get_parent();
                var ParentNodeChilds = ParentNode.get_allNodes();
                var TotalChildNodes = ParentNodeChilds.length;
                ParentNode.set_checked(true);
                for (var i = TotalChildNodes - 1; i >= 0; i--) {
                    var ChildNode = ParentNodeChilds[i];
                    if (ChildNode.get_checkState() == 0) {
                        ParentNode.set_checked(false);
                        break;
                    }
                }
            }

            ///////////////////////// Generate Maps combobox functions ////////////////////////////

            function ddl_OnClientItemChecked(sender, eventArgs) {
                var item = eventArgs.get_item();
                var checked = item.get_checked();
                if (checked == true) {
                    if (item.get_value() < 0) {
                        var i;
                        for (i = 1; i < item.get_parent().get_items().get_count() ; i++) {
                            item.get_parent().get_items().getItem(i).uncheck();
                        }
                    }
                    else {
                        item.get_parent().get_items().getItem(0).uncheck();
                    }
                }
                else {
                    if (item.get_parent().get_checkedItems().length == 0)
                        item.get_parent().get_items().getItem(0).set_checked(true);
                }
            }

            //////////////////////////////////////////////////////////////////////////////////////

            function DisplayAs_CheckedChanged() {
                var chkDisplayAs = $("input[id$=chkDisplayAs]")[0];
                var grid = $find($("[id$=rdgActions]")[0].id);
                var gridAllRows = grid.get_masterTableView().get_dataItems();
                for (var i = 0; i < gridAllRows.length; i++) {
                    var objGridRow = gridAllRows[i];
                    var txtDisplayAs = objGridRow.findElement('txtDisplayAs');
                    if (chkDisplayAs.checked) {
                        txtDisplayAs.disabled = false;
                    } else txtDisplayAs.disabled = true;
                }
            }

            function chkStepSecurity_CheckedChanged() {
                var chkStepSecurity = $("input[id$=chkStepSecurity]")[0];
                var toolbar = $find($("[id$=mainToolBar]")[0].id);
                var rtbStepSecurity = toolbar.findItemByText("StepSecurity");
                if (chkStepSecurity.checked) {
                    rtbStepSecurity.set_enabled(true);
                } else {
                    rtbStepSecurity.set_enabled(false);
                    rtbStepSecurity.onclick = "";
                }
            }

            function OpenRoleStepSecurity() {
                var qs = getQueryStrings();
                var StepId = qs["StepId"];
                var Type = qs["Type"];
                OpenRoleSecurityPOPUp("WorkflowRoleStepSecurity.aspx?StepId=" + StepId + "&Type=" + Type, 440, 500, true);
                return false;
            }

            function OpenRoleSecurityPOPUp(URL, Width, Height, Refresh) {
                var wnd = window.radopen(URL);
                wnd.setSize(Width, Height);
                if (Refresh == true) {
                    wnd.add_close(ReloadPage);
                }
                wnd.Center();
                return false;
            }

            function ReloadPage() {
                var btn = $("[id$=btnReload]")[0];
                btn.click();
            }

        </script>
        <style type="text/css">
            @media screen and (max-width: 880px) and (min-width: 320px) {
                .ToolBar {
                    top: 0;
                }
            }

            input[type="checkbox"] + label {
                margin: 0px 0px 10px 3px;
                position: relative !important;
                bottom: 2px !important;
            }

            .controlWidth > span:first-of-type {
                width: 100% !important;
                box-sizing: border-box;
                height: 85px !important;
            }
            span#lblRequired, span#rfvReviewDays, span#cvManualCC {
                height: 24px !important;
            }
            @media screen and (max-width: 843px) and (min-width: 320px) {
                .documentSinglePage {
                    margin-top: 50px !important;
                }
            }
        </style>
    </telerik:RadScriptBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <script type="text/javascript">
            $(document).ready(function () {
                if (getUrlVars()[0] == 'FromTemplateImage') {
                    $(window).unload(function () {
                        for (var i = 0; i < window.parent.length; i++) {
                            if (typeof window.parent[i].CloseDesigner === 'function')
                                window.parent[i].CloseDesigner();
                        }
                    });
                }
            });

        </script>
        <telerik:RadAjaxManagerProxy ID="TemplateRoleStep" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="chkDisplayAs">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgActions" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarStepSecurity" onclick="return OpenRoleStepSecurity();"
                                CommandName="StepSecurity" Text="StepSecurity" meta:resourcekey="RadToolBarButton_StepSecurity">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save"
                                CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save"
                                CommandName="SaveExit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton>
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkStepSecurity" runat="server" Enabled="false" onclick="chkStepSecurity_CheckedChanged();" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 100%;"></td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblStep" runat="server" Text="Step*" meta:resourcekey="lblStep"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <asp:TextBox ID="txtStep" runat="server" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblApprover" runat="server" Text="Approver(s)*" meta:resourcekey="lblApprover"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlApprover" Height="250px" runat="server"
                                    meta:resourcekey="ddlApprover" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    AllowCustomText="True" EnableItemCaching="false" OnClientDropDownClosing="OnClientDropDownClosing"
                                    OnClientDropDownClosed="OnClientDropDownClosed" OnItemsRequested="ddl_ItemsRequested"
                                    OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApply" />
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:Label ID="lblRequired" runat="server" Text="Required." meta:resourcekey="lblRequired"
                                    Visible="false" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblReviewDays" runat="server" Text="Review Days*" meta:resourcekey="lblReviewDays"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtReviewDays" runat="server" CssClass="Integer" MaxLength="3"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfvReviewDays" CssClass="Validator"
                                    ValidationGroup="Save" ControlToValidate="txtReviewDays" Display="Dynamic" meta:resourcekey="rfvReviewDays">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmvReviewDays" runat="server" ControlToValidate="txtReviewDays"
                                    CssClass="Validator" ValidationGroup="Save" Display="Dynamic" meta:resourcekey="cmvReviewDays"
                                    ForeColor="" Operator="GreaterThanEqual" ValueToCompare="0">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblCC" runat="server" Text="CC" meta:resourcekey="lblCC"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton" OnClientClick="return OpenSelectUserPopup()">
                                        <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div style="min-height: 78px;overflow-x:auto;"
                                    class="AllLightBlueBorder" id="dvCC">
                                    <span id="spnCC" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblManualCC" runat="server" Text="Manual CC" meta:resourcekey="lblManualCC"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" TextMode="MultiLine" ID="txtManualCC" Height="80px"></asp:TextBox><br />
                                <asp:CustomValidator runat="server" ID="cvManualCC" ErrorMessage="Invalid Email "
                                    ControlToValidate="txtManualCC" CssClass="Validator" ClientValidationFunction="CheckMails"
                                    meta:resourcekey="cvManualCC" Display="Dynamic" ValidationGroup="Save" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEventTypes" runat="server" Text="Event Type(s)" meta:resourcekey="lblEventTypes"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table class="TableNoSpacingNoBorder">
                                    <tr>
                                        <td style="padding-left: 0px;">
                                            <asp:CheckBox ID="chkEmail" runat="server" Text="Email" meta:resourcekey="chkEmail" class="mobile-switch" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkOnscreenMessage" runat="server" Text="Onscreen Message" meta:resourcekey="chkOnscreenMessage" class="mobile-switch" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkTextSMS" runat="server" Text="Text (SMS)" meta:resourcekey="chkTextSMS" CssClass="Hide" class="mobile-switch" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblReturnTo" runat="server" Text="Return To" meta:resourcekey="lblReturnTo"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlReturnTo" AutoPostBack="false" AllowCustomText="true"
                                    Filter="Contains" runat="server" Width="100%">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblResubmitTo" runat="server" Text="Resubmit To" meta:resourcekey="lblResubmitTo"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlResubmitTo" AutoPostBack="false" AllowCustomText="true"
                                    Filter="Contains" runat="server">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRAM" runat="server" Text="RAM" meta:resourcekey="lblRAM"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlRAM" AllowCustomText="true" Filter="Contains" runat="server">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblInstructions" runat="server" Text="Instructions" meta:resourcekey="lblInstructions"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox runat="server" TextMode="MultiLine" ID="txtInstructions" Height="80px"
                                    InputType="Text">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblValidationProcedure" runat="server" Text="Validation Procedure" meta:resourcekey="lblValidationProcedure"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtValidationProcedure" runat="server"></asp:TextBox>&nbsp;&nbsp;
                            <span runat="server" id="imgHelp" class="Icon"></span>
                                <telerik:RadToolTip ID="rtlHelp" runat="server" RelativeTo="Element" Height="40px"
                                    meta:resourcekey="rtlHelp" Text="The validation procedure must exist in the database along with the parameters 'RecordId' (BIGINT) and 'RecordTypeId' (BIGINT)."
                                    TargetControlID="imgHelp" IsClientID="true" Position="BottomCenter" EnableAriaSupport="true"
                                    EnableShadow="true" HideEvent="LeaveToolTip">
                                </telerik:RadToolTip>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblOptions" runat="server" CssClass="legend" meta:resourcekey="lblOptions" Text="Options"></asp:Label>
                                    </legend>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkAllMustApprove" runat="server" Text="All Must Approve" meta:resourcekey="chkAllMustApprove" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkCanEditRecord" runat="server" Text="Can Edit Record" meta:resourcekey="chkCanEditRecord" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkCanEditNotes" runat="server" Text="Can Edit Notes1"
                                                    meta:resourcekey="chkCanEditNotes" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkCanEditAttachments" runat="server" Text="Can Edit Attachments1"
                                                    meta:resourcekey="chkCanEditAttachments" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkRequireComments" runat="server" Text="Require Comments" meta:resourcekey="chkRequireComments" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkDispalyEmailButtons" runat="server" Text="Dispaly Email Buttons" meta:resourcekey="chkDispalyEmailButtons" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="ChkDocuSignStep" runat="server" Text="DocuSign" meta:resourcekey="ChkDocuSignStep" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblNotifyOnAll" runat="server" CssClass="legend" meta:resourcekey="lblNotifyOnAll" Text="Notify On All"></asp:Label>
                                    </legend>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkSubmissions" runat="server" Text="Submissions" meta:resourcekey="chkSubmissions" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkApprovals" runat="server" Text="Approvals" meta:resourcekey="chkApprovals" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkBranches" runat="server" Text="Branches" meta:resourcekey="chkBranches" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkReturns" runat="server" Text="Returns" meta:resourcekey="chkReturns" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkRejects" runat="server" Text="Rejects" meta:resourcekey="chkRejects" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkWithdrawals" runat="server" Text="Withdrawals" meta:resourcekey="chkWithdrawals" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkFinalApproval" runat="server" Text="Final Approval" meta:resourcekey="chkFinalApproval" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkDelegates" runat="server" Text="Delegates" meta:resourcekey="chkDelegates" class="mobile-switch" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right" style="order: 3 !important">
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblActions" CssClass="legend" runat="server" meta:resourcekey="lblActions" Text="Actions11"></asp:Label>
                                    </legend>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkDisplayAs" runat="server" Text="Display As11" meta:resourcekey="chkDisplayAs" onclick="DisplayAs_CheckedChanged();" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="dvTemplateDiplayActions" runat="server">
                                                    <telerik:RadGrid ID="rdgActions" runat="server" ClientSettings-Scrolling-AllowScroll="true"
                                                        HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="100%" SetWidth="true" FitParentContainer="true" PageSize="10"
                                                        ShowStatusBar="false">
                                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                            DataKeyNames="Id,ActionTypeId" TableLayout="Fixed" EditMode="InPlace">
                                                            <Columns>
                                                                <telerik:GridTemplateColumn HeaderText="Allow11" UniqueName="Allow" HeaderStyle-Width="50px" DataField="Allow" ItemStyle-HorizontalAlign="Center">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelect" Checked='<%# Eval("Allow")%>' runat="server" class="mobile-switch" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="ActionType11" UniqueName="ActionType" DataField="ActionType">
                                                                    <ItemTemplate>
                                                                        <span><%# Eval("ActionType")%></span>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="90px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Display AS11" UniqueName="DisplayAs" DataField="DisplayAs">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtDisplayAs" Width="100%" runat="server" Text='<%# Eval("DisplayAs")%>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </div>
                                                <div id="dvDocumentDiplayActions" runat="server">
                                                    <telerik:RadGrid ID="rdgDocumentActions" runat="server" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                                        HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="100%" PageSize="10"
                                                        ShowStatusBar="false">
                                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                            DataKeyNames="Id,ActionTypeId" TableLayout="Fixed" EditMode="InPlace">
                                                            <Columns>
                                                                <telerik:GridTemplateColumn HeaderText="Allow11" UniqueName="Allow" HeaderStyle-Width="50px" DataField="Allow">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelect" Checked='<%# Eval("Allow")%>' runat="server" class="mobile-switch" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="ActionType11" UniqueName="ActionType" DataField="ActionType">
                                                                    <ItemTemplate>
                                                                        <span><%# Eval("ActionType")%></span>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="90px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Display AS11" UniqueName="DisplayAs" DataField="DisplayAs">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtDisplayAs" Width="100%" runat="server" Text='<%# Eval("DisplayAs")%>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="divGenerateRecords" runat="server">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblGenerateRecords" CssClass="legend" runat="server" meta:resourcekey="lblGenerateRecords"
                                                Text="Generate Records"></asp:Label>
                                        </legend>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblAction" runat="server" meta:resourcekey="lblAction" Text="Action"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:Label ID="lblGenerate" runat="server" meta:resourcekey="lblGenerate" Text="Generate"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px;"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblApprove" runat="server" meta:resourcekey="lblApprove" Text="Approve"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlApprove" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblReturn" runat="server" meta:resourcekey="lblReturn" Text="Return"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlReturn" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblReject" runat="server" meta:resourcekey="lblReject" Text="Reject"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlReject" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblWithdraw" runat="server" meta:resourcekey="lblWithdraw" Text="Withdraw"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlWithdraw" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblFinalApprove" runat="server" meta:resourcekey="lblFinalApprove"
                                                        Text="Final Approve"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlFinalApprove" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblDelegate" runat="server" meta:resourcekey="lblDelegate" Text="Delegate"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlDelegate" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput" AutoPostBack="true"
                                                        Height="250px" runat="server" AllowCustomText="True" OnClientItemChecked="ddl_OnClientItemChecked">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px;"></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkSubmitIfWorkflowEnabled" runat="server" Text="Submit if Workflow enabled"
                                                        meta:resourcekey="chkSubmitIfWorkflowEnabled" class="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hddnIds" />
        <asp:HiddenField runat="server" ID="hddnNames" />
        <asp:Button ID="btnAddCCs" runat="server" CssClass="Hide" />
        <asp:Button ID="btnRemoveCCs" runat="server" CssClass="Hide" />
        <asp:HiddenField ID="hfdeletedCCs" runat="server" Value="0" ValidateRequestMode="Disabled" />
        <asp:Button ID="btnReload" runat="server" CssClass="Hide" />
        <asp:Button ID="btnApprover" runat="server" CssClass="Hide" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" Behaviors="Close,Move"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>

