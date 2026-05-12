<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Application_ApplicationAddresses.ascx.vb" Inherits="Website.Application_ApplicationAddresses" %>
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
<fieldset>
<legend><asp:Label ID="lblAddresses" runat="server" meta:resourcekey="lblAddresses" Text="Addresses" ></asp:Label></legend>                   

<telerik:RadGrid ID="rdgAddresses" GroupingEnabled="false" runat="server"   AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
    AllowMultiRowEdit="True" AllowMultiRowSelection="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" >
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"   
    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
    EnableHeaderContextMenu="true" >

<Columns>    

    <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="AddressId"  ItemStyle-Wrap="false" HeaderText="ID*"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   Groupable="true" Reorderable="true"
                            SortExpression="AddressId" GroupByExpression="AddressId [GridColumn_AddressId] Group By AddressId ASC"> 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("AddressId").ToString = String.Empty, "&nbsp;", Container.DataItem("AddressId").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddressId" MaxLength="50" runat="server" Text='<%# Eval("AddressId") %>' Width="100%" onfocus="blur()"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvAddressId" runat="server" ControlToValidate="txtAddressId"
                    CssClass="Validator" ErrorMessage="Enter the ID" meta:resourcekey="rfvAddressId"
                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                </asp:RequiredFieldValidator>
            </div>
        </EditItemTemplate>
        <HeaderStyle Width="90px" />
    </telerik:GridTemplateColumn>
    
	<telerik:GridTemplateColumn HeaderStyle-Width="70px"   ItemStyle-Wrap="false"  HeaderText="Primary" UniqueName="IsPrimary" >
        <ItemTemplate> 
            <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
        </ItemTemplate>
        <EditItemTemplate>
            <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" />
        </EditItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        <HeaderStyle Width="70px" />
    </telerik:GridTemplateColumn>
	
    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Address 1"  ItemStyle-Wrap="false" UniqueName="Address1" > 
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Text='<%# Eval("Address1") %>' Width="100%"></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Address 2"  ItemStyle-Wrap="false" UniqueName="Address2">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Text='<%# Eval("Address2") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="City" UniqueName="City">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Text='<%# Eval("City") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="State" UniqueName="StateName" Visible="False">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("StateName").ToString = String.Empty, "&nbsp;", Container.DataItem("StateName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>              
            <telerik:RadComboBox ID="ddlState" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Zip" UniqueName="Zip">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>                        
            <asp:TextBox ID="txtZip" Width="100%" MaxLength="50" Text='<%# Eval("Zip") %>'  Runat="server" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>

    <telerik:GridTemplateColumn HeaderStyle-Width="100px"   ItemStyle-Wrap="false"  HeaderText="Country" UniqueName="CountryName">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("CountryName").ToString = String.Empty, "&nbsp;", Container.DataItem("CountryName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>              
            <telerik:RadComboBox ID="ddlCountry" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
        </EditItemTemplate>
        <HeaderStyle Width="100px" />
    </telerik:GridTemplateColumn>

    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Phone" UniqueName="Phone">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" Text='<%#Eval("Phone") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false"  HeaderText="Ext" UniqueName="Ext" Visible="False">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtExt" Width="100%" MaxLength="10" Text='<%# Eval("Ext") %>'  Runat="server"></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>

    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Fax" UniqueName="Fax">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtFax" runat="server" MaxLength="50" Text='<%#Eval("Fax") %>' Width="100%" ></asp:TextBox>                                
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Alt. Phone" UniqueName="AltPhone" >
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("AltPhone").ToString = String.Empty, "&nbsp;", Container.DataItem("AltPhone").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtAltPhone" runat="server" MaxLength="50" Text='<%#Eval("AltPhone") %>' Width="100%" ></asp:TextBox>                             
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Email" UniqueName="Email">
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
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Website" UniqueName="Website">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("Website").ToString = String.Empty, "&nbsp;", Container.DataItem("Website").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtWebsite" MaxLength="250" runat="server" Text='<%# Eval("Website") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
    
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Type" UniqueName="Type">
        <ItemTemplate> 
            <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
        </ItemTemplate>
        <EditItemTemplate>
            <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
        </EditItemTemplate>
        <HeaderStyle Width="120px" />
    </telerik:GridTemplateColumn>
   
    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Notes" UniqueName="Notes">
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
        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
            Visible='<%# rdgAddresses.EditIndexes.Count = 0 AND (Not rdgAddresses.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>' meta:resourcekey="btnEditSelectedResource1">
           <span class="Icon"></span>
            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnAddressUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
            Visible='<%# rdgAddresses.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
           <span class="Icon"></span>
            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnAddressSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  
            Visible='<%# rdgAddresses.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
           <span class="Icon"></span>
            <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll"  CssClass="GridCmdCancelAll" 
            Visible='<%# rdgAddresses.EditIndexes.Count > 0 Or rdgAddresses.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
            <span class="Icon"></span>
            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"  
            Visible='<%# rdgAddresses.EditIndexes.Count = 0 AND (Not rdgAddresses.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>' meta:resourcekey="btnAddResource1">
          <span class="Icon"></span>
            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnAddressDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"  
            Visible='<%# rdgAddresses.EditIndexes.Count = 0 AND (Not rdgAddresses.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>'
            runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
            <span class="Icon"></span>
            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
            meta:resourcekey="btnRefreshResource1" Visible='<%# rdgAddresses.EditIndexes.Count = 0 And (Not rdgAddresses.MasterTableView.IsItemInserted) %>'>
           <span class="Icon"></span>
            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
        </asp:LinkButton>
        
    </div>
</CommandItemTemplate>
</MasterTableView>
<ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" >
    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
</ClientSettings>
<ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>

</fieldset>
<div  id="S_8">
<table cellpadding="0" cellspacing="0" runat="server">
<tr>
    <td style="padding-top:10px;">
           <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage"  runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
    </td>
</tr>
</table>
</div>