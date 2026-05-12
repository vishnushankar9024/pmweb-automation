<%@ Page Language="vb" meta:resourcekey="Page" Title="Notification Log" AutoEventWireup="false" CodeBehind="NotificationLog.aspx.vb" Inherits="Website.NotificationLog1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .RadGrid .rgDataDiv {
            max-height: 252px;
        }

        .TreeToolbarSaveExit {
            position: absolute;
            left: 46% !important;
            top: 0px;
        }

        .TreeToolbarCancel {
            position: absolute;
            right: 10px !important;
            top: 0;
        }

        /*.jspContainer, .jspPane {
            width: 100% !important;
        }

            .jspPane span {
                white-space: normal !important;
            }*/

        .removeMargin input {
            margin-left: 0px;
        }

        .divContactBox {
            width: 100% !important;
            height: 35px;
            max-height: 35px;
            overflow: auto;
            float: left;
            border: 1px solid #666666;
            box-sizing: border-box;
            background: #EDEDED;
        }

        .jspDrag {
            background: #7396AA !important;
            top: 2px !important;
        }

        .padding {
            padding-left: 24px;
            padding-right: 24px;
        }

        div.ContactBox {
            padding: 4px 10px !important;
            background: #ffffff !important;
            border: 1px solid #7396AA !important;
        }

        .subNotificationControlWidth {
            width: 100%;
        }


        @media screen and (max-width:1024px) {

            .NotificationControlWidth {
                width: 100%;
                min-width: 240px;
            }
        }

        @media screen and (min-width:320px) and (max-width:843px) {

            .documentSinglePage {
                padding-top: 24px !important;
            }

            .padding {
                padding-left: 0px !important;
                padding-right: 0px !important;
            }

            .NotificationControlWidth {
                width: 100%;
                min-width: 0px !important;
            }

            .subNotificationControlWidth {
                width: 100%;
                min-width: 0px !important;
            }

            .popup .labelWidth {
                width: 160px !important;
            }
            /*.controlWidth {
                min-width: 20px !important;
                width: 260px !important;
            }

            html body .riSingle .riTextBox {
                width: 115px !important;
            }*/
        }



        .documentSinglePage {
            margin-top: 24px;
        }

        @media screen and (min-width:1305px) {

            .ShowOnTablet {
                display: none !important;
            }

            .HideOnTablet {
                display: block;
            }

            .popup {
                display: inline-block !important;
            }

            .tdFrom {
                width: 50%;
            }
        }



        @media screen and (max-width:1305px) {

            .PMMainPage > .row.row-8-4-fit8 > .col-8-fit {
                width: 100% !important;
            }

            .ShowOnTablet {
                display: inline-block !important;
            }

            .popup .gridrow {
                margin-top: 55px !important;
            }

            .HideOnTablet {
                display: none;
            }

            .popup {
                display: none;
                position: fixed !important;
                width: 80vw !important;
                max-width: 400px;
                height: 100% !important;
                left: 0 !important;
                top: 0 !important;
                bottom: 0 !important;
                z-index: 2000;
                background: white;
                border-right: 1px solid #666666;
                padding: 0 20px;
            }

                .popup .Toolbar {
                    position: absolute !important;
                }

                .popup .row {
                    margin-top: 74px;
                }

            .tdFrom {
                width: 70%;
            }
        }

        @media screen and (max-width:460px) {
            .popup, .PMHeader .row .col-4.popup {
                padding: 0 10px !important;
            }
        }

        .labelWidth > div[style*="float:left"], .labelWidth > div[style*="float: left"] {
            width: 50% !important;
        }



        .PMHeader .row + .row .col-8 {
            position: static !important;
        }

        /*.reEditorModes {
            border-bottom: 1px solid #666666;
        }*/

        .RadPicker_Default .rcCalPopup, .RadPicker_Default .rcTimePopup {
            position: relative;
            left: -2px;
        }

        .RadEditor .reToolZone .reEditorModes {
            padding: 0 !important;
        }

        .RadEditor .reToolZone {
            padding: 0 0 1px 0 !important;
        }
    </style>
