<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectDetails.ascx.vb"
    Inherits="Website.ProjectDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<table style="width:100%;">
    <tr>
        <td valign="top" style="width:350px">
            <table style="width:330px;" cellpadding="0" border="0">
                <tr>
                    <td valign="top">
                        <fieldset id="fldsetAddress" runat="server">
                            <legend><asp:Label runat="server" ID="lblAddress" meta:resourcekey="lblAddress" Text="Address11"></asp:Label></legend>
                            <table style="" cellpadding="0" cellspacing="2" border="0">
                                <tr>
                                    <td style="width:110px">
                                        <asp:Label ID="lblAddress1" meta:resourcekey="lblAddress1" runat="server" Text="Address 1 11"></asp:Label>
                                    </td>
                                    <td style="width:220px;">
                                        <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Width="217px"></asp:TextBox>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAddress2" meta:resourcekey="lblAddress2" runat="server" Text="Address 2 11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Width="217px"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCity" meta:resourcekey="lblCity" runat="server" Text="City11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Width="217px"></asp:TextBox>
                                    </td>
                                
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server" Text="State11"></asp:Label>
                                    </td>
                                    <td>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="padding-left:0px">
                                                    <telerik:RadComboBox ID="ddlStates" runat="server" Width="100px" Skin="Default" Style="font-size: 11px"
                                                        NoWrap="true" Height="350px" AllowCustomText="true" Filter="Contains" >
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="Width:30px; padding-left:5px">
                                                    <asp:Label ID="lblZip" meta:resourcekey="lblZip" runat="server" Text="Zip11"></asp:Label>
                                                </td>
                                                <td style="text-align: right !important; width:90px;">
                                                    <asp:TextBox ID="txtZip" MaxLength="50" Width="85px" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country11"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlCountries" Width="220px" Height="350px" AllowCustomText="true" Filter="Contains" 
                                            runat="server" Skin="Default" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPhone" meta:resourcekey="lblPhone" runat="server" Text="Phone11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhone" MaxLength="50" runat="server" Width="217px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFax" meta:resourcekey="lblFax" runat="server" Text="Fax11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFax" MaxLength="50" runat="server" Width="217px"></asp:TextBox>
                                    </td>
                                </tr>
                           </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td  valign="top">
                    <fieldset Id="fldsetTags" runat="server">
                            <legend><asp:Label runat="server" ID="lblTags" meta:resourcekey="lblTags" Text="Tags11"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td style="width:110px">
                                        <asp:LinkButton  runat="server" ID="btnlatitude" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnlatitude" Text="Latitude11"></asp:LinkButton>
                                    </td>
                                    <td style="width:220px;">
                                        <asp:TextBox ID="txtlatitude" runat="server" Width="217px" ></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton runat="server" ID="btnLongitude" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnLongitude" Text="Longitude11"></asp:LinkButton>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtLongitude" runat="server" Width="217px" ></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton runat="server" ID="btnElevation" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnElevation" Text="Elevation11"></asp:LinkButton>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtElevation" runat="server" Width="217px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleProjectAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address11"></asp:LinkButton>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="217px" ></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server" Text="Upload Logo11" Width="70px"></asp:Label>
                                </td>
                                <td>
                                    <div style="padding: 5px">
                                        <asp:Image ID="imglogo" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="240px" Height="70px" />
                                    </div>
                                    <div>
                                        <asp:FileUpload ID="FileToUpload" runat="server" Width="240px"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top">
            <table>
                <tr>
                    <td>
                        <fieldset id="fldsetPersonnel" runat="server">
                            <legend><asp:Label runat="server" ID="lblPersonnel" meta:resourcekey="lblPersonnel" Text="Personnel11"></asp:Label></legend>
                            <table align="left">
                                <tr>
                                    <td align="left" style="width:80px">
                                        <asp:LinkButton ID="btnGoToClient" CssClass="Link" meta:Resourcekey="lblClient" runat="server"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlClients" runat="server" Width="204" DropDownWidth="300px" 
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ...11" 
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlClients"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" >
                                        </telerik:RadComboBox>
                                    </td>
                                    <td align="left" style="width:120px; padding-left:15px">
                                        <asp:Label ID="lblManager" meta:resourcekey="lblManager" runat="server" Text="Manager11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtManager" runat="server" MaxLength="100" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:LinkButton ID="btnGoToGC" CssClass="Link" meta:Resourcekey="lblGC" runat="server"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlGCs" runat="server" Width="204px" DropDownWidth="300px" 
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ...11" 
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlGCs"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" >
                                        </telerik:RadComboBox>
                                    </td>
                                    <td align="left" style="padding-left:15px">
                                        <asp:Label ID="lblSuperintendent" meta:resourcekey="lblSuperintendent" runat="server" Text="Superintendent11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSuperintendent" runat="server" MaxLength="100" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:LinkButton ID="btnGoToArchitect" CssClass="Link" meta:Resourcekey="lblArchitect" runat="server"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlArchitects" runat="server" Width="204px" DropDownWidth="300px" 
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ...11" 
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlArchitects"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" ></telerik:RadComboBox>
                                    </td>
                                    <td align="left" style="padding-left:15px">
                                        <asp:LinkButton ID="btnGoToCommitmentCompany" CssClass="Link" meta:Resourcekey="lblCommitment" runat="server"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlCommitmentCompany" runat="server" Width="204px" DropDownWidth="300px" 
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ...11" 
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCommitmentCompany"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" ></telerik:RadComboBox>
                                    </td>               
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblExecutive" meta:resourcekey="lblExecutive" runat="server" Text="Executive11"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtExecutive" runat="server" MaxLength="100" Width="200px"></asp:TextBox>
                                    </td>
                                    <td align="left" style="padding-left:15px">
                                        <asp:LinkButton ID="btnGoToOwner" CssClass="Link" meta:Resourcekey="lblOwner" runat="server"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlOwner" runat="server" Width="204px" DropDownWidth="300px" 
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ...11" 
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlOwner"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" ></telerik:RadComboBox>
                                    </td>               
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset id="fldsetAssets" runat="server">
                            <legend><asp:Label runat="server" ID="lblAssets" meta:resourcekey="lblAssets" Text="Linked Assets11"></asp:Label></legend>
                                <telerik:RadGrid ID="rdgAssets" runat="server" HeaderStyle-Font-Size="8" Width="860px"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11" AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
                                    <mastertableview datakeynames="Id" commanditemdisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" Groupable="false" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="140px" SortExpression="Suite">
                                                <ItemTemplate>
                                                    <span> <%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>    
                                            <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-Width="140px" SortExpression="Property">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hliProperty" runat="server" CssClass="NoWrap,Link" Text='<%#IIf(PM.ProjectInfo.PropertyId =0, "&nbsp;", PM.ProjectInfo.PropertyName)%>'
                                                        NavigateUrl='<%# "~/Properties.aspx?Id=" & CStr(iif(PM.ProjectInfo.PropertyId =0,"0",PM.ProjectInfo.PropertyId))%>'></asp:HyperLink>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>                     
                                            <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Building" HeaderStyle-Width="140px" SortExpression="Building">
                                                <ItemTemplate>
                                                    <span> <%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>                   
                                            <telerik:GridTemplateColumn HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Floor" SortExpression="Floor">
                                                <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Space" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Space" SortExpression="Space">
                                                <ItemTemplate>
                                                    <span> <%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>                         
                                            <telerik:GridTemplateColumn HeaderText="Equipment" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-Width="140px" SortExpression="Equipment">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>&nbsp;  
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>                                  
                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding:2px">
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkAsset" CssClass="GridCmdlinkAsset" 
                                                     OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=4',1035, 710,true);">
                                                    <span class="Icon"></span>
                                                    <asp:Label runat="server" ID="lblAddAsset" Text = "link Asset(s)"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>                                         
                                                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdUnlinkAsset" 
                                                    runat="server" SecurityButtonType="ItemMode_Delete" CommandName="UnlinkAsset">
                                                        <span class="Icon"></span>
                                                    <asp:Label runat="server" ID="lblDeleteAssets" Text="Delete Assets"></asp:Label> &nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  > 
                                                    <span class="Icon"></span>
                                                    <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </mastertableview>
                                    <headerstyle font-size="8pt"></headerstyle>
                                    <clientsettings resizing-allowcolumnresize="true">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true"  />
                                    </clientsettings>
                                </telerik:RadGrid>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
