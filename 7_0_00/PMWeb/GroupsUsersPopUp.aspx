<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GroupsUsersPopUp.aspx.vb" Inherits="Website.GroupsUsersPopUp" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
     <script type="text/javascript" >
         function SelectGroupUser(s,e) {
             var id = e.get_item().get_value();
             var type;
             if (id == '0') { type = 'Portfolio'; }
             else {
                 if (id.substring(0, 1) == 'G')
                 { type = 'Group'; }
                 else
                 { type = 'User'; }
             }
             $(window.parent.document).find("input[id$='hdnGroupUserId']").val(id);
             $(window.parent.document).find("input[id$='hdnGroupUserType']").val(type);
             CloseRadWnd();
             $(window.parent.document).find("input[id$='btnLoadSettings']").click();
}
 </script>
    <div>
    <Telerik:RadListBox ID="lsvLinks" runat="server" Width ="100%">
        
     </Telerik:RadListBox>
    </div>
    </form>
</body>
</html>
