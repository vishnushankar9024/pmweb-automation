<%@ Page Title="Email" meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="MergeEmailPopup.aspx.vb" Inherits="Website.MergeEmailPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
        function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var Bidder = 0;

            var wnd = window.radopen('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source);
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

        function CheckClose(sender, args) {
            if (args.get_item().get_commandName() == "Close") {
                window.close();
                return false;
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

        function OpenContactPOPUp(ButtonId) {
            $("input[id$=hdnBtnId]").val(ButtonId);
            return OpenPOPUp('ContactMail.aspx', 420, 425, false);


        }
        function ManageAttach() {
            document.getElementById("Checkboxes").style.display = "inline";

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

    </script>
</telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="CheckClose">
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Email" EnableImageSprite="true" CssClass="ToolbarEmail"
                                            Value="Email" ValidationGroup="Email" CausesValidation="true">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row Margins documentSinglePage">
                <div class="col-4" style="width: 400px">
                    <table class="colTable" border="0">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblSucceed" runat="server" meta:resourcekey="lblSucceed" Text="Email Sent Successfully!"
                                    Visible="False" Class="Success"></asp:Label>
                                <asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed."
                                    Visible="False" Class="Validator"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px">
                                <asp:Label ID="lblFrom" CssClass="Bold" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtFrom" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left">
                                    <asp:Label Text="To" CssClass="Bold" ID="lblTo" meta:resourcekey="lblTo" runat="server" />
                                </div>
                                <div>
                                    <div style="float: right">
                                        <asp:LinkButton runat="server" ID="btnTo" CssClass="SearchButton" OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'hdnIds'), 'Contacts', 'Merge')">
                                                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtTo" runat="server" Text=""></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvToEmails" runat="server" ControlToValidate="txtTo" ValidationGroup="Email"
                                        CssClass="Validator" ErrorMessage="Enter the Email(s)" Display="Dynamic" meta:resourcekey="rfvToEmails"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" ID="cvToEmails" ControlToValidate="txtTo" CssClass="Validator"
                                        ClientValidationFunction="CheckMails" EnableClientScript="true" meta:resourcekey="cvToEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left">
                                    <asp:Label Text="CC" CssClass="Bold" ID="lblCC" meta:resourcekey="lblCC" runat="server" />
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton runat="server" ID="btnCC" CssClass="SearchButton" OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'hdnIds'), 'Contacts', 'Merge')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCC" runat="server" Text=""></asp:TextBox>
                                    <asp:CustomValidator runat="server" ID="cvCCEmails" ControlToValidate="txtCC" CssClass="Validator"
                                        ClientValidationFunction="CheckMails" meta:resourcekey="cvCCEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubject" CssClass="Bold" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSubject" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:LinkButton ID="btnAttach" runat="server" OnClientClick="return ManageAttach();" CssClass="AttachmentButton">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAttach" CssClass="Bold" runat="server" Text="Attach"
                                        meta:resourcekey="lblAttach"></asp:Label>
                                </asp:LinkButton>
                            </td>
                            <td class="controlWidth">
                                <div id="Checkboxes" runat="server">
                                    <div style="display:flex">
                                        <asp:CheckBox ID="chkWord" runat="server" />
                                    </div>
                                    <div style="display:flex">
                                        <asp:CheckBox ID="chkExcel" runat="server" />
                                    </div>
                                </div>
                                  <div style="display:flex">
                                <asp:CheckBox ID="chkAddLink" meta:resourcekey="chkAddLink" Text="Add Document Link" runat="server" />
                                      </div>
                            </td> 
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row Margins">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlEditor" runat="server">
                                    <telerik:RadEditor ID="RadEditor1" DialogsScriptFile="~/JS/RadEditorDialog.js" Width="100%" ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                          OnClientLoad="OnClientLoad" runat="server" Skin="Default" Height="350px">
                                    </telerik:RadEditor>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>
        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <asp:HiddenField ID="hdnBtnId" runat="server" />
    </form>
</body>
</html>
