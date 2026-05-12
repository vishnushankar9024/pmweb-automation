<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIMCOBieComponents.ascx.vb"
    Inherits="Website.BIMCOBieComponents" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamLocation" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgComponent">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgComponent" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpComponent" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgComponent" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true"
                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" CssClass="WithoutTopBorder"
                AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="5%" SortExpression="Id">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SortOrder").ToString = String.Empty, "&nbsp;", Container.DataItem("SortOrder").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(Eval("SortOrder") Is DBNull.Value, String.Empty, Eval("SortOrder").ToString)%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" DataField="Name"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Name")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Level" UniqueName="Level" DataField="Level"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Level">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Level").ToString = String.Empty, "&nbsp;", Container.DataItem("Level").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLevel" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Level")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="TypeName" DataField="TypeName"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="TypeName">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTypeName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TypeName")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="300px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Space" UniqueName="Space" DataField="Space"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Space">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Space").ToString = String.Empty, "&nbsp;", Container.DataItem("Space").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSpace" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Space")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="CategoryDescription" DataField="Description"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. System" UniqueName="ExtSystem" DataField="ExtSystem"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtSystem">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtSystem").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtSystem").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtSystem" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtSystem")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. Object" UniqueName="ExtObject" DataField="ExtObject"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtObject">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtObject").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtObject").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtObject" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtObject")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. Identifier" UniqueName="ExtIdentifier" DataField="ExtIdentifier"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtIdentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtIdentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtIdentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtIdentifier" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtIdentifier")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Serial Number" UniqueName="SerialNumber" DataField="SerialNumber"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="SerialNumber">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("SerialNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("SerialNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSerialNumber" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("SerialNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Installation Date" UniqueName="InstallationDate" DataField="InstallationDate"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="InstallationDate">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("InstallationDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("InstallationDate")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpInstallationDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default"
                                    EnableTyping="True">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Warranty Start Date" UniqueName="WarrantyStartDate" DataField="WarrantyStartDate"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="GrossArea">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("WarrantyStartDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("WarrantyStartDate")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpWarrantyStartDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default"
                                    EnableTyping="True">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tag Number" UniqueName="TagNumber" DataField="TagNumber"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NetArea">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("TagNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("TagNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTagNumber" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TagNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="BarCode" UniqueName="BarCode" DataField="BarCode"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="BarCode">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("BarCode").ToString = String.Empty, "&nbsp;", Container.DataItem("BarCode").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBarCode" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("BarCode")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Asset Identifier" UniqueName="AssetIdentifier" DataField="AssetIdentifier"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="AssetIdentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssetIdentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("AssetIdentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssetIdentifier" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("AssetIdentifier")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy" DataField="CreatedBy"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedBy">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CreatedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("CreatedBy").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCreatedBy" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("CreatedBy")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Created On" UniqueName="CreatedOn" DataField="CreatedOn"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedOn">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("CreatedOn")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("CreatedOn")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpCreatedOn" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default"
                                    EnableTyping="True">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgComponent.EditIndexes.Count = 0 And (Not rdgComponent.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="LocationGroup" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgComponent.EditIndexes.Count > 0%>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgComponent.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgComponent.EditIndexes.Count > 0 Or rdgComponent.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgComponent.EditIndexes.Count = 0 And (Not rdgComponent.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgComponent.EditIndexes.Count = 0 And (Not rdgComponent.MasterTableView.IsItemInserted)%>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgComponent.EditIndexes.Count = 0 And (Not rdgComponent.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
