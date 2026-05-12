<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BiddersFilter.ascx.vb" Inherits="Website.BiddersFilter" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


            <telerik:RadGrid ID="rdgBiddersFilter" runat="server"  Width="100%"  AutoGenerateColumns="False" AllowPaging="True" PageSize="250" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel> 
            
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
  
                <Columns>
  
                   <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false"  HeaderStyle-Width="50px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkAllBidders" onClick="AllBiddersCheckClicked(this)" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelectBidder" onClick="BiddersSelectParent(this)" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
     
                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Company" SortExpression="Company" UniqueName="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                                                DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <%# Eval("Company").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="200px" ></HeaderStyle>
                    </telerik:GridTemplateColumn>
           
                    <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Contact" SortExpression="Contact" UniqueName="Contact" GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC"
                                                DataField="Contact" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <%# Eval("Contact").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="200px" ></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    
                    <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Email" SortExpression="Email" UniqueName="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                                                DataField="Email" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <%# Eval("Email").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120" ></HeaderStyle>
                    </telerik:GridTemplateColumn>
    
                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Company Type" SortExpression="Type" UniqueName="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC"
                                                DataField="Type" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                            <%# Eval("Type").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120" ></HeaderStyle>
                    </telerik:GridTemplateColumn>

                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <ItemStyle Wrap="false" />
                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                         
                <CommandItemTemplate>
                    <div >
                        <table>
                            <tr>
                                <td>    
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="SaveContacts"  CssClass="GridCmdSaveContacts" SecurityButtonType="AddEditMode_Edit"
                                        ValidationGroup="DocumentAttachments" Visible="True">
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                               </td>
                               
                                
                            </tr>
                        </table>
                    </div>
                </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                <Selecting AllowRowSelect="true" /></ClientSettings>
            </telerik:RadGrid>
            <asp:HiddenField ID="hdnBiddersCount" runat="server" Value="0" />
