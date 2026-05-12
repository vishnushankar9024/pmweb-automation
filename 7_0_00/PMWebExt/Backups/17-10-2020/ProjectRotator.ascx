<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectRotator.ascx.vb" Inherits="Website.ProjectRotator" %>
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
    
<asp:Panel ID="pnlRotator2" Width="100%" Height="100%" runat="server">
    <table style="width: 100%;" >
         <tr>
            <td align="center" valign="middle" class="AllLightBlueBorder">
               <asp:Image ID="imagePreview" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Height="320" Width="370"
                     AlternateText="preview" BorderWidth="0" ></asp:Image>
            </td>
         </tr>
         
       
        <tr>
       <td>
        <table style="width: 100%;"  class="AllLightBlueBorder">
           <tr>
            <td>
                <div style="width: 370px; overflow: auto; height:100px">
					<asp:datalist  id="dtlRotator" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False"
						Runat="server">
						<ItemTemplate>
							 <div class="RotatorDiv" style="height:70px; width:80px">
                                   <asp:ImageButton Id="ibtImage"  CommandName="ImageClicked" 
                                   style="height:70px; width:80px" ImageUrl='' onmouseover="this.style.cursor='hand'"  runat="server"/>
                             </div>
						</ItemTemplate>
					</asp:datalist>
				</div>
            </td>
            </tr>
        </table>
            </td>
        </tr>
    </table>
</asp:Panel>
