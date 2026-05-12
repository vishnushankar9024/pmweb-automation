<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Application_ApplicationAddressContacts.ascx.vb" Inherits="Website.Application_ApplicationAddressContacts" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAddressContacts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAddressContacts" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>
        <%--<telerik:AjaxSetting AjaxControlID="btnRefreshContactsGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAddressContacts" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>    --%>                                          
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<fieldset style="width:100%;">
<legend><asp:Label ID="lblContacts" runat="server" meta:resourcekey="lblContacts" Text="Contacts"></asp:Label></legend>

<telerik:RadGrid ID="rdgAddressContacts" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True"  SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" GroupingEnabled="false">
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" 
                        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>    
            <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="FirstName"  ItemStyle-Wrap="false" HeaderText="First Name"> 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("FirstName").ToString = String.Empty, "&nbsp;", Container.DataItem("FirstName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFirstName" MaxLength="50" runat="server" Text='<%# Eval("FirstName") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Last Name"  ItemStyle-Wrap="false" UniqueName="LastName"> 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("LastName").ToString = String.Empty, "&nbsp;", Container.DataItem("LastName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLastName" MaxLength="100" runat="server" Text='<%# Eval("LastName") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Address"  ItemStyle-Wrap="false" UniqueName="Address">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("ApplicationAddressName").ToString = String.Empty, "&nbsp;", Container.DataItem("ApplicationAddressName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlAddress" runat="server" Filter="Contains" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" 
                                    NoWrap="true" CausesValidation="false">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                    
                </EditItemTemplate>
                <HeaderStyle Width="200px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="Title" UniqueName="Title">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTitle" MaxLength="50" runat="server" Text='<%# Eval("Title") %>' Width="100%" ></asp:TextBox>
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
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Ext" UniqueName="Ext">
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
            <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="Cell" UniqueName="Cell">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Cell").ToString = String.Empty, "&nbsp;", Container.DataItem("Cell").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCell" MaxLength="50" runat="server" Text='<%# Eval("Cell") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Alt. Phone" UniqueName="AltPhone">
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
                    <telerik:RadComboBox  ID="ddlType" runat="server" AllowCustomText="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="70px"   ItemStyle-Wrap="false"  HeaderText="Primary" UniqueName="IsPrimary">
                <ItemTemplate> 
                    <img src="Images/Global/<%#CStr(IIF(Eval("IsPrimary") isnot system.DBNULL.value AndAlso Cbool(Eval("IsPrimary"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbPrimary" Checked='<%# Cbool(IIF(Eval("IsPrimary") is system.DBNULL.value, 0,Eval("IsPrimary")))%>' runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
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
                    Visible='<%# rdgAddressContacts.EditIndexes.Count = 0 AND (Not rdgAddressContacts.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnContactUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                    Visible='<%# rdgAddressContacts.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnContactSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert" 
                    CommandName="PerformInsert" Visible='<%# rdgAddressContacts.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll" 
                    CommandName="CancelAll" Visible='<%# rdgAddressContacts.EditIndexes.Count > 0 Or rdgAddressContacts.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                        CommandName="InitNewRow" Visible='<%# rdgAddressContacts.EditIndexes.Count = 0 AND (Not rdgAddressContacts.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>' 
                        meta:resourcekey="btnAddResource1">
                  <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                        Visible='<%# rdgAddressContacts.EditIndexes.Count = 0 AND (Not rdgAddressContacts.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" 
                    meta:resourcekey="btnRefreshResource1" Visible='<%# rdgAddressContacts.EditIndexes.Count = 0 And (Not rdgAddressContacts.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" >
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
    </ClientSettings>
    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>

<asp:Button ID="btnRefreshContactsGrid" runat="server" CssClass="Hide" />
</fieldset>
<div id="S_19">
<table cellpadding="0" cellspacing="0" runat="server" >
<tr>
    <td style="padding-top:10px;"> 
           <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
    </td>
</tr>
</table>
</div>