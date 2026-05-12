<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SpaceDetails.ascx.vb" Inherits="Website.SpaceDetails" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
   <%@ Register src="DocumentSpecifications.ascx" tagname="DocumentSpecifications" tagprefix="uc2" %>


<telerik:RadAjaxLoadingPanel ID="ldpSpaceDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
    
<table>
    <tr>
        <td>&nbsp;</td> 
        <td style="width:300px"><asp:CheckBox ID="chkIsLeased" runat="server" Visible ="false"  meta:resourcekey="chkIsLeased" Text=" This space may be occupied." /></td>
        <td style="width:300px">&nbsp;</td> 
        <td style="width:300px">&nbsp;</td>
        <td style="width:300px">&nbsp;</td>
    </tr>
</table>
<table width="100%">
<tr>
    <td style="vertical-align:top; padding-top:11px; width:350px">
        <table>
            <tr>
                <td valign="top">
                    <fieldset  runat="server" id="fldsetAddress" >
                        <legend>
                            <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" runat="server" Text="Address"></asp:Label>
                        </legend>
                        <table>
                            <tr>
                                <td class="NoWrap" width="100px">
                                    <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1"></asp:Label>
                                </td>
                                <td colspan = "3">
                                    <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Width="250px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap">
                                    <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address 2"></asp:Label>
                                </td>
                                <td colspan = "3">
                                    <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap">
                                    <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity" Text="City"></asp:Label>
                                </td>
                                <td colspan = "3">
                                    <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Width="250px" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <asp:Label runat="server" ID="lblState" meta:resourcekey="lblState" Text="State"></asp:Label>
                                </td>
                                <td width="100px">
                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="125px" Skin="Default" DropDownWidth="120px"
                                        style="font-size: 11px" Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains"  >
                                        <collapseanimation duration="200" type="OutQuint" />
                                        </telerik:RadComboBox>
                                </td> 
                                <td  style="text-align:center" >
                                    <asp:Label runat="server" ID="LblZip" meta:resourcekey="lblZip"  Text="ZIP"></asp:Label>
                                </td>
                                <td width="50px">
                                    <asp:TextBox ID="txtZip" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap">
                                    <asp:Label runat="server" ID="lblCountry" meta:resourcekey="lblCountry" Text="Country" ></asp:Label>
                                </td>
                                <td colspan ="3">
                                    <telerik:RadComboBox ID="ddlCountries" runat="server"  Skin="Default" AllowCustomText="true"
                                        style="font-size: 11px" Height="400px">
                                        <collapseanimation duration="200" type="OutQuint" />
                                    </telerik:RadComboBox>
                       
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap">
                                    <asp:Label runat="server" ID="lblPhone" meta:resourcekey="lblPhone" Text="Phone"></asp:Label>
                                </td>
                                <td colspan = "3">
                                    <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="NoWrap">
                                    <asp:Label runat="server" ID="lblFax" meta:resourcekey="lblFax" Text="Fax"></asp:Label>
                                </td>
                                <td colspan = "3">
                                    <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
                <tr>
        <td>
            <table>
                <tr>
                    <td valign="middle" align="center" style="width:90px">
                        <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type"></asp:Label>
                    </td>
                    <td valign="middle" align="left">
                        <telerik:RadComboBox ID="ddlComponentType" runat="server" Width="250px" Skin="Default" AllowCustomText="true"
                         LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true" >
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td valign="middle" align="center" style="width:90px">
                      <asp:Label ID="lblServiceInterval" runat="server" meta:resourcekey="lblServiceInterval" Text="Service Interval"></asp:Label>
                    </td>
                    <td valign="middle" align="left">
                      <asp:TextBox ID="txtServiceInterval" MaxLength="15" runat="server" CssClass ="PositiveDouble" Width="248px"></asp:TextBox>
                    </td>
                   
                </tr>
            </table>
        </td>
        <td>
        </td>
    </tr> 
            <tr>
                <td valign="top"> 
                    <fieldset  runat="server" id="fldsetTags" >
                        <legend>
                            <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                        </legend>
                        <table>
                            <tr>
                        <td class="NoWrap">
                            <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="OpenGoogleSpaceAddressesPicker();" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:LinkButton>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                   <tr>
                        <td>
                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                        </td>
                        <td>
                            <div class="NoWrap"><asp:TextBox ID="txtBarcode" runat="Server" Width="120px" style="vertical-align:middle;height:16px;" MaxLength="255"></asp:TextBox>
                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" Style="vertical-align: middle;cursor:pointer" alt="" 
                                    onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','SPACE','<%= PM.Asset.SpaceInfo.Id %>')" />
                                <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                            <asp:label runat="server" id="lblBarCodeUnique" cssclass="Validator"  Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:label>
                            </div>
                            
                        </td>
                    </tr>
                        </table>
                    </fieldset>
                </td>
            </tr> 
        </table>
    </td>
    <td valign="top">
        <uc2:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
    </td> 
</tr>
</table>




