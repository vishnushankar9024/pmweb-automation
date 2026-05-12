<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIMCOBieManagerZones.ascx.vb" Inherits="Website.BIMCOBieManagerZones" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamZones" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgZones">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgZones" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpZones" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgZones" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true"
                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="100%" CssClass="WithoutTopBorder"
                AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="100px" SortExpression="Id">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SortOrder").ToString = String.Empty, "&nbsp;", Container.DataItem("SortOrder").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(Eval("SortOrder") Is DBNull.Value, String.Empty, Eval("SortOrder").ToString)%>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name"
                            DataField="Name" HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Name")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Spaces Names" UniqueName="SpacesNames" DataField="SpacesNames"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="SpacesNames">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("SpacesNames").ToString = String.Empty, "&nbsp;", Container.DataItem("SpacesNames").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSpacesNames" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("SpacesNames")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" DataField="Category"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Category">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCategory" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Category")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. System" UniqueName="ExtSystem"
                            DataField="ExtSystem" HeaderStyle-HorizontalAlign="Center" SortExpression="ExtSystem">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtSystem").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtSystem").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtSystem" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ExtSystem")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Object" UniqueName="ExtObject"
                            DataField="ExtObject" HeaderStyle-HorizontalAlign="Center" SortExpression="ExtObject">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtObject").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtObject").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtObject" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ExtObject")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Identifier" UniqueName="ExIdentifier"
                            DataField="ExIdentifier" HeaderStyle-HorizontalAlign="Center" SortExpression="ExIdentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExIdentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("ExIdentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExIdentifier" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ExIdentifier")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                            DataField="Description" HeaderStyle-HorizontalAlign="Center" SortExpression="Description">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy"
                            DataField="CreatedBy" HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedBy">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CreatedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("CreatedBy").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCreatedBy" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("CreatedBy")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Created On" UniqueName="CreatedOn"
                            DataField="CreatedOn" HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedOn">
                            <ItemTemplate>
                                <%# FormatDate(Container.DataItem("CreatedOn"))%>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="rdpCreatedOn" runat="server" MinDate="1901-01-01" DateInput-Width="100px"
                                    MaxDate="2100-01-01" Width="130px" Skin="Default">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="false" Width="200px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgZones.EditIndexes.Count = 0 And (Not rdgZones.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="LocationGroup" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgZones.EditIndexes.Count > 0%>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgZones.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgZones.EditIndexes.Count > 0 Or rdgZones.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgZones.EditIndexes.Count = 0 And (Not rdgZones.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgZones.EditIndexes.Count = 0 And (Not rdgZones.MasterTableView.IsItemInserted)%>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgZones.EditIndexes.Count = 0 And (Not rdgZones.MasterTableView.IsItemInserted)%>'
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
