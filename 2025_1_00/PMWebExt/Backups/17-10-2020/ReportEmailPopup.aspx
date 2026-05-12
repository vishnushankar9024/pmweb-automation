<%@ Page Language="vb" Title="Email" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ReportEmailPopup.aspx.vb" Inherits="Website.ReportEmailPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
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

        //function OpenContactPOPUp(ButtonId) {
        //    debugger;
        //    $("input[id$=hdnBtnId]").val(ButtonId);
        //    var ToIds = $("input[id$=hdnToIds]").val();
        //    var CCIds = $("input[id$=hdnCCIds]").val();
        //    return OpenPOPUp('ContactMail.aspx?ToIds=' + ToIds + '&CCIds=' + CCIds + '&ButtonId=' + ButtonId, 470, 455, false);


        //}

        function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=0&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }

            return false;
        }


        function AddContacts() {
            var btnAddContacts = $("[id$=btnAddContacts]");
            btnAddContacts.click();

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
    <style>
        @media screen and (max-width: 843px) and (min-width: 320px){
            .labelWidth {
                width:160px !important;
            }
            .controlWidth {
            width:240px !important;
            }
            .PMHeader .row .col-4{width:400px !important}
            .documentSinglePage {
                margin-top: 55px;
            }
        }
    </style>
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
                                <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="CheckClose">
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
        <table class="colTable">
            <tr>
                <td>
                    <asp:Label ID="lblSucceed" runat="server" meta:resourcekey="lblSucceed" Text="Email Sent Successfully!"
                        Visible="False" Class="Success"></asp:Label>
                    <asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed."
                        Visible="False" Class="Validator"></asp:Label>
                </td>
            </tr>
        </table>

                    <div class="PMHeader">
                        <div class="row Margins documentSinglePage" style="margin-bottom:0;">
                            <div class="col-4" style="width:400px">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td class="labelWidth" style="width:160px">
                                            <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFrom" Width="100%" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label Text="To" ID="lblTo" meta:resourcekey="lblTo" runat="server" />
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="btnTo" CssClass="SearchButton" OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'hdnIds'), 'Contacts', 'ReportPreview')">
                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTo" runat="server" Width="100%" Text=""></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvToEmails" runat="server" ControlToValidate="txtTo" ValidationGroup="Email"
                                                    CssClass="Validator" ErrorMessage="Enter the Email(s)" Display="Dynamic" meta:resourcekey="rfvToEmails"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator runat="server" ID="cvToEmails" ControlToValidate="txtTo" CssClass="Validator"
                                                    ClientValidationFunction="CheckMails" EnableClientScript="true" meta:resourcekey="cvToEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label Text="CC" ID="lblCC" meta:resourcekey="lblCC" runat="server" />
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="btnCC" CssClass="SearchButton" OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'txtCC'), this.id.replace('btnCC', 'hdnIds'), 'Contacts', 'ReportPreview')">
                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCC" runat="server" Width="100%" Text=""></asp:TextBox>
                                                <asp:CustomValidator runat="server" ID="cvCCEmails" ControlToValidate="txtCC" CssClass="Validator"
                                                    ClientValidationFunction="CheckMails" meta:resourcekey="cvCCEmails" ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtSubject" runat="server" Width="100%" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="btnAttach" runat="server" Enabled="false" CssClass="AttachmentButton">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAttach" runat="server" Text="Attach" CssClass="labelWidth"
                                                    meta:resourcekey="lblAttach"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <div id="Checkboxes" runat="server">
                                                <asp:LinkButton ID="btnPdf" runat="server" CssClass="ToolbarPDFButton">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblReportName" runat="server"></asp:Label>
                                                </asp:LinkButton>
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
                                            <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                                 ID="RadEditor1" Width="100%" OnClientLoad="OnClientLoad" runat="server" Skin="Default" Height="250px" >
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
                            </table>
                                </div>
                    </div>

        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <asp:HiddenField ID="hdnBtnId" runat="server" Value="" />
        <asp:HiddenField ID="hdnIds" runat="server" Value="" />
        <asp:HiddenField ID="hdnEmails" runat="server" />
    </form>
</body>
</html>
