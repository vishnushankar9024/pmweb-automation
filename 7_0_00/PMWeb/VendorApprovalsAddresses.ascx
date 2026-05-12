<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsAddresses.ascx.vb" Inherits="Website.VendorApprovalsAddresses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAddresses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAddresses" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgAddresses" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" SetWidth="true"
    ShowFooter="false" AllowPaging="true" PageSize="10" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" 
    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" UseEditFormInMobile="true" AppendMenus="true" >
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
<MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"   
    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
    EnableHeaderContextMenu="true">

<Columns>    

    <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="AddressId"  ItemStyle-Wrap="false" HeaderText="ID*"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                            SortExpression="AddressId" GroupByExpression="AddressId [GridColumn_AddressId] Group By AddressId ASC" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("AddressId").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressId").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddressId" MaxLength="50" runat="server" Text='<%# Eval("AddressId") %>' Width="100%" ></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvAddressId" runat="server" ControlToValidate="txtAddressId"
                    CssClass="Validator" ErrorMessage="Enter the ID" meta:resourcekey="rfvAddressId"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="90px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Address 1"  ItemStyle-Wrap="false" UniqueName="Address1" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Address1" GroupByExpression="Address1 [GridColumn_Address1] Group By Address1 ASC" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Text='<%# Eval("Address1") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Address 2"  ItemStyle-Wrap="false" UniqueName="Address2" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Address2" GroupByExpression="Address2 [GridColumn_Address2] Group By Address2 ASC" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Text='<%# Eval("Address2") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="City" UniqueName="City"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true" 
                                SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City ASC" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Text='<%# Eval("City") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="90px"  ItemStyle-Wrap="false"  HeaderText="State" UniqueName="StateName" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="StateName" GroupByExpression="StateName [GridColumn_StateName] Group By StateName ASC" >
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("StateName").ToString = String.Empty, "&nbsp;", Container.DataItem("StateName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>              
            <telerik:RadComboBox ID="ddlState" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
        </EditItemTemplate>
        <HeaderStyle Width="90px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Zip" UniqueName="Zip" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Zip" GroupByExpression="Zip [GridColumn_Zip] Group By Zip ASC" >
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>                        
            <asp:TextBox ID="txtZip" Width="100%" MaxLength="50" Text='<%# Eval("Zip") %>'  Runat="server" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>

    <telerik:GridTemplateColumn HeaderStyle-Width="130px"   ItemStyle-Wrap="false"  HeaderText="Country" UniqueName="CountryName" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="CountryName" GroupByExpression="CountryName [GridColumn_CountryName] Group By CountryName ASC" >
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("CountryName").ToString = String.Empty, "&nbsp;", Container.DataItem("CountryName").ToString)%></span>
        </ItemTemplate>
         <EditItemTemplate>              
            <telerik:RadComboBox ID="ddlCountry" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
        </EditItemTemplate>
        <HeaderStyle Width="130px" />
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
            <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
        </ItemTemplate>
        <EditItemTemplate>
            <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" class="mobile-switch"/>
        </EditItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        <HeaderStyle Width="70px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Notes" UniqueName="Notes" 
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtNotes" MaxLength="100" runat="server" Text='<%# Eval("Notes") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>

</Columns>

<CommandItemTemplate>
    <div style="padding:2px">
               
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" CssClass="GridCmdEditRows"
                    meta:resourcekey="btnEditSelectedResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="Save" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited"  
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" 
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  
                    meta:resourcekey="btnSaveResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" 
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"  meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
</asp:LinkButton>
                </div>
</CommandItemTemplate>
</MasterTableView>
<ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
</ClientSettings>
<ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>

