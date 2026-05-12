<%@ Page Language="vb" meta:resourcekey="Page" Title="Reports Preview" AutoEventWireup="false" CodeBehind="ReportsPreviewPopup.aspx.vb" Inherits="Website.ReportsPreviewPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">
    function Close() {

        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
        radWindow.close();
    }

    function OpenEmailPopup() {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('ReportEmailPopup.aspx')
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        //wnd.add_close();
        return false;

    }

    function openReport() {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('ReportPrintingPreview.aspx');
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }

        return false;

    }

    //function CloseEmailMergeWindow() {
    //    //var left = (screen.width - 900) / 2;
    //    //var top = (screen.height - 500) / 2;
    //    var oWindow = null;
    //    if (window.radWindow) oWindow = window.radWindow;
    //    else if (window.frameElement != null) {
    //        if (window.frameElement.radWindow)
    //            oWindow = window.frameElement.radWindow;
    //    }
    //    if (oWindow != null) {
    //        window.open('ReportEmailPopup.aspx', "",
    //            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
    //        oWindow.Close();
    //    }
    //    else {
    //        window.close();
    //        window.open('ReportEmailPopup.aspx', "",
    //            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
    //    }

    //}
    function MoreMenuClicked(sender, args) {
        maintoolbarClick(args.get_item().get_value())
    }
    function click_handler(sender, args) {
        maintoolbarClick(args.get_item().get_commandName())
    }

    function OpenReportViewerPOPUp(URL) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var PopupWidth = (browserWidth * 0.9) - 10; // 10 = borders of the popup
        var PopupHeight = (browserHeight * 0.9) - 60;// 60 = title + status bar of the popup
        var left = ((browserWidth - PopupWidth) / 2) + 10;
        var top = ((browserHeight - PopupHeight) / 2) + 60;
        window.open(URL, null,
                         'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + PopupWidth + ',height=' + PopupHeight + ',top=' + top + ',left=' + left);
        return false;
    }

    function maintoolbarClick(value) {
        switch (value) {
            case 'SendEmail':
                return OpenEmailPopup();
                break;
            case 'ReportViewer':
                return OpenReportViewerPOPUp('ReportPrintingPreview.aspx');
                break;
            case 'Cancel':
                ClosePopWnd(window); return false;
                break;
        }
    }

</script>
<link href="CSS/ControlsCSS/Toolbar.css" rel="stylesheet" />
<style type="text/css">
    body:nth-of-type(1) img[src*="Blank.gif"] {
        display: none;
    }

    .GridCmdExpToExcel .Icon {
        background-image: url("CSS/Images/ResponsiveIcons/24newEnabled.png") !important;
        background-position: -960px 0px !important;
        height: 24px;
        width: 24px;
        display: inline-block;
    }
