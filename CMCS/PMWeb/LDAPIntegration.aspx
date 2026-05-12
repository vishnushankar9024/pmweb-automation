<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="LDAPIntegration.aspx.vb" Inherits="Website.LDAPIntegration" %>

<%@ Register Src="LDAPIntegration.ascx" TagName="LDAPIntegration" TagPrefix="uc1" %>
<%@ Register Src="LDAPImportedUsers.ascx" TagName="LDAPImportedUsers" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/LDAPIntegration/LDAP.js" type="text/javascript"></script>
    <style>
        input[type="checkbox"] + label, input[type="radio"] + label {
    margin-top: -3px !important;
}
    </style>
    <telerik:radcodeblock id="CodeBlock" runat="server">
        <script type="text/javascript">
            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }
        </script>
    </telerik:radcodeblock>
    <telerik:radajaxpanel id="pnlDetailPane" loadingpanelid="ldpPM" runat="server" width="100%">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td>
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage  marginBottomOnMobile">
            <div class="row JustifyContent R3Cols">
                <div class="col-4 col-4-left">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblLdapSetting" runat="server" CssClass="legend" Text="LDAP Setting" meta:resourcekey="lblLdapSettings"></asp:Label>
                                    </legend>
                                    <table class="colTable" width="100%">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPath" runat="server" meta:resourcekey="lblPath"></asp:Label>

                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPath" runat="server"></asp:TextBox><br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblUserName" runat="server" meta:resourcekey="lblUserName"></asp:Label>

                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox><br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPassword" runat="server" meta:resourcekey="lblPassword"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Style="box-sizing: border-box; width: 100%;border:1px solid #666;height:24px;"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:CheckBox ID="chkUseAuthentication" Text="UseAuthentication11" runat="server" meta:resourcekey="chkUseAuth" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlAuthentication" runat="server" Width="100%">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Anonymous" Value="16"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="Delegation" Value="256"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="FastBind" Value="32"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="None" Value="0"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="ReadonlyServer" Value="4"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="Sealing" Value="128"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="SecureSocketsLayer" Value="2"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="Secure" Value="1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="ServerBind" Value="512"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem Text="Signing" Value="64"></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>


                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:CheckBox ID="chkUseFilter" Text="UseFilter11" runat="server" meta:resourcekey="chkUseFilter" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLDAPFilter" runat="server"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnConnect" meta:resourcekey="btnConnect" runat="server" Text="Connect11" />
                                                <asp:Button ID="btnDisconnect" meta:resourcekey="btnDisconnect" runat="server" Text="Disconnect11" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSaveSettings" meta:resourcekey="btnSaveSettings" runat="server" Text="Save Settings1" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                          
                </div>
                <div class="col-4 col-4-middle">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblImportDefaults" runat="server" CssClass="legend" Text="ImportDefaults111" meta:resourcekey="lblImportDefaults"></asp:Label>
                                    </legend>
                                    <table class="colTable" width="100%">
                                        <tr>
                                            <td valign="top" class="labelWidth">
                                                <asp:Label ID="lblLicenseType" runat="server" Text="LicenseType11" meta:resourcekey="lblLicenseType"></asp:Label>

                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlLicenseTypes" runat="server" Width="100%" Filter="Contains"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                                    AllowCustomText="false" OnClientSelectedIndexChanged="ResetCombos"
                                                    Height="200px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" class="labelWidth">
                                                <asp:Label ID="lblNamedLicense" runat="server" Text="NamedLicense11" meta:resourcekey="lblNamedLicense"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlIsNamedLic" runat="server" Width="100%" Filter="Contains"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                    Height="100px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblGroupName" runat="server" Text="lblGroupName11" meta:resourcekey="lblGroupName"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlGroups" runat="server" Width="100%" Filter="Contains"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                                    AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                    Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCompany" runat="server" Text="lblCompany" meta:resourcekey="lblCompany"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" Filter="Contains" OnItemsRequested="ddl_ItemsRequested" AllowCustomText="true"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..." NoWrap="True"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCreateContacts" runat="server" Text="lblCreateContacts" meta:resourcekey="lblCreateContacts"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkCreateContacts" Text="" runat="server" meta:resourcekey="chkCreateContacts" /></td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblIsSAMLAuthenticated" runat="server" Text="lblIsSAMLAuthenticated" meta:resourcekey="lblIsSAMLAuthenticated"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkIsSAMLAuthenticated" Text="" runat="server" /></td>
                                        </tr>
                                         <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:Label ID="lblLDAPUserNameProperty" runat="server" Text="lblLDAPUserNameProperty" meta:resourcekey="lblLDAPUserNameProperty"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLDAPUserNameProperty" runat="server"></asp:TextBox></td>
                                        </tr>
                                         <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:Label ID="lblLDAPFirstNameProperty" runat="server" Text="lblLDAPFirstNameProperty" meta:resourcekey="lblLDAPFirstNameProperty"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLDAPFirstNameProperty" runat="server"></asp:TextBox></td>
                                        </tr>
                                         <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:Label ID="lblLDAPLastNameProperty" runat="server" Text="lblLDAPLastNameProperty" meta:resourcekey="lblLDAPLastNameProperty"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLDAPLastNameProperty" runat="server"></asp:TextBox></td>
                                        </tr>
                                         <tr>
                                            <td class="labelWidth" style="display: flex;">
                                                <asp:Label ID="lblLDAPEmailProperty" runat="server" Text="lblLDAPEmailProperty" meta:resourcekey="lblLDAPEmailProperty"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLDAPEmailProperty" runat="server"></asp:TextBox></td>
                                        </tr>

                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblValidateImport" runat="server" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Button ID="btnImport" meta:resourcekey="btnImport" OnClientClick="DisablePanelAjax()" runat="server" Text="Import Users1" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                         
                </div>
                <div class="col-4 col-4-right">
                                <asp:Panel ID="pnlLicenses" runat="server" Style="vertical-align: top">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblNamedUsers" runat="server" CssClass="legend" Text="lblNamedUsers" meta:resourcekey="lblNamedUsers"></asp:Label></legend>
                                        <table class="colTable" style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="rdgLicenses" runat="server" Width="100%"
                                                        AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8"
                                                        AllowPaging="false" AllowSorting="false" ShowGroupPanel="false">
                                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                            DataKeyNames="LicenseTypeId" CommandItemDisplay="None" TableLayout="Fixed" Width="100%">
                                                            <Columns>

                                                                <telerik:GridTemplateColumn HeaderText="LicenseType" SortExpression="LicenseType" UniqueName="LicenseType">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItem("LicenseType")%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="100%" HorizontalAlign="Left" />
                                                                    <HeaderStyle Width="100%" />
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Maximum" SortExpression="Maximum" UniqueName="Maximum">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItem("Maximum")%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="100%" HorizontalAlign="Right" />
                                                                    <HeaderStyle Width="100%" />
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Assigned" SortExpression="Assigned" UniqueName="Assigned">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItem("Assigned")%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="100%" HorizontalAlign="Right" />
                                                                    <HeaderStyle Width="100%" />
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Available" SortExpression="Available" UniqueName="Available">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItem("Available")%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="100%" HorizontalAlign="Right" />
                                                                    <HeaderStyle Width="100%" />
                                                                </telerik:GridTemplateColumn>

                                                            </Columns>
                                                            <ItemStyle Wrap="false" />
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>

                                        </table>
                                    </fieldset>
                                </asp:Panel>
                        
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                                <uc1:LDAPIntegration ID="LDAPIntegration1" runat="server" />
                        
                </div>
            </div>
        </div>
    </telerik:radajaxpanel>
  
</asp:Content>
