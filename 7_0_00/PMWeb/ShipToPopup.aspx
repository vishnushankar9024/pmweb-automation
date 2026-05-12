<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="ShipToPopup.aspx.vb" Inherits="Website.ShipToPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <script type="text/javascript">
        function returnToParent(FirslLine) {
            //create the argument that will be returned to the parent page
            var oArg = new Object();

            //        //get the city's name 
            oArg.FirslLine = FirslLine;

            //get a reference to the current RadWindow
            var oWnd = GetRadWindow();



            oWnd.close(oArg);
            oWnd.close();

        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlCompanies">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlCompanies" />
                        <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpComp" runat="server" BackgroundPosition="Center"
            Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                                    Width="100%">
                                    <Items>
                                          <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage" style="min-width:100% !important;">
                <div>
                    <table class="colTable" style="width: calc(100% - 48px) !important;margin-left:24px !important;margin-right:24px; !important">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSelectAddress" meta:resourcekey="lblSelectAddress" runat="server" Text="Select Address"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                    MarkFirstMatch="false" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                    NoWrap="True" AutoPostBack="true" Height="150px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadTextBox ID="txtDescription" TextMode="MultiLine" Height="82px" Width="100%"
                                    runat="server" Skin="Default" TabIndex="11">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
