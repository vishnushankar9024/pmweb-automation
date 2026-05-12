<%@ Page Title="PMWeb Word" Language="vb" AutoEventWireup="false" CodeBehind="MergePrintPopup.aspx.vb" Inherits="Website.MergePrintPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .reTool .ToggleBorder {
            background-image: url(Images/Global/sToggleBorders.png);
        }

        .chi {
            height: calc(100vh - 52px) !important;
            box-sizing: border-box !important;
        }

        table#rdeContentWrapper {
            height: 100% !important;
        }

        .RadEditor .reToolZone {
            padding-top: 0px !important;
        }

        .RadToolBar .ToolbarSaveAs .rtbIcon {
            background-image: url("CSS/Images/rtbCopy.png") !important;
        }

        .RadToolBar .rtbItemHovered .ToolbarSaveAs .rtbIcon,
        .RadToolBar .rtbItemFocused .ToolbarSaveAs .rtbIcon {
            background-image: url("CSS/Images/rtbCopy.png") !important; /*change to hoveredicon*/
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                var msgNewAttachment = '<%= Me.JSEscape(Me.GetLocalResourceObject("MessageNewAttachment")) %>';
                var editorObj;
                var editorContent;
                function OnClientLoad(editor) {
                    editor.fire("ToggleTableBorder");
                }

                function OnClientModeChange(editor) {
                    var mode = editor.get_mode();
                    switch (mode) {
                        case 1:
                            editor.fire("ToggleTableBorder");
                            break;

                        case 4:
                            setTimeout(function () {
                                var tool = editor.getToolByName("Print");
                                tool.setState(0);
                            }, 0);
                            break;
                    }
                }

                //Telerik.Web.UI.Editor.CommandList["ToggleBorder"] = function (commandName, editor, args) {
                //    editor.fire("ToggleTableBorder");
                //};

                function AlertNewAttachment() {
                    alert(msgNewAttachment);
                }
                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                        sender.close(true);
                    if (args.get_item().get_value() == "PDF") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                 var button = mainToolBar.findItemByValue("PDF");
                 button.click();
             }
             if (args.get_item().get_value() == "MSWord") {
                 var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                 var button = mainToolBar.findItemByValue("MSWord");
                 button.click();
             }
             if (args.get_item().get_value() == "Cancel") {
                 var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                 var button = mainToolBar.findItemByValue("Cancel");
                 button.click();
             }
             if (args.get_item().get_value() == "History") {
                 var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                 var button = mainToolBar.findItemByValue("History");
                 button.click();
             }
             maintoolbarClick(args.get_item().get_value());
         }

         function click_handler(sender, args) {
             maintoolbarClick(args)
         }

         function maintoolbarClick(args) {
             switch (args.get_item().get_commandName()) {
                 case 'MSWord':
                     return CloseWordMergeWindow();
                     break;
             }
         }

         function CloseWordMergeWindow() {
             var oWindow = null;
             if (window.radWindow) oWindow = window.radWindow;
             else if (window.frameElement != null) {
                 if (window.frameElement.radWindow)
                     oWindow = window.frameElement.radWindow;
             }
             if (oWindow != null) {
                 window.open('MergeProcessing.aspx' + location.search + '&OfficeType=DOC',
                              'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');
                 oWindow.Close();
             }
             else {
                 window.open('MergeProcessing.aspx' + location.search + '&OfficeType=DOC',
                              'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');

             }


         }



            </script>

        </telerik:RadCodeBlock>
        <table cellspacing="0" cellpadding="0" width="100%" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Height="25px" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" CommandName="Save" EnableImageSprite="true" CssClass="ToolbarSave"
                                Value="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" CommandName="SaveAs" EnableImageSprite="true" CssClass="ToolbarSaveAs"
                                Value="SaveAs">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="PDF" EnableImageSprite="true" CssClass="ToolbarPDFButton "
                                Value="PDF">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="MSWord" EnableImageSprite="true" CssClass="ToolbarWordButton "
                                Value="MSWord">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass=" ToolbarCancel"
                                Value="Cancel">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="History" EnableImageSprite="true" CssClass="ToolbarHistory"
                                Value="History">
                            </telerik:RadToolBarButton>
                            <%--<telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Send to PDF1" Value="PDF">
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Send to MSWord1" Value="MSWord">
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Cancel1" Value="Cancel">
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="History1" Value="History">
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>--%>
                        </Items>
                    </telerik:RadToolBar>

                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlEditor" runat="server" CssClass="PopupToolbarPaddingTop" Style="margin-top: 50px;">
            <telerik:RadEditor ID="rdeContent" DialogsScriptFile="~/JS/RadEditorDialog.js" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                Width="100%" OnClientModeChange="OnClientModeChange" OnClientLoad="OnClientLoad" runat="server"
                Skin="Default" CssClass="chi" EditModes="Preview,Design,Html">
                <Tools>
                    <telerik:EditorToolGroup>
                        <telerik:EditorTool Name="ToggleBorder" />
                    </telerik:EditorToolGroup>
                </Tools>
                <Content>
                </Content>
                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared"
                    DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />

            </telerik:RadEditor>

        </asp:Panel>

        <asp:Panel ID="pnlHistory" runat="server" Width="100%">
            <asp:DataList ID="dtlHistory" runat="server" Width="100%">
                <ItemTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="background-color: #FFEBDD; padding: 5px; font-size: 11px">
                                <div style="float: Left"><b><%#CStr(HttpContext.GetGlobalResourceObject("PMWeb", "LANG_BY2"))%> <%#Container.DataItem("CreatedBy")%> <%#CStr(HttpContext.GetGlobalResourceObject("PMWeb", "LANG_ONN"))%> <%#CDate(Container.DataItem("CreateDate")).ToShortDateString%></b></div>
                                <div style="float: right">&nbsp;&nbsp;<asp:LinkButton ID="lbtRestore" CssClass="Link" CommandName="Restore" CommandArgument='<%#Container.DataItem("Id")%>' runat="server" Text="Restore 1" meta:resourcekey="lbtRestore"></asp:LinkButton></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="overflow: auto;">
                                    <asp:Label ID="lblModifiedContent" runat="server" Text='<%#Container.DataItem("ModifiedContent")%>'></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </asp:Panel>


    </form>
</body>
</html>
