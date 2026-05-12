<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FloorPlanView.ascx.vb" Inherits="Website.FloorPlanView" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="SpaceToolTip.ascx" tagname="SpaceToolTip" tagprefix="uc1" %>
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
          <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadToolTipManager1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadToolTipManager1" LoadingPanelID="ldpPM"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>   
          </AjaxSettings>         
  </telerik:RadAjaxManager>
<link href="CSS/TabberStyle.css" rel="stylesheet" type="text/css" />
<table>
    <tr>
        <td class="AllLightBlueBorder">
            <asp:Image ID="imgPlanview" usemap="#map1" runat="server" />
            <asp:PlaceHolder ID="plMapArea" runat="server"></asp:PlaceHolder>
        </td>
        <td>
        </td>
    </tr>
</table>
<telerik:RadToolTipManager runat="server" ID="RadToolTipManager1" Position="TopCenter" 
        RelativeTo="Mouse" Width="395px" Height="185px" Animation="Resize" HideEvent="ManualClose" 
        Skin="Default" OnAjaxUpdate="OnAjaxUpdate" EnableShadow="true" RenderInPageRoot="true" AnimationDuration="200">
    </telerik:RadToolTipManager>
<script type="text/javascript">
    function ShowTab(ctrl) {
        /* Show the tabberIndex tab and hide all the other tabs */

        $("#tooltipTab").find("li").removeClass("tabberactive");
        $(ctrl).addClass("tabberactive");
        $("#tooltipTab").find(".tabbertab").hide();
        $("#tooltipTab").find("#" + $(ctrl).attr("rel")).show();
    };
</script>