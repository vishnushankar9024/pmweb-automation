<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMRotator.ascx.vb" Inherits="Website.PMRotator" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>       
            <telerik:AjaxSetting AjaxControlID="dtlRotator">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="imagePreview"  />
                    <telerik:AjaxUpdatedControl ControlID="dtlRotator" />
                </UpdatedControls>
            </telerik:AjaxSetting>
         </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<style>
    .transition{transition:.7s;}
    #carousel{width:0px;position:relative;top:0;left:0px}
    td{padding:0;}
</style>
<asp:Panel ID="pnlRotator" Width="100%" Height="100%" runat="server">
    <table style="width: 100%;"  cellpadding="0" cellspacing="0">
         <tr>
            <td>
               <asp:Image ID="imagePreview" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Height="230" style="width:400px!important;max-width:400px!important"
                     AlternateText="preview" BorderWidth="0" CssClass="ImageSizeOnMobile" ></asp:Image>
            </td>
         </tr>
         
       
        <tr>
       <td>
       
                <div class="Wrap" style="position:relative; width:400px;height:88px;">
                    <div class="Window" style="overflow:hidden;position:relative;">
                        <div id="carousel" > 
					<asp:datalist  id="dtlRotator" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False"
						Runat="server">
						<ItemTemplate>
							 <div class="RotatorDiv" style="height:88px; width:100px;cursor:pointer;float:left;display:flex;flex-direction:column;justify-content:center;" runat="server" id="dvRotImg">
                                   <asp:ImageButton Id="ibtImage"  CommandName="ImageClicked"
                                   style="height:88px; width:100px!important;max-width:100px!important;padding:0 !impotant;" ImageUrl='' onmouseover="this.style.cursor='hand'"  runat="server"/>
                             </div>
						</ItemTemplate>
					</asp:datalist>

                        </div>
				</div>
                    <div id="next" class="rrButton rrButtonRight">&nbsp;</div>
                   <div class="rrButton rrButtonLeft" id="prev">&nbsp;</div>
                    
                </div>
         
          
            </td>
        </tr>
    </table>
</asp:Panel>
