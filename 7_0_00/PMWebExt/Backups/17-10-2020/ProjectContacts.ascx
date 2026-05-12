<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectContacts.ascx.vb" Inherits="Website.ProjectContacts" %>
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
<telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="20">
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
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="First Name" UniqueName="FirstName" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="20%" SortExpression="FirstName" CurrentFilterFunction="Contains" DataField="FirstName"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("FirstName").ToString = String.Empty, "&nbsp;", Container.DataItem("FirstName").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Last Name" UniqueName="LastName" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="LastName"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("LastName").ToString = String.Empty, "&nbsp;", Container.DataItem("LastName").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Contact" UniqueName="Contact" HeaderStyle-HorizontalAlign="Center" DataField="Contact"
                HeaderStyle-Width="150px" SortExpression="Contact"
                GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Contact").ToString = String.Empty, "&nbsp;", Container.DataItem("Contact").ToString)%></span>&nbsp;
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Title" UniqueName="Title" HeaderStyle-HorizontalAlign="Center" DataField="Title"
                HeaderStyle-Width="150px" SortExpression="Title" GroupByExpression="Title [GridColumn_Title] Group By Title ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" HeaderStyle-HorizontalAlign="Center" DataField="Company"
                HeaderStyle-Width="150px" SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCompany" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Company Type" UniqueName="CompanyTypeName" HeaderStyle-HorizontalAlign="Center" DataField="CompanyTypeName"
                HeaderStyle-Width="150px" SortExpression="CompanyTypeName" GroupByExpression="CompanyTypeName [GridColumn_CompanyTypeName] Group By CompanyTypeName ASC">
                <ItemTemplate>
                    <span><%# IIf(Container.DataItem("CompanyTypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyTypeName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCompanyTypeName" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Department" GroupByExpression="DepartmentName [GridColumn_DepartmentName] Group By DepartmentName ASC" DataField="DepartmentName"
                UniqueName="DepartmentName" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="150px" SortExpression="DepartmentName">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("DepartmentName").ToString = String.Empty, "&nbsp;", Container.DataItem("DepartmentName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblDepartment" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Address" UniqueName="AddressCode" HeaderStyle-HorizontalAlign="Center" DataField="AddressCode"
                HeaderStyle-Width="100px" SortExpression="AddressCode" GroupByExpression="AddressCode [GridColumn_AddressCode] Group By AddressCode ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("AddressCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressCode").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC" DataField="Phone"
                UniqueName="Phone" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="100px" SortExpression="Phone">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Ext" GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC" DataField="Ext"
                UniqueName="Ext" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="Ext">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>

                    <asp:Label ID="lblExt" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Fax" GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC" DataField="Fax"
                UniqueName="Fax" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Fax">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lbFax" runat="server"></asp:Label>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Cell" UniqueName="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Cell" CurrentFilterFunction="Contains" DataField="Cell"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("cell").ToString = String.Empty, "&nbsp;", Container.DataItem("cell").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Alt Phone" UniqueName="AltPhone" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="20%" SortExpression="AltPhone" CurrentFilterFunction="Contains" DataField="AltPhone"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC" DataField="Email"
                UniqueName="Email" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Email">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Website" GroupByExpression="Website [GridColumn_Website] Group By Website ASC"
                UniqueName="Website" CurrentFilterFunction="Contains" DataField="Website"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Website">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="TypeName"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="TypeName" GroupByExpression="TypeName [GridColumn_Type] Group By TypeName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Primary" UniqueName="Primary" HeaderStyle-Width="10%" ItemStyle-Wrap="false"
                SortExpression="IsPrimary" CurrentFilterFunction="Contains" DataField="IsPrimary"
                AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Center" GroupByExpression="IsPrimary [GridColumn_Primary] Group By IsPrimary ASC" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="10%" ItemStyle-Wrap="false"
                SortExpression="IsActive" CurrentFilterFunction="Contains" DataField="IsActive"
                AutoPostBackOnFilter="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="IsActive [GridColumn_Inactive] Group By IsActive ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Notes" CurrentFilterFunction="Contains" DataField="Notes"
                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                Groupable="false">
                <ItemTemplate>
                    <uc1:userdefinedfields id="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert"
                    Visible='<%# rdgContacts.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll"
                    Visible='<%# rdgContacts.EditIndexes.Count > 0 Or rdgContacts.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                        meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" OnClientClick="return OpenPOPUp('ProjectContactPopup.aspx',900, 506,true);"
                    Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                        meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    Visible='<%# rdgContacts.EditIndexes.Count = 0 AND (Not rdgContacts.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server"
                        Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid"
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
    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
    </ClientSettings>
</telerik:RadGrid>