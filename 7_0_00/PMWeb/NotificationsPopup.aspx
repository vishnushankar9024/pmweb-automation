<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="NotificationsPopup.aspx.vb" Inherits="Website.NotificationsPopup" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
     <script type="text/javascript">
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
             var ObjectType = querySt('ObjectType');
             if ((Entitype == '0') && (ObjectType != 'BUDGETINITIATIVES')) {
                 ProjectId = EntityId;
             }
             var win = window.open('NotificationCompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
             return false;
         }

         function OpenNotificationSingleCompanyFilterPopup1(txtFullContact, txtContact, txtEmail, txtIds, Type, Source) {
             var left = (screen.width - 920) / 2;
             var top = (screen.height - 300) / 2;
             var ProjectId = 0;
             var Entitype = GetquerySt('EntityType');
             var EntityId = GetquerySt('EntityId');
             var ObjectType = GetquerySt('ObjectType');
             if ((Entitype == '0') && (ObjectType != 'BUDGETINITIATIVES')) {
                 ProjectId = EntityId
             }
             var win = window.open('NotificationCompaniesFilterPopup.aspx?txtFullContact=' + txtFullContact + '&txtContact=' + txtContact + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
                     'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
             return false;
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
                 ClosePopWnd(window);
                 return false;
             }
         }

         function SaveContacts(sender, args) {
             CopyToHidden();
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

     </script>
    </telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
      <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="dtpSendDate" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="dtpSendDate"  />
                     <telerik:AjaxUpdatedControl ControlID="dtpDueDate"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="chkCompleted" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="dtpCompletedDate"  />
                   <telerik:AjaxUpdatedControl ControlID="chkCompleted"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
        <asp:TextBox Visible="false" runat="server" ID="txtCreatedBy" ReadOnly="true" Width="95px"></asp:TextBox>
        <telerik:RadDatePicker ID="dtpCreatedDate" Visible="false" Enabled="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Default" EnableTyping="True">
            <DateInput ID="DateInput4" Skin="Default" runat="server"></DateInput>
        </telerik:RadDatePicker>
        <telerik:RadDatePicker ID="dtpSendDate" Visible="false" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Default" EnableTyping="True">
            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            <DateInput ID="DateInput6" Skin="Default" runat="server" AutoPostBack="True"></DateInput>
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
 

        <table cellpadding="0" cellspacing="0" border="0">
            <tr class="toolbar">
                <td style="width: 760px">
                    <asp:Panel runat="server" ID="pnlMainToolbar">
                        <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" Skin="Default" OnClientButtonClicking="SaveContacts" AutoPostBack="true"
                            OnClientButtonClicked="CheckClose" CssClass="small-toolbar">
                            <Items>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Email" EnableImageSprite="true" CssClass="ToolbarEmail"
                                    Value="Email" meta:resourcekey="RadToolBarButton_Send" Text="Send" ValidationGroup="Email" CausesValidation="true">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s" Text="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                    Value="Close" meta:resourcekey="RadToolBarButton_Close" Text="Close">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton CssClass="ToolBarRight" PostBack="False" Text="" Value="Sent">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td class="NoWrap">
                                                    <asp:Label ID="lblCreatedBy" runat="server"></asp:Label>
                                                </td>
                                                <td class="NoWrap">
                                                    <asp:Label ID="lblSentBy" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel runat="server" ID="pnlHdn">
                        <asp:Label ID="lblSucceed" runat="server" meta:resourcekey="lblSucceed" Text="Email Sent Successfully!" Visible="False" Class="Success"></asp:Label>
                        <asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed." Visible="False" Class="Validator"></asp:Label>
                        <asp:Label ID="lblReportFail" runat="server" Visible="False" Class="Validator" Text="<%$ Resources:PMWeb, Notification_UnconfiguredReport %>"></asp:Label>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
        
                    <asp:Panel ID="pnlNotification" runat="server">
        <table border="0">
            <tr>
                <td style="vertical-align:top;">
                        <table style="vertical-align: top; margin: 5px; width: 780px;" cellspacing="0" border="0">
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:HiddenField runat="server" ID="hdnIsLoged" Value="0" ValidateRequestMode="Disabled" />
                                    <asp:HiddenField runat="server" ID="hdnFromId" ValidateRequestMode="Disabled" />
                                    <asp:HiddenField runat="server" ID="hdnFrom" ValidateRequestMode="Disabled" />
                                    <asp:HiddenField runat="server" ID="hdnFromEmail" ValidateRequestMode="Disabled" />
                                    <asp:Label ID="lblFrom" CssClass="Bold" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                </td>
                                <td style="width: 715px; padding-left: 10px;vertical-align:top;" class="NoWrap">
                                    <asp:TextBox ID="txtFrom" runat="server" Width="583px" Text=""></asp:TextBox>
                                    <input type="button" runat="server" style="padding-bottom: 10px" class="SmallButton" value=":::" id="btnFrom" onclick="return OpenNotificationSingleCompanyFilterPopup1(this.id.replace('btnFrom', 'txtFrom'), this.id.replace('btnFrom', 'hdnFrom'), this.id.replace('btnFrom', 'hdnFromEmail'), this.id.replace('btnFrom', 'hdnFromId'), 'Contacts', 'Notification')" />
                                    <asp:CheckBox ID="chkIsSystem" runat="server" Style="vertical-align: middle" />
                                    <asp:Label ID="lblSystem" runat="server" CssClass="Bold" Text="System1" meta:resourcekey="lblSystem" />
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:Label Text="To" CssClass="Bold" ID="lblTo" meta:resourcekey="lblTo" runat="server" />
                                </td>
                                <td style="width: 715px; padding-left: 10px;">
                                    <asp:TextBox ID="txtTest" CssClass="Hide" runat="server" Width="80%" Text="test"></asp:TextBox>
                                    <div style="Width: 655px; max-width: 655px; height: 30px; max-height: 30px; overflow: auto; float: left" class="AllLightBlueBorder scroll-pane" runat="server" id="dvTo">
                                        <span id="spnToCompany" runat="server" style="white-space: nowrap;"></span>
                                        <asp:HiddenField ID="hdnToCompany" runat="server" ValidateRequestMode="Disabled" />
                                    </div>
                                    <input type="button" class="SmallButton" value=":::" runat="server" style="padding-bottom: 10px; margin-left: 3px;" id="btnTo" onclick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnTo', 'spnToCompany'), this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'hdnIds'), 'Contacts', 'Notification')" />
                                    <div style="clear: both">
                                        <asp:CustomValidator runat="server" ID="CustomValidator2" ControlToValidate="txtTest" CssClass="Validator" ClientValidationFunction="CheckEmptyToMails" EnableClientScript="true" meta:resourcekey="rfvToEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label Text="CC" CssClass="Bold" ID="lblCC" meta:resourcekey="lblCC" runat="server" />
                                </td>
                                <td valign="top" style="width: 715px; padding-left: 10px;">
                                    <div style="Width: 655px; max-width: 655px; height: 30px; max-height: 30px; overflow: auto; float: left" class="AllLightBlueBorder scroll-pane" runat="server" id="dvCC">
                                        <span id="spnCC" runat="server" style="white-space: nowrap;"></span>
                                        <asp:HiddenField ID="hdnCC" runat="server" ValidateRequestMode="Disabled" />
                                    </div>
                                    <input type="button" runat="server" style="padding-bottom: 10px; margin-left: 3px;" value=":::" class="SmallButton" id="btnCC" onclick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnCC', 'spnCC'), this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'NotExistIds'), 'Contacts', 'Notification')" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label Text="BCC" CssClass="Bold" ID="lblBCC" meta:resourcekey="lblBCC" runat="server" />
                                </td>

                                <td style="width: 715px; padding-left: 10px;" id="tdBccbtn" runat="server">
                                    <div style="Width: 655px; max-width: 655px; height: 30px; max-height: 30px; overflow: auto; float: left" class="AllLightBlueBorder scroll-pane" runat="server" id="dvBcc">
                                        <span id="spnBCC" runat="server" style="white-space: nowrap;"></span>
                                        <asp:HiddenField ID="hdnBCC" runat="server" ValidateRequestMode="Disabled" />
                                    </div>

                                    <input type="button" runat="server" style="padding-bottom: 10px; margin-left: 3px;" value=":::" class="SmallButton" id="btnBCC" onclick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnBCC', 'spnBCC'), this.id.replace('btnBCC', 'txtBCC'), this.id.replace('btnBCC', 'hdnIds'), 'Contacts', 'Notification')" />

                                </td>
                            </tr>
                            <tr>
                                <td style="width: 60px;">
                                    <asp:Label runat="server" Text="Manual CC" ID="lblManualCC" meta:resourcekey="lblManualCC"></asp:Label>
                                </td>
                                <td style="width: 715px; padding-left: 10px;">
                                    <asp:TextBox runat="server" Width="653px" ID="txtAddEmails"></asp:TextBox>
                                    <div>
                                        <asp:CustomValidator runat="server" ID="cvEmails" ControlToValidate="txtAddEmails" CssClass="Validator" ClientValidationFunction="CheckMails" meta:resourcekey="cvToEmails" Display="Dynamic" ValidationGroup="Email" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 55px">
                                    <asp:Label ID="lblSubject" CssClass="Bold" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                                </td>
                                <td style="width: 300px; padding-left: 10px;">
                                    <asp:TextBox ID="txtSubject" MaxLength="1000" runat="server" Width="653px" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-top: 10px;" colspan="2">
                                    <table border="0">
                                        <tr>
                                            <td valign="top" style="height: 215px;">
                                                <fieldset style="height: 230px;">
                                                    <legend>
                                                        <asp:Label ID="lblOptions" runat="server" meta:resourcekey="lblOptions" Text="Options" Style="margin-left: 5px;"></asp:Label></legend>
                                                    <table cellpadding="0" cellspacing="2px" border="0">
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label ID="lblStatus" CssClass="Bold" runat="server" meta:resourcekey="lblStatus" Text="Status"></asp:Label>
                                                            </td>
                                                            <td style="width: 200px; padding-left: 10px;" colspan="2">
                                                                <telerik:RadComboBox ID="ddlStatus" Width="200px" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                                                    CloseDropDownOnBlur="true" DropDownWidth="300px" NoWrap="False" AllowCustomText="true">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label ID="lblNotification" CssClass="Bold" runat="server" meta:resourcekey="lblNotification" Text="Notification type"></asp:Label>
                                                            </td>
                                                            <td style="width: 200px; padding-left: 10px;" colspan="2">
                                                                <telerik:RadComboBox ID="ddlNotification" Width="200px" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                                                    CloseDropDownOnBlur="true" DropDownWidth="300px" NoWrap="False" AllowCustomText="true">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label Text="Reference" CssClass="Bold" ID="lblReference" meta:resourcekey="lblReference" runat="server" />
                                                            </td>
                                                            <td style="width: 200px; padding-left: 10px;" colspan="2">
                                                                <asp:TextBox runat="server" Width="195px" MaxLength="255" ID="txtReference"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label Text="Due Date" CssClass="Bold" ID="lblDueDate" meta:resourcekey="lblDueDate" runat="server" />
                                                            </td>
                                                            <td style="width: 200px; padding-left: 10px;">
                                                                <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Default" EnableTyping="True">
                                                                    <DateInput ID="DateInput5" Skin="Default" runat="server"></DateInput>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                            <td>
                                                                <telerik:RadTimePicker ID="dtpDueTime" runat="server" Culture="English (United States)"
                                                                    EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                                    Skin="Default" Width="103px">
                                                                    <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                                        Skin="Default">
                                                                    </DateInput>
                                                                    <Calendar ID="Calendar1" runat="server" Skin="Default">
                                                                    </Calendar>
                                                                </telerik:RadTimePicker>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label Text="Reminder" CssClass="Bold" ID="lblReminder" meta:resourcekey="lblReminder" runat="server" />
                                                            </td>
                                                            <td style="width: 200px; padding-left: 6px;" colspan="2">
                                                                <asp:CheckBox runat="server" AutoPostBack="false" Checked="true" ID="chkReminder" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label Text="Completed" CssClass="Bold" ID="lblCompleted" meta:resourcekey="lblCompleted" runat="server" />
                                                            </td>
                                                            <td style="width: 200px; padding-left: 6px;" colspan="2">
                                                                <asp:CheckBox runat="server" AutoPostBack="true" ID="chkCompleted" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label Text="Completed Date" CssClass="Bold" ID="lblCompletedDate" meta:resourcekey="lblCompletedDate"
                                                                    runat="server" />
                                                            </td>
                                                            <td style="width: 200px; padding-left: 10px;">
                                                                <telerik:RadDatePicker ID="dtpCompletedDate" runat="server" MinDate="1901-01-01"
                                                                    MaxDate="2100-01-01" Width="103px" Skin="Default" EnableTyping="True">
                                                                    <DateInput ID="DateInput1" Skin="Default" runat="server">
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                            <td>
                                                                <telerik:RadTimePicker ID="dtpCompletedTime" runat="server" Culture="English (United States)"
                                                                    EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                                    Skin="Default" Width="103px">
                                                                    <DateInput ID="DateInput3" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                                        Skin="Default">
                                                                    </DateInput>
                                                                    <Calendar ID="Calendar2" runat="server" Skin="Default">
                                                                    </Calendar>
                                                                </telerik:RadTimePicker>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 80px" class="NoWrap">
                                                                <asp:Label ID="lblIncludeUrl" meta:resourcekey="lblIncludeUrl" CssClass="Bold" runat="server" Text="Add Link"></asp:Label>
                                                            </td>
                                                            <td style="width: 200px; padding-left: 6px;" colspan="2">
                                                                <asp:CheckBox ID="chkAddLink" Checked="True" Text="" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                            <td valign="top" style="height: 215px">
                                                <fieldset style="height: 230px; width: 420px;">
                                                    <legend>
                                                        <asp:Label ID="lblAttachToEmail" runat="server" meta:resourcekey="lblAttachToEmail" Text="Select To Attach To Email" Style="margin-left: 5px;"></asp:Label></legend>
                                                    <div style="height: 215px; overflow: auto; border: solid 1px #688caf">
                                                        <telerik:RadGrid ID="rdgAttachToEmail" BorderStyle="None" runat="server" Height="100%" AllowPaging="true" PageSize="5" Width="100%" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                                                InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                                                                <Columns>

                                                                    <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="50px">
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Height="20px" />
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" Groupable="false" HeaderText="Type" UniqueName="Type">
                                                                        <ItemTemplate>
                                                                            <%# Eval("TypeTranslation").ToString%>&nbsp;
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" Groupable="false" HeaderText="Description" UniqueName="Description">
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
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    
                </td>
            </tr>
            <tr>
                <td style="height:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Panel ID="pnlEditor" runat="server">
                        <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                             Width="758px" Height="300px"  ID="RadEditor1" Skin="Default" runat="server" OnClientLoad="OnClientLoad">
                            <Content></Content>
                            <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        </telerik:RadEditor>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="height:10px;">
                </td>
            </tr>
        </table>
        </asp:Panel>
        <table border="0">
            <tr>
                <td style="vertical-align:top">
                <asp:Panel ID="pnlError" runat="server" Width="100%">
                        <table width="100%" border="0" >
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>

        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <asp:HiddenField ID="hdnBtnId" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnLockAfterSend" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnIsSent" runat="server" ValidateRequestMode="Disabled" />
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" ValidateRequestMode="Disabled" />
    </form>
</body>
</html>
