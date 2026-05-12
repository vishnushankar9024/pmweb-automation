<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PropertyDetails.ascx.vb"
    Inherits="Website.PropertyDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rtrImages">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="imagePreview" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMMainPage JustifyContent">
    <div class="row">
        <div class="col-4 col-4-left">
            <fieldset runat="server">
                <legend>
                    <asp:Label ID="lblPersonnel" class="legend" meta:Resourcekey="lblPersonnels" runat="server"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersOwner" meta:Resourcekey="lblPersOwner" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersOwner" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                meta:Resourcekey="ddlPersOwner" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                Height="250px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersClient" meta:Resourcekey="lblPersClient" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersClients" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                meta:Resourcekey="ddlPersClients" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                Height="250px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersTenant" meta:Resourcekey="lblPersTenant" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersTenants" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                meta:Resourcekey="ddlPersTenants" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                Height="250px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersAgent" meta:Resourcekey="lblPersAgent" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersAgents" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                meta:Resourcekey="ddlPersAgents" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                Height="250px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersAuthority" meta:Resourcekey="lblPersAuthority" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersAuthorities" runat="server"
                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                meta:Resourcekey="ddlPersAuthorities" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                Height="250px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersPropertyManager" meta:Resourcekey="lblPersPropertyManager" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtPersPropertyManager" MaxLength="255" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblPersOwnerContact" meta:resourcekey="lblPersOwnerContact"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersOwnerContacts" runat="server" DropDownWidth="400px"
                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersOwnerContacts"
                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
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
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblPersManager" meta:resourcekey="lblPersManager"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersManager" runat="server" DropDownWidth="400px"
                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersManager"
                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
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
                        <td class="labelWidth">
                            <asp:Label ID="lblPersSuperintendent" meta:Resourcekey="lblPersSuperintendent" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPersSuperintendents" runat="server" DropDownWidth="400px"
                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersSuperintendents"
                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
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
                        <td class="labelWidth">
                            <asp:Label ID="lblPersSecurity" meta:Resourcekey="lblPersSecurity" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtPersSecurity" MaxLength="255" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersMaintenance" meta:Resourcekey="lblPersMaintenance" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtPersMaintenance" MaxLength="255" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPersMunicipality" meta:Resourcekey="lblPersMunicipality" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtPersMunicipality" MaxLength="255" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-middle">
            <fieldset runat="server">
                <legend>
                    <asp:Label ID="lblLeasing" class="legend" runat="server" Text="Leasing" meta:resourcekey="lblLease"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:LinkButton ID="imgVisualCalculator" runat="server" CssClass="SearchButton">
                                            <span class="Icon"></span>
                            </asp:LinkButton>
                        </td>
                        <td class="controlWidth" style="text-align: center; color: #666666; text-transform: uppercase">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="45%">
                                        <asp:Label ID="lblLinked" runat="server" Text="Linked" meta:resourcekey="lblLinked"></asp:Label>
                                    </td>
                                    <td style="padding-left: 10px; width: 45%; padding-right: 4px;">
                                        <asp:Label ID="lblActual" runat="server" Text="Actual" meta:resourcekey="lblActual"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblGrossArea" runat="server" Text="Gross Area" meta:resourcekey="lblGrossArea"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="45%">
                                        <asp:TextBox ID="txtLinkedGrossArea" ReadOnly="true" runat="server" style="text-align:right;"></asp:TextBox>
                                    </td>
                                    <td style="padding-left: 10px; width: 45%; padding-right: 4px;">
                                        <asp:TextBox ID="txtActualGrossArea" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblRentable" runat="server" Text="Rentable" meta:resourcekey="lblRentable"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="45%">
                                        <asp:TextBox ID="txtLinkedRentable" ReadOnly="true" runat="server" style="text-align:right;"></asp:TextBox>
                                    </td>
                                    <td style="padding-left: 10px; width: 45%; padding-right: 4px;">
                                        <asp:TextBox ID="txtActualRentable" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblUsable" runat="server" Text="Usable" meta:resourcekey="lblUsable"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="45%">
                                        <asp:TextBox ID="txtLinkedUsable" ReadOnly="true" runat="server" style="text-align:right;"></asp:TextBox>
                                    </td>
                                    <td style="padding-left: 10px; width: 45%; padding-right: 4px;">
                                        <asp:TextBox ID="txtActualUsable" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblAreaUOM" runat="server" Text="Area UOM" meta:resourcekey="lblAreaUOM"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlAreaUOM" Filter="Contains" Height="300px" AllowCustomText="true" style="width:237px !important"
                                runat="server" Skin="Default">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-right"></div>
    </div>
</div>

