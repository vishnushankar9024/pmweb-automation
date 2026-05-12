<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsDepartments.ascx.vb" Inherits="Website.VendorApprovalsDepartments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamDepartments" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDepartments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDepartments" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

            <telerik:RadGrid ID="rdgDepartments" runat="server" SetWidth="true"   AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder"
    ShowFooter="false" AllowPaging="true" PageSize="10" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" UseEditFormInMobile="true"
    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" AppendMenus="true"   >
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
<MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"   
    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
    EnableHeaderContextMenu="true">

                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="70px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                            SortExpression="Id" GroupByExpression="Id [GridColumn_Id] Group By Id ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Id") Is DBNull.Value, "&nbsp;", Container.DataItem("Id").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("ID").ToString%>'></asp:Label>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Department Name*" UniqueName="DepartmentName" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="200px" SortExpression="DepartmentName" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="DepartmentName [GridColumn_DepartmentName] Group By DepartmentName ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("DepartmentName") Is DBNull.Value, "&nbsp;", Container.DataItem("DepartmentName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDepartmentName" Width="100%" MaxLength="100" runat="server" Text='<%# Eval("DepartmentName").ToString %>'></asp:TextBox>
                                <div>
                                <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" ControlToValidate="txtDepartmentName" meta:resourcekey="rfvDepartment"
                                    CssClass="Validator" ErrorMessage="<br />Enter the Department Name" Display="Dynamic" ForeColor=""
                                    ValidationGroup="EstimateMarkup"></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Address" UniqueName="AddressCode" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="200px" SortExpression="AddressCode" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="AddressCode [GridColumn_AddressCode] Group By AddressCode ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("AddressCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressCode").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAddress" runat="server"  Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Addresses..." AllowCustomText="true"
                                    Width="100%" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Phone" UniqueName="Phone" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Phone" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPhone" MaxLength="50" runat="server" Text='<%#EVAL("Phone") %>'
                                    Width="100%" >
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Ext" UniqueName="Ext" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Ext" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExt" Width="100%" MaxLength="50" Text='<%# Eval("Ext") %>' runat="server">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Fax" UniqueName="Fax" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Fax" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFax" MaxLength="50" runat="server" Text='<%#EVAL("Fax") %>'
                                    Width="100%" >
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cell" UniqueName="Cell" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Cell" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("cell").ToString = String.Empty, "&nbsp;", Container.DataItem("cell").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCell" MaxLength="50" runat="server" Text='<%#EVAL("cell") %>'
                                    Width="100%" >
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Alt Phone" UniqueName="AltPhone" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="AltPhone" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC">
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
                            HeaderStyle-Width="120px" SortExpression="Email" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("Email") %>' Width="100%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revEmail" CssClass="Validator" meta:resourcekey="revEmail" 
                                    ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    runat="server" ValidationGroup="Save" ErrorMessage="example@domain.com"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Website" UniqueName="Website" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="Website" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Website [GridColumn_Website] Group By Website ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebsite" MaxLength="200" runat="server" Text='<%# Eval("Website") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="120px" SortExpression="TypeName" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="TypeName [GridColumn_Type] Group By TypeName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" runat="server" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Types..." Width="100%"
                                    NoWrap="true" CausesValidation="False" meta:resourcekey="ddlType" >
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Primary" UniqueName="Primary" HeaderStyle-Width="70px" ItemStyle-Wrap="false"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" SortExpression="IsPrimary" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="IsPrimary [GridColumn_Primary] Group By IsPrimary ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>'
                                    runat="server" class="mobile-switch"/>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="200px" SortExpression="Notes" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="300" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                     
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" 
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgDepartments.EditIndexes.Count = 0 AND (Not rdgDepartments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="EstimateMarkup"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgDepartments.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgDepartments.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgDepartments.EditIndexes.Count > 0 Or rdgDepartments.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgDepartments.EditIndexes.Count = 0 AND (Not rdgDepartments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgDepartments.EditIndexes.Count = 0 AND (Not rdgDepartments.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgDepartments.EditIndexes.Count = 0 AND (Not rdgDepartments.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
