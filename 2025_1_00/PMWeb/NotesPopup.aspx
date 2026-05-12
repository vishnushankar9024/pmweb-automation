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
            var txtNotes = window.parent.document.getElementById(querySt('txtNotesId'));
            if (txtNotes != null) {
                var currenttxtNotes = document.getElementById('txtNotes')
          if (txtNotes.value != '&nbsp;')
                    currenttxtNotes.value = txtNotes.value;
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
                        if (querySt('Source') != 'AssemblyPass' && querySt('Source') != 'AssemblyPassVariable') {

                            args.set_cancel(true);
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
                        if (typeof window.parent.saveNotes == 'function')
                            window.parent.saveNotes();
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

        window.onload = function()
        {
            document.querySelector("#txtNotes").innerText = GetText();
        }
    </script>
     <style type="text/css">
         .txtNotes{
             height: calc(100vh - 141px) !important;
         }
         </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <div id="ProfileTitle" class="ProfileTitle" runat="server" visible="false">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0" runat="server" id="ToolBar">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="small-toolbar">
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
        <div class="PMMainPage PMPopupMainPage" style="margin-bottom: 0 !important;" runat="server" id="divNotes">
            <div class="row">
                <div class="col-12">
                    <asp:TextBox runat="server" ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Style="height: calc(100vh - 100px)" Width="100%"></asp:TextBox>
                </div>
            </div>
        </div>

    </form>

</body>
</html>
