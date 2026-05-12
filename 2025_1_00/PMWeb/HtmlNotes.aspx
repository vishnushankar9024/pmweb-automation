<%@ Page Language="vb" meta:resourcekey="Page" Title="Notes" AutoEventWireup="false" CodeBehind="HtmlNotes.aspx.vb" Inherits="Website.HtmlNotes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script language="javascript" type="text/javascript">
    function CloseNotesPopup() {
        var btnRefreshId;
        btnRefreshId = $(window.parent.document).find("input[id$=btnRefreshMeetingMinutes]");
        if (btnRefreshId) {
            btnRefreshId.click();
        }
    }
</script>
    <style>
   iframe{height:100% !important}
   iframe.reHtmlMode{height:0 !important}
.reHtmlMode + .reTextArea{height:100% !important}
    </style>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
            <table style="width: 100%" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
                <tr>
                    <td style="width: 100%" class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" Value="SaveAndExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Close">
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <div class="PMMainPage PMPopupMainPage R24SidePadding">
                <div class="row documentSinglePage" style="margin-bottom:0 !important">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr style="display:none">
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" Visible="false" Text="Description" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtSubject" Visible="false" ReadOnly="true" MaxLength="100" Width="100%" runat="server"></asp:TextBox>
                                    <%-- <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                        CssClass="Validator" Display="Dynamic" ForeColor=""
                        ValidationGroup="Editor" meta:resourcekey="rfvSubject"></asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEditedBy" Text="Edited By" runat="server" meta:resourcekey="lblEditedBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEditedByUser" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEditedByDate" Text="Date" runat="server"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEditedByDate" ReadOnly="True" Width="100%" runat="server" style="text-align:right;"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
           
         
                <div class="row">
                        <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Width="100%" Height="400px"
                            ID="edtNotes" Skin="Default" runat="server" DialogsScriptFile="~/JS/RadEditorDialog.js" >
                            <Content>
                            </Content>
                            <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                            <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                SearchPatterns="*.*" />
                            <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                SearchPatterns="*.*" />
                        </telerik:RadEditor>
                 
                </div> 
                <%--<div class="row">
                    <asp:Button ID="btnSave" Text="<%$ Resources:PMWeb, PerformInsert %>" runat="server" Width="100px" style="text-decoration:none !important;"/>&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" Text="<%$ Resources:PMWeb, CancelAll %>" OnClientClick="Close();return false;" runat="server" Width="100px" style="text-decoration:none !important;"/>
                </div>--%>
            </div>
    </form>
</body>
</html>
