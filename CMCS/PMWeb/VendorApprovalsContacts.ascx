<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsContacts.ascx.vb" Inherits="Website.VendorApprovalsContacts" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgContacts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgContacts" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" SetWidth="true"
                        ShowFooter="false" AllowPaging="true" PageSize="250" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" 
                        AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" 
                        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>    
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" UniqueName="FirstName"  ItemStyle-Wrap="false" HeaderText="First Name" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC" > 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("FirstName").ToString = String.Empty, "&nbsp;", Container.DataItem("FirstName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFirstName" MaxLength="50" runat="server" Text='<%# Eval("FirstName") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Last Name"  ItemStyle-Wrap="false" UniqueName="LastName" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC" > 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("LastName").ToString = String.Empty, "&nbsp;", Container.DataItem("LastName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLastName" MaxLength="100" runat="server" Text='<%# Eval("LastName") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Address"  ItemStyle-Wrap="false" UniqueName="Address"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true" 
                                        SortExpression="AddressID" GroupByExpression="AddressID [GridColumn_Address] Group By AddressID ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("AddressID").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressID").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlAddress" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Addresses..."
                                    Width="100%" NoWrap="true" CausesValidation="False" meta:resourcekey="ddlAddress">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"  ItemStyle-Wrap="false"  HeaderText="Title" UniqueName="Title" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Title" GroupByExpression="Title [GridColumn_Title] Group By Title ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTitle" MaxLength="50" runat="server" Text='<%# Eval("Title") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Phone" UniqueName="Phone" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#Eval("Phone") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Ext" UniqueName="Ext" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Ext" GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtExt" Width="100%" MaxLength="10" Text='<%# Eval("Ext") %>'  Runat="server"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Fax" UniqueName="Fax" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Fax" GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFax" runat="server" MaxLength="50" Text='<%#Eval("Fax") %>' Width="100%" ></asp:TextBox>                                
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="Cell" UniqueName="Cell"
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Cell").ToString = String.Empty, "&nbsp;", Container.DataItem("Cell").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCell" MaxLength="50" runat="server" Text='<%# Eval("Cell") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Alt. Phone" UniqueName="AltPhone" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="AltPhone" GroupByExpression="AltPhone [GridColumn_AltPhone] Group By AltPhone ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="50" Text='<%#Eval("AltPhone") %>' Width="100%" ></asp:TextBox>                             
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Email" UniqueName="Email" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" Text='<%# Eval("Email") %>' Width="100%" ></asp:TextBox>
                    <div>
                        <asp:RegularExpressionValidator ID="rfvEmail" CssClass="Validator" meta:resourcekey="rfvEmail" 
                            ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                            runat="server" ValidationGroup="Save"  display="Dynamic" ErrorMessage="example@domain.com">
                        </asp:RegularExpressionValidator>
                    </div>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Website" UniqueName="Website" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Website" GroupByExpression="Website [GridColumn_Website] Group By Website ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtWebsite" MaxLength="250" runat="server" Text='<%# Eval("Website") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Type" UniqueName="Type" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="TypeName" GroupByExpression="TypeName [GridColumn_Type] Group By TypeName ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="70px"   ItemStyle-Wrap="false"  HeaderText="Primary" UniqueName="IsPrimary" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="IsPrimary" GroupByExpression="IsPrimary [GridColumn_IsPrimary] Group By IsPrimary ASC" >
                <ItemTemplate> 
                    <img src="Images/Global/<%#CStr(IIF(Eval("IsPrimary") isnot system.DBNULL.value AndAlso Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" class="mobile-switch"/>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="200px"   ItemStyle-Wrap="false"  HeaderText="Notes" UniqueName="Notes" 
                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                        SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength="100" runat="server" Text='<%# Eval("Notes") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="200px" />
            </telerik:GridTemplateColumn>
        </Columns>

        <CommandItemTemplate>
            <div style="padding:2px">
               
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                     meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                    CommandName="CancelAll"  CssClass="GridCmdCancelAll"
                    meta:resourcekey="btnCancelResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                        meta:resourcekey="btnAddResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
    </ClientSettings>
</telerik:RadGrid>
