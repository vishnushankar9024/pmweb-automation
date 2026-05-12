<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="MergeTemplates.aspx.vb" Inherits="Website.MergeTemplates" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <style type="text/css">
        body {
            background-color: White !important;
        }

        .reToolbar:first-child .reToolLastItem
        {margin-left:0px !important}
        .reTool .PageBreak {
            background-image: url('css/Images/ResponsiveIcons/16x16 EnabledNewest.png');
            background-position:-2032px 0px;
        }

        .reTool .SpellNumbers {
             background-image: url('css/Images/ResponsiveIcons/16x16 EnabledNewest.png');
              background-position:-2048px 0px;
        }

           .reTool .PageBreak:hover {
            background-image: url('css/Images/ResponsiveIcons/16x16 HoveredNewest.png');
             background-position:-2032px 0px;
        }

        .reTool .SpellNumbers:hover{
            background-image:  url('css/Images/ResponsiveIcons/16x16 HoveredNewest.png');
            background-position:-2048px 0px;
        }

        .reToolbar:first-child li:nth-of-type(3) a {
            width: 120px;
            margin-right: 8px;
        }

        .reDropdown, .Default .reDropdown:hover.reDropdown:hover {
            width: 120px;
            margin-right: 8px;
        }
        a.reTool.reSplitButton, a.reTool.reSplitButton:hover{width:24px !important}
        span.split_arrow {display: none;}
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .documentSinglePage {
                margin: 70px 0 36px 0 !important;
            }

            .marginBottomOnMobile {
                margin-bottom: 36px;
            }
        }
    </style>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            function Refresh() {

                __doPostBack($("[id$=pnlDetailPane]")[0].id);
            }

            function OpenTaskSheetsPopUp() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var ddlObjectTypes = $find($("[id$=ddlObjectTypes]")[0].id);
                var wnd = window.radopen("CopyFrommergeTemplates.aspx?Id=" +
                                    ddlObjectTypes.get_value());
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function IsMouseOverEditor(events) {
                var target = (document.all) ? events.srcElement : events.target;
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id)
                        if (parentNode.id == '<%= pnlEditor.ClientID %>')
                            return parentNode;
                    parentNode = parentNode.parentNode;
                }
                return null;
            }

            function MyDropHandler(source, dest, events) {
                document.body.style.cursor = "default";
                alert(IsMouseOverEditor(events));
                if (IsMouseOverEditor(events)) {
                }
            }
            function onClose(result) {
                var oWindow = GetRadWnd();
                oWindow.Close();
                var editor = $find("<%=edtMergeTemplate.ClientID%>");
                alert(result);
            }


            function pasteTextInEditor(text) {
                var editor = $find("<%=edtMergeTemplate.ClientID%>");
                editor.pasteHtml(text);
            }
            function pasteTextInEditor(text) {
                var edtTemplate = $find("<%=edtMergeTemplate.ClientID%>");
                var treRepeatHeader = $find("<%=treRepeatHeader.ClientID%>");
                var treRepeatFooter = $find("<%=treRepeatFooter.ClientID%>");
                var hdnValue = document.getElementById("<%= hdfEditor.ClientID %>").value;
                if (hdnValue == "1") { edtTemplate.pasteHtml(text); }
                else if (hdnValue == "2")
                    treRepeatHeader.pasteHtml(text);
                else if (hdnValue == "3")
                    treHeader.pasteHtml(text);
                else if (hdnValue == "4")
                    treFooter.pasteHtml(text);
                else treRepeatFooter.pasteHtml(text);
            }

            function MyMoveHandler(events) {
                if (!IsMouseOverEditor(events)) {
                    document.body.style.cursor = "no-drop";
                }
                else {
                    document.body.style.cursor = "hand";
                }
            }

            function OnClientItemDoubleClicked(sender, eventArgs) {
                var node = eventArgs.get_node();
                if (node.get_value() != null)
                    pasteTextInEditor(node.get_value());
            }
            function makeUnselectable(element) {
                var nodes = element.getElementsByTagName("*");
                for (var index = 0; index < nodes.length; index++) {
                    var elem = nodes[index];
                    elem.setAttribute("unselectable", "on");
                }
            }
            Sys.Application.add_load(function () {
                var tree = $find("<%= tree.ClientID %>");
                makeUnselectable(tree.get_element());
            });


                function OnClientLoad(editor) {
                    editor.get_contentArea().style.backgroundColor = "white";
                    editor.get_contentArea().style.backgroundImage = "none";

                }

                Telerik.Web.UI.Editor.CommandList["PageBreak"] = function (commandName, editor, args) {
                    editor.pasteHtml("<span STYLE='page-break-after: always'>[Page-Break]</span>");
                };

                Telerik.Web.UI.Editor.CommandList["SpellNumbers"] = function (commandName, editor, args) {
                    editor.pasteHtml(".Spell()");
                };




                function click_handler(sender, args) {
                    switch (args.get_item().get_commandName()) {


                        case 'New':
                            window.location = "MergeTemplates.aspx";
                            break;

                        default:
                            //                        eventArgs.set_cancel(false);
                            break;

                    }


                }

                var ObjectTypeId = 'a';
                function ddlSelectedIndexChanging(sender, args) {
                    ObjectTypeId = 'a';
                    if (args.get_item()) ObjectTypeId = args.get_item().get_value();
                }

                function ddlDropDownOpening(sender, args) {
                }

                function CheckddlRecord(sender, args) {
                    var combo = $find(sender.controltovalidate);
                    if (combo.get_selectedItem() != null) {
                        if (isNumeric(ObjectTypeId) == true && ObjectTypeId > 0) {
                            args.IsValid = true;
                        } else if (combo.get_selectedItem().get_index() > 0) {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    } else {
                        args.IsValid = false;
                    }
                    return;
                }

        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=138">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlTemplates" runat="server" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" Width="100%" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    meta:resourcekey="ddlTemplates"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                    EnableVirtualScrolling="True">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                          Value="Search" CausesValidation="false" NavigateUrl="SearchDocument.aspx?O=138">
                      </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" ValidationGroup="Save" CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>



                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CausesValidation="False" CommandName="New"
                            EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" PostBack="false" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName="Print"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ProjectCalendarDays"></telerik:RadToolBarButton>

                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadAjaxPanel ID="pnlDetailPane" EnableAJAX="false" runat="server" LoadingPanelID="ldpPM" Width="100%">
        <div class="PMMainPage">
            <div class="row row-8-4-fit8" style="margin-top: 50px;">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" runat="server" Text="ID*" meta:resourcekey="lblName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" MaxLength="200" runat="server" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ValidationGroup="Save"
                                    CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfv_Name"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" Text="Description*" meta:resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblObjectType" runat="server" Text="Record Type*" meta:resourcekey="lblObjectType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlObjectTypes" runat="server" Filter="Contains" AllowCustomText="false"
                                    Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="250px" EnableVirtualScrolling="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblRequired" runat="server" CssClass="Validator" meta:Resourcekey="lblRequired" Visible="false"></asp:Label>
                                <asp:RequiredFieldValidator ID="rfvObjectTypes" meta:Resourcekey="csv_RecordType" runat="server" ControlToValidate="ddlObjectTypes"
                                    CssClass="Validator" InitialValue=""
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                </asp:RequiredFieldValidator>
                                <%--<asp:CompareValidator ID="rfvObjectType" runat="server" ControlToValidate="ddlObjectTypes" CssClass="Validator" 
                        meta:resourcekey="csvRecordType" Display="Dynamic" ForeColor="" Operator="GreaterThan" ValueToCompare="0">
                    </asp:CompareValidator>--%>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDefaultTemplate" runat="server" Text="Default Template" meta:resourcekey="chkDefaultTemplate"></asp:Label>

                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkDefaultTemplate" runat="server" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <fieldset style="height: 100%;">
                                    <legend>
                                        <asp:Label ID="lblActions" meta:resourcekey="lblActions" runat="server" Text="Actions"></asp:Label></legend>
                                    <table style="height: 100%">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnCopyFromTemplate" meta:resourcekey="btnCopyFromTemplate" runat="server" CausesValidation="false"
                                                    SecurityButtonType="ItemMode_Add" OnClientClick="return OpenTaskSheetsPopUp();" CssClass="LargeButton"
                                                    Text="Copy From Template"></asp:Button></td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" colspan="2">
                                <fieldset runat="server" id="fldTotals">
                                    <legend class="legend">
                                        <asp:Label ID="lblMergeFields" Text="Merge Fields" meta:Resourcekey="lblMergeFields" runat="server"></asp:Label>
                                    </legend>
                                </fieldset>
                            </td>
                        </tr>

                        <tr>
                            <td valign="top" colspan="2" style="max-height: 300px;">

                                <div style="overflow: auto; width: 100%; max-height: 300px">
                                    <telerik:RadTreeView ID="tree" runat="server" OnClientNodeClicked="OnClientItemDoubleClicked" ShowLineImages="false">
                                    </telerik:RadTreeView>
                                </div>
                                <telerik:RadListBox ID="RadListBox1" Skin="Default" runat="server" Visible="false"
                                    SelectionMode="Single" AllowTransfer="false" AutoPostBackOnTransfer="false"
                                    AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true"
                                    OnClientItemDoubleClicked="OnClientItemDoubleClicked" OnClientDropping="MyDropHandler">
                                    <Items>
                                    </Items>
                                </telerik:RadListBox>


                            </td>

                        </tr>

                    </table>

                </div>
                <div class="col-8 AddTopPadWhenUnfit">
                    <telerik:RadTabStrip runat="server" ID="tbsDocument" Orientation="HorizontalTop" AutoPostBack="true"
                        SelectedIndex="0" MultiPageID="RMP" ShowBaseLine="True" Skin="Default" CssClass="RDPWord">
                        <Tabs>
                            <telerik:RadTab Text="Body" PageViewID="RP1" Selected="true" Value="Body">
                            </telerik:RadTab>
                            <telerik:RadTab Text="Header" PageViewID="RP2" Value="HeaderMerge" meta:resourcekey="HeaderMerge">
                            </telerik:RadTab>
                            <telerik:RadTab Text="Footer" PageViewID="RP3" Value="Footer">
                            </telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>
                    <telerik:RadMultiPage runat="server" ID="RMP" SelectedIndex="0"
                        Width="100%">
                        <telerik:RadPageView runat="server" ID="RP1">
                            <asp:Panel ID="pnlEditor" runat="server">
                                <telerik:RadEditor ID="edtMergeTemplate" DialogsScriptFile="~/JS/RadEditorDialog.js" runat="server" Style="height: 100% !important" CssClass="WithoutTopBorder" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    Skin="Default"
                                    Width="100%">
                                    <Tools>
                                        <telerik:EditorToolGroup>
                                            <telerik:EditorTool Name="AjaxSpellCheck" Text="Spellcheck" />
                                            <telerik:EditorTool Name="FontName" Text="Font Name" ShortCut="CTRL+SHIFT+F" />
                                            <telerik:EditorTool Name="RealFontSize" Text="Font Size" ShortCut="CTRL+SHIFT+P" />
                                            <telerik:EditorTool Name="Bold" ShortCut="CTRL+B" Text="Bold" />
                                            <telerik:EditorTool Name="Italic" ShortCut="CTRL+I" Text="Italic" />
                                            <telerik:EditorTool Name="Underline" ShortCut="CTRL+U" Text="Underline" />
                                            <telerik:EditorTool Name="StrikeThrough" Text="Strikethrough" />
                                            <telerik:EditorTool Name="JustifyLeft" Text="Align Left" />
                                            <telerik:EditorTool Name="JustifyCenter" Text="Align Center" />
                                            <telerik:EditorTool Name="JustifyRight" Text="Align Right" />
                                            <telerik:EditorTool Name="JustifyFull" Text="Justify" />
                                            <telerik:EditorTool Name="ForeColor" Text="Font Color" />
                                            <telerik:EditorTool Name="BackColor" Text="Background Color" />
                                            <telerik:EditorTool Name="ImageManager" Text="Image Manager" />
                                            <telerik:EditorTool Name="TemplateManager" Text="Template Manager" ShortCut="CTRL+M" />
                                            <telerik:EditorTool Name="InsertTable" Text="Table" />
                                            <telerik:EditorTool Name="InsertLink" Text="Insert Link" />
                                            <telerik:EditorTool Name="PageBreak" Text="Pagebreak" />
                                            <telerik:EditorTool Name="SpellNumbers" Text="Spell Numbers" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                    <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                    <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                </telerik:RadEditor>
                            </asp:Panel>
                        </telerik:RadPageView>
                        <telerik:RadPageView runat="server" ID="RP2">
                            <asp:Panel ID="pnlRepeatHeader" runat="server" GroupingText="RepeatHeader" meta:resourcekey="pnlRepeatHeader">
                                <telerik:RadEditor runat="server" ID="treRepeatHeader" DialogsScriptFile="~/JS/RadEditorDialog.js" Skin="Default" ToolProviderID="edtMergeTemplate" Width="100%" Style="height: 100% !important"
                                    DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                                    <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                    <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                </telerik:RadEditor>
                            </asp:Panel>
                        </telerik:RadPageView>
                        <telerik:RadPageView runat="server" ID="RP3">
                            <asp:Panel ID="pnlRepeatFooter" runat="server" GroupingText="RepeatFooter" meta:resourcekey="pnlRepeatFooter">
                                <telerik:RadEditor runat="server" ID="treRepeatFooter" DialogsScriptFile="~/JS/RadEditorDialog.js"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    Skin="Default" ToolProviderID="edtMergeTemplate" Width="100%" Style="height: 100% !important">
                                    <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                    <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                        SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                        ViewPaths="~/Images/Shared" />
                                </telerik:RadEditor>
                            </asp:Panel>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdfEditor" runat="server" Value="1" />

    </telerik:RadAjaxPanel>


</asp:Content>

