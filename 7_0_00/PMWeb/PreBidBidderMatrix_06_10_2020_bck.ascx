<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PreBidBidderMatrix.ascx.vb" Inherits="Website.PreBidBidderMatrix" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgBidderMatrix" Width="100%" runat="server" UseEditFormInMobile="true" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>


                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id"  ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                    <Columns>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" DataField="BidCategory" ItemStyle-Wrap="false" HeaderText="Bid Category" SortExpression="BidCategory" UniqueName="BidCategory" GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC">
                            <ItemTemplate>
                                <%#Eval("BidCategory").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlBidCategory" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="CompanyName" HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Company" SortExpression="CompanyName" UniqueName="CompanyName" GroupByExpression="CompanyName [GridColumn_CompanyName] Group By CompanyName ASC">
                            <ItemTemplate>
                                <%#Eval("CompanyName").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("CompanyName").ToString%>&nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="Notes" HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Notes" UniqueName="Notes" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <%#Eval("Notes").ToString%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="Inactive" HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("Inactive") is system.DBNULL.value, 0,Eval("Inactive")))%>' runat="server" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn>
						<telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="PQQ Status" UniqueName="PQQStatus" >
                <ItemTemplate> 
                    <div></div>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="PQ Start Date" UniqueName="PQStartDate" >
                <ItemTemplate> 
                    <div></div>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="PQ Expires Date" UniqueName="PQExpiresDate" >
                <ItemTemplate> 
                    <div></div>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="NDA" UniqueName="NDA" >
                <ItemTemplate> 
                    <div></div>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgBidderMatrix.EditIndexes.Count = 0 %>' meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>

                            </asp:LinkButton>

                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgBidderMatrix.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>

                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgBidderMatrix.EditIndexes.Count > 0 %>' meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>

                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAddBidders" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" Width="90px" CssClass="NoWrap GridCmdAddBidders"
                                CommandName="AddBidders" OnClientClick="return OpenMultipleCompaniesPopup();" Visible='<%# rdgBidderMatrix.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddBidders" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>



                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return DeleteSelectedLines('rdgBidderMatrix');" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" Visible='<%# rdgBidderMatrix.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgBidderMatrix.EditIndexes.Count = 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:Label ID="lblDisplay" runat="server" meta:resourcekey="lblDisplay" Text="Display"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
  
                <telerik:RadComboBox ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDisplay_OnSelectedIndexChanged">
                    <Items>
                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemAll" Value="0" Text="-- All --" Selected="True"></telerik:RadComboBoxItem>
                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemActiveBidderMatrixOnly" Value="1" Text="Active Bidder Matrix Only"></telerik:RadComboBoxItem>
                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemInactiveBidderMatrixOnly" Value="2" Text="Inactive Bidder Matrix Only"></telerik:RadComboBoxItem>
                    </Items>
                </telerik:RadComboBox>

                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                    <Selecting AllowRowSelect="true" />
					<ClientEvents OnRowCreated="GetPQDetails"/>
                </ClientSettings>
            </telerik:RadGrid>
            <asp:Button ID="btnRefreshBidderMatrix" runat="server" CssClass="Hide" />
        </div>
    </div>
</div>
