<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MergeTemplatePopup.aspx.vb" Inherits="Website.MergeTemplatePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">


    function click_handler(sender, args) {
        maintoolbarClick(args)
    }

    function maintoolbarClick(args) {
        switch (args.get_item().get_commandName()) {
            case 'CancelMerge':
                ClosePopWnd(window);
                break;
            case 'PDFSave':
                return OpenPDFWindow();
                break;
            case 'ExcelSave':
                return OpenExcelWindow();
                break;
            case 'WordSave':
                return OpenWindow();
                break;
            case 'PMWebWord':
                return OpenPrintPopup();
                break;
            case 'SendEmail':
                return OpenEmailPopup();
                break;
        }
    }

    function MoreMenuClicked(sender, args) {
        if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
            sender.close(true);
        if (args.get_item().get_value() == "WordSave") {
            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
            var button = mainToolBar.findItemByValue("WordSave");
            button.click();
        }
        if (args.get_item().get_value() == "PMWebWord") {
            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
            var button = mainToolBar.findItemByValue("PMWebWord");
            button.click();
        }
        if (args.get_item().get_value() == "SendEmail") {
            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
            var button = mainToolBar.findItemByValue("SendEmail");
            button.click();
        }
        maintoolbarClick(args.get_item().get_value());
    }



    function SelectCurrentRow(ctrl) {
        var tr = $("#" + ctrl.id).parents("tr:eq(0)");
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var masterTable = grid.get_masterTableView();
        masterTable.selectItem(tr[0].sectionRowIndex);
    }

    function OpenExcelWindow() {
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var TemplateId = null;
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var TemplateId = row.getDataKeyValue("Id")
        }
        if (TemplateId != null) {
            CloseExcelMergeWindow(TemplateId)
            return false;
        }
        return true;
    }

    function OpenPDFWindow() {
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var TemplateId = null;
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var TemplateId = row.getDataKeyValue("Id")
        }
        if (TemplateId != null) {
            ClosePDFMergeWindow(TemplateId)
            return false;
        }
        return true;
    }


    function OpenEmailPopup() {
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var TemplateId = null;
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var TemplateId = row.getDataKeyValue("Id")
        }
        if (TemplateId != null) {

            CloseEmailMergeWindow(TemplateId);
            return false;
        }
        return true;
    }

    function OpenWindow() {
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var TemplateId = null;
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var TemplateId = row.getDataKeyValue("Id")
        }
        if (TemplateId != null) {


            CloseWordMergeWindow(TemplateId);
            return false;
        }
        return true;
    }

    function CloseWordMergeWindow(TemplateId) {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement != null) {
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
        }
        if (oWindow != null) {
            window.open('MergeProcessing.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=DOC',
                         'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');
            oWindow.Close();
        }
        else {
            window.open('MergeProcessing.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=DOC',
                         'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');

        }


    }

    function CloseExcelMergeWindow(TemplateId) {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement != null) {
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
        }
        if (oWindow != null) {
            window.open('MergeProcessing.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=EXCEL',
                        'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');
            oWindow.Close();
        }
        else {
            window.open('MergeProcessing.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=EXCEL',
                        'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');

        }

    }

    function ClosePDFMergeWindow(TemplateId) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var left = (browserWidth - (browserWidth * 0.9)) / 2;
        var top = (browserHeight - (browserHeight * 0.9)) / 2;
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement != null) {
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
        }
        if (oWindow != null) {
            OpenPOPUp('MergePopup_PrintPreview.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=PDF', 100, 100, false);
        }
        else {
            OpenPOPUp('MergePopup_PrintPreview.aspx' + location.search + '&TemplateId=' + TemplateId + '&OfficeType=PDF', 100, 100, false);
        }

    }


    function OpenPrintPopup() {
        var grid = $find($("[id$=rdgTemplates]")[0].id);
        var TemplateId = null;
        for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            var TemplateId = row.getDataKeyValue("Id")
        }
        if (TemplateId != null) {

            ClosePrintMergeWindow(TemplateId);
            return false;
        }
        return true;
    }

    function ClosePrintMergeWindow(TemplateId) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd =  window.radopen('MergePrintPopup.aspx' + location.search + '&TemplateId=' + TemplateId)
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;

    }


    function CloseEmailMergeWindow(TemplateId) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('MergeEmailPopup.aspx' + location.search + '&TemplateId=' + TemplateId)
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;

    }

</script>

<head runat="server">
    <title>Template</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgTemplates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgTemplates" />
                        <telerik:AjaxUpdatedControl ControlID="fldNotes" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <asp:PlaceHolder ID="plhScript" runat="server"></asp:PlaceHolder>
        <table style="width: 100%;" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" Width="100%" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton CommandName="CancelMerge" CssClass="ToolbarCancelButton" EnableImageSprite="true" PostBack="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="PDFSave" CssClass="ToolbarPDFButton" EnableImageSprite="true" PostBack="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="ExcelSave" CssClass="ToolbarExcelButton" EnableImageSprite="true" PostBack="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="WordSave" Value="WordSave" EnableImageSprite="true" CssClass="ToolbarWordButton" PostBack="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="PMWebWord" Value="PMWebWord" EnableImageSprite="true" CssClass="ToolbarMergeWordButton" PostBack="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="SendEmail" Value="SendEmail" EnableImageSprite="true" CssClass="ToolbarEmail" PostBack="false"></telerik:RadToolBarButton>

                            <%--<telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" CssClass="MoreMenu ToolbarMobileMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Merge To Word" Value="WordSave" CssClass="WordSave">
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="PMWeb Word" Value="PMWebWord" CssClass="PMWebWord">
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Send Email" Value="SendEmail" CssClass="SendEmail">
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

        <div class="PMMainPage PMPopupMainPage ">
            <div class="row row-8-4" >
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label ID="Label1" meta:resourcekey="lbltemplate" runat="server"></asp:Label>
                        </legend>
                        <telerik:RadGrid ID="rdgTemplates" runat="server" ShowFooter="false" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="9"
                            AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="false"
                            AllowSorting="True" GridLines="None" Width="99%">
                            <PagerStyle Mode="NumericPages" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom"></PagerStyle>

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id,IsDefault" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false"
                                TableLayout="Fixed">
                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Linkbutton1" OnClientClick="SelectCurrentRow(this);" CommandName="Preview" CssClass="SearchButton"
                                                runat="server">
                                                         <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Template" ItemStyle-Wrap="false" SortExpression="Template"
                                        UniqueName="Template">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Template") = String.Empty, "&nbsp;", Container.DataItem("Template"))%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="140px"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" SortExpression="Description"
                                        UniqueName="Description">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="140px"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                                        SortExpression="IsDefault" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                alt="" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="68px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true">
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>

                    </fieldset>

                </div>
                <div class="col-8">
                    <fieldset id="fldNotes" runat="server">
                        <legend>
                            <asp:Label ID="lblContent" meta:resourcekey="lblContent" Text="Preview" runat="server"></asp:Label>
                        </legend>
                        <div style="overflow: auto; height: 405px; width: 100%" >
                            <asp:Label ID="lblTemplateBody" runat="server"></asp:Label>&nbsp;
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>



        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