</head>
<script type="text/javascript">

    function pageload() {
        var value = $('#hdnopenDiv').val()
        if (value != '' && value == 'rtbAttachments') {
            $('#GridDiv').css("display", "block");
        } else if (value != '' && value == 'rtbDetail') {
            $('#DetailDiv').css("display", "block");
        }
        $('#hdnopenDiv').val('');
    };

    function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
        var left = (screen.width - 920) / 2;
        var top = (screen.height - 300) / 2;
        var Bidder = 0;
        if (querySt("ObjectType") == 'ESTIMATE_PROCUREMENT') {
            Bidder = 1;

        }
        if (querySt("ObjectType") == 'PREBID') {
            Bidder = 2;

        }
        var ProjectId = 0;
        var Entitype = querySt('EntityType');
        var EntityId = querySt('EntityId');
        if (Entitype == '0') {
            ProjectId = EntityId
        }
        var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
              'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
        return false;
    }

    function SaveContacts(sender, args) {
        
        CopyToHidden();

    }
    
    function refreshNotification() {
        var btn = window.opener.$("[id$=btnRebindNotificationGrid]")[0];
        if (btn != null) {
            btn.click();
            //                   var refreshbtn=window.opener.document.getElementById(btn.id)
            //                if(refreshbtn!=null)
            //                    refreshbtn.click();
            //                }
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
    function CheckClose(sender, args) {
        if (args.get_item().get_commandName() == "Close") {
            window.close();
            return false;
        }
        if (args.get_item().get_commandName() == "Email") {
            sender.set_enabled(false);
            toolbar = sender;
            setTimeout('toolbar.set_enabled(true);', 1000);
        }
    }


    var editorObj;
    var editorContent;

    function OnClientLoad(editor) {
        editorObj = editor;
        editor.get_contentArea().style.backgroundColor = "white";
        editor.get_contentArea().style.backgroundImage = "none";
    }

    function ddlFrom_OnClientSelectedIndexChanged(sender, eventArgs) {
        var item = eventArgs.get_item();
        var itemId = item.get_parent()._clientStateFieldID;

        var Email = item.get_attributes().getAttribute("ContactName");

        sender.set_text(Email);


    }

    function OpenContactPOPUpFrom(ButtonId) {

        $("input[id$=hdnBtnId]").val(ButtonId);
        var objectType = 'ObjectType=' + querySt('ObjectType')
        return OpenPOPUp('CompanyContact.aspx?Type=1&' + objectType + '&OneSelect=True', 420, 425, false);
    }

    function OpenContactPOPUpTo(ButtonId) {

        $("input[id$=hdnBtnId]").val(ButtonId);
        var objectType = 'ObjectType=' + querySt('ObjectType')
        return OpenPOPUp('CompanyContact.aspx?Type=1&' + objectType, 420, 425, false);
    }
    function OpenContactPOPUpCC(ButtonId) {
        $("input[id$=hdnBtnId]").val(ButtonId);
        var objectType = 'ObjectType=' + querySt('ObjectType')
        return OpenPOPUp('CompanyContact.aspx?Type=2&' + objectType, 420, 425, false);
    }

    function ManageAttachments() {
        var style = document.getElementById("checkboxAttachements").style.display
        if (style == "") {
            document.getElementById("checkboxAttachements").style.display = "none";
        }
        else
            document.getElementById("checkboxAttachements").style.display = "";
        // editorObj.set_html('');
        return false;

    }

    function ManageAttach() {
        var style = document.getElementById("CheckboxesNotes").style.display
        if (style == "") {
            document.getElementById("CheckboxesNotes").style.display = "none";
        }
        else
            document.getElementById("CheckboxesNotes").style.display = "";
        // editorObj.set_html('');
        return false;

    }
    function ManageAttachTemplate() {
        var style = document.getElementById("chkTemplate").style.display
        if (style == "") {
            document.getElementById("chkTemplate").style.display = "none";
        }
        else
            document.getElementById("chkTemplate").style.display = "";
        // editorObj.set_html('');
        return false;
    }

    function ManageAttachReport() {
        var style = document.getElementById("ChkReport").style.display
        if (style == "") {
            document.getElementById("ChkReport").style.display = "none";
        }
        else
            document.getElementById("ChkReport").style.display = "";
        // editorObj.set_html('');
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
    function CheckEmptyToMails(sender, args) {
        var txtAddEmails = document.getElementById('<%=spnToCompany.ClientID %>').innerHTML;
        var emails = args.Value;



        if (txtAddEmails == "") {
            var txtAddEmails = $("[id$=txtAddEmails]");

            if (txtAddEmails.val() == "") {
                args.IsValid = false;
                return;
            }

        }

        args.IsValid = true;
        return;


    }

    function ddlItems_OnClientSelectedIndexChanged(sender, eventArgs) {
        var Item = sender.get_selectedItem();
        if (Item != null) {
            var txtSubjectt = $("[id$=txtSubject]");
            txtSubjectt.val(Item.get_text());


        }
    }
    function AddToCompanyEmail(argContactId, argContactName, argEmail, SpnClientId) {
        var tmpId = parseInt(Math.random() * 100000);
        document.getElementById(SpnClientId).innerHTML = document.getElementById(SpnClientId).innerHTML + '<div id="divContactBox_' + tmpId + '" class="ContactBox"  ContactId="' + argContactId + '" Email="' + argEmail + '">' +
                        '<span class="nowrap">&nbsp;&nbsp;' + argContactName + '</span>' +
                        '<a style="margin-left:5px;text-decoration: none;" href="#" onclick="javascript:return RemoveContactBox(\'' + String(tmpId) + '\');"><b>x&nbsp;&nbsp;</b></a>' +
                        '</div>';
        $('.scroll-pane').jScrollPane();
    }

    function RemoveContactBox(argId) {

        var LockAfterSend = $("[id$=hdnLockAfterSend]")[0].value;
        var IsSent = $("[id$=hdnIsSent]")[0].value;

        if (LockAfterSend == "False" || (LockAfterSend == "True" && IsSent == "False")) {
            $("#divContactBox_" + String(argId)).remove();
        }
        return false;
    }

    function CopyToHidden() {
        document.getElementById('<%=hdnToCompany.ClientID %>').value = document.getElementById('<%=spnToCompany.ClientID%>').innerHTML;
        document.getElementById('<%=hdnCC.ClientID %>').value = document.getElementById('<%=spnCC.ClientID%>').innerHTML;
        if (document.getElementById('<%=hdnBCC.ClientID %>') != null) {
            document.getElementById('<%=hdnBCC.ClientID %>').value = document.getElementById('<%=spnBCC.ClientID%>').innerHTML;
        }
    }
    function InitiateScrollBar() {
        $('.scroll-pane').jScrollPane();


    }
    function refreshNotification() {
        var btn = window.opener.$("[id$=btnRebindNotificationGrid]")[0];
        if (btn != null) {
            btn.click();
            //                   var refreshbtn=window.opener.document.getElementById(btn.id)
            //                if(refreshbtn!=null)
            //                    refreshbtn.click();
            //                }
        }
    }

    function pageLoad() {
        CheckParentBox();
    }

    function AllCheckClicked(iObj) {


        var i = 0;
        var rdgRights = $("div[id$='rdgAttachToEmail']");
        var j = 0;
        var k = 0;
        rdgRights.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                    if (!this.checked)
                        j = j + 1;
                    if (this.checked)
                        k = k + 1;
                    this.checked = iObj.checked;
                }

            }
            i++;
        });

        var hdnCount = $("[id$=hdnCount]");
        var Value = parseFloat(hdnCount.val());
        if (iObj.checked) {
            Value = Value + j;
        }
        else {
            if ((Value - k) >= 0)
                Value = Value - k;
        }
        hdnCount.val(Value);

    }
    function SelectParent(chk) {

        var rdgRights = $("div[id$='rdgAttachToEmail']");
        var chkPArent = rdgRights.find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        rdgRights.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (chk.checked) {
                    if (!this.disabled && !this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                }
            }
            i++;
        });
        var hdnCount = $("[id$=hdnCount]");
        var Value = parseFloat(hdnCount.val());

        if (!chk.checked) {
            chkPArent.checked = false;
            if (Value > 0)
                Value = Value - 1;


        } else {
            chkPArent.checked = isChecked;
            Value = Value + 1;
        }
        hdnCount.val(Value);

        return false;
    }

    function CheckParentBox() {


        var rdgRights = $("div[id$='rdgAttachToEmail']");
        if (rdgRights.find("input[type='checkbox']")[0] == null) return;
        var ParentIsNotChecked = true;
        var i = 0;
        var d = 1;
        var c = 1;
        rdgRights.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (!this.disabled && !this.checked) {
                    if (this.id.indexOf("chkSelect") > 0)
                        ParentIsNotChecked = false;
                }
                if (this.disabled) {
                    d = d + 1;
                }
                if (this.id.indexOf("chkSelect") > 0) {

                    c = c + 1;
                }

            }
            i++;
        });

        if (d == c) {
            ParentIsNotChecked = false;

        }

        if (!ParentIsNotChecked) {
            rdgRights.find("input[type='checkbox']")[0].checked = false;

        } else {
            if (i > 0) {
                rdgRights.find("input[type='checkbox']")[0].checked = true;
            }

        }
    }
    function SaveContacts(sender, args) {
        var value = args.get_item().get_commandName();
        if (value == 'OpenGridDiv') {
            $('#GridDiv').css("display", "block")
            return false;
        } else if (value == 'OpenDetailDiv') {
            $('#DetailDiv').css("display", "block")
            return false;
        } else if (value == 'Save' || value == 'SaveAndExit') {
            args.get_item().set_enabled(false)
        }
        CopyToHidden();
    }
    
    function EnableToolbarButtons() {
        $find($("[id$=mainToolBar]")[0].id).findButtonByCommandName('Save').set_enabled(true)
        $find($("[id$=mainToolBar]")[0].id).findButtonByCommandName('SaveAndExit').set_enabled(true)
    }

    function SubToolbarClick(sender, args) {
        var commandName = args.get_item().get_commandName();
        var value = $('#hdnopenDiv').val()
        switch (commandName) {
            case 'closeDetail':
                $('#DetailDiv').css("display", "none");
                return false;

            case 'closeGrid':
                $('#GridDiv').css("display", "none");
                return false;

            case 'Save':
                $('#hdnopenDiv').val(sender.get_id());
                var toolbar = $find("<%=mainToolBar.ClientID%>")
                var save = toolbar.findItemByValue("Save");
                save.click();
                return false;
                break;

            case 'SaveExit':
                $('#DetailDiv').css("display", "none");
                $('#GridDiv').css("display", "none");
                var toolbar = $find("<%=mainToolBar.ClientID%>")
                var save = toolbar.findItemByValue("Save");
                save.click();
                break;

        }

    }

