<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BuildingDetails.ascx.vb" Inherits="Website.BuildingDetails" %>
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

<telerik:RadAjaxLoadingPanel ID="ldpBuildingDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
  

<div class="PMHeader">
    <div class="row">
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td style="width:100%">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblLeasing" class="legend" meta:resourcekey="lblLeasing" runat="server" Text="Leasing11"></asp:Label>
                            </legend>
                            <table style="width:100%">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:linkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                            align="left" CssClass="SearchButton">
                                            <span class="Icon"></span>
                                        </asp:linkButton>
                                    </td>
                                    <td class="controlWidth">
                                         <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 50%;" class="NoWrap">
                                                    <asp:Label runat="server" ID="LblLinked" meta:resourcekey="LblLinked" Text="Linked11"></asp:Label>
                                                </td>
                                                <td style="width: 50%; text-align: center;" class="NoWrap">
                                                    <asp:Label runat="server" ID="LblActual" meta:resourcekey="LblActual" Text="Actual11"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth NoWrap">
                                        <asp:Label runat="server" ID="LblGrossArea" meta:resourcekey="LblGrossArea" Text="GrossArea11"> </asp:Label>
                                    </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 50%;" class="NoWrap">
                                                    <asp:TextBox style="width:99%" ID="TxtLinkedGrossArea" runat ="server" readonly = "true"></asp:TextBox>
                                                </td>
                                                <td style="width: 50%; text-align: center;" class="NoWrap">
                                                    <asp:TextBox style="width:90%"  ID="TxtActualGrossArea" CssClass="Double" runat ="server"></asp:TextBox>
                                                    <asp:Label runat="server" ID="LblGrossAreaUOM" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                            <table width="100%">
                                                <tr>
                                                    <td style="width:50%" class="NoWrap"> 
                                                </td>
                                                <td style="width:50%" class="NoWrap"> 
                                                    
                                                </td>
                                                </tr>
                                            </table>
                                        </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblRentable" meta:resourcekey="lblRentable" Text="Rentable11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%">
                                            <tr>
                                                <td style="width:50%">
                                                    <asp:TextBox style="width:99%" ID="TxtLinkedRentable"  runat ="server" readonly = "true"></asp:TextBox>
                                                </td>
                                                <td style="width:50%">
                                                    <asp:TextBox style="width:90%" ID="TxtActualRentable"  CssClass="Double" runat ="server"></asp:TextBox> 
                                                    <asp:Label runat="server" ID="lblRentableUOM" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblUsable" meta:resourcekey="lblUsable" Text="Usable11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%">
                                            <tr>
                                                <td style="width:50%">
                                                    <asp:TextBox style="width:99%" ID="TxtLinkedUsable" runat ="server"  readonly = "true"></asp:TextBox>
                                                </td>
                                                <td style="width:50%"> 
                                                    <asp:TextBox style="width:90%" ID="TxtActualUsable" CssClass="Double" runat ="server"></asp:TextBox>
                                                    <asp:Label  runat="server" ID="lblUsableUOM" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td valign="top" class="tdSpecs">
                        <uc2:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
                    </td>
                </tr>
            </table>    
        </div>
        <div class="col-4"></div>
    </div>
</div>
 


