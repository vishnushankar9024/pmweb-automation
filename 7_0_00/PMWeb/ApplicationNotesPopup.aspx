<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ApplicationNotesPopup.aspx.vb" Inherits="Website.ApplicationNotesPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
   <style>
       .ToolBar{position:absolute;top:-1px;}
       .TToolbarTd{position:relative;bottom:-8px;}
    </style>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
  
          <table style="width: 100%" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
                <tr>
                    <td style="width: 100%;position:relative;bottom:-8px;" class="ToolbarTd" >
                        <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" style="position:absolute;top:0px;">
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
                            <tr >
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" Visible="True" Text="Description" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDescription" Visible="True"  Width="100%" runat="server"></asp:TextBox>
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
                   <%--  <div class="col-12">--%>

                <telerik:RadEditor ID="edtNotes" Skin="Default" runat="server" Width="100%"  ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"   DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                    <Content></Content>
                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <TemplateManager ViewPaths="~/Images/Shared"  UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                </telerik:RadEditor>
                <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="edtNotes"
                    CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Enter the notes."
                    ValidationGroup="Editor" meta:resourcekey="rfvNotes">
                </asp:RequiredFieldValidator>
         <%--  </div>--%>
</div>
        <%-- <div class="row">    
             <table>--%>
     <%--   <tr>
            <td colspan>
                <asp:Button ID="btnSave" Text="<%$ Resources:PMWeb, PerformInsert %>" runat="server" ValidationGroup="Editor" Visible='<%# Not PM.Application.ApplicationInfo.Submitted.HasValue%>'  />&nbsp;&nbsp;
                <asp:Button ID="btnCancel" Text="<%$ Resources:PMWeb, CancelAll %>" runat="server" Visible='<%# Not PM.Application.ApplicationInfo.Submitted.HasValue%>'  />
            </td>
        </tr>--%>
<%--   </table>

         </div>--%>
             </div>
    
<%--         <div class="PMMainPage PMPopupMainPage">
                <div class="row row-NotesPopup">
                    <div class="col-4">
   
    <table border="0"  class="colTable">
        <tr>
            <td class="labelWidth">
                <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
            </td>
            <td class="controlWidth">
                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtDescription"
                    CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Description is required."
                    ValidationGroup="Editor" meta:resourcekey="rfvSubject">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        </table>
                        </div>
                    </div>--%>
   <%--<asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Class="Hide"></asp:TextBox>--%>
    </form>
</body>
</html>