</script>

<body onload="pageload();">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>

                <telerik:AjaxSetting AjaxControlID="chkCompleted">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="dtpCompletedDate" />
                        <telerik:AjaxUpdatedControl ControlID="chkCompleted" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <asp:TextBox Visible="false" runat="server" ID="txtCreatedBy" ReadOnly="true" Width="95px"></asp:TextBox>
        <telerik:RadDatePicker ID="dtpCreatedDate" Visible="false" Enabled="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100px" Skin="Default" EnableTyping="True">
            <DateInput ID="DateInput3" Skin="Default" runat="server"></DateInput>
        </telerik:RadDatePicker>
        <telerik:RadDatePicker ID="dtpSendDate" Visible="false" AutoPostBack="true" runat="server"
            MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Default" EnableTyping="True">
            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                Skin="Default">
            </Calendar>
            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="True">
            </DateInput>
        </telerik:RadDatePicker>
        <telerik:RadTimePicker ID="dtpSendTime" runat="server" Culture="English (United States)" Visible="false"
            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
            Skin="Default" Width="103px">
            <DateInput ID="DateInput7" runat="server" LabelCssClass="radLabelCss_Office2007"
                Skin="Default">
            </DateInput>
            <Calendar ID="Calendar3" runat="server" Skin="Default">
            </Calendar>
        </telerik:RadTimePicker>
        <asp:TextBox runat="server" Visible="false" ID="txtSendBy" ReadOnly="true" Width="95px"></asp:TextBox>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" OnClientButtonClicking="SaveContacts" AutoPostBack="true"
                                    OnClientButtonClicked="CheckClose">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" AccessKey="s">
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit">
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close">
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton IsSeparator="true">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" OuterCssClass="AlarmNotification ShowOnTablet" PostBack="false" CommandName="OpenDetailDiv"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" OuterCssClass="AttachmentNotification ShowOnTablet" PostBack="false" CommandName="OpenGridDiv"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Email" EnableImageSprite="true" CssClass="ToolbarEmail"
                                            Value="Email" ValidationGroup="Email" CausesValidation="true">
                                        </telerik:RadToolBarButton>



                                        <telerik:RadToolBarButton CssClass="ToolBarRight" PostBack="False" Text="" Value="Sent">
                                            <ItemTemplate>
                                                <div style="width: 100%;">
                                                    <table>
                                                        <tr>
                                                            <td class="NoWrap" style="padding-right: 10px">
                                                                <asp:Label ID="lblCreatedBy" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="NoWrap">
                                                                <asp:Label ID="lblSentBy" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row documentSinglePage" style="padding-top: 0;">
                <div class="col-4">
                    <table class="colTable" border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblSucceed" runat="server" meta:resourcekey="lblSucceed" Text="Email Sent Successfully!" Visible="False" Class="Success"></asp:Label>
                                <%--<asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed." Visible="False" Class="Validator"></asp:Label> --%>
                                <asp:Label ID="lblReportFail" runat="server" Visible="False" Class="Validator" Text="<%$ Resources:PMWeb, Notification_UnconfiguredReport %>"></asp:Label>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row row-8-4-fit8" style="padding-top: 0;">
                <div class="col-8">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:HiddenField runat="server" ID="hdnIsLoged" Value="0" ValidateRequestMode="Disabled" />
                                <asp:HiddenField runat="server" ID="hdnFromId" ValidateRequestMode="Disabled" />
                                <asp:HiddenField runat="server" ID="hdnFrom" ValidateRequestMode="Disabled" />
                                <asp:HiddenField runat="server" ID="hdnFromEmail" ValidateRequestMode="Disabled" />
                                <div style="float: left">
                                    <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton runat="server" ID="btnFrom" CssClass="SearchButton"
                                        OnClientClick="return OpenNotificationSingleCompanyFilterPopup(this.id.replace('btnFrom', 'txtFrom'), this.id.replace('btnFrom', 'hdnFrom'), this.id.replace('btnFrom', 'hdnFromEmail'), this.id.replace('btnFrom', 'hdnFromId'), 'Contacts', 'Notification')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td valign="middle" class="NoWrap NotificationControlWidth">
                                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="tdFrom">
                                            <asp:TextBox BackColor="#EDEDED" ID="txtFrom" runat="server" Width="99%" Text=""></asp:TextBox>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox ID="chkIsSystem" runat="server" Style="vertical-align: middle;" />
                                            <asp:Label CssClass="labelColor" ID="lblSystem" runat="server" Text="System1" meta:resourcekey="lblSystem" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" valign="middle">
                                <div style="float: left;">
                                    <asp:Label Text="To" ID="lblTo" meta:resourcekey="lblTo" runat="server" />
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton ID="btnTo" runat="server" CssClass="SearchButton"
                                        OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnTo', 'spnToCompany'), this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'hdnIds'), 'Contacts', 'Notification')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="NotificationControlWidth">
                                <asp:TextBox ID="txtTest" CssClass="Hide" runat="server" Width="80%" Text="test"></asp:TextBox>
                                <div class="scroll-pane divContactBox" runat="server" id="dvTo">
                                    <span id="spnToCompany" runat="server" style="white-space: nowrap;"></span>
                                    <asp:HiddenField ID="hdnToCompany" runat="server" ValidateRequestMode="Disabled" />
                                </div>
                                <div style="clear: both">
                                    <asp:CustomValidator runat="server" ID="CustomValidator2" ControlToValidate="txtTest" CssClass="Validator" ClientValidationFunction="CheckEmptyToMails" EnableClientScript="true" meta:resourcekey="rfvToEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label Text="CC" ID="lblCC" meta:resourcekey="lblCC" runat="server" />
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton ID="btnCC" runat="server" CssClass="SearchButton"
                                        OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnCC', 'spnCC'), this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'NotExistIds'), 'Contacts', 'Notification')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="NotificationControlWidth">
                                <div class="scroll-pane divContactBox" runat="server" id="dvCC">
                                    <span id="spnCC" runat="server" style="white-space: nowrap;"></span>
                                    <asp:HiddenField ID="hdnCC" runat="server" ValidateRequestMode="Disabled" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="NotificationLabelWidth" valign="top">
                                <div style="float: left;">
                                    <asp:Label Text="BCC" ID="lblBCC" meta:resourcekey="lblBCC" runat="server" />
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton ID="btnBCC" runat="server" CssClass="SearchButton"
                                        OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnBCC', 'spnBCC'), this.id.replace('btnBCC', 'txtBCC'), this.id.replace('btnBCC', 'hdnIds'), 'Contacts', 'Notification')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="NotificationControlWidth" id="tdBccbtn" runat="server">
                                <div class="scroll-pane divContactBox" runat="server" id="dvBcc">
                                    <span id="spnBCC" runat="server" style="white-space: nowrap;"></span>
                                    <asp:HiddenField ID="hdnBCC" runat="server" ValidateRequestMode="Disabled" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" Text="Manual CC" ID="lblManualCC" meta:resourcekey="lblManualCC"></asp:Label>
                            </td>
                            <td class="NotificationControlWidth">
                                <asp:TextBox runat="server" Width="100%" ID="txtAddEmails"></asp:TextBox>
                                <div>
                                    <asp:CustomValidator runat="server" ID="cvEmails" ControlToValidate="txtAddEmails" CssClass="Validator" ClientValidationFunction="CheckMails" meta:resourcekey="cvToEmails" Display="Dynamic" ValidationGroup="Email" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                            </td>
                            <td class="NotificationControlWidth">
                                <asp:TextBox ID="txtSubject" MaxLength="1000" runat="server" Width="100%" Text=""></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div id="DetailDiv" class="popup" style="width: 100%;">
                        <table style="width: 100%; position: absolute !important; left: 0;" cellpadding="0" cellspacing="0" class="ToolBar ShowOnTablet">
                            <tr valign="top">
                                <td valign="top">
                                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td valign="middle" style="vertical-align: middle; width: 10%; padding-left: 10px;">
                                                <telerik:RadToolBar ID="rtbDetail" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="ShowOnTablet" OnClientButtonClicked="SubToolbarClick">
                                                    <Items>
                                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave " CommandName="Save" Height="50px"></telerik:RadToolBarButton>
                                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit TreeToolbarSaveExit " Height="50px" CommandName="SaveExit"></telerik:RadToolBarButton>
                                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnTablet TreeToolbarCancel " Height="50px" PostBack="false" CommandName="closeDetail"></telerik:RadToolBarButton>
                                                    </Items>
                                                </telerik:RadToolBar>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div class="PMMainPage" style="padding: 0;">
                            <div class="row JustifyContent" style="padding-top: 0;">
                                <div class="col-4 col-4-left">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus" Text="Status"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlStatus" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblNotification" runat="server" meta:resourcekey="lblNotification" Text="Notification type"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlNotification" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label Text="Reference" ID="lblReference" meta:resourcekey="lblReference" runat="server" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox CssClass="text" runat="server" Width="100%" MaxLength="255" ID="txtReference"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblIncludeUrl" meta:resourcekey="lblIncludeUrl" runat="server" Text="Add Link"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkAddLink" Checked="True" CssClass="removeMargin" Text="" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-4 col-4-right">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label Text="Due Date" ID="lblDueDate" meta:resourcekey="lblDueDate" runat="server" />
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="9999-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                                <DateInput ID="DateInput5" Skin="Default" runat="server"></DateInput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                        <td style="width: 50%; padding-left: 2px">
                                                            <telerik:RadTimePicker ID="dtpDueTime" runat="server" Culture="English (United States)"
                                                                EnableTyping="True" MaxDate="9999-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                                Skin="Default" Width="100%">
                                                                <DateInput ID="DateInput6" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                                    Skin="Default">
                                                                </DateInput>
                                                                <Calendar ID="Calendar1" runat="server" Skin="Default">
                                                                </Calendar>
                                                            </telerik:RadTimePicker>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label Text="Reminder" ID="lblReminder" meta:resourcekey="lblReminder" runat="server" />
                                            </td>
                                            <td class="subNotificationControlWidth">
                                                <asp:CheckBox runat="server" AutoPostBack="false" CssClass="removeMargin" ID="chkReminder" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label Text="Completed" ID="lblCompleted" meta:resourcekey="lblCompleted" runat="server" />
                                            </td>
                                            <td class="subNotificationControlWidth">
                                                <asp:CheckBox runat="server" AutoPostBack="true" CssClass="removeMargin" ID="chkCompleted" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label Text="Completed Date" ID="lblCompletedDate" meta:resourcekey="lblCompletedDate"
                                                    runat="server" />
                                            </td>
                                            <td class="subNotificationControlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <telerik:RadDatePicker ID="dtpCompletedDate" runat="server" MinDate="1901-01-01"
                                                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                                <DateInput ID="DateInput1" Skin="Default" runat="server">
                                                                </DateInput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                        <td style="width: 50%; padding-left: 2px">
                                                            <telerik:RadTimePicker ID="dtpCompletedTime" runat="server" Culture="English (United States)"
                                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                                Skin="Default" Width="100%">
                                                                <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                                    Skin="Default">
                                                                </DateInput>
                                                                <Calendar ID="Calendar2" runat="server" Skin="Default">
                                                                </Calendar>
                                                            </telerik:RadTimePicker>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div id="GridDiv" class="popup">
                        <fieldset class="fld">
                            <legend>
                                <asp:Label ID="lblAttachToEmail" runat="server" meta:resourcekey="lblAttachToEmail" Text="Select To Attach To Email"></asp:Label></legend>
                            <table style="width: 100%; position: absolute !important; left: 0;" cellpadding="0" cellspacing="0" class="ToolBar ShowOnTablet">
                                <tr valign="top">
                                    <td valign="top">
                                        <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td valign="middle" style="vertical-align: middle; width: 10%; padding-left: 10px;">
                                                    <telerik:RadToolBar ID="rtbAttachments" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="ShowOnTablet" OnClientButtonClicked="SubToolbarClick">
                                                        <Items>
                                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave " CommandName="Save" Height="50px"></telerik:RadToolBarButton>
                                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit TreeToolbarSaveExit " Height="50px" CommandName="SaveExit"></telerik:RadToolBarButton>
                                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnTablet TreeToolbarCancel " Height="50px" PostBack="false" CommandName="closeGrid"></telerik:RadToolBarButton>
                                                        </Items>
                                                    </telerik:RadToolBar>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <div class="PMHeader">
                                    <div class="row gridrow" style="padding-top: 0;">
                                        <div class="col-12">
                                            <telerik:RadGrid ID="rdgAttachToEmail" BorderStyle="None" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                Height="100%" AllowPaging="false" Width="100%" AutoGenerateColumns="False"
                                                HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn Reorderable="true" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="50px">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type">
                                                            <ItemTemplate>
                                                                <%# Eval("TypeTranslation").ToString%>&nbsp;
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="100px"></HeaderStyle>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description">
                                                            <ItemTemplate>
                                                                <%# Eval("Description").ToString%>&nbsp;
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="200px"></HeaderStyle>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <ItemStyle Wrap="false" />
                                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        <asp:Panel ID="pnlEditor" runat="server">
                            <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                Width="100%" Style="box-sizing: border-box" ID="RadEditor1" Skin="Default" runat="server" OnClientLoad="OnClientLoad">
                                <Content></Content>
                                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            </telerik:RadEditor>
                        </asp:Panel>
                    </div>
                </div>
            </div>

        </div>


        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>

        <asp:HiddenField ID="hdnBtnId" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnLockAfterSend" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnIsSent" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" ValidateRequestMode="Disabled" />
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
        <%--<asp:Label ID="lblOptions" runat="server" meta:resourcekey="lblOptions" Text="Options" Style="margin-left: 5px;"></asp:Label>--%>
    </form>
</body>
</html>
