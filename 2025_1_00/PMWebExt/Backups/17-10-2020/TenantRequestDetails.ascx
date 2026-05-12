<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TenantRequestDetails.ascx.vb" Inherits="Website.TenantRequestDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="DocumentSpecifications.ascx" tagname="DocumentSpecifications" tagprefix="uc3" %>
<table>
    <tr>
        <td valign="top" style="width:300px">
            <table>
                <tr>
                <td>
               <asp:label runat="server" id="lblSubmitted"  meta:Resourcekey="lblSubmitted"   text="Submitted"></asp:label>
                </td>
                <td>
                <asp:textbox  runat="server" id="txtSubmitted" text="" width="214px"></asp:textbox>
                </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:HyperLink runat ="server" CssClass ="Link" ID ="hliWorkOrder" meta:Resourcekey="hliWorkOrder" Text="Linked Work Order" ></asp:HyperLink>
                        </td>
                        <td>
                        <asp:textbox runat="server" id="txtWorkOrder" width="214px" ></asp:textbox>
                        </td>
                </tr>
                             <tr>
                    <td><asp:Label ID="lblReportedBy" meta:resourceKey="lblReportedBy" runat="server" Text="Reported By"></asp:Label></td>
                    <td><telerik:RadComboBox ID="ddlContacts" runat="server" width="217px" DropDownWidth="405px" 
                                            Skin="Default" Style="font-size: 11px" NoWrap="True" Height="200px" 
                                            EnableItemCaching="false" CloseDropDownOnBlur="true" AutoPostBack="False" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            AllowCustomText="True" ShowMoreResultsBox="True" EnableLoadOnDemand="True"
                                            OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" OnClientDropDownClosed="dllcompClientClosed"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" >
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
                                    <table>
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
                            </telerik:RadComboBox></td>
                    
                 </tr>
                <%-- <tr>
                 <td>
                 <asp:label runat="server" id="lblUnits"  meta:resourceKey="lblUnits" text="Unit(s)"></asp:label>
                 </td>
                 <td>
                 <asp:textbox runat="server" id="txtunits" width="214px" ReadOnly="True"></asp:textbox>
                 </td>
                 </tr>--%>
               <%-- <tr>
                 <td>
                 <asp:label runat="server" id="lblTenants"  meta:resourceKey="lblTenants" text="Tenant(s)" ></asp:label>
                 </td>
                 <td>
                 <asp:textbox runat="server" id="txtTenants" width="214px" ReadOnly="True"></asp:textbox>
                 </td>
                 </tr>--%>
                   <tr>
                                    <td><asp:Label ID="lblStatusRevision" meta:resourceKey="lblStatusRevision" runat="server" Text="Status/Revision"></asp:Label></td>
                                    <td colspan ="3">
                                        <table   cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width:144px">
                                                   <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains" MarkFirstMatch="true"
                                Skin="Default" CloseDropDownOnBlur="true" Width="120px" NoWrap="true" CausesValidation="False"
                                TabIndex="2">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                 <asp:textbox runat="server" Id="txtRevision" Width="70px" CssClass="PositiveInteger"></asp:textbox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
            </table>
               <fieldset style="width:300px;" runat="server" id="fldsetTags" >
                   <legend>
                         <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                   </legend>
                   <table width="300px;" border="0">
                   <tr>
                            <td class="NoWrap">
                                <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleTenantRequestAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address"></asp:LinkButton>
                            </td>
                            <td >
                                <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="200px" ></asp:TextBox>
                            </td>
                   </tr>
                    <tr>
                        <td> 
                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                        </td>
                        <td>
                            <div class="NoWrap"><asp:TextBox ID="txtBarcode" runat="Server" Width="120px" style="vertical-align:middle;height:16px;" MaxLength="255"></asp:TextBox>
                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" Style="vertical-align: middle;cursor:pointer" alt="" 
                                    onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','ASSET_TENANTREQUEST','<%= PM.Asset.TenantsInfo.TenantsRequestId %>')" />
                            <asp:label runat="server" id="lblBarCodeUnique" cssclass="Validator"  Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:label>
                                <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                            </div>
                            
                        </td>
                    </tr>

                   </table>
                   </fieldset>
        </td>
        <td style="width:674px" valign="top">
         <uc3:DocumentSpecifications ID="Spec" runat="server" />
        </td>
    </tr>
</table>
