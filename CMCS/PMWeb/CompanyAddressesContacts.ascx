<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyAddressesContacts.ascx.vb" Inherits="Website.CompanyAddressesContacts" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RamCompanyAdressCont" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgContacts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<telerik:RadAjaxLoadingPanel ID="ldpAdresses" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8"
                CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowGroupPanel="True"
                AllowFilteringByColumn="true" AllowMultiRowEdit="true" ShowStatusBar="true"
                AllowPaging="True" PageSize="250" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="ID" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="UserName" Groupable="false" CurrentFilterFunction="Contains" DataField="UserName"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#Container.DataItem("UserName")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUserName" MaxLength="100" runat="server" Text='<%# Eval("UserName") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="First Name" UniqueName="FirstName" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="FirstName" CurrentFilterFunction="Contains" DataField="FirstName"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FirstName").ToString = String.Empty, "&nbsp;", Container.DataItem("FirstName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFirstName" MaxLength="100" runat="server" Text='<%# Eval("FirstName") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Name" UniqueName="LastName" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="LastName"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("LastName").ToString = String.Empty, "&nbsp;", Container.DataItem("LastName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLastName" MaxLength="100" runat="server" Text='<%# Eval("LastName") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Department" GroupByExpression="DepartmentName [GridColumn_DepartmentName] Group By DepartmentName ASC"
                            UniqueName="DepartmentName" HeaderStyle-HorizontalAlign="Center" CurrentFilterFunction="Contains" DataField="DepartmentName"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            HeaderStyle-Width="20%" SortExpression="DepartmentName">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("DepartmentName").ToString = String.Empty, "&nbsp;", Container.DataItem("DepartmentName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlDepartment" OnClientSelectedIndexChanged="ddlDepartment_OnClientSelectedIndexChanged" runat="server"
                                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" AllowCustomText="true"
                                    NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Address" UniqueName="AddressCode" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="AddressCode"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="AddressCode" GroupByExpression="AddressCode [GridColumn_AddressCode] Group By AddressCode ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AddressCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressCode").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAddress" runat="server" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    Width="100%" NoWrap="true" CausesValidation="False" AllowCustomText="true">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Title" GroupByExpression="Title [GridColumn_Title] Group By Title ASC"
                            UniqueName="Title" CurrentFilterFunction="Contains" DataField="Title"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Title">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTitle" MaxLength="100" Width="100%" runat="server" Text='<%# Eval("Title") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC"
                            UniqueName="Phone" CurrentFilterFunction="Contains" DataField="Phone"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="Phone">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#EVAL("Phone") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext" GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC"
                            UniqueName="Ext" HeaderStyle-HorizontalAlign="Center" CurrentFilterFunction="Contains" DataField="Ext"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="20%" SortExpression="Ext">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExt" Width="100%" MaxLength="50" Text='<%# Eval("Ext") %>' runat="server">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Fax" GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC"
                            UniqueName="Fax" HeaderStyle-HorizontalAlign="Center" CurrentFilterFunction="Contains" DataField="Fax"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="20%" SortExpression="Fax">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFax" runat="server" MaxLength="50" Text='<%#EVAL("Fax") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cell" UniqueName="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Cell" CurrentFilterFunction="Contains" DataField="Cell"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("cell").ToString = String.Empty, "&nbsp;", Container.DataItem("cell").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCell" runat="server" MaxLength="50" Text='<%#EVAL("cell") %>'
                                   Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Alt Phone" UniqueName="AltPhone" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="AltPhone" CurrentFilterFunction="Contains" DataField="AltPhone"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="50" Text='<%#EVAL("AltPhone") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                            UniqueName="Email" HeaderStyle-HorizontalAlign="Center" CurrentFilterFunction="Contains" DataField="Email"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="20%" SortExpression="Email">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("Email") %>' Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RegularExpressionValidator ID="rfvEmail" CssClass="Validator" meta:resourcekey="rfvEmail"
                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        runat="server" ValidationGroup="Save" Display="Dynamic" ErrorMessage="Not valid email"></asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Website" GroupByExpression="Website [GridColumn_Website] Group By Website ASC"
                            UniqueName="Website" CurrentFilterFunction="Contains" DataField="Website"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Website">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebsite" MaxLength="100" runat="server" Text='<%# Eval("Website") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="TypeName"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="TypeName" GroupByExpression="TypeName [GridColumn_Type] Group By TypeName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox AllowCustomText="true" ID="ddlType" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Primary" UniqueName="Primary" HeaderStyle-Width="10%" ItemStyle-Wrap="false"
                            SortExpression="IsPrimary" CurrentFilterFunction="Contains" DataField="IsPrimary"
                            AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Center" GroupByExpression="IsPrimary [GridColumn_Primary] Group By IsPrimary ASC" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" CssClass="mobile-switch" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="10%" ItemStyle-Wrap="false"
                            SortExpression="IsActive" CurrentFilterFunction="Contains" DataField="IsActive"
                            AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="IsActive [GridColumn_Inactive] Group By IsActive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsActive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" CssClass="mobile-switch" Checked='<%# CBool(IIf(Eval("IsActive") Is System.DBNull.Value, 0, Eval("IsActive")))%>' runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Notes" CurrentFilterFunction="Contains" DataField="Notes"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project"
                            DataField="Project" CurrentFilterFunction="Contains"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                            UniqueName="Project" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="10%" SortExpression="Project">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Project").ToString = String.Empty, "&nbsp;", Container.DataItem("Project").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#Eval("Project")%>
                    &nbsp;
                                </span>

                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"
                                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server"
                                SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgContacts.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"
                                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                Visible='<%# rdgContacts.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgContacts.EditIndexes.Count > 0 Or rdgContacts.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                                    meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server"
                                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true"
                    AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />

                </ClientSettings>
            </telerik:RadGrid>

        </div>
    </div>
</div>
