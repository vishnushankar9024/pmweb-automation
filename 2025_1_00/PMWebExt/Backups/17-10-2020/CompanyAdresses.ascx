<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyAdresses.ascx.vb" Inherits="Website.CompanyAdresses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RamCompanyAdress" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCompanyAdresses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCompanyAdresses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadAjaxLoadingPanel ID="ldpAdress" runat="server" Skin="Default" />
<telerik:RadGrid ID="rdgCompanyAdresses" runat="server" CssClass="WithoutTopBorder"
    AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8"
    PageSize="25" AllowPaging="True" ShowFooter="True" ShowGroupPanel="True"
    AllowMultiRowEdit="True" AllowMultiRowSelection="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" AllowFilteringByColumn="true" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top" ShowFooter="true"
        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="ID*" DataField="AddressCode" UniqueName="AddressCode"
                SortExpression="AddressCode" Groupable="false"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("AddressCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressCode").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddressCode" MaxLength="50" runat="server" Text='<%# Eval("AddressCode") %>' Width="100%"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvAddressCode" runat="server" ControlToValidate="txtAddressCode"
                            CssClass="Validator" ErrorMessage="Enter the ID" meta:resourcekey="rfvAddressCodeRequired"
                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </div>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Address 1" DataField="Address1" UniqueName="Address1" SortExpression="Address1"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Address1 [GridColumn_Address1] Group By Address1 ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Text='<%# Eval("Address1") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Address 2" DataField="Address2" UniqueName="Address2" SortExpression="Address2"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Address2 [GridColumn_Address2] Group By Address2 ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Text='<%# Eval("Address2") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="City" DataField="City" UniqueName="City" SortExpression="City"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="City [GridColumn_City] Group By City ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Text='<%# Eval("City") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="State" DataField="StateName" UniqueName="StateName" SortExpression="StateName"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="StateName [GridColumn_StateName] Group By StateName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("StateName").ToString = String.Empty, "&nbsp;", Container.DataItem("StateName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlState" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Zip" DataField="Zip" UniqueName="Zip" SortExpression="Zip"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Zip [GridColumn_Zip] Group By Zip ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtZip" Width="100%" MaxLength="50" Text='<%# Eval("Zip") %>' runat="server">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Country" DataField="CountryName" UniqueName="CountryName" SortExpression="CountryName"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="CountryName [GridColumn_CountryName] Group By CountryName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CountryName").ToString = String.Empty, "&nbsp;", Container.DataItem("CountryName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCountry" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="130px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Phone" DataField="Phone" UniqueName="Phone" SortExpression="Phone"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#EVAL("Phone") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Ext" DataField="Ext" UniqueName="Ext" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Ext"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>

                    <asp:TextBox ID="txtExt" Width="100%" MaxLength="10" Text='<%# Eval("Ext") %>' runat="server">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Fax" DataField="Fax" UniqueName="Fax" SortExpression="Fax"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFax" runat="server" MaxLength="50" Text='<%#EVAL("Fax") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Alt Phone" DataField="AltPhone" UniqueName="AltPhone" SortExpression="AltPhone"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="50" Text='<%#EVAL("AltPhone") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Email" DataField="Email" UniqueName="Email" SortExpression="Email"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
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
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Website" DataField="Website" UniqueName="Website" SortExpression="Website"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Website [GridColumn_Website] Group By Website ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtWebsite" MaxLength="250" runat="server" Text='<%# Eval("Website") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>


            <telerik:GridTemplateColumn HeaderText="Type" DataField="TypeName" UniqueName="TypeName" SortExpression="TypeName"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="TypeName [GridColumn_TypeName] Group By TypeName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>


            <telerik:GridTemplateColumn HeaderText="Primary" DataField="IsPrimary" UniqueName="IsPrimary" SortExpression="IsPrimary"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                GroupByExpression="IsPrimary [GridColumn_IsPrimary] Group By IsPrimary ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" CssClass="mobile-switch" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Inactive" DataField="IsActive" UniqueName="Inactive" SortExpression="IsActive"
                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                GroupByExpression="IsActive [GridColumn_IsActive] Group By IsActive ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("IsActive") is system.DBNULL.value, 0,Eval("IsActive")))%>' runat="server" CssClass="mobile-switch" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes" UniqueName="Notes" SortExpression="Notes"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength="100" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>

                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
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
            <telerik:GridBoundColumn Aggregate="SUM" DataField="Id" Visible="False" />

        </Columns>
        <EditItemStyle Wrap="false" />
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count = 0 And (Not rdgCompanyAdresses.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server"
                        Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server"
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count > 0 %>'
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"
                        meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgCompanyAdresses.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save"
                        meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count > 0 Or rdgCompanyAdresses.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                        meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count = 0 And (Not rdgCompanyAdresses.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                        meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count = 0 And (Not rdgCompanyAdresses.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server"
                        Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgCompanyAdresses.EditIndexes.Count = 0 And (Not rdgCompanyAdresses.MasterTableView.IsItemInserted) %>'
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
    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true"
        AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />

    </ClientSettings>

    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>


