<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LocationProgramsDetails.ascx.vb"
    Inherits="Website.LocationProgramsDetails" %>
<table>
    <tr>
        <td valign="top" style="width: 340px">
            <fieldset>
                <legend>
                    <asp:Label ID="lblAddress" meta:Resourcekey="lblAddress" runat="server"></asp:Label>
                </legend>
                <table cellpadding="0" cellspacing="5" border="0">
                    <tr>
                        <td colspan="1" width="140px" class="NoWrap">
                            <asp:Label ID="lblAddress1" meta:Resourcekey="lblAddress1" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtAddress1" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="1" class="NoWrap">
                            <asp:Label ID="lblAddress2" meta:Resourcekey="lblAddress2" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtAddress2" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="NoWrap">
                            <asp:Label ID="lblCity" meta:Resourcekey="lblCity" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtCity" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlStates" runat="server" Width="103px" Skin="Default" Style="font-size: 11px"
                                NoWrap="true" Height="200px" AllowCustomText="true" Filter="Contains">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                        <td class="NoWrap">
                            <asp:Label ID="lblZip" meta:Resourcekey="lblZip" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:TextBox ID="TxtZip" MaxLength="255" runat="server" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="NoWrap">
                            <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <telerik:RadComboBox ID="ddlCountries" Width="205px" Height="200px" AllowCustomText="true"
                                Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="NoWrap">
                            <asp:Label ID="lblPhone" meta:Resourcekey="lblPhone" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtPhone" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="NoWrap">
                            <asp:Label ID="lblFax" meta:Resourcekey="lblFax" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtFax" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset>
                <legend>
                    <asp:Label ID="lblTags" meta:Resourcekey="lblTags" runat="server"></asp:Label>
                </legend>
                <table cellpadding="0" cellspacing="5" border="0">
 
                    <tr>
                        <td class="NoWrap">
                            <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleLocProgramAddressesPicker();" meta:resourcekey="lblGoogleAddress" Text="Google Address"></asp:LinkButton>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                        </td>
                        <td>
                            <div class="NoWrap"><asp:TextBox ID="txtBarcode" runat="Server" Width="120px" style="vertical-align:middle;height:16px;" MaxLength="255"></asp:TextBox>
                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" Style="vertical-align: middle;cursor:pointer" alt="" 
                                    onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','LOC_PROGRAM','<%= PM.Asset.ProgramInfo.Id %>')" />
                            <asp:label runat="server" id="lblBarCodeUnique" cssclass="Validator"  Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:label>
                                  <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                            </div>
                            
                        </td>
                    </tr>
                </table>
            </fieldset>
            <table>
                <tr>
                    <td class="NoWrap" valign="top">
                        <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server"></asp:Label>
                    </td>
                    <td>
                        <div style="padding: 10px">
                            <asp:Image ID="imglogo" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="210px"
                                Height="70px" />
                        </div>
                        <div>
                            <asp:FileUpload ID="FileToUpload" runat="server" />
                        </div>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" style="width: 730px">
            <fieldset>
                <legend>
                    <asp:Label ID="lblLocationDefaults" meta:resourcekey="lblLocationDefaults" runat="server"></asp:Label>
                </legend>
                <table style="width: 100%;" cellpadding="0" cellspacing="5" border="0">
                    <tr>
                        <td width="120px" class="NoWrap">
                            <asp:Label ID="lblDefLocType" meta:resourcekey="lblDefLocType" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlDefLocTypes" runat="server" AllowCustomText="True" Width="204px" meta:Resourcekey="ddlTypes"
                                Skin="Default" Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                        <td class="NoWrap">
                            <asp:Label ID="lblOperatingProject" runat="server" meta:resourcekey="lblOperatingProject"
                                Text="Operating Project"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlOperatingProject" runat="server" AutoPostBack="true"
                                Skin="Default" DropDownWidth="300px" meta:resourcekey="ddlOperatingProject" OnItemsRequested="ddl_ItemsRequested"
                                NoWrap="true" Width="204px" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                EnableVirtualScrolling="True">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefCurrency" meta:resourcekey="lblDefCurrency" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlDefCurrency" runat="server" Width="204px" Skin="Default"
                                Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefTargetBudget" meta:resourcekey="lblDefTargetBudget" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefTargetBudget" MaxLength="15" CssClass="Currency" runat="server"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefAreaUOM" meta:resourcekey="lblDefAreaUOM" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlDefAreaUOM" Filter="Contains" Height="200px" AllowCustomText="true"
                                runat="server" Width="204px" Skin="Default" Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefTargetRevenue" meta:resourcekey="lblDefTargetRevenue" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefTargetRevenue" MaxLength="15" CssClass="Currency" runat="server"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefGrossArea" meta:resourcekey="lblDefGrossArea" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefGrossArea" MaxLength="15" CssClass="Double" runat="server"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefTargetOccupancy" meta:resourcekey="lblDefTargetOccupancy" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefTargetOccupancy" runat="server" CssClass="Percent"
                                MaxLength="9" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefRentable" meta:resourcekey="lblDefRentable" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefRentable" MaxLength="15" CssClass="Double" runat="server"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td width="120px" class="NoWrap">
                            <asp:Label ID="lblDefCapacity" meta:resourcekey="lblDefCapacity" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefCapacity" CssClass="PositiveInteger" MaxLength="9" runat="server"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap">
                            <asp:Label ID="lblDefUsable" meta:resourcekey="lblDefUsable" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDefUsable" MaxLength="15" CssClass="Double" runat="server" Width="200px"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <fieldset>
                    <legend>
                        <asp:Label ID="lblPersonnel" meta:Resourcekey="lblPersonnel" runat="server"></asp:Label>
                    </legend>
                    <table style="width: 100%;" cellpadding="0" cellspacing="5" border="0">
                        <tr>
                            <td width="120px" class="NoWrap">
                                <asp:Label ID="lblPersOwner" meta:Resourcekey="lblPersOwner" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersOwner" runat="server" Width="204px" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlPersOwner" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                </telerik:RadComboBox>
                            </td>
                            <td width="120px" class="NoWrap">
                                <asp:Label runat="server" ID="lblPersOwnerContact" meta:resourcekey="lblPersOwnerContact"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersOwnerContacts" runat="server" Width="204px" DropDownWidth="405px"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersOwnerContacts"
                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                </td>
                                                <td style="width: 135px;">
                                                    <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                </td>
                                                <td style="width: 135px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersClient" meta:Resourcekey="lblPersClient" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersClients" runat="server" Width="204px" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlPersClients" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                </telerik:RadComboBox>
                            </td>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersManager" meta:Resourcekey="lblPersManager" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersManager" runat="server" Width="205px" DropDownWidth="405px"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersManager"
                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                </td>
                                                <td style="width: 135px;">
                                                    <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                </td>
                                                <td style="width: 135px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersTenant" meta:Resourcekey="lblPersTenant" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersTenants" runat="server" Width="204px" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlPersTenants" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                </telerik:RadComboBox>
                            </td>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersSuperintendent" meta:Resourcekey="lblPersSuperintendent" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersSuperintendents" runat="server" Width="204px" DropDownWidth="405px"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersSuperintendents"
                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                </td>
                                                <td style="width: 135px;">
                                                    <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                </td>
                                                <td style="width: 135px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersAgent" meta:Resourcekey="lblPersAgent" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersAgents" runat="server" Width="204px" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlPersAgents" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                </telerik:RadComboBox>
                            </td>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersSecurity" meta:Resourcekey="lblPersSecurity" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPersSecurity" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersAuthority" meta:Resourcekey="lblPersAuthority" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlPersAuthorities" runat="server" Width="204px" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlPersAuthorities" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                    Height="250px">
                                </telerik:RadComboBox>
                            </td>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersMaintenance" meta:Resourcekey="lblPersMaintenance" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPersMaintenance" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersPropertyManager" meta:Resourcekey="lblPersPropertyManager"
                                    runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPersPropertyManager" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="NoWrap">
                                <asp:Label ID="lblPersMunicipality" meta:Resourcekey="lblPersMunicipality" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPersMunicipality" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </fieldset>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
