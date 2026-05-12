<%@ Page meta:Resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ProcurementRevisionPopup.aspx.vb" Inherits="Website.ProcurementRevisionPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function CloseRevision(Id) {

                var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                radWindow.close();
                radWindow.BrowserWindow.location.href = 'EstimateProcurements.aspx?Id=' + Id + '&ModuleId&PageId=161';

            }

        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="chkCopyBidders">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBidders" />
                        <telerik:AjaxUpdatedControl ControlID="rdbBiddersToCopy" />
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBestBids" />
                        <telerik:AjaxUpdatedControl ControlID="lblSelectionInfo" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdbBiddersToCopy">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBidders" />
                        <telerik:AjaxUpdatedControl ControlID="rdbBiddersToCopy" />
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBestBids" />
                        <telerik:AjaxUpdatedControl ControlID="lblSelectionInfo" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="chkCopyBestBids">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBidders" />
                        <telerik:AjaxUpdatedControl ControlID="rdbBiddersToCopy" />
                        <telerik:AjaxUpdatedControl ControlID="chkCopyBestBids" />
                        <telerik:AjaxUpdatedControl ControlID="lblSelectionInfo" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row">
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblOptions" Text="Options" meta:Resourcekey="lblOptions"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkCopyBidders" AutoPostBack="true" runat="server" Checked="true" Text="Copy Bidders" meta:Resourcekey="chkCopyBidders" />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 10px;">
                                    <asp:RadioButtonList ID="rdbBiddersToCopy" Width="250px" runat="server" Height="15px" AutoPostBack="true" RepeatDirection="Vertical" CssClass="RadioCss RadioPadding">
                                        <asp:ListItem Text="Active Bidders Only" meta:resourcekey="rdbActiveBiddersOnly" Value="Active" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Inactive Bidders Only" class="NoWrap" meta:resourcekey="rdbInactiveBiddersOnly" Value="Inactive"></asp:ListItem>
                                        <asp:ListItem Text="All Bidders" class="NoWrap" meta:resourcekey="rdbAllBidders" Value="All"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkCopyBestBids" AutoPostBack="true" runat="server" Text="Copy Best Bids" meta:Resourcekey="chkCopyBestBids" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-4" style="padding-left:10px; color: #666666;">
                    <asp:Label ID="lblSelectionInfo" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <table>
                        <tr>
                            <td width="40%">
                            </td>
                            <td width="30%">
                                <asp:Button ID="btnOk" runat="server" meta:resourcekey="btnOk" Text="OK" />
                            </td>
                            <td width="30%">
                                <asp:Button ID="btnCancel" runat="server" meta:resourcekey="btnCancel" Text="Cancel" />
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
