<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIMCOBieManagerSpaces.ascx.vb"
    Inherits="Website.BIMCOBieManagerSpaces" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamLocation" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSpace">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSpace" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpSpace" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
               <telerik:RadGrid ID="rdgSpace" AllowMultiRowSelection="true" runat="server"  SetWidth="true" AppendMenus = "true"
                 HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="100%" CssClass="WithoutTopBorder"
                AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="250" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="5%" SortExpression="Id">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SortOrder").ToString = String.Empty, "&nbsp;", Container.DataItem("SortOrder").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(Eval("SortOrder") Is DBNull.Value, String.Empty, Eval("SortOrder").ToString)%>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" DataField="Name" 
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Name")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" DataField="Category"
                            HeaderStyle-HorizontalAlign="Center"  SortExpression="Category">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCategory" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Category")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Floor Name" UniqueName="FloorName" DataField="FloorName"
                            HeaderStyle-HorizontalAlign="Center"  SortExpression="FloorName">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("FloorName").ToString = String.Empty, "&nbsp;", Container.DataItem("FloorName").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFloorName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("FloorName")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="CategoryDescription" DataField="Description"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Description">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. System" UniqueName="ExtSystem" DataField="ExtSystem"
                            HeaderStyle-HorizontalAlign="Center"  SortExpression="ExtSystem">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtSystem").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtSystem").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtSystem" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtSystem")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. Object" UniqueName="ExtObject" DataField="ExtObject"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtObject">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtObject").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtObject").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtObject" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtObject")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. Identifier" UniqueName="ExtItentifier" DataField="ExtItentifier"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtItentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtItentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtItentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtItentifier" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtItentifier")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Room Tag" UniqueName="RoomTag" DataField="RoomTag"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="RoomTag">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("RoomTag").ToString = String.Empty, "&nbsp;", Container.DataItem("RoomTag").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRoomTag" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("RoomTag") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>
                                               
                        <telerik:GridTemplateColumn HeaderText="Usable Height" UniqueName="UsableHeight" DataField="UsableHeight"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="UsableHeight">
                            <ItemTemplate>
                               <%# FormatNumber(Container.DataItem("UsableHeight"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="Double" ID="txtUsableHeight" MaxLength="500" Width="100%" runat="server" Text='<%# FormatNumber(Eval("UsableHeight"))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />                            
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Gross Area" UniqueName="GrossArea" DataField="GrossArea"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="GrossArea">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("GrossArea").ToString = String.Empty, "&nbsp;", Container.DataItem("GrossArea").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtGrossArea" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("GrossArea")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Net Area" UniqueName="NetArea" DataField="NetArea"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NetArea">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NetArea").ToString = String.Empty, "&nbsp;", Container.DataItem("NetArea").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNetArea" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NetArea")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>
                                      
                         <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy" DataField="CreatedBy"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedBy">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CreatedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("CreatedBy").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCreatedBy" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("CreatedBy")%>'></asp:TextBox>
                            </EditItemTemplate>
                             <HeaderStyle wrap="false" Width="110px" />
                        </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Created On" UniqueName="CreatedOn" DataField="CreatedOn"
                            HeaderStyle-HorizontalAlign="Center"  SortExpression="CreatedOn">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("CreatedOn")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("CreatedOn")))%>
                            </ItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="rdpCreatedOn" Skin="Default" MaxLength="500" DateInput-Width="90px" Width="100%" MinDate="1-1-1900" runat="server" Text='<%# Eval("CreatedOn")%>'></telerik:RadDatePicker>   
                            </EditItemTemplate>
                             <HeaderStyle wrap="false" Width="120px" />
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows"  CssClass="GridCmdEditRows" Visible='<%# rdgSpace.EditIndexes.Count = 0 And (Not rdgSpace.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="LocationGroup" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited" Visible='<%# rdgSpace.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgSpace.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSpace.EditIndexes.Count > 0 Or rdgSpace.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgSpace.EditIndexes.Count = 0 And (Not rdgSpace.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgSpace.EditIndexes.Count = 0 And (Not rdgSpace.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"  meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgSpace.EditIndexes.Count = 0 And (Not rdgSpace.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true"
                    Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
