<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="MySettings_ControlsPopup.aspx.vb" Inherits="Website.MySettings_ControlsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <script type="text/javascript">
        function ActivatePopup() {
            var op = window.parent.document.getElementById('RadWindowWrapper_' + currWindowId);
            if (op) {
                setTimeout(function () { op.className = op.className.replace('rwInactiveWindow', '') }, 500)
            }
        }
        function OpenWidgetPopup(Source, Width, Height) {
            hideConfigureCtrlPopup();
            var qs = getQueryStrings();
            var PopupId = qs["PopupId"];
            if (Source == "MySettingsNews") {
                OpenMySettingsNewsPOPUp('WidgetPopup.aspx?Source=' + Source + '&PopupId=' + PopupId, Width, Height, null, null)
            } else {
                OpenLargePOPUpParent('WidgetPopup.aspx?Source=' + Source + '&PopupId=' + PopupId, Width, Height, null, null)
            }
            ActivatePopup()
            return false;
        }

        function OpenRegionsWeatherPopup(Width, Height) {
            hideConfigureCtrlPopup();
            var qs = getQueryStrings();
            var PopupId = qs["PopupId"];
            OpenSmallPOPUpParent('MySettingsRegionsWeatherPopup.aspx?PopupId=' + PopupId, Width, Height, null, null)
            ActivatePopup()
            return false;
        }

        function OpenBackgroundImagePopup(Width, Height) {
            hideConfigureCtrlPopup();
            var qs = getQueryStrings();
            var PopupId = qs["PopupId"];
            OpenPOPUpParent('MySettings_UploadBackgroundImage.aspx?PopupId=' + PopupId, Width, Height, null, null)
            ActivatePopup()
            return false;
        }
        function hideConfigureCtrlPopup() {
            var qs = getQueryStrings();
            var PopupId = qs["PopupId"];
            var mainWindow = window.parent.document.getElementById('RadWindowWrapper_' + PopupId);
            mainWindow.className = mainWindow.className + ' Hide';
            return false;
        }
        
        var currWindowId = null;

        function OpenPOPUpParent(URL, Width, Height, AddClose, gridId) {

            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen(URL);
            if (isParentMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(Width, Height);
                wnd.Center();
            }
            if (AddClose == true) {
                wnd.add_close(WindowClosed);
                if (gridId) { GridToRebind = gridId; }
            }
            currWindowId = wnd.get_id();
            return false;
        }
        function OpenMySettingsNewsPOPUp(URL, Width, Height, AddClose, gridId) {
            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen(URL);
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwReminder");
            if (browserWidth < 700) {
                wnd.setSize(browserWidth - 10, Height);
            }
            else {
                wnd.setSize(650, Height);
            }
            wnd.Center();
            if (AddClose == true) {
                wnd.add_close(WindowClosed);
                if (gridId) { GridToRebind = gridId; }
            }
            currWindowId = wnd.get_id();
            return false;
        }
        function OpenLargePOPUpParent(URL, Width, Height, AddClose, gridId) {

            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen(URL);
            if (isParentMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            if (AddClose == true) {
                wnd.add_close(WindowClosed);
                if (gridId) { GridToRebind = gridId; }
            }
            currWindowId = wnd.get_id();

            return false;
        }
        function OpenSmallPOPUpParent(URL, Width, Height, AddClose, gridId) {

            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen(URL);
            if (isParentMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
                wnd.Center();
            }
            if (AddClose == true) {
                wnd.add_close(WindowClosed);
                if (gridId) { GridToRebind = gridId; }
            }
            currWindowId = wnd.get_id();

            return false;
        }
        function isParentMobileScreen() {
            var browserWidth = $telerik.$(window.parent).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }
    </script>
    <form id="form1" runat="server">
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td style="width: 100%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <telerik:RadGrid ID="rdgWidgets" runat="server" HeaderStyle-Font-Size="8" Width="99%" AutoGenerateColumns="False" AllowMultiRowEdit="True" SetWidth="true" AppendMenus="true" 
            AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="false" FitPageHeightOffset="5" ClientSettings-Scrolling-AllowScroll="true">
            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show" HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <asp:CheckBox ID="chbSelected" AutoPostBack="false"
                                Checked='<%# CBool(IIf(Eval("Show") Is System.DBNull.Value, 0, Eval("Show")))%>'
                                runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Controls" UniqueName="Control" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <%#IIf(Container.DataItem("Control") = String.Empty, "&nbsp;", Container.DataItem("Control"))%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Content" UniqueName="Content" HeaderStyle-Width="130px"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="imgWidget" Style="cursor: pointer" runat="server"
                                class="SearchButton">
                                                                                   <span class="Icon"></span>
                            </asp:LinkButton>
                            &nbsp;
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle Font-Size="8pt"></HeaderStyle>
            <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
            </ClientSettings>
        </telerik:RadGrid>


    </form>
</body>
</html>
