<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyDepartments.ascx.vb" Inherits="Website.CompanyDepartments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RamDepartments" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDepatments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDepatments" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgDepatments" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder"
                  HeaderStyle-Font-Size="8"  ShowGroupPanel="True"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="50"
                AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" 
                EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
                  <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="80px" SortExpression="Id" Groupable="false" ItemStyle-HorizontalAlign="Right"
                             DataField="Id"    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Id") Is DBNull.Value, "&nbsp;", Container.DataItem("Id").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("ID").ToString%>' Width="100%"></asp:Label>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Department Name*" UniqueName="DepartmentName" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="110px" SortExpression="DepartmentName"
                            DataField="DepartmentName"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="DepartmentName [GridColumn_DepartmentName] Group By DepartmentName ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("DepartmentName") Is DBNull.Value, "&nbsp;", Container.DataItem("DepartmentName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDepartmentName" MaxLength="100" Width="100%" runat="server" Text='<%# Eval("DepartmentName").ToString %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" ControlToValidate="txtDepartmentName" meta:resourcekey="rfvDepartmentName"
                                    CssClass="Validator" ErrorMessage="<br />Enter the Department Name" Display="Dynamic" ForeColor=""
                                    ValidationGroup="EstimateMarkup"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Address" UniqueName="AddressCode" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="210px" SortExpression="AddressCode"
                            DataField="AddressCode"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="AddressCode [GridColumn_AddressCode] Group By AddressCode ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("AddressCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressCode").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAddress" runat="server"  Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    Width="100%" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Phone" UniqueName="Phone" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="90px" SortExpression="Phone"
                             DataField="Phone"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPhone" MaxLength="50" runat="server" Text='<%#EVAL("Phone") %>'
                                    Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext" UniqueName="Ext" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="75px" SortExpression="Ext"
                             DataField="Ext"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExt" Width="100%" MaxLength="50" Text='<%# Eval("Ext") %>' runat="server">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Fax" UniqueName="Fax" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="90px" SortExpression="Fax"
                             DataField="Fax"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFax" MaxLength="50" runat="server" Text='<%#EVAL("Fax") %>'
                                    Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cell" UniqueName="Cell" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="90px" SortExpression="Cell"
                             DataField="Cell"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("cell").ToString = String.Empty, "&nbsp;", Container.DataItem("cell").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCell" MaxLength="50" runat="server" Text='<%#EVAL("cell") %>'
                                    Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Alt Phone" UniqueName="AltPhone" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="90px" SortExpression="AltPhone"
                             DataField="AltPhone"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAltPhone" MaxLength="50" runat="server" Text='<%#EVAL("AltPhone") %>'
                                     Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Email" UniqueName="Email" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Email"
                             DataField="Email"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("Email") %>' Width="100%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="Validator" Display="Dynamic" 
                                    ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    runat="server" ValidationGroup="EstimateMarkup" ErrorMessage="Not valid email"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Website" UniqueName="Website" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Website"
                             DataField="Website"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Website [GridColumn_Website] Group By Website ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebsite" MaxLength="200" runat="server" Text='<%# Eval("Website") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="210px" SortExpression="TypeName"
                             DataField="TypeName"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="TypeName [GridColumn_TypeName] Group By TypeName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Types..." Width="100%"
                                    NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Primary" UniqueName="Primary" HeaderStyle-Width="75px" ItemStyle-Wrap="false"
                            SortExpression="IsPrimary" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                             DataField="IsPrimary"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="IsPrimary [GridColumn_IsPrimary] Group By IsPrimary ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>'
                                    runat="server" CssClass="mobile-switch" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="75px" ItemStyle-Wrap="false"
                            SortExpression="IsActive" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                             DataField="IsActive"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="IsActive [GridColumn_IsActive] Group By IsActive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("IsActive") is system.DBNULL.value, 0,Eval("IsActive")))%>'
                                    runat="server" CssClass="mobile-switch" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Notes"
                             DataField="Notes"  CurrentFilterFunction="Contains"    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="300" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
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
                          
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                SecurityButtonType="ItemMode_Edit"  CssClass="GridCmdEditRows" 
                                Visible='<%# rdgDepatments.EditIndexes.Count = 0 AND (Not rdgDepatments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="EstimateMarkup"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"  Visible='<%# rdgDepatments.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgDepatments.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgDepatments.EditIndexes.Count > 0 Or rdgDepatments.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgDepatments.EditIndexes.Count = 0 AND (Not rdgDepatments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgDepatments.EditIndexes.Count = 0 AND (Not rdgDepatments.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgDepatments.EditIndexes.Count = 0 AND (Not rdgDepatments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
            </telerik:RadGrid>

            </div>
        </div>
    </div>