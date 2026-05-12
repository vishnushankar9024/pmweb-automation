<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="WorkflowEmailTemplates.aspx.vb" Inherits="Website.WorkflowEmailTemplates" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .col-4 .RadEditor iframe,
        .col-4 .RadEditor .reTextArea {
            height: 385px !important;
        }

            .col-4 .RadEditor iframe.reHtmlMode {
                height: 0 !important;
            }

               /*  .divContentHolder {
    padding-top: 115px;
}*/
        .RadToolBar .rtbItemHovered .ToolbarUpdUnlockedTemplates .rtbIcon {
            height: 16px !important;
            width: 16px !important;
            background-image: url(CSS/Images/ResponsiveIcons/16Hovered.png) !important;
            background-position: -336px -1px !important;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlNotificationTypes">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="sldSMSLength" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript" src="JS/Workflow/EmailTemplates.js"></script>
        <script type="text/javascript">
            var focusId;
            var editor;

            $(function () {
                $(":input").focus(function () { focusId = this.id; });
            });

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


    function pasteTextInEditor(text) {
        editor = $find("<%=RadEditor1.ClientID%>");
        editor.pasteHtml(text);
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
        if (!focusId) { return }
        var node = eventArgs.get_node();
        if (!node.get_value()) { return }
        var ae = document.activeElement;
        if (focusId.indexOf('txtSubject') > 0) {
            insertAtCaret(focusId, node.get_value());
        } else {
            pasteTextInEditor(node.get_value());
        }
    }

    function makeUnselectable(element) {
        var nodes = element.getElementsByTagName("*");
        for (var index = 0; index < nodes.length; index++) {
            var elem = nodes[index];
            elem.setAttribute("unselectable", "on");
        }
    }

    function insertAtCaret(areaId, text) {
        var txtarea = document.getElementById(areaId);
        var scrollPos = txtarea.scrollTop;
        var strPos = 0;
        var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
"ff" : (document.selection ? "ie" : false));
        if (br == "ie") {
            txtarea.focus();
            var range = document.selection.createRange();
            range.moveStart('character', -txtarea.value.length);
            strPos = range.text.length;
        }
        else if (br == "ff") strPos = txtarea.selectionStart;

        var front = (txtarea.value).substring(0, strPos);
        var back = (txtarea.value).substring(strPos, txtarea.value.length);
        txtarea.value = front + text + back;
        strPos = strPos + text.length;
        if (br == "ie") {
            txtarea.focus();
            var range = document.selection.createRange();
            range.moveStart('character', -txtarea.value.length);
            range.moveStart('character', strPos);
            range.moveEnd('character', 0);
            range.select();
        }
        else if (br == "ff") {
            txtarea.selectionStart = strPos;
            txtarea.selectionEnd = strPos;
            txtarea.focus();
        }
        txtarea.scrollTop = scrollPos;
    }


    function sldSMSLength_Changed(sender, args) {
        var intFrom = <% =sldSMSLength.MinimumValue %>;
        intFrom = intFrom + sender.get_selectionStart();
        var intTo =  <% =sldSMSLength.MaximumValue %>;
        intTo = intTo - sender.get_selectionStart();
        $('#lblFromLength').html('(' + intFrom + ')');
        $('#lblToLength').html('(' + intTo + ')');
    }
    function MoreMenuClicked(sender, args) {
        if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
            sender.close(true);
            if (args.get_item().get_value() == "UpdUnlockedTemplates") {
                var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                var button = mainToolBar.findItemByValue("UpdUnlockedTemplates");
                button.click();
            }
            //maintoolbarClick(args.get_item().get_value(), args)
        }
    }
        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar">
            <td style="vertical-align: middle; width: 10%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                    OnClientButtonClicking="OnClientButtonClickingHandler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                            CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ProjectCalendarDays">
                        </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton ID="btnUpdUnlockedTemplate" PostBack="true" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="UpdUnlockedTemplates"
                            meta:resourcekey="btnUpdUnlockedTemplates" CommandName="UpdUnlockedTemplates" Text="Update Unlocked Templates" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Update Unlocked Templates" Value="UpdUnlockedTemplates" CssClass="UpdUnlockedTemplates"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <%--     <td class="ToolbarTd">
                <asp:Button ID="btnUpdUnlockedTemplates" runat="server"/>
            </td>--%>
            <td>
                <asp:Panel runat="server" ID="pnlSlider">
                    <table>
                        <tr>
                            <td style="padding-left: 10px; padding-right: 10px;" class="NoWrap">
                                <div style="width: 190px">
                                    <asp:Label ID="lblSMSLength" runat="server" meta:resourcekey="lblSMSLength" Text="Text (SMS) Characters:"></asp:Label>
                                    <asp:Label ID="lblSMSLengthSubject" runat="server" meta:resourcekey="lblSMSLengthSubject"
                                        Text="[Subject]"></asp:Label>
                                    <span id="lblFromLength"></span>
                                </div>
                            </td>
                            <td>
                                <telerik:RadSlider runat="server" ID="sldSMSLength" OnClientLoad="sldSMSLength_Changed"
                                    Width="100px" SmallChange="1" Skin="Default" OnClientValueChange="sldSMSLength_Changed"
                                    ShowIncreaseHandle="false" ShowDecreaseHandle="false" />
                            </td>
                            <td style="padding-left: 10px; padding-right: 10px;" class="NoWrap">
                                <div style="width: 100px">
                                    <asp:Label ID="lblSMSLengthMessage" runat="server" meta:resourcekey="lblSMSLengthMessage"
                                        Text="[Message]"></asp:Label>
                                    <span id="lblToLength"></span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td style="width: 100%;"></td>
        </tr>
    </table>
    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" LoadingPanelID="ldpPM" Width="100%">
        <div class="PMMainPage JustifyContent marginBottomOnMobile">
            <div class="row" style="margin-bottom: 0 !important">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNotification" runat="server" meta:resourcekey="lblNotification" Text="Notification on"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlNotificationTypes" runat="server" AutoPostBack="True"
                                    AllowCustomText="false" CausesValidation="False" EnableVirtualScrolling="True"
                                    Height="165px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" meta:resourcekey="ddlNotificationTypes"
                                    NoWrap="True" Skin="Default" Width="100%">
                                    <CollapseAnimation Duration="150" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row" style="padding-top: 0px !important;">
                <div class="col-6 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFromEmail" runat="server" meta:resourcekey="lblFromEmail" Text="From Email *"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtFromName" runat="server" MaxLength="200" Width="100%"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvFromName" runat="server" ControlToValidate="txtFromName"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="Enter the From Name" ForeColor=""
                                    meta:resourcekey="rfvFromName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSubject" runat="server" MaxLength="200" Width="100%"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="Enter the subject" ForeColor=""
                                    meta:resourcekey="rfvSubject"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="LblLock" runat="server" meta:resourcekey="lblLock" Text="Lock"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="CbxLock" runat="server" class="mobile-switch" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row" style="padding-top: 0px !important;width:1248px !important">
                <div class="col-4 col-4-left">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblFields" CssClass="legend" runat="server" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                        </legend>
                        <telerik:RadTreeView ID="tree" Height="500px" runat="server" Style="border: 1px solid #666666;"
                            OnClientNodeClicked="OnClientItemDoubleClicked" ShowLineImages="false">
                        </telerik:RadTreeView>
                        <telerik:RadListBox ID="RadListBox1" runat="server" AllowReorder="false" AllowTransfer="false"
                            AutoPostBackOnReorder="false" AutoPostBackOnTransfer="false" EnableDragAndDrop="true"
                            OnClientItemDoubleClicked="OnClientItemDoubleClicked" SelectionMode="Single"
                            Skin="Default" Visible="false">
                            <Items>
                            </Items>
                        </telerik:RadListBox>
                    </fieldset>
                </div>
                <div style="width: 800px; float: right; padding-left: 24px; padding-right: 24px;order:2">
                    <fieldset style="margin-bottom:30px">
                        <legend>
                            <asp:Label ID="lblEditor" runat="server" CssClass="legend" meta:resourcekey="lblEditor" Text="Editor"></asp:Label>
                        </legend>
                        <asp:Panel ID="pnlEditor" runat="server" Width="100%">
                            <telerik:RadEditor ID="RadEditor1" DialogsScriptFile="~/JS/RadEditorDialog.js" runat="server" Height="500px" Width="100%"
                                OnClientLoad="OnClientLoad" Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                                <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000" SearchPatterns="*.*"
                                    UploadPaths="~/Images/Shared" ViewPaths="~/Images/Shared" />
                            </telerik:RadEditor>
                        </asp:Panel>
                    </fieldset>
                </div>
                </div>
            <div class="row" style="padding-top:0;">
                <div class="col-4 col-4-left">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblAttachToEmail" CssClass="legend" runat="server" meta:resourcekey="lblAttachToEmail"
                                Text="Select To Attach To Email"></asp:Label>
                        </legend>
                        <telerik:RadGrid ID="rdgAttachToEmail" runat="server"
                            Height="100%" AllowPaging="true" PageSize="250" Width="100%" AutoGenerateColumns="False" FitParentContainer="true"
                            HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                            ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <HeaderContextMenu EnableViewState="false">
                            </HeaderContextMenu>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed"
                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true"
                                EnableHeaderContextMenu="true" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                        AllowFiltering="false" HeaderStyle-Width="45px">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" onClick="AllAttachmentCheckClicked(this)" runat="server" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" onClick="SelectAttachmentParent(this)" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Height="20px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Type"
                                        UniqueName="Type">
                                        <ItemTemplate>
                                            <%# Eval("TranslatedType").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Description"
                                        UniqueName="Description">
                                        <ItemTemplate>
                                            <%# Eval("TranslatedDescription").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ItemStyle Wrap="false" />
                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
</asp:Content>
