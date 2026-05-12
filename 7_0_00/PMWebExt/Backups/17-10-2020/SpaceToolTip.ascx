<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SpaceToolTip.ascx.vb" Inherits="Website.SpaceToolTip" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr style="padding:5px" >
        <td width="100px" style=" padding-left:5px"><b>
        <asp:Label runat="server" ID="lblspace" Text="Space"></asp:Label></b>
         </td>
        <td width="285px">
            <asp:HyperLink ID="HypSpace"  class="Link" Text="" runat="server">
            </asp:HyperLink></td>
    </tr>
    <tr>
        <td colspan="2">
             <telerik:RadTabStrip ID="RadTabStrip1" runat="server" Skin="Windows7" MultiPageID="RadMultiPage1"
                SelectedIndex="0">
                        <Tabs>
                            <telerik:RadTab Text="Occupants" Value="Occupants">
                            </telerik:RadTab>
                            <telerik:RadTab Text="Equipments" Value="Equipment">
                            </telerik:RadTab>
                             </Tabs>
                    </telerik:RadTabStrip>
                 <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0"
                Width="244px">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <asp:Literal ID="ltlOccupant" runat="server"></asp:Literal>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <asp:Literal ID="ltlEquipment" runat="server"></asp:Literal>
                </telerik:RadPageView>
                </telerik:RadMultiPage>
            
        </td>
    </tr>
 </table>

