<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentDetails.ascx.vb" Inherits="Website.EquipmentDetails" %>
<%@ Import Namespace="Library" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="AssetRotator.ascx" tagname="AssetRotator" tagprefix="uc1" %>
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

<telerik:RadAjaxLoadingPanel ID="ldpEquipmentDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
  
<table style="width: 100%;" >      
     <tr>
        <td  style="width:380px; padding-top:15px;" valign="top">
            <fieldset style="width:340px">
                <legend><asp:Label ID="lblPurchaseInformation" runat="server" meta:resourcekey="lblPurchaseInformation" Text="Purchase Information"></asp:Label></legend>
            <table width="320px">
                <tr>
                    <td  class="NoWrap">
                        <asp:Label ID="lblReceivedDate" runat="server" meta:resourcekey="lblReceivedDate" Text="Received Date"></asp:Label>
                    </td>
                    <td align="right">
                        <span runat="server" id="rmd_dtpReceivedDate" style="display:block">
                            <telerik:RadDatePicker ID="dtpReceivedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                Width="118px" style="margin-right:2px;" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput5"   Skin="Default" runat="server"></DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblVendor" runat="server" meta:resourcekey="lblVendor" Text="Vendor"></asp:Label>
                    </td>
                    <td class="NoWrap">
                      
                    <telerik:RadComboBox ID="ddlVendor" runat="server" Width="203px" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                        OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1" Height="300px"
                             OnClientDropDownClosed="dllcompClientClosed1"   DropDownWidth="350px" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested">
                            <CollapseAnimation Duration="200" Type="OutQuint"  />
                         </telerik:RadComboBox>
                              <asp:HiddenField ID="HiddenField2" runat="server" />
                    </td>
                    <td>
                        
                        <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton" 
                        OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlVendor'),'Companies')" >
                        <span class="Icon"></span>
                        </asp:LinkButton>

                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblManufacturer" runat="server" meta:resourcekey="lblManufacturer" Text="Manufacturer"></asp:Label>
                    </td>
                    <td class="NoWrap">
                   
                       <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="203px" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                        OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" Height="300px"
                              OnClientDropDownClosed="dllcompClientClosed"  DropDownWidth="350px"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested">
                            <CollapseAnimation Duration="200" Type="OutQuint"  />
                         </telerik:RadComboBox>
                          <asp:HiddenField ID="HiddenField1" runat="server" />
                    
                    </td>
                    <td>
                         
                    <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                        OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlManufacturer'),'Companies')" >
                    <span class="Icon"></span>
                    </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblManufacturerNumber" runat="server" meta:resourcekey="lblManufacturerNumber" Text="Mfr. #"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtManufacturerNumber" MaxLength="15" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblSerialNumber" runat="server" meta:resourcekey="lblSerialNumber" Text="Serial #"></asp:Label>
                    </td>
                    <td  colspan="2">
                        <asp:TextBox ID="txtSerialNumber" MaxLength="15" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblLotNumber" runat="server" meta:resourcekey="lblLotNumber" Text="Lot #"></asp:Label>
                    </td>
                    <td  colspan="2">
                        <asp:TextBox ID="txtLotNumber" MaxLength="15" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblItem" runat="server" meta:resourcekey="lblItem" Text="Item"></asp:Label>
                    </td>
                    <td  colspan="2">
                        <telerik:RadComboBox ID="ddlItem" runat="server" Width="205px" 
                        Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="300px" DropDownWidth="350px"
                       EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                         </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblPrice" runat="server" meta:resourcekey="lblPrice" Text="Price"></asp:Label>
                    </td>
                    <td  colspan="2">
                         <asp:TextBox ID="txtPrice" MaxLength="15" runat="server" CssClass="Currency" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblWarrantyExpires" runat="server" meta:resourcekey="lblWarrantyExpires" Text="Warranty Expires"></asp:Label>
                    </td>
                    <td align="right" >
                         <span runat="server" id="rmd_dtpWarrantyExpires" style="display:block">
                            <telerik:RadDatePicker ID="dtpWarrantyExpires" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                Width="118px"  Skin="Default" style="margin-right:2px;"  EnableTyping="True" >
                                <DateInput ID="DateInput7"    Skin="Default" runat="server"></DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                      <td>&nbsp;</td>
                </tr>
            </table>
            </fieldset>
        </td>
        <td valign="top" rowspan="3" >
                <uc2:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </td>     
    </tr> 
    <tr>
        <td>
            <table>
                <tr>
                    <td style="width:93px">
                        <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type"></asp:Label>
                    </td>
                    <td valign="middle">
                        <telerik:RadComboBox ID="ddlComponentType" runat="server" Width="205px" Skin="Default" AllowCustomText="True"
                         LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true" >
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </td>
        <td>
        </td>
    </tr> 
    <tr>
        <td valign="top">
            <fieldset style="width:340px">
                <legend><asp:Label ID="lblTags" runat="server" meta:resourcekey="lblTags" Text="Tags"></asp:Label></legend>
                <table>
                    <tr>
                        <td style="width:100px">
                            <asp:LinkButton runat="server" ID="btnGoogleAddress" meta:resourcekey="lblGoogleAddress" OnClientClick="return OpenGoogleEquipmentAddressesPicker();" Text="Google Address"></asp:LinkButton>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="190px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                        </td>
                        <td>
                            <div class="NoWrap"><asp:TextBox ID="txtBarcode" runat="Server" Width="120px" style="vertical-align:middle;height:16px;" MaxLength="255"></asp:TextBox>
                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" Style="vertical-align: middle;cursor:pointer" alt="" 
                                    onclick= "return OpenEquipmentBarCodePopup();" />
                                 <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                            <asp:label runat="server" id="lblBarCodeUnique" cssclass="Validator"  Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:label>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
        <td>
        </td>
    </tr>
</table>


