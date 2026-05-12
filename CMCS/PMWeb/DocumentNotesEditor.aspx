<%@ Page Title="Notes" Language="vb" AutoEventWireup="false" CodeBehind="DocumentNotesEditor.aspx.vb"
    Inherits="Website.DocumentNotesEditor" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<head id="Head1" runat="server">
    <style type="text/css">
        body {
            background-image: none !important;
            color: #000000 !important;
        }

        .rwInnerSpan {
            cursor: pointer !important;
        }
        @media screen and (max-width:1032px) {
        .col-560{padding-left:0px !important;padding-right:24px !important}
        }
         @media screen and (max-width:832px) {
        .col-560{padding-right:0px !important}
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript" src="JS/TelerikUtilities.js"></script>
        <telerik:RadCodeBlock runat="server">
            <script type="text/javascript">

               
                function Click_Handler(sender, args) {
                    var value = args.get_item().get_commandName();

                    switch (value) {
                        case 'Cancel':
                            CloseRadWnd();
                            break;
                    }
                }

                function CallbackConf(args) {
                    window.location = 'DocumentNotesEditor.aspx';

                }

                function openWarning() {
                    var lblWarningMsg = $("span[id$=lblWarningMsg]");
                    radconfirm(unescape(lblWarningMsg.html()), CallbackConf, 400, 150, null, "PMWeb");
                }

                function ConfirmSave(action) {
                    var btnSaveToDatabase = $("[id$=btnSaveToDatabase]");
                    var hdnToolbarSaveAction = $("[id$=hdnToolbarSaveAction]")[0];
                    hdnToolbarSaveAction.value = action;
                    btnSaveToDatabase.click();
                    return false;
                }

            </script>
        </telerik:RadCodeBlock>

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls >
                        <telerik:AjaxUpdatedControl ControlID="TreeToolbar"  />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpNotes" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%; z-index: 999" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="Click_Handler" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

            <div class="PMMainPage PMPopupMainPage documentSinglePage">
                <div class="row row-NotesPopup">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblItem" runat="server" meta:resourcekey="lblItem"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtItem" ReadOnly="True" disabled="disabled" runat="server" Style="text-align: right;"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtSubject" MaxLength="500" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                                        CssClass="Validator" Display="Dynamic" ForeColor=""
                                        ValidationGroup="Editor" meta:resourcekey="rfvSubject"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-560">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCreatedBy" runat="server" Text="Created By" meta:resourcekey="lblCreatedBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="60%">
                                                <asp:TextBox ID="txtCreatedByUser" ReadOnly="True" disabled="disabled" runat="server" Style="text-align: right;"></asp:TextBox>
                                            </td>
                                            <td width="40%" style="padding-left: 10px;">
                                                <asp:TextBox ID="txtCreatedByDate" ReadOnly="True" Style="text-align: right;" disabled="disabled" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEditedBy" runat="server" meta:resourcekey="lblEditedBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="60%">
                                                <asp:TextBox ID="txtEditedByUser" ReadOnly="True" disabled="disabled" runat="server" Style="text-align: right;"></asp:TextBox>
                                            </td>
                                            <td width="40%" style="padding-left: 10px;">
                                                <asp:TextBox ID="txtEditedByDate" ReadOnly="True" Style="text-align: right;" disabled="disabled" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>    
                <div class="row">
                     <div class="col-12">
                         <telerik:RadEditor DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Style="height: 100%!important; width: 100%;" ID="edtNotes" Skin="Default" runat="server" >
                             <Content></Content>
                             <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                             <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                             <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                             <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                             <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                         </telerik:RadEditor>
                         <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="edtNotes"
                             CssClass="Validator" Display="Dynamic" ForeColor=""
                             ValidationGroup="Editor" meta:resourcekey="rfvNotes"></asp:RequiredFieldValidator>
                     </div>
                </div>
            </div>
        <div style="width: 100%; padding-top: 20px; display: none">
            <asp:Button ID="btnSave" Text="<%$ Resources:PMWeb, PerformInsert %>" runat="server" ValidationGroup="Editor" OnClientClick="return ConfirmSave();" />&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" Text="<%$ Resources:PMWeb, CancelAll %>" runat="server" />
            <asp:Button ID="btnSaveToDatabase" runat="server" ValidationGroup="Editor" CssClass="Hide" />&nbsp;&nbsp;
        </div>
        <asp:HiddenField runat="server" ID="hdnCancelReload" Value="0" />
        <asp:HiddenField runat="server" ID="hdnToolbarSaveAction" Value="0" />
        <asp:Label runat="server" ID="lblWarningMsg" CssClass="Hide"></asp:Label>
        <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default"
            Localization-OK="<%$ Resources:PMWeb, Confirm_Reload %>" Localization-Cancel="<%$ Resources:PMWeb, Confirm_Cancel %>">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
