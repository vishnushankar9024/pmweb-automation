<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="DocumentTeamResendMessages.aspx.vb" Inherits="Website.DocumentTeamResendMessages" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<telerik:RadScriptBlock ID="rsbDocument" runat="server">
    <script language="javascript" type="text/javascript">
        function OnClientLoad(editor, args) {
            editor.get_contentArea().style.backgroundColor = "white";
            editor.get_contentArea().style.backgroundImage = "none";
        }

        function RemoveEmailToBox(argId) {
            var hfdeletedEmailTo = $("[id$=hfdeletedEmailTo]")[0];
            hfdeletedEmailTo.value = argId;
            var btnRemoveEmailTo = $("[id$=btnRemoveEmailTo]");
            btnRemoveEmailTo.click();
        }

        function RemoveEmailCCBox(argId) {
            var hfdeletedEmailCC = $("[id$=hfdeletedEmailCC]")[0];
            hfdeletedEmailCC.value = argId;
            var btnRemoveEmailCC = $("[id$=btnRemoveEmailCC]");
            btnRemoveEmailCC.click();
        }

        function InitiateScrollBar() {
            $('.scroll-pane').jScrollPane();
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
            var spnTo = $("[id$=spnTo]")[0];
            if (spnTo.innerHTML == null || spnTo.innerHTML == "") {
                args.IsValid = false;
            }
            else {
                args.IsValid = true;
            }
            return;
        }
    </script>
</telerik:RadScriptBlock>
<head id="Head1" runat="server">
    <title></title>
    <style>
        td.reEditorModesCell{
            display:none;
        }
        td.reEditorModesCell {
            display: none;
        }

        iframe#edtBody_contentIframe {
            height: 411px !important;
            width: 100% !important;
            border-left: none;
            border-right: none;
        }

        td.reLeftVerticalSide {
            display: none;
        }

        td.reRightVerticalSide {
            display: none;
        }

        td#edtBodyCenter {
            height: 411px !important;
        }

        td#edtBodyLeft {
            display: none;
        }

        td#edtBodyRight {
            display: none;
        }

        td#edtBodyTop .reToolbar:first-child li:nth-of-type(3) a {
            width: 72px;
        }

        td#edtBodyTop .reToolbar:first-child .reToolLastItem a {
            width: 48px;
        }

        .reToolbar .reTool_text:hover span {
            background-image: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarEmail" CommandName="Send" Value="Send" ValidationGroup="Send"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent">
            <div class="row row-8-4 documentSinglePage" style="margin-bottom:24px !important;">
                <div class="col-8">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTo" runat="server" Text="To" meta:resourcekey="lblTo"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div style="width: calc(100% - 2px); height: 30px; max-height: 30px; overflow: auto; background-color: #ededed;" class="AllLightBlueBorder" id="dvTo">
                                    <span id="spnTo" runat="server" style="white-space: nowrap;"></span>
                                </div>
                                <asp:CustomValidator runat="server" ID="cvSpnTo" ErrorMessage="Not valid Email(s)"
                                    CssClass="Validator" ClientValidationFunction="CheckEmptyToMails"
                                    meta:resourcekey="cvSpnTo" Display="Dynamic" ValidationGroup="Send">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCC" runat="server" Text="CC" meta:resourcekey="lblCC"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div style="width:calc(100% - 2px); height: 30px; max-height: 30px; overflow: auto; background-color: #ededed;" class="AllLightBlueBorder" id="dvCC">
                                    <span id="spnCC" runat="server" style="white-space: nowrap;"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAdditionalCC" runat="server" Text="Additional CC" meta:resourcekey="lblAdditionalCC"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtAdditionalCC" runat="server" Width="100%" Height="30px" Style="background-color:#ededed !important;"></asp:TextBox>
                                <asp:CustomValidator runat="server" ID="cvAdditionalCC" ErrorMessage="Invalid Email"
                                    ControlToValidate="txtAdditionalCC" CssClass="Validator" ClientValidationFunction="CheckMails"
                                    meta:resourcekey="cvAdditionalCC" Display="Dynamic" ValidationGroup="Send">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubject" runat="server" Text="Subject" meta:resourcekey="lblSubject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSubject" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBody" runat="server" Text="Body" meta:resourcekey="lblBody"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadEditor ID="edtBody" DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Width="100%" Height="500px"
                                    Skin="Default" runat="server" OnClientLoad="OnClientLoad">
                                    <Content></Content>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblSendHistory" runat="server" meta:resourcekey="lblSendHistory" Text="Send History"></asp:Label>
                                    </legend>
                                    <table>
                                        <tr>
                                            <td style="width: 60%">
                                                <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDate"></asp:Label>
                                            </td>
                                            <td style="width: 40%">
                                                <asp:Label ID="lblSucceed" runat="server" Text="Succeed?" meta:resourcekey="lblSucceed"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Repeater ID="rptSendHistory" runat="server" Visible="true">
                                                    <ItemTemplate>
                                                        <table border="0">
                                                            <tr>
                                                                <td style="width: 60%">
                                                                    <asp:Label ID="lblDates" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="width: 40%">
                                                                    <asp:CheckBox ID="chkSucceed" runat="server" Enabled="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:Button ID="btnRemoveEmailCC" runat="server" CssClass="Hide" />
        <asp:HiddenField ID="hfdeletedEmailCC" runat="server" Value="0" />
        <asp:Button ID="btnRemoveEmailTo" runat="server" CssClass="Hide" />
        <asp:HiddenField ID="hfdeletedEmailTo" runat="server" Value="0" />
    </form>
</body>
</html>
