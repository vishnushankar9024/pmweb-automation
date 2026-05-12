<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ExternalUsers.ascx.vb" Inherits="Website.ExternalUsers1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
   <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgExternalUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgExternalUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<header>
    <style type="text/css">
        #ctl00_CPH1_ExternalUsers1_rdgExternalUsers {
            margin-top:80px;
        }
     </style>
</header>

<telerik:RadGrid ID="rdgExternalUsers" GroupingEnabled="false" runat="server"   AutoGenerateColumns="False" CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FitPageHeightOffset="1"
            ShowFooter="false" AllowPaging="true" AllowFilteringByColumn="true" PageSize="250" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True"  SetWidth="true" AppendMenus = "true" UseEditFormInMobile ="true"
            AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8">
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace" EnableHeaderContextMenu="true" >
    <Columns>
    <telerik:GridTemplateColumn  ItemStyle-Wrap="false"  HeaderText="Inactive" UniqueName="Inactive" 
                            CurrentFilterFunction="Contains" DataField="IsActive"  FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                            SortExpression="IsActive" GroupByExpression="IsActive [GridColumn_IsActive] Group By IsActive ASC" >
        <ItemTemplate> 
            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsActive")) = CBool(0), "checked.png", "unchecked.png"))%>" alt="" />
        </ItemTemplate>
        <EditItemTemplate>
            <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("IsActive") Is System.DBNull.Value OrElse Eval("IsActive") = CBool(1), 0, 1))%>' runat="server" />
        </EditItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn UniqueName="FederalTaxId"  ItemStyle-Wrap="false" HeaderText="Federal Tax ID" 
                                CurrentFilterFunction="Contains" DataField="FederalTaxId"  FilterListOptions="VaryByDataType"  AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="FederalTaxId" GroupByExpression="FederalTaxId [GridColumn_FederalTaxId] Group By FederalTaxId ASC"> 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("FederalTaxId").ToString = String.Empty, "&nbsp;", Container.DataItem("FederalTaxId").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtFederalTaxId" MaxLength="50" runat="server" Text='<%# Eval("FederalTaxId") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvFederalTaxId" runat="server" ControlToValidate="txtFederalTaxId" CssClass="Validator" ErrorMessage="Required"
                         meta:resourcekey="rfv_FederalTaxId" Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  HeaderText="Company"  ItemStyle-Wrap="false" UniqueName="CompanyName" 
                                CurrentFilterFunction="Contains" DataField="CompanyName"  FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="CompanyName" GroupByExpression="CompanyName [GridColumn_CompanyName] Group By CompanyName ASC"> 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtCompanyName" MaxLength="100" runat="server" Text='<%# Eval("CompanyName") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName"
                    CssClass="Validator" ErrorMessage="Required" meta:resourcekey="rfv_CompanyName"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save" >
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="150px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  ItemStyle-Wrap="false"  HeaderText="Country" UniqueName="CountryName"
                                CurrentFilterFunction="Contains" DataField="CountryName"  FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="CountryName" GroupByExpression="CountryName [GridColumn_CountryName] Group By CountryName ASC">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("CountryName").ToString = String.Empty, "&nbsp;", Container.DataItem("CountryName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>              
    <%--        <asp:DropDownList ID="ddlCountry" runat="server" Width="100%"></asp:DropDownList>--%>

                             <telerik:RadComboBox ID="ddlCountry" runat="server" Width="100%" AllowCustomText="True"  Filter="Contains" MarkFirstMatch="true" 
                                                                         Skin="Default" Style="font-size: 11px" Height="250px" >
                             </telerik:RadComboBox>


            <div>
                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountry"
                    CssClass="Validator" ErrorMessage="Required" meta:resourcekey="rfv_Country"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="150px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  HeaderText="Contact Name"  ItemStyle-Wrap="false" UniqueName="ContactName" 
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Name" DataField="Name" GroupByExpression="Name [GridColumn_Name] Group By Name ASC"> 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtName" MaxLength="100" runat="server" Text='<%# Eval("Name") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    CssClass="Validator" ErrorMessage="Required" meta:resourcekey="rfv_Name"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="150px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  ItemStyle-Wrap="false"  HeaderText="Contact Email" UniqueName="Email"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Email" DataField="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("Email") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="Save"
                                        CssClass="Validator" ErrorMessage="Required" Display="Dynamic" meta:resourcekey="rfv_Email"  ></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" CssClass="Validator" meta:resourcekey="revEmail" 
                    ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    runat="server" ValidationGroup="Save"  display="Dynamic" ErrorMessage="example@domain.com">
                </asp:RegularExpressionValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="170px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  ItemStyle-Wrap="false"  HeaderText="Contact Phone" UniqueName="Phone"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Phone" DataField="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#Eval("Phone") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                    CssClass="Validator" ErrorMessage="Required" meta:resourcekey="rfv_Phone"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="170px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn  HeaderText="Username"  ItemStyle-Wrap="false" UniqueName="Username"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Username"  DataField="Username" FilterListOptions="VaryByDataType" GroupByExpression="Username [GridColumn_Username] Group By Username ASC" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Username").ToString = String.Empty, "&nbsp;", Container.DataItem("Username").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtUsername" MaxLength="100" runat="server" Text='<%# Eval("Username") %>' Width="100%" ></asp:TextBox>
            <asp:Label ID="lblUsernameExist" runat="server" meta:resourcekey="lblUsernameExist" Text="Username Already Exist" Visible="false" ></asp:Label>
            <div>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                    CssClass="Validator" ErrorMessage="Required" meta:resourcekey="rfv_Username"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="150px" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn HeaderText="Password" Groupable="false" UniqueName="Password"  AllowFiltering="false" >
         <ItemTemplate>
             <asp:Label runat="server" Id ="lblPassword"></asp:Label>
          </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtPassword" MaxLength="128" runat="server" TextMode="Password" ></asp:TextBox>
            <div>
                
            </div>
        </EditItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        <HeaderStyle Width="150px" HorizontalAlign="Center" />
    </telerik:GridTemplateColumn>
    <telerik:GridTemplateColumn HeaderStyle-Width="170px"   ItemStyle-Wrap="false"  HeaderText="Account Created" UniqueName="CreateDate"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="CreateDate" DataField="CreateDate" GroupByExpression="CreateDate [GridColumn_CreateDate] Group By CreateDate ASC">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("CreateDate").ToString = String.Empty, "&nbsp;", FormatDate(CDate(Container.DataItem("CreateDate"))))%></span>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Right"></ItemStyle>
        <EditItemTemplate>
            <asp:TextBox ID="txtCreateDate" runat="server" Text='<%# FormatDate(Eval("CreateDate"))%>' ReadOnly="true" Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    </Columns>
    <CommandItemTemplate>
        <table>
            <tr>
                <td>
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                         meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited"   CssClass="GridCmdUpdateEdited" 
                                        meta:resourcekey="btnUpdateEditedResource1" CausesValidation="true">
                       <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label> &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add"  CssClass="GridCmdPerformInsert" 
                                    CommandName="PerformInsert" meta:resourcekey="btnSaveResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label> &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                         meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label> &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" 
                         meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                            &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows" 
                         OnClientClick="javascript:return ConfirmDelete();"
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  >
                       <span class="Icon"></span>
                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnInactivate" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="Inactivate" CssClass="GridCmdMakeInactive"  >
                        <span class="Icon"></span>
                        <asp:Label ID="lblInactivate" runat="server" Text="" ></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnActivate" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="Activate" CssClass="GridCmdMakeActive"  >
                        <span class="Icon"></span>
                        <asp:Label ID="lblActivate" runat="server" Text="" ></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnEmailPasswords" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="EmailPasswords" CssClass="GridCmdSendEmailPasswords"  >
                        <span class="Icon"></span>
                        <asp:Label ID="lblEmailPasswords" runat="server" Text="" ></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" >
    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
    </ClientSettings>
</telerik:RadGrid>
