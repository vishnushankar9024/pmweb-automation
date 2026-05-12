<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfirmDeleteSpecificationPopup.aspx.vb" Inherits="Website.ConfirmDeleteSpecificationPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script>
        function AcceptChanges() {         
            var btnDelteSpecs = $(window.parent.document).find("[id$=btnDeleteSpecs]")
            if (btnDelteSpecs.length > 0) {
                window.parent.document.getElementById($(window.parent.document).find("[id$=btnDeleteSpecs]")[0].id).click()
            }
            else {
                window.parent.document.getElementById($(window.parent.document).find("[id$=btnUpdateEditedSpecs]")[0].id).click()
  
            }
            
            
            window.close();

        }

    </script>
    <style>


    </style>
</head>
<body>
    <form id="form1" runat="server">
        
             <div id="ProfileTitle" class="ProfileTitle" runat="server">
            
             <asp:label runat="server" ID="TitleUser" meta:Resourcekey="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <div class="PMMainPage PMPopupMainPage documentSinglePage R24SidePadding" runat="server">
             <div class="row">
                <div class="col-4">
    <asp:Label runat="server" ID="lblMessage" Style="font-size: 14px; color: #666;opacity:0.7" meta:Resourcekey="lblMessage" ></asp:Label>
       </div>
 <div id="divResults" style="text-align: center">
                 <table>
                     <tr>
                         <td>
    <asp:Button runat="server"  CssClass="ButtonOK" ID="btnOk" OnClientClick="AcceptChanges()"  Style="position: fixed; width: 100px; bottom: 24px; right: 165px"  meta:Resourcekey="btnOk" />
    <asp:Button runat= "server" ID="btnCancel" CssClass="ButtonCancel" meta:Resourcekey="btnCancel" OnClientClick="window.close()" style="position:fixed;width:100px;bottom:24px;right:24px"  />
      </td>
                     </tr>
                 </table>
                    </div>
                </div>
        </div>
               
    
           
        </form>
       
</body>
</html>
