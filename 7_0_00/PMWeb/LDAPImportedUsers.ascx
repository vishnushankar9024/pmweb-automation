<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LDAPImportedUsers.ascx.vb" Inherits="Website.LDAPImportedUsers" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgimportedUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgimportedUsers" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                   
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgimportedUsers" runat="server"  
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                PageSize="10" AllowPaging="true" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                AllowMultiRowEdit="false" AllowMultiRowSelection="false" AllowSorting="true" ShowGroupPanel="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView DataKeyNames="Id" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                     CommandItemDisplay="none" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace">
                    <Columns>
                      <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" AllowFiltering="false" UniqueName="IsDeleted" HeaderText=""  Groupable="False"  HeaderStyle-Width="80px">
                            <ItemTemplate>
                        <asp:Label Text="Deleted!" ID="lblDeleted" meta:resourcekey="lblDeleted" runat="server" ForeColor="Red" Visible="false"></asp:Label>   
 &nbsp;
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ID*" CurrentFilterFunction="Contains" UniqueName="UserName"
                            DataField="UserName" AutoPostBackOnFilter="true" GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC">
                            <ItemTemplate>
                            <asp:Label ID="lblUserId" runat="server" Text='<%#Eval("UserName")%>'></asp:Label> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="First Name*" CurrentFilterFunction="Contains"
                            UniqueName="FirstName" DataField="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC"
                            AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                            <asp:Label ID="lblFirstName" runat="server" Text='<%#Eval("FirstName")%>'></asp:Label> 
                                &nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Last Name" CurrentFilterFunction="Contains"
                            UniqueName="LastName" DataField="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC"
                            AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                               <asp:Label ID="lblLastName" runat="server" Text='<%#Eval("LastName")%>'></asp:Label> 
                                &nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="License Type*" CurrentFilterFunction="Contains"
                            UniqueName="LicenseType" DataField="LicenseType" AutoPostBackOnFilter="true"
                            DataType="System.String" FilterListOptions="VaryByDataType" GroupByExpression="LicenseType [GridColumn_LicenseType] Group By LicenseType ASC">
                            <ItemTemplate>
                                 <asp:Label ID="lblLicenseType" runat="server" Text='<%#Eval("LicenseType")%>'></asp:Label> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                       
                        <telerik:GridTemplateColumn HeaderText="Named License*" CurrentFilterFunction="Contains" UniqueName="IsNamedLic"
                            DataField="IsNamedLic" DataType="System.Boolean" FilterListOptions="VaryByDataType"
                            GroupByExpression="IsNamedLic [GridColumn_IsNamedLic] Group By IsNamedLic ASC">
                            <ItemTemplate>
                                 <asp:Label ID="lblIsNamedLic" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                       </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Group Name*" CurrentFilterFunction="Contains"
                            UniqueName="Group" DataField="GroupName" AutoPostBackOnFilter="true" DataType="System.String"
                            FilterListOptions="VaryByDataType" GroupByExpression="GroupName [GridColumn_Group] Group By GroupName ASC">
                            <ItemTemplate>
                              <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupName")%>'></asp:Label> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Email" CurrentFilterFunction="Contains" UniqueName="Email"
                            DataField="Email" AutoPostBackOnFilter="true" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                            DataType="System.String">
                            <ItemTemplate>
                                 <asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email")%>'></asp:Label> 
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" 
                    AllowDragToGroup="True" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                    
                </ClientSettings>
                
               <%-- <ValidationSettings ValidationGroup="Users" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />--%>
            </telerik:RadGrid>