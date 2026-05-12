<%@ Page Language="vb"  meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="LinkToRecordPopup.aspx.vb" Inherits="Website.LinkToRecordPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <style type="text/css">
  
  
  .RadListBox_Office2007 .rlbGroup {
  
      border-style:none !important; 
  }
  
  </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>

      <script type="text/javascript">

          function RedirectPage(str) {
              window.top.location.href = str
        
          }

         </script>
    <div>

   <telerik:RadListBox ID="rlbLinkedRecord" 
           runat="server" BorderStyle="None" Skin="Default"
            SelectionMode="Single"   width="100%" AllowTransfer="false" 
              AllowReorder="False" EnableDragAndDrop="False" >
              <ItemTemplate>
              <div runat="server" OnClick='<%# String.Format("RedirectPage(""{0}"")",  Eval("Value")) %>' style="cursor:pointer"   >     
                <asp:LinkButton CssClass="labelColor" runat="server" ID="linkPlanName" OnClick='<%# String.Format("RedirectPage(""{0}"")",  Eval("Value")) %>'  Text='<%# Eval("Text") %>'></asp:LinkButton>  
              </div>    
              </ItemTemplate>
     </telerik:RadListBox>
    </div>
    </form>
</body>
</html>
