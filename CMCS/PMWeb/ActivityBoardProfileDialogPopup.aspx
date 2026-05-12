<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardProfileDialogPopup.aspx.vb" Inherits="Website.ActivityBoardProfileDialogPopup" meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        input[type="checkbox"] {
            margin-left: 0px !important;
        }

            input[type="checkbox"] + label {
                margin: 0px 0px 10px 3px;
                position: relative !important;
                bottom: 2px !important;
            }

        .pb-8 {
            padding-bottom: 8px;
        }
       

    </style>
</head>
<body>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function toggleSubscriptions() {
                var chkSubscribe = document.getElementById("chkSubscribe");
                var lblSubscribe = document.getElementById("lblSubscribe");
                var divSubscriptions = document.getElementById("divSubscriptions");
                if (chkSubscribe.checked) {
                    lblSubscribe.innerText = `<%= GetLocalResourceObject("Unsubscribe") %>`;
                    divSubscriptions.classList.remove("Hide");
                }
                else {
                    lblSubscribe.innerText = `<%= GetLocalResourceObject("Subscribe") %>`;
                    divSubscriptions.classList.add("Hide");
                }
            }
            function toggleWeekDay() {
                var isWeekly = $find($("[id$=ddlFrequency]")[0].id).get_value() === "1";
                if (isWeekly) {
                    document.getElementById("ddlWeekDay").classList.remove("Hide");
                }
                else {
                    document.getElementById("ddlWeekDay").classList.add("Hide");
                }
            }
        </script>
    </telerik:RadCodeBlock>
    
    <form id="form1" runat="server">
        <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" AutoPostBack="true" CssClass="small-toolbar">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" CommandName="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                Value="SaveAndExit" ToolTip="Save & Exit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close" ToolTip="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage" style="margin-bottom: 0;">
            <div class="row">
                <div class="col-12">
                    <table class="colTable" style="padding-bottom: 24px;">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubscribe" meta:resourcekey="Unsubscribe" runat="server" Text="Subscribe"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <input id="chkSubscribe" runat="server" type="checkbox" checked="checked" onchange="toggleSubscriptions();" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                    </table>
                    <div runat="server" id="divSubscriptions">
                        <div style="padding-bottom: 24px;">
                            <asp:CheckBox runat="server" ID="chkComments" meta:resourcekey="chkComments" Text="Email Me Whenever Someone Comments" Checked="true" />
                        </div>
                        <div class="pb-8" style="color: #666666 !important;">
                            <asp:Label runat="server" ID="lblSummaryReport" meta:resourcekey="lblSummaryReport" Text="Email Me a Summary Report of" />
                        </div>
                        <div class="pb-8">
                            <asp:CheckBox runat="server" ID="chkActionsTaken" meta:resourcekey="chkActionsTaken" Text="Action Taken" Checked="true" />
                        </div>
                        <div class="pb-8">
                            <asp:CheckBox runat="server" ID="chkTasksDue" meta:resourcekey="chkTasksDue" Text="Upcoming Tasks Due" Checked="true" />
                        </div>
                        <telerik:RadComboBox ID="ddlFrequency" AllowCustomText="true" Filter="Contains" runat="server"
                            Skin="Default" Style="font-size: 11px" OnClientSelectedIndexChanged="toggleWeekDay">
                        </telerik:RadComboBox>
                        <telerik:RadComboBox ID="ddlWeekDay" AllowCustomText="true" Filter="Contains" runat="server"
                            Skin="Default" Style="font-size: 11px; padding-left: 5px;">
                        </telerik:RadComboBox>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
