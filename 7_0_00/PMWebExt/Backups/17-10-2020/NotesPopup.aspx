<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NotesPopup.aspx.vb"  Inherits="Website.NotesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function GetNotes() {
            var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
            if (txtNotes != null) {
                var currenttxtNotes = document.getElementById('txtNotes')
                if (querySt('SpecGroupId') > 0 || querySt('SpecGroupId') == '-1')
                    currenttxtNotes.value = txtNotes.innerHTML;
                else
                    currenttxtNotes.value = txtNotes.value;
            }
        }

        function GetText() {
            var txtNotes = window.parent.$("span[id$=" + querySt('txtNotesId') + "]")[0];
            if (txtNotes != null) {
                var currenttxtNotes = document.getElementById('txtNotes')
                if (txtNotes.innerHTML != '&nbsp;')
                    currenttxtNotes.value = txtNotes.innerHTML;
            }
        }


        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }

        function click_handler(sender, args) {
            switch (args.get_item().get_commandName()) {
                case 'Save':
                    if (querySt('SpecGroupId') > 0 || querySt('SpecGroupId') == '-1') {
                        var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
                        if (txtNotes != null) {
                            var currenttxtNotes = document.getElementById('txtNotes')
                            txtNotes.innerHTML = currenttxtNotes.value;
                        }
                    } else {
                        var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
                        if (txtNotes != null) {
                            var currenttxtNotes = document.getElementById('txtNotes')
                            txtNotes.value = currenttxtNotes.value;
                        }
                        //window.close();
                    }
                    break;
                case 'SaveAndExit':
                    if (querySt('SpecGroupId') > 0 || querySt('SpecGroupId') == '-1') {
                        var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
                        if (txtNotes != null) {
                            var currenttxtNotes = document.getElementById('txtNotes')
                            txtNotes.innerHTML = currenttxtNotes.value;
                        }
                    }
                    else {
                        var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
                        if (txtNotes != null) {
                            var currenttxtNotes = document.getElementById('txtNotes')
                            txtNotes.value = currenttxtNotes.value;
                        }
                        window.close();

                    }
                    break;
                case "Close":
                    window.close();
                    break;

                default:
                    break;
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="CheckClose" CssClass="small-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave"
                                CommandName="Save" AccessKey="s" Value="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndExit" AccessKey="s" Value="SaveAndExit" style="margin-right:-8px !important;">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom: 0 !important;">
            <div class="row">
                <div class="col-12">
                    <asp:TextBox runat="server" ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Style="height: calc(100vh - 100px) !important;" Width="100%"></asp:TextBox>
                </div>
            </div>
        </div>

    </form>

</body>
</html>
