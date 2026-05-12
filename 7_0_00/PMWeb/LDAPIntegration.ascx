<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LDAPIntegration.ascx.vb" Inherits="Website.LDAPIntegration1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlLicenses" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblValidation" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    .PMMainPage .PMHeader .row {
     padding-top: 0px !important;
}

    input[type="checkbox"] + label{
        color:white !important;
        vertical-align: middle;
    }
    
</style>
<div class="PMHeader">
    <div class="row ">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgUsers" runat="server" CssClass="WithoutTopBorder" BorderWidth="0"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                PageSize="10" AllowPaging="true" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AllowMultiRowEdit="false" AllowMultiRowSelection="false" AllowSorting="true" ShowGroupPanel="true" Width="100%" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView DataKeyNames="Id" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" AllowFiltering="false" UniqueName="Select" HeaderText="Select" Groupable="False"  HeaderStyle-Width="100px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" Text="SelectAll1" OnCheckedChanged="chkSelectAll_CheckedChanged" meta:resourcekey="chkSelectAll" AutoPostBack="true" Checked='<%# IIf(ViewState("chkSelectAll") = True, True, False) %>' />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" AutoPostBack="False" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ID*" CurrentFilterFunction="Contains" UniqueName="UserName"
                            DataField="UserName" AutoPostBackOnFilter="true" GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblUserId" runat="server" Text='<%#Eval("UserName")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="First Name*" CurrentFilterFunction="Contains"
                            UniqueName="FirstName" DataField="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC"
                            AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <asp:TextBox ID="txtFirstName" MaxLength="50" runat="server" Text='<%#Eval("FirstName")%>'
                                    Width="99%"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Last Name" CurrentFilterFunction="Contains"
                            UniqueName="LastName" DataField="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC"
                            AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <asp:TextBox ID="txtLastName" MaxLength="50" runat="server" Text='<%#Eval("LastName")%>'
                                    Width="99%"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="LDAP Groups" CurrentFilterFunction="Contains"
                            UniqueName="LDAPGroups" DataField="LDAPGroups" GroupByExpression="LDAPGroups [GridColumn_LDAPGroups] Group By LDAPGroups ASC"
                            AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <asp:TextBox ID="txtLDAPGroups" runat="server" Text='<%#Eval("LDAPGroups")%>'
                                    Width="99%"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="License Type*" CurrentFilterFunction="Contains"
                            UniqueName="LicenseType" DataField="LicenseType" AutoPostBackOnFilter="true"
                            DataType="System.String" FilterListOptions="VaryByDataType" GroupByExpression="LicenseType [GridColumn_LicenseType] Group By LicenseType ASC">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlLicenseTypes" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                    AllowCustomText="false" OnClientSelectedIndexChanged="ResetCombos" Style="font-size: 11px"
                                    Height="200px">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Named License*" CurrentFilterFunction="Contains" UniqueName="IsNamedLic"
                            DataField="IsNamedLic" DataType="System.Boolean" FilterListOptions="VaryByDataType"
                            GroupByExpression="IsNamedLic [GridColumn_IsNamedLic] Group By IsNamedLic ASC">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlIsNamedLic" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                    Style="font-size: 11px" Height="100px">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Group Name*" CurrentFilterFunction="Contains"
                            UniqueName="Group" DataField="GroupName" AutoPostBackOnFilter="true" DataType="System.String"
                            FilterListOptions="VaryByDataType" GroupByExpression="GroupName [GridColumn_Group] Group By GroupName ASC">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlGroups" runat="server" Width="100%" Height="250px"
                                    Filter="Contains" AllowCustomText="true"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    Style="font-size: 11px"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Company" CurrentFilterFunction="Contains" UniqueName="Company" DataField="Company" AutoPostBackOnFilter="true"
                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" DropDownWidth="300px" OnItemsRequested="ddl_ItemsRequested"
                                    EmptyMessage="Select Company..." OnClientSelectedIndexChanged="ddlCompanies_SelectedIndexChanged"
                                    Style="font-size: 11px" Height="250px"
                                    Filter="Contains" AllowCustomText="false"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Contact" CurrentFilterFunction="Contains" UniqueName="Contact" DataField="FullContact" AutoPostBackOnFilter="true"
                            GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlContacts" runat="server" Width="100%" Filter="Contains"
                                    OnClientSelectedIndexChanged="ddlContact_SelectedIndexChanged" DropDownWidth="300px"
                                    MarkFirstMatch="True" Skin="Default" Style="font-size: 11px" OnItemDataBound="ddlContacts_ItemDataBound"
                                    NoWrap="True" Height="150px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Contact..." AllowCustomText="false"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CreateContact" CurrentFilterFunction="Contains" UniqueName="CreateContact"
                            DataField="CreateContact" AutoPostBackOnFilter="true" GroupByExpression="CreateContact [GridColumn_CreateContact] Group By CreateContact ASC"
                            DataType="System.Boolean" Groupable="false">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkCreateContactsAll" runat="server" Text="CreateContactsAll" OnCheckedChanged="chkCreateContactsAll_CheckedChanged" meta:resourcekey="chkCreateContactsAll" AutoPostBack="true" Checked='<%# IIf(ViewState("chkCreateContactsAll") = True, True, False) %>' />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkCreateContact" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SAML User" CurrentFilterFunction="Contains" UniqueName="IsSAMLAuthenticated"
                            DataField="IsSAMLAuthenticated" AutoPostBackOnFilter="true" GroupByExpression="IsSAMLAuthenticated [GridColumn_IsSAMLAuthenticated] Group By IsSAMLAuthenticated ASC"
                            DataType="System.Boolean" Groupable="false">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkIsSAMLAuthenticatedAll" runat="server" Text="SAMLUsersAll" OnCheckedChanged="chkIsSAMLAuthenticatedAll_CheckedChanged" meta:resourcekey="chkIsSAMLAuthenticatedAll" AutoPostBack="true" Checked='<%# IIf(ViewState("chkIsSAMLAuthenticatedAll") = True, True, False) %>' />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsSAMLAuthenticated" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Email" CurrentFilterFunction="Contains" UniqueName="Email"
                            DataField="Email" AutoPostBackOnFilter="true" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                            DataType="System.String">
                            <ItemTemplate>
                                <asp:TextBox ID="txtEmail" Width="100%" MaxLength="50" runat="server" Text='<%#Eval("Email")%>'></asp:TextBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                        <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Users" CssClass="GridCmdAddLdapUsers"
                            SecurityButtonType="AddEditMode_Add" CommandName="AddLdapUsers" Visible="true">
                            <span class="Icon"></span>
                            <asp:Label ID="Label5" runat="server" Text="Save" meta:resourcekey="btnSave"></asp:Label>&nbsp;&nbsp;
                        </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true"
                    AllowDragToGroup="True">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                </ClientSettings>

                <%-- <ValidationSettings ValidationGroup="Users" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />--%>
            </telerik:RadGrid>
        </div>
    </div>
</div>

<br />
<asp:Label ID="lblValidation" runat="server" CssClass="Validator"></asp:Label>