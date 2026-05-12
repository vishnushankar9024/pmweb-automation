<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SaveCustomLayoutPopup.aspx.vb" Inherits="Website.SaveCustomLayoutPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
    function SaveClicked() {
        $(window.parent.document).find("[id$=hfSaveAsLayout]").val(1);
        return true;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <style>

    @media screen and (max-width: 843px) and (min-width: 320px){
.labelWidth {
    width: 160px !important;
}

    }
            @media screen and (max-width: 467px) and (min-width: 418px){
div.PMMainPage {
    padding-right: 8px;
    padding-left: 24px !important;
}
        }
</style>
        <table class="ToolBar" style="width: 100%;position:static !important" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>                                        
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="CreateLayout" ValidationGroup="Save"></telerik:RadToolBarButton>
                                       <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" CausesValidation="false"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMMainPage PMPopupMainPage documentSinglePag">
                        <div class="row">
                            <div class="col-4">
                                <table class="colTable" border="0" >
                                    <tr>
                                        <td class="labelWidth" >
                                            <asp:Label ID="lblName" Text="Layout Name" meta:resourcekey="lblName" runat="server" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtName" Width="99%" Text="My Custom Layout" runat="server" />
                                            <span id="divLayoutNameError">
                                                <asp:RequiredFieldValidator ID="rfvLayoutName" ControlToValidate="txtName"
                                                    runat="server" CssClass="Validator" Display="Dynamic"
                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:WarningMsg_Required%>"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lblError" Text="You must enter a Layout Name." meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="False"></asp:Label>
                                                <asp:Label ID="lblLayoutNameUnique" meta:Resourcekey="lblLayoutNameUnique" runat="server" Text="Layout Name must be unique."
                                                    Visible="False" CssClass="Validator"></asp:Label>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
