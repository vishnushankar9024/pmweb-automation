<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderHeaders.ascx.vb" Inherits="Website.QueryBuilderHeaders" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
        function OnEditorClientLoad() {
            var arrEditors = ['rdeRepeatedHeader', 'rdeHeader', 'rdeFooter'];
            arrEditors.forEach(function (editor) {
                var rde = $find("ctl00_CPH1_QueryBuilderHeaders1_" + editor);
                var element = rde.get_document().body;
                $telerik.addExternalHandler(element, "click", function (e) {
                    document.getElementById("<%= hdfEditor.ClientID %>").value = arrEditors.indexOf(editor) + 1;
                });
            });
            }

            function pasteTextInEditor(text) {
                var value =  document.getElementById("<%= hdfEditor.ClientID %>").value;
                switch (value) {
                    case "1":
                        var rdeRepeatedHeader = $find("<%=rdeRepeatedHeader.ClientID%>");
                        rdeRepeatedHeader.pasteHtml(text);
                        break;
                    case "2":
                        var rdeHeader = $find("<%=rdeHeader.ClientID%>");
                        rdeHeader.pasteHtml(text);
                        break;
                    case "3":
                        var rdeFooter = $find("<%=rdeFooter.ClientID%>");
                        rdeFooter.pasteHtml(text);
                        break;
                }
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
            function OnClientLoad(editor, args) {
                alert("Hello");
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
                var tree = $find("<%= treeFields.ClientID %>");
                makeUnselectable(tree.get_element());
                var element = document.all ? editor.get_document().body : editor.get_document();
                $telerik.addExternalHandler(element, "click", function (e) {
                    document.getElementById("<%= hdfEditor.ClientID %>").value = 1;
            });
            }
            function OnClientLoad1(editor, args) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
                var element = document.all ? editor.get_document().body : editor.get_document();
                $telerik.addExternalHandler(element, "click", function (e) {
                    document.getElementById("<%= hdfEditor.ClientID %>").value = 2;
                });
                }

                function OnClientItemDoubleClicked(sender, eventArgs) {
                    var node = eventArgs.get_node();
                    pasteTextInEditor(node.get_value());
                }
    </script>
    <style>
        @media screen and (max-width:1323px) {
            .reContentCell iframe{height:37px !important}
        }
    </style>
</telerik:RadCodeBlock>
<asp:HiddenField ID="hdfEditor" runat="server" />

  <div style="padding-top:24px;padding-left:24px;display:flex">
        <div style="width:400px">
            <fieldset>
                <legend>
                    <asp:Label ID="lbltitle" Text="Header" meta:Resourcekey="lbltitle" runat="server"></asp:Label>
                </legend>
                    <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="False" Skin="Default" MultipleSelect="True" Width="100%"
                        OnClientNodeClicked="OnClientItemDoubleClicked" CssClass="TreeHeight">
                        <ExpandAnimation Duration="100"></ExpandAnimation>
                        <CollapseAnimation Duration="100" Type="OutQuint" />
                    </telerik:RadTreeView>
            </fieldset>
        </div>
       <div style="padding-left:24px" class="col-8">
            <asp:Panel ID="pnlEditor" runat="server">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblRepeatedHeader" Text="Repeated Header Region" meta:Resourcekey="lblRepeatedHeader" runat="server"></asp:Label>
                    </legend>
                    <telerik:RadEditor ID="rdeRepeatedHeader" Height="200px" DialogsScriptFile="~/JS/RadEditorDialog.js" 
                        ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                        runat="server" Skin="Default" Width="99%">
                        <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates" DeletePaths="~/Uploads/QueryBuilderTemplates"
                            SearchPatterns="*.*" />
                    </telerik:RadEditor>
                </fieldset>
            </asp:Panel>

            <asp:Panel ID="pnlEditor1" runat="server">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblHeader" Text="Header Region" meta:Resourcekey="lblHeader" runat="server"></asp:Label>
                    </legend>
                    <telerik:RadEditor ID="rdeHeader" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                        runat="server" Width="99%" Height="200px"
                        Skin="Default" DialogsScriptFile="~/JS/RadEditorDialog.js" >
                        <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates" DeletePaths="~/Uploads/QueryBuilderTemplates"
                            SearchPatterns="*.*" />
                    </telerik:RadEditor>
                </fieldset>
            </asp:Panel>

            <asp:Panel ID="Panel1" runat="server" Visible="false">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblRepeatedFooter" Text="Repeated Footer Region" meta:Resourcekey="lblRepeatedFooter" runat="server"></asp:Label>
                    </legend>
                    <telerik:RadEditor ID="rdeRepeatedFooter" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                        runat="server" Height="200px"
                        Skin="Default" Width="99%" DialogsScriptFile="~/JS/RadEditorDialog.js" >
                        <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates"
                            DeletePaths="~/Uploads/QueryBuilderTemplates" SearchPatterns="*.*" />
                    </telerik:RadEditor>
                </fieldset>
            </asp:Panel>

            <asp:Panel ID="Panel2" runat="server">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblFooter" Text="Footer Region" meta:Resourcekey="lblFooter" runat="server"></asp:Label>
                    </legend>
                    <telerik:RadEditor ID="rdeFooter" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                      runat="server" Skin="Default" Height="200px"
                        Width="99%" DialogsScriptFile="~/JS/RadEditorDialog.js" >
                        <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <TemplateManager MaxUploadFileSize="204000000" ViewPaths="~/Uploads/QueryBuilderTemplates" UploadPaths="~/Uploads/QueryBuilderTemplates"
                            DeletePaths="~/Uploads/QueryBuilderTemplates" SearchPatterns="*.*" />
                    </telerik:RadEditor>
                </fieldset>
            </asp:Panel>
        </div>
    </div>


