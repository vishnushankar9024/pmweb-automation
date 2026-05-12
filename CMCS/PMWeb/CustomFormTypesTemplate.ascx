<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormTypesTemplate.ascx.vb" Inherits="Website.CustomFormTypesTemplate" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style type="text/css">
        body {
            background-color: White !important;
        }

        .reTool .PageBreak {
            background-image: url(Images/Global/sPageBreak.png);
        }

        .reTool .SpellNumbers {
            background-image: url(Images/Global/sSpell.png);
        }

        div.reToolWrapper table.reSpinBox input.radfd_skipme {
            width: 80px !important;
        }

        .tableWizardCellProperties .reToolWrapper, .tableWizardTableProperties .reToolWrapper {
            width: 105px !important;
        }

        .RadEditor .reLayoutWrapper {
            height: calc(100vh - 153px) !important;
        }

        .reWrapper {
            height: calc(100vh - 153px) !important;
        }

        iframe {
            height: calc(100vh - 290px) !important;
        }

        .RadTreeView {
            height: calc(100vh - 200px) !important;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .MobileAssetTree {
                position: fixed;
                z-index: 9999;
                height: calc(100vh - 153px);
                vertical-align: top;
                background-color: white;
            }
        }

        @media screen and (max-width: 880px) and (min-width: 844px) {
            .BiReportingExplorerBar {
                left: 484px !important;
            }

            .rail .BiReportingExplorerBar {
                left: 357px !important;
            }
        }

        @media screen and (max-width: 880px) {
            .BiReportingExplorerBarClosed .AsserExplorerbutton {
                margin-top: 20px !important;
            }

            .AsserExplorerbutton {
                margin-top: 360px !important;
            }
        }

        @media screen and (max-height:650px) {
            .AsserExplorerbutton {
                margin-top: 195px !important;
            }
        }

        /*@media screen and (min-width:844px) {
            #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_CustomFormTypesTemplate_RadContentPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_CustomFormTypesTemplate_treeGroupsAndItemsPane {
                height: calc(100vh - 181px) !important;
                background-color: white;
            }
        }


        @media screen and (max-width:843px) {
            .GridLayoutsLeftSplitterPane {
                position: fixed;
                width: 60vw !important;
                top: 0;
                height: calc(100vh - 123px) !important;
                z-index: 3000;
                border: 1px solid #999;
                margin-top: 87px;
                background-color: white;
            }

            .GridsLayoutSplitter {
                position: fixed;
                left: calc(60vw);
                z-index: 3000;
                height: calc(100vh - 123px) !important;
            }

            .GridLayoutsSplitterPane {
                width: calc(100vw - 6px) !important;
                height: calc(100vh - 123px) !important;
            }
        }*/

        .removeLeft {
            left: 0 !important;
        }

        .RDSplitter, .RDLeftPane, .RDRightPane {
            height: calc(var(--Content-height) - 50px - 38px) !important;
        }

        .documentMultiPages {
            margin-bottom: 0px;
        }
    </style>
    <script type="text/javascript">
        function RadLoad() {
            document.getElementsByClassName('radfd_skipme')[8].style.width = '100px'
            document.getElementsByClassName('radfd_skipme')[9].style.width = '100px'
        }

        function OnClientItemDoubleClicked(sender, eventArgs) {
            var node = eventArgs.get_node();
            if (node.get_value() != "parent") {
                pasteTextInEditor(node.get_value());
            }

        }

        function pasteTextInEditor(text) {
            var editor = $find("<%=rdeTemplate.ClientID%>");
            editor.pasteHtml(text);
        }

        function ClientLoad(editor) {
            editor.get_contentArea().style.backgroundColor = "white";
            editor.get_contentArea().style.backgroundImage = "none";
        }
        function makeUnselectable(element) {
            var nodes = element.getElementsByTagName("*");

            for (var index = 0; index < nodes.length; index++) {
                var elem = nodes[index];
                elem.setAttribute("unselectable", "on");
            }
        }
        Sys.Application.add_load(function () {
            var tree = $find("<%= treeFields.ClientID %>");
            makeUnselectable(tree.get_element());
        })

        function ToggleCustomMenu() {
            var tdCustomMenu = $('[id$=tdCustomMenu]')[0];
            var tdCustomExplorerBar = $('[id$=tdCustomExplorerBar]')[0];
            var form = $('form')[0]
            var btnToggleCustomMenu = $('[id$=btnToggle]')[0];
            if (tdCustomMenu.style.display == 'none') {
                tdCustomMenu.style.display = '';
                tdCustomExplorerBar.style.left = "285px";
                tdCustomExplorerBar.className = 'ReportManagerBar BiReportingExplorerBar'
                btnToggleCustomMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                //setCookie('AssetMenuStatus', 'inline', 60);
            } else {
                tdCustomMenu.style.display = 'none';
                tdCustomExplorerBar.style.left = "0px";
                tdCustomExplorerBar.className = 'ReportManagerBar BiReportingExplorerBarClosed'
                btnToggleCustomMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                //setCookie('AssetMenuStatus', 'none', 60);
            }
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Skin="Default" CssClass="RDSplitter" SplitBarsSize="">
    <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="RDLeftPane" EnableEmbeddedBaseStylesheet="False">
        <div style="height: 29px; background-color: #EDEDED; border: 1px solid #999999;"></div>
        <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="False"
            MultipleSelect="False" ShowLineImages="false"
            OnClientNodeClicked="OnClientItemDoubleClicked">
        </telerik:RadTreeView>
    </telerik:RadPane>
    <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />
    <telerik:RadPane ID="RadContentPane" CssClass="RDRightPane" runat="server" Width="70%" Index="2" Skin="Default">
        <telerik:RadEditor ID="rdeTemplate" runat="server" DialogsScriptFile="~/JS/RadEditorDialog.js"
            Skin="Default" ToolsFile="~/EditorCustomForm.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css?rnd=<%= PM.Security.LicenseInfo.PMWebVersion %>"
            Width="100%">

            <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                ViewPaths="~/Images/Shared" />
            <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                ViewPaths="~/Images/Shared" />
        </telerik:RadEditor>
    </telerik:RadPane>
</telerik:RadSplitter>




