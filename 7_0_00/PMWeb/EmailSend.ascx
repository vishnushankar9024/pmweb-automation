<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EmailSend.ascx.vb" Inherits="Website.EmailSend" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
    <script type="text/javascript">
        var editorObj;
        var editorContent;
    </script>
</telerik:RadScriptBlock>
<asp:HiddenField runat="server" ID="hdnFM_SelectedFile" />
<table cellpadding="0" class="ToolbarTd" cellspacing="0" width="100%" style="width:100%;table-layout:fixed;height:50px;background-color: #ededed;padding-left:0px !important">
    <tr style="vertical-align: top;">
        <td valign="middle" style="vertical-align: middle; width: 100%" >
            <telerik:RadToolBar ID="mainToolBar" CssClass="EmailSendtoolbar" OnClientButtonClicked="onToolbarClicked" runat="server" Skin="Default" AutoPostBack="true">
                <Items>
                    <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Email" EnableImageSprite="true" CssClass="ToolbarEmail"
                        Value="Email"  ValidationGroup="Email" CausesValidation="true">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="CancelSendMail"
                        EnableImageSprite="true" CssClass="ToolbarCancelSendMail"  PostBack="true" CausesValidation="false">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>

<table style="width: 100%;" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td>
            <div class="PMMainPage JustifyContent">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlFrom" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                        Width="250px" Filter="Contains" MarkFirstMatch="true" EnableItemCaching="false"
                                        EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>' NoWrap="True" AllowCustomText="true"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        Height="300px" CausesValidation="False" OnItemsRequested="ddl_ItemsRequested">
                                        <HeaderTemplate>
                                            <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                    </td>
                                                    <td style="width: 135px;">
                                                        <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                    </td>
                                                    <td style="width: 135px;">
                                                        <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <div>
                                        <asp:RequiredFieldValidator ID="rfvFromEmail" runat="server" ControlToValidate="ddlFrom"
                                            ValidationGroup="Email" CssClass="Validator" ErrorMessage="Enter an Email" Display="Dynamic"
                                            meta:resourcekey="rfvFromEmail"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="ddlFrom"
                                            CssClass="Validator" ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ValidationGroup="Email" Display="Dynamic" meta:resourcekey="revEmail"></asp:RegularExpressionValidator>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label Text="To"  ID="lblTo" meta:resourcekey="lblTo" runat="server" />
                                    </div>
                                    <div style="float: right">
                                            <asp:LinkButton runat="server" ID="LinkButton1"
                                                OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('LinkButton1', 'txtTo'), this.id.replace('LinkButton1', 'txtTo'), this.id.replace('LinkButton1', 'hdnIds'), 'Contacts', 'Emailhome')"
                                                CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtTo" runat="server"  Text=""></asp:TextBox>
                                    <div>
                                        <asp:RequiredFieldValidator ID="rfvToEmails" runat="server" ControlToValidate="txtTo"
                                            ValidationGroup="Email" CssClass="Validator" ErrorMessage="Enter Email(s)" Display="Dynamic"
                                            meta:resourcekey="rfvToEmails"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator runat="server" ID="cvToEmails" ControlToValidate="txtTo" CssClass="Validator"
                                            ClientValidationFunction="CheckMails" EnableClientScript="true" meta:resourcekey="cvToEmails"
                                            ErrorMessage="Not valid Email(s)" Display="Dynamic" ValidationGroup="Email" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label Text="CC"  ID="lblCC" meta:resourcekey="lblCC" runat="server" />
                                    </div>
                                    <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter"
                                                OnClientClick="return OpenNotificationMultipleCompanyFilterPopup(this.id.replace('imgfilter', 'txtCC'), this.id.replace('imgfilter', 'txtCC'), this.id.replace('imgfilter', 'hdnIds'), 'Contacts', 'Emailhome')"
                                                CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCC" runat="server" Text=""></asp:TextBox>
                                    <div>
                                        <asp:CustomValidator runat="server" ID="cvCCEmails" ControlToValidate="txtCC" CssClass="Validator"
                                            ClientValidationFunction="CheckMails" meta:resourcekey="cvCCEmails" ErrorMessage="Not valid Email(s)"
                                            Display="Dynamic" ValidationGroup="Email" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server"  Text="Manual CC" ID="lblManualCC" meta:resourcekey="lblManualCC"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" ID="txtAddEmails"></asp:TextBox>
                                    <div>
                                        <asp:CustomValidator runat="server" ID="cvEmails" ControlToValidate="txtAddEmails" CssClass="Validator" ClientValidationFunction="CheckMails" meta:resourcekey="cvToEmails" Display="Dynamic" ValidationGroup="Email" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtSubject" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div class="AttachmentButton">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" Text="Attach file from :" ID="lblAttachmentLabel" meta:ResourceKey="lblAttachmentLabel" />
                                    </div>
                                    <asp:LinkButton ID="btnAttachDesktop" meta:resourcekey="btnAttachDesktop" Style="text-decoration: underline;"
                                        Text="Desktop" runat="server" OnClientClick="return addAttach();">
                                    </asp:LinkButton>
                                    <br />
                                    <asp:LinkButton ID="btnAttachFileManager" runat="server" Text="Document Manager" Style="text-decoration: underline; white-space: nowrap;"
                                        meta:resourcekey="btnAttachFileManager" OnClientClick="return AttachFileForFileManager(this);"></asp:LinkButton>
                                </td>
                                <td class="controlWidth">
                                    <asp:Repeater ID="rptEmailAttachments" runat="server" OnItemCommand="rptEmailAttachments_ItemCommand">
                                        <ItemTemplate>
                                            <div class="floatLeft" style="border: 1px solid #a3b9d8; padding: 5px; margin: 2px 3px; background-color: #e5ecf7; white-space: nowrap;">
                                                <a id="lkDownload" runat="server" href="#">
                                                    <%#Eval("FileName")%></a>
                                                <asp:LinkButton ID="lknRemoveAttach" Text="X" CommandArgument='<%#Eval("Id")%>' 
                                                    CommandName="RemoveAttachement" runat="server">X</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                               <tr>
                                <td style="vertical-align: top;" colspan="2">
                                    <asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed" Visible="False" Class="Failure"></asp:Label>
                                </td>
                            </tr>
                            <tr class="Hide">
                                <td class="labelWidth">
                                    <asp:Button ID="btnRefreshAttach" runat="server" CssClass="Hide" Text="RefreshAttach" />
                                    <asp:Button runat="server" ID="btnAttachFromFM" CssClass="Hide" Text="attach" OnClick="btnAttachFromFM_Click" />
                                </td>
                                <td class="controlWidth">
                                    <div class="floatLeft">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlEditor" runat="server">
                                        <telerik:RadEditor ID="RadEditor1" Style="box-sizing: border-box;" Width="100%" OnClientLoad="OnRadEditorClientLoad" 
                                            ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"   DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                            runat="server" Skin="Default" Height="350px">
                                               <ImageManager MaxUploadFileSize="9999999" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                        </telerik:RadEditor>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField runat="server" ID="hdnIsLoged" Value="0" />
<asp:HiddenField runat="server" ID="hdnIds" />
<telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
    ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
    InitialBehavior="None" Left="" Style="display: none;" Top="">
</telerik:RadWindowManager>
<asp:HiddenField ID="hdnBtnId" runat="server" />
