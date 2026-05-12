<%@ Page Language="vb" meta:resourcekey="Page"  AutoEventWireup="false" CodeBehind="ConfirmSubscriptionOverride.aspx.vb" Inherits="Website.ConfirmSubscriptionOverride" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Confirm Subscription Override</title>
    <script type="text/javascript">
        function CloseAndSave() {
            var btnSave = $(window.parent.document).find("[id$=btnSave]");
            CloseRadWnd();
            btnSave.click();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <asp:scriptmanager id="PMScriptManager" runat="server">
    </asp:scriptmanager> 
       <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td valign="top">
                        <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                    Width="220px" CssClass="popup-toolbar">
                    <Items>
                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"
                            >
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton  CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" ></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
                        </td>
                    </tr>
           </table>
  <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr id="trTbsDetails" runat="server">
                    <td>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div class="PMHeader">
                                        <div class="row documentSinglePage">
                                            <div class="col-4">
                                                <table class="colTable" border="0">
                    <tr>
                        <td valign="top" style="width:50px">
                            <asp:Image ID="imgCaution" runat="server" ImageUrl="Images/Global/NoticeIcon.png" style="height:20px;Width:20px;padding-left:10px;"/>

                        </td>
                        <td  valign="top">
                            <asp:Label ID="lblCaution" meta:resourceKey="lblCaution" runat="server" ></asp:Label>
                        </td>
                    </tr>
                </table>
      </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
      </table>
    </form>
</body>
</html>