</style>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, maximum-scale=1" />
</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <%-- <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                 <telerik:AjaxSetting AjaxControlID="pnlRating">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlReport" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="pnlRating"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>--%>

        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <asp:PlaceHolder ID="plhScript" runat="server"></asp:PlaceHolder>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">

                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancelButton"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" Visible="true" CommandName="Separator1" />
                            <telerik:RadToolBarButton CssClass="ToolbarPDFButton" CommandName="PrintToPdf" EnableImageSprite="true" Visible="true"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="PrintToExcel" CssClass="ToolbarExcelButton" EnableImageSprite="true" Visible="true"></telerik:RadToolBarButton>
                            <%--<telerik:RadToolBarButton CommandName="PrintToWord" CssClass="ToolbarWordButton" EnableImageSprite="true" Visible="false"></telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton CommandName="SendEmail" PostBack="false" EnableImageSprite="true" CssClass="ToolbarEmail" Visible="true"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" Visible="true" CommandName="Separator2" />
                            <telerik:RadToolBarButton CommandName="ReportViewer" PostBack="false" EnableImageSprite="true" CssClass="ToolbarReportViewerButton" Visible="true"></telerik:RadToolBarButton>
                            <%--                                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            <ItemTemplate>
                                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                    <Items>
                                                        <telerik:RadMenuItem CssClass="menuMore">
                                                            <Items>
                                                                <telerik:RadMenuItem Text="PrintToPdf" Value="PrintToPdf"></telerik:RadMenuItem>
                                                                <telerik:RadMenuItem Text="PrintToExcel" Value="PrintToExcel"></telerik:RadMenuItem>
                                                                <telerik:RadMenuItem Value="SendEmail" Text="SendEmail"></telerik:RadMenuItem>
                                                                <telerik:RadMenuItem Value="ReportViewer" Text="ReportViewer"></telerik:RadMenuItem>
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


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="PMHeader">
                <div class="row">
                    <div class="col-6" style="margin-bottom: 24px;">
                        <fieldset>
                            <telerik:RadGrid ID="rdgReports" runat="server" ShowFooter="false" SetWidth="true" FitParentContainer="true" ClientSettings-EnablePostBackOnRowClick="true"
                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10"
                                AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="false"
                                AllowSorting="True" GridLines="None" Width="99%">
                                <PagerStyle Mode="NumericPages" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="ReportId,IsDefault" ClientDataKeyNames="ReportId" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false"
                                    TableLayout="Fixed">
                                    <Columns>
                                        <%--  <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnPreviewFile" OnClientClick="SelectCurrentRow(this);" CommandName="Preview"
                                                            runat="server" CssClass="SearchButton">
                                                            <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="False" />
                                                </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="Report" ItemStyle-Wrap="false" SortExpression="ReportName"
                                            UniqueName="ReportName">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("ReportName") = String.Empty, "&nbsp;", Container.DataItem("ReportName"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Record Type" ItemStyle-Wrap="false" SortExpression="RecordType"
                                            UniqueName="RecordType">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default" HeaderStyle-Width="70px" ItemStyle-Wrap="false"
                                            SortExpression="IsDefault" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="imgChecked" runat="server">
                                                            <i class="CheckedDefault" style="padding-right: 16px;padding-top: 1px;"></i>
                                                </asp:Label>

                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <ClientSettings Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true" EnablePostBackOnRowClick="true">
                                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="True"></Resizing>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>

                    </div>
                    <div class="col-6">
                        <%-- <div style="position:absolute;height: 270px; width:450px;top:0; z-index:10;"></div>--%>

                        <div style="width: 100%; height: 300px" id="ReportViewerDiv" runat="server">
                            <rsweb:ReportViewer ID="rvSqlReport3" runat="server"
                                DocumentMapWidth="200" Width="100%" AsyncRendering="false"
                                ProcessingMode="Remote" Font-Names="Verdana" ZoomPercent="50" Font-Size="8pt" ShowToolBar="false" ShowParameterPrompts="false" KeepSessionAlive="true">
                            </rsweb:ReportViewer>
                        </div>
                        <div id="SelectReportDiv" runat="server" style="width: 100%">
                            <asp:Label ID="lblReportPreview" runat="server" meta:resourcekey="lblReportPreview"></asp:Label>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <%--        <asp:LinkButton ID="btnPDFSave" CssClass="PDFButton" runat="server"
            Style="margin-right: 10px;">
            <span class="Icon"></span>
            <asp:Label ID="Label3" runat="server" meta:resourcekey="btnPDFSave" Text="Print To PDF"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>

        <asp:LinkButton ID="btnExcelSave" CssClass="ExcelButton" runat="server"
            Style="margin-right: 10px;">
            <span class="Icon"></span>
            <asp:Label ID="lblSave" runat="server" meta:resourcekey="btnMergeExcel" Text="Print To Excel"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        <%--<asp:LinkButton   ID="btnWordSave"     runat="server" 
                                Style="margin-right: 10px;">
                                        <img style="border: 0px; vertical-align: middle;"  src="Images/Toolbar/WordIcon.jpg" />
                                        <asp:Label ID="lblWord" runat="server" meta:resourcekey="btnMergeWord" Text="Export To Word" ></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>--%>

        <%--  <asp:LinkButton ID="btnSendEmail" OnClientClick="return OpenEmailPopup();" runat="server" CssClass="SendEmailButton"
            Style="margin-right: 10px;">
            <span class="Icon"></span>
            <asp:Label ID="lblEmail" runat="server" meta:resourcekey="btnEmail" Text="Send Email"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        <asp:LinkButton ID="btnReportViewer" OnClientClick="return openReport();" runat="server" CssClass="ReportViewerButton"
            Style="margin-right: 10px;">
            <span class="Icon"></span>
            <asp:Label ID="Label4" runat="server" meta:resourcekey="btnReportViewer" Text="Report Viewer"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        <asp:LinkButton ID="btnCancel" OnClientClick="ClosePopWnd(window);return false;" runat="server" CssClass="CancelButton"
            Style="margin-right: 10px;">
            <span class="Icon"></span>
            <asp:Label ID="Label2" runat="server" meta:resourcekey="btnCancel" Text="Cancel"></asp:Label>

        </asp:LinkButton>--%>







        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
