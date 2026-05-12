<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UnitDetails.ascx.vb" Inherits="Website.UnitDetails" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
  <%@ Register src="PMRotator.ascx" tagname="PMRotator" tagprefix="uc1" %>
   <%@ Register src="DocumentSpecifications.ascx" tagname="DocumentSpecifications" tagprefix="uc2" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rtrImages">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="imagePreview" LoadingPanelID="ldpPM"/>
                </UpdatedControls>
            </telerik:AjaxSetting>                                                                        
    </AjaxSettings>          
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpUnitDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>


<div style="float:left;width:59%" >
<br />
    <table style="width: 100%;">
        <tr>
            <td style="width: 40%; padding-top: 10px;" valign="top">
                <table id="tblAddresses">
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblAddress1" meta:resourcekey="lblAddress1" runat="server" Text="Address 1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtAddress1" runat="server" Width="250px" Text="300 United Way"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblAddress2" meta:resourcekey="lblAddress2" runat="server" Text="Address 2"></asp:Label>
                     
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtAddress2" runat="server" Width="250px" Text=""></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                             <asp:Label ID="lblCity" meta:resourcekey="lblCity" runat="server" Text="City"></asp:Label>    
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtCity" runat="server" Width="250px" Text="Fairview"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                              <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server" Text="State"></asp:Label>    
                        </td>
                        <td colspan="3">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px;" align="left">
                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="70px" Skin="Default" Style="font-size: 11px"
                                            Height="400px" NoWrap="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                    <td align="center">
                                       <asp:Label ID="lblZip" meta:resourcekey="lblZip" runat="server" Text="Zip"></asp:Label>   
                                    </td>
                                    <td width="120px" align="right">
                                        <telerik:RadMaskedTextBox ID="txtZip" Width="100%" runat="server" DisplayMask="#####-####"
                                            Mask="#####-####">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                          <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country"></asp:Label>      
                        </td>
                        <td colspan="3">
                            <telerik:RadComboBox ID="ddlCountries" runat="server" Width="100%" Skin="Default"
                                Style="font-size: 11px" Height="400px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                        </td>
                        <td colspan="3">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="3">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 60%; padding-top: 10px;" valign="top">
                <table id="tblContact" class="Top" width="100%">
                    <tr>
                        <td width="20%" valign="top" align="right">
                             <asp:Label ID="lblOwner" meta:resourcekey="lblOwner" runat="server" Text="Owner"></asp:Label>
                        </td>
                        <td width="80%">
                            <telerik:RadComboBox ID="ddlOwnerContacts" AllowCustomText="false" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" Width="300px"
                                NoWrap="true" ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                <Items>
                                    <telerik:RadComboBoxItem Text="" />
                                </Items>
                                <ItemTemplate>
                                    <telerik:RadTreeView ID="rdvContacts" Skin="Default" runat="server" Height="250px"
                                        MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvOwnerNodeClicking"
                                        OnNodeDataBound="rdvOwner_NodeDataBound" OnNodeExpand="rdvOwner_NodeExpand">
                                    </telerik:RadTreeView>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" align="right">
                             <asp:Label ID="lblContact"  meta:resourcekey="lblContact" runat="server" Text="Contact"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtContactDetails" runat="server" TextMode="MultiLine" Skin="Default"
                                Width="100%" Height="119px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
            <td rowspan="2">
            <div style="float:right;height:100%; width:365px;" >
 <uc1:PMRotator ID="PMRotator1" runat="server" />
 </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <uc2:DocumentSpecifications ID="DocumentSpecifications" runat="server" />

            </td>
        </tr>
    </table>
</div>
        
 
