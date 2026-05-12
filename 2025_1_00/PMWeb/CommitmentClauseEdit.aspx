<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CommitmentClauseEdit.aspx.vb" Inherits="Website.CommitmentClauseEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <style type="text/css">
        body {
            background-image: none !important;
            color: #000000 !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpNotes" runat="server" Skin="Default" />
        <div>
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td valign="top">
                        <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="ToolbarTd">

                                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                                        Width="220px" CssClass="popup-toolbar">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Text="Save"
                                                meta:resourcekey="RadToolBarButton_Save">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" meta:resourcekey="RadToolBarButton_Cancel" Text="Cancel"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>

            <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr id="trTbsDetails" runat="server">
                    <td>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div class="PMHeader">
                                        <div class="row documentSinglePage">
                                            <div class="col-4">
                                                <table class="colTable" border="0">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblLineNumber" Text="Linenumber" runat="server"></asp:Label>
                                                        </td>

                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtLineNumber" Style="text-align: right;" ReadOnly="True" runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                    </tr>

                                                    <tr>

                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblClauseId" Text="Clause ID" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtClauseId" CssClass="Double" runat="server" Width="100%"></asp:TextBox>

                                                        </td>
                                                    </tr>


                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDescription" Text="Description" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtDescription" Width="100%" runat="server"></asp:TextBox>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblAmount" Text="Amount" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%"
                                                                MaxLength="15"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-4">
                                                <table class="colTable" border="0">

                                                    <tr>
                                                        <td class="NoWrap labelWidth">

                                                            <asp:Label ID="lblEditedBy" Text="EditedBy" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <table>
                                                                <tr>
                                                                    <td width="50%">
                                                                        <asp:TextBox ID="txtEditedByUser" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td width="50%" style="padding-left: 40px">
                                                                        <asp:TextBox ID="txtEditedByDate" ReadOnly="True" Width="100%" runat="server" float="right"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="NoWra labelWidth">
                                                            <asp:Label ID="lblCreatedBy" Text="Created By" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <table>
                                                                <tr>
                                                                    <td width="50%">
                                                                        <asp:TextBox ID="txtCreatedByUser" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td width="50%" style="padding-left: 40px">
                                                                        <asp:TextBox ID="txtCreatedByDate" ReadOnly="True" Width="100%" runat="server" float="right"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="colTable" border="0">
                <tr>
                    <td colspan="5" style="background: white;">
                        <telerik:RadEditor ID="edtNotes" Skin="Default" DialogsScriptFile="~/JS/RadEditorDialog.js"  runat="server" Width="100%" Height="100%"  ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                            <Content>
                            </Content>
                            <ImageManager ViewPaths="~/Notes" UploadPaths="~/Notes" DeletePaths="~/Notes" SearchPatterns="*.*" />
                            <MediaManager ViewPaths="~/Notes" UploadPaths="~/Notes" DeletePaths="~/Notes" SearchPatterns="*.*" />
                            <FlashManager ViewPaths="~/Notes" UploadPaths="~/Notes" DeletePaths="~/Notes" SearchPatterns="*.*" />
                            <TemplateManager ViewPaths="~/Notes" UploadPaths="~/Notes" DeletePaths="~/Notes"
                                SearchPatterns="*.*" />
                            <DocumentManager ViewPaths="~/Notes" UploadPaths="~/Notes" DeletePaths="~/Notes"
                                SearchPatterns="*.*" />
                        </telerik:RadEditor>
                    </td>
                </tr>

            </table>
<%--            <table class="colTable">
                <tr>
                    <td style="">
                        <asp:Button ID="btnSave" Text="<%$ Resources:PMWeb, PerformInsert %>" runat="server" ValidationGroup="Editor" />&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" Text="<%$ Resources:PMWeb, CancelAll %>" runat="server" />
                    </td>
                </tr>
            </table>--%>
        </div>
    </form>
</body>
</html>
