<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ApplicationCustomFieldsNotesPopup.aspx.vb" Inherits="Website.ApplicationCustomFieldsNotesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Notes</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function GetNotes() {
            var txtNotes = window.opener.document.getElementById(querySt('txtNotesId'));
            if (txtNotes != null) {
                var currenttxtNotes = document.getElementById('txtNotes')
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
                    var txtNotes = window.opener.document.getElementById(querySt('txtNotesId'));
                    if (txtNotes != null) {
                        var currenttxtNotes = document.getElementById('txtNotes')
                        txtNotes.value = currenttxtNotes.value;

                    }


                    window.close();
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
 
   <table cellpadding="0" cellspacing="0" width="100%">
            <tr class="toolbar">
             <td>
                    <telerik:RadToolBar ID="mainToolBar" Height ="25px" Width ="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked ="CheckClose" >
                    <Items> 
                       <telerik:RadToolBarButton  ImageUrl="Images/Global/Save.png" PostBack="false"
                                        CommandName="Save" AccessKey="s" Text ="Save" >
                                    </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close"  ImageUrl="Images/Global/Cancel.png"
                            Value="Close" meta:resourcekey="RadToolBarButton_Close" Text ="Close" ></telerik:RadToolBarButton>
                            </Items> 
                    </telerik:RadToolBar> 
             </td> 
              </tr>
              <tr>
              <td>
        <asp:TextBox runat="server" ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="300px" Width="100%"></asp:TextBox>
        
              
              </td>
              
              </tr>
              
              </table>
 
 
 
 
 
 
    </form>
  
</body>
</html>
