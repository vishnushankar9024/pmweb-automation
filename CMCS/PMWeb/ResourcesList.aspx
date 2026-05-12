<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ResourcesList.aspx.vb" Inherits="Website.ResourcesList" %>
  <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="ResourceLabors.ascx" tagname="ResourceLabors" tagprefix="uc1" %>
<%@ Register src="ResourceMaterials.ascx" tagname="ResourceMaterials" tagprefix="uc2" %>
<%@ Register src="ResourceEquipment.ascx" tagname="ResourceEquipment" tagprefix="uc3" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<script type="text/javascript">
    var Prem = null;
    var OT = null;

    function LoadPrem(sender, args) {Prem = sender;}
    function LoadOT(sender, args) { OT = sender; }
    
    function Blur(sender, args) {
        Prem.set_value(sender.get_value() * 2);
        OT.set_value(sender.get_value() * 1.5);
    }
    
   
    function show(Reg, OT, Prem) {
        var result = Reg.value * 1.5;
        OT.value = result;
        result = Reg.value * 2;
        Prem.value = result;

    }

</script>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="tbsDocument">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpRessource" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
         <telerik:AjaxSetting AjaxControlID="mlpRessource">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpRessource" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpRessource" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>

<table  style="width: 100%;" cellpadding="0" cellspacing="0">
<tr id="trTbsDetails" runat="server">
        <td>                         
            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
                runat="server" MultiPageID="mlpRessource" Skin="Default" 
                     Width="100%" EnableViewState="False">
                <Tabs>
                    <telerik:RadTab Text="Labor" Value="Labor" Selected="True"/>                   
                    <%-- <telerik:RadTab Text="Materials" Value="Materials"/>--%>
                     <telerik:RadTab Text="Equipment" Value="Equipment"/>
                     <telerik:RadTab Text="Other" Value="Other" Visible="false" />
                </Tabs>
            </telerik:RadTabStrip>
        </td>
    </tr>
    <tr id="trMplDetails" runat="server">
          <td >
              <telerik:RadMultiPage ID="mlpRessource" runat="server" SelectedIndex="0"  
                    Width="100%" RenderSelectedPageOnly="true" BorderColor="LightBlue">
                    <telerik:RadPageView ID="pvLabor" runat="server">
                        <uc1:ResourceLabors ID="ResourceLabors1" runat="server" />
                    </telerik:RadPageView>
                   <%-- <telerik:RadPageView ID="pvMaterials" runat="server">
                        <uc2:ResourceMaterials ID="ResourceMaterials" runat="server" />
                    </telerik:RadPageView>--%>
                    <telerik:RadPageView ID="pvEquipment" runat="server">
                        <uc3:ResourceEquipment ID="ResourceEquipment1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvOther" runat="server">
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
        </td>
    </tr>
</table>
</asp:Content>
