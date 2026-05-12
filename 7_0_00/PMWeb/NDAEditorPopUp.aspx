<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="NDAEditorPage" CodeBehind="NDAEditorPopUp.aspx.vb" Inherits="Website.NDAEditorPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        .RadEditor .reTextArea {
            height: calc(100vh - 150px) !important;
        }

        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(1) {
            display: none;
        }


        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(2) {
            height: 29px;
        }


        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(3) {
            height: calc(100vh - 150px);
        }

            .RadEditor .reLayoutWrapper > tbody > tr:nth-child(3) > td {
                height: calc(100vh - 150px) !important;
            }

        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(4) {
            height: 29px;
        }

        .RadEditor iframe {
            height: calc(100vh - 150px) !important;
        }

        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(5) {
            display: none;
        }

        .RadEditor .reLayoutWrapper > tbody > tr:nth-child(6) {
            display: none;
        }

        @media screen and (max-width:786px) {
            .RadEditor iframe {
                height: calc(100vh - 176px) !important;
            }

            .RadEditor .reLayoutWrapper > tbody > tr:nth-child(3) {
                height: calc(100vh - 176px);
            }

                .RadEditor .reLayoutWrapper > tbody > tr:nth-child(3) > td {
                    height: calc(100vh - 176px) !important;
                }

            .RadEditor .reTextArea {
                height: calc(100vh - 176px) !important;
            }
        }
    </style>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script language="javascript" type="text/javascript">

        var editorObj;



        function OnClientLoad(editor) {
            editorObj = editor;
            editor.get_contentArea().style.backgroundColor = "white";
            editor.get_contentArea().style.backgroundImage = "none";
        }

    </script>

</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd labelColor HideOnMobileToolbar" style="width: 160px">
                    <asp:Label ID="lblSelectDisclosure" runat="server" Text="Select Disclosure"></asp:Label>
                </td>
                <td class="ToolbarTd" style="width: 240px">
                    <telerik:RadComboBox ID="ddlNDAList" AutoPostBack="true" Width="240px" runat="server" AllowCustomText="true" Text="" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                </td>
                <td class="ToolbarTd" valign="middle" style="vertical-align: middle;">
                    <telerik:RadToolBar ID="mainToolBar" Style="width: 70%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 100%"></td>
            </tr>

        </table>
        <div class="PMMainPage PMPopupMainPage">
            <div class="row documentSinglePage" style="margin-bottom: 0 !important">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr style="display: none">
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" Visible="false" Text="Description" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSubject" Visible="false" ReadOnly="true" MaxLength="100" Width="100%" runat="server"></asp:TextBox>
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
                                <asp:TextBox ID="txtEditedByDate" ReadOnly="True" Width="100%" runat="server" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <table class="documentSinglePage" style="width: 100%;">
                        <tr>
                            <td>
                                <telerik:RadEditor DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" OnClientLoad="OnClientLoad"
                                    Style="width: 100%; margin-left: auto; margin-right: auto; height: calc(100vh - 90px)"
                                    ID="edtNDA" Skin="Default" runat="server">
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
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
