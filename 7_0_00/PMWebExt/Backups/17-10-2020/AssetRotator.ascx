<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetRotator.ascx.vb" Inherits="Website.AssetRotator" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefreshRotator">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlRotator" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshRotator" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
   
    <style type="text/css">
         .transition{transition:.7s;}
           #carousel{width:0px;position:relative;top:0;left:0px}
        

        .Rotator td{
            padding: 0;
        }
    </style>

</telerik:RadCodeBlock>
<asp:Panel ID="pnlRotator" Width="100%" Height="100%" class="Wrap" runat="server"  style="position:relative; width:400px;height:116px;">
     <div id="RotatorContainer" style="position:relative;overflow:hidden;" class="Window">
            <div id="carousel" > 
         <asp:DataList ID="dtlRotator" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" CssClass="Rotator"
             runat="server">
             <ItemTemplate>
                 <div class="RotatorDiv" style="height: 106px; width: 100px" runat="server" id="dvRotImg">
                     <asp:ImageButton ID="ibtImage" OnClientClick="return PopupImageGallery(this);"
                         Style="height: 106px; width: 100px;padding: 1px 0 1px 0 !important;" ImageUrl='' onmouseover="this.style.cursor='hand'" runat="server" />
                 </div>
             </ItemTemplate>
         </asp:DataList>
                </div>
          <div id="Rotatornext" runat="server" class=" Rotatornext rrButton rrButtonRight">&nbsp;</div>
          <div class="Rotatorprev rrButton rrButtonLeft" runat="server" id="Rotatorprev">&nbsp;</div>
     </div>
</asp:Panel>
<asp:Button ID="btnRefreshRotator" runat="server" CssClass="Hide" />
