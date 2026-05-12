<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMWebViewerSettings.ascx.vb" Inherits="Website.PMWebViewerSettings1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPMWebViewerSettings">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPMWebViewerSettings" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div style="padding-top:38px">
<telerik:RadGrid ID="rdgPMWebViewerSettings" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" AppendMenus="true"
    AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="20" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label Text="&nbsp;" Width="100%" runat="server" ID="lblColor"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadColorPicker ShowIcon="true" ID="rcpColor" runat="server" CssClass="NewColorPicker" KeepInScreenBounds="true"
                        PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight" />


                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="User" UniqueName="User" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("User") = String.Empty, "&nbsp;", Container.DataItem("User"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" Filter="Contains" AutoPostBack="true"
                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" OnSelectedIndexChanged="ddlUserSelectedIndexChanged"
                        NoWrap="True" AllowCustomText="true" ValidationGroup="Save"
                        Style="font-size: 11px" Height="250px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..." AutoPostBack="true"
                        NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies" OnSelectedIndexChanged="ddlCompaniesSelectedIndexChanged"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested"
                        Style="font-size: 11px" Height="250px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Apply to All in Company" UniqueName="ApplyToAllInCompany"
                ItemStyle-Wrap="false" SortExpression="ApplyToAllInCompany" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ApplyToAllInCompany")) = CBool(1), "checked.png", "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbApplyToAllInCompany" Checked='<%# CBool(IIf(Eval("ApplyToAllInCompany") Is System.DBNull.Value, 0, Eval("ApplyToAllInCompany")))%>'
                        runat="server" />
                </EditItemTemplate>

            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Free Color Selection" UniqueName="FreeColorSelection"
                ItemStyle-Wrap="false" SortExpression="FreeColorSelection" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("FreeColorSelection")) = CBool(1), "checked.png", "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbFreeColorSelection" Checked='<%# CBool(IIf(Eval("FreeColorSelection") Is System.DBNull.Value, 0, Eval("FreeColorSelection")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Stamps - Text" UniqueName="StampsText"
                ItemStyle-Wrap="false" SortExpression="StampsText" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:LinkButton ID="btnStampsText" Style="cursor: pointer" runat="server"
                        CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                    </asp:LinkButton>
                    <asp:Label ID="lblAll" runat="server" Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="btnStampsTextEdit" Style="cursor: pointer" runat="server"
                        CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                    </asp:LinkButton>
                    <asp:Label ID="lblAllEdit" runat="server" Visible="false"></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnStampTextIds" Value='<%#Eval("StampsTextIds")%>' />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Stamps - Images" UniqueName="StampsImages"
                ItemStyle-Wrap="false" SortExpression="StampsImages" HeaderStyle-Width="150px"
                HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:LinkButton ID="btnStampsImages" Style="cursor: pointer" runat="server"
                        CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                    </asp:LinkButton>
                    <asp:Label ID="lblImagesAll" runat="server" Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="btnStampsImagesEdit" Style="cursor: pointer" runat="server"
                        CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                    </asp:LinkButton>
                    <asp:Label ID="lblAllImagesEdit" runat="server" Visible="false"></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnStampImagesIds" Value='<%#Eval("StampsImagesIds")%>' />
                </EditItemTemplate>
                <ItemStyle Wrap="false" HorizontalAlign="Center" />
            </telerik:GridTemplateColumn>
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerSettings.MasterTableView.IsItemInserted)%>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server"
                        Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count > 0%>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"
                        meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgPMWebViewerSettings.MasterTableView.IsItemInserted%>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count > 0 Or rdgPMWebViewerSettings.MasterTableView.IsItemInserted%>' meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                        meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerSettings.MasterTableView.IsItemInserted)%>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                        meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerSettings.MasterTableView.IsItemInserted)%>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgPMWebViewerSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerSettings.MasterTableView.IsItemInserted)%>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                        meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" ClientEvents-OnRowSelecting="rdgPMWebViewerSettings_OnRowSelecting" ClientEvents-OnGridCreated="GridCreated">
        <Selecting AllowRowSelect="True" />
        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
    </ClientSettings>
    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>
</div>

