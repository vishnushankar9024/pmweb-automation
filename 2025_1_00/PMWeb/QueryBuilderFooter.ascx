<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderFooter.ascx.vb" Inherits="Website.QueryBuilderFooter" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
        function pasteTextInEditor(text) {
            var editor = $find("<%=rdeRepeatedFooter.ClientID%>");
            var editor1 = $find("<%=rdeFooter.ClientID%>");
            if (document.getElementById("<%= hdfEditor.ClientID %>").value == "2") {
                editor1.pasteHtml(text);
            }
            else
                editor.pasteHtml(text);
        }

        function MyMoveHandler(events) {
            if (!IsMouseOverEditor(events) || !IsMouseOverEditor1(events)) {
                document.body.style.cursor = "no-drop";
            }
            else {
                document.body.style.cursor = "hand";
            }
        }


        function makeUnselectable(element) {
            var nodes = element.getElementsByTagName("*");
            for (var index = 0; index < nodes.length; index++) {
                var elem = nodes[index];
                elem.setAttribute("unselectable", "on");
            }
        }
        function ClientLoad(editor) {
            editor.get_contentArea().style.backgroundColor = "white";
            editor.get_contentArea().style.backgroundImage = "none";
            var tree = $find("<%= treeFields.ClientID %>");
            makeUnselectable(tree.get_element());
            var element = document.all ? editor.get_document().body : editor.get_document();
            $telerik.addExternalHandler(element, "click", function (e) {
                document.getElementById("<%= hdfEditor.ClientID %>").value = 1;
            });
            }
            function ClientLoad1(editor) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
                var element = document.all ? editor.get_document().body : editor.get_document();
                $telerik.addExternalHandler(element, "click", function (e) {
                    document.getElementById("<%= hdfEditor.ClientID %>").value = 2;
              });
              }

              function ClientItemDoubleClicked(sender, eventArgs) {
                  var node = eventArgs.get_node();
                  pasteTextInEditor(node.get_value());
              }
    </script>
</telerik:RadCodeBlock>
<asp:HiddenField ID="hdfEditor" runat="server" />
<table width="100%" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-3">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lbltitle" Text="Footer" meta:Resourcekey="lbltitle" runat="server"></asp:Label>
                                        </legend>
                                        <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="False" Height="400px"
                                            Skin="Default" MultipleSelect="True" Width="100%"
                                            OnClientNodeClicked="ClientItemDoubleClicked">
                                            <ExpandAnimation Duration="100"></ExpandAnimation>
                                            <CollapseAnimation Duration="100" Type="OutQuint" />
                                        </telerik:RadTreeView>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-9">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlEditor" runat="server" Visible="false" Style="width: 99%">
                                        <fieldset>
                                            <legend>
                                                <asp:Label ID="lblRepeatedFooter" Text="Repeated Footer Region" meta:Resourcekey="lblRepeatedFooter" runat="server"></asp:Label>
                                            </legend>
                                            <telerik:RadEditor ID="rdeRepeatedFooter" DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                                OnClientLoad="ClientLoad" runat="server"
                                                Skin="Default" Width="100%" >
                                                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                                <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates"
                                                    DeletePaths="~/Uploads/QueryBuilderTemplates" SearchPatterns="*.*" />
                                            </telerik:RadEditor>
                                        </fieldset>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlEditor1" runat="server">
                                        <fieldset>
                                            <legend>
                                                <asp:Label ID="lblFooter" Text="Footer Region" meta:Resourcekey="lblFooter" runat="server"></asp:Label>
                                            </legend>
                                            <telerik:RadEditor ID="rdeFooter" DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                                 OnClientLoad="ClientLoad1" runat="server" Skin="Default"
                                                Width="100%" >
                                                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                                <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates"
                                                    DeletePaths="~/Uploads/QueryBuilderTemplates" SearchPatterns="*.*" />
                                            </telerik:RadEditor>
                                        </fieldset>
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
