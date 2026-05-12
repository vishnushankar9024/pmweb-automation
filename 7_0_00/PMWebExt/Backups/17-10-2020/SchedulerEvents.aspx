<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SchedulerEvents.aspx.vb" Inherits="Website.SchedulerEvents" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgSchedulerEvents">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSchedulerEvents" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="chkIsActive">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="chkIsActive" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>




        <div class="PMMainPage">
            <div class="row row-8-4 documentMultiPagesWithoutToolbar">
                <div class="col-8">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblEvents" meta:resourcekey="lblEvents" Text="Events"></asp:Label>
                        </legend>
                        <telerik:RadGrid ID="rdgSchedulerEvents" AllowMultiRowSelection="true" runat="server" AppendMenus="true" FitParentContainer="true"
                            HeaderStyle-Font-Size="8" UseEditFormInMobile="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                            Height="99%" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" CssClass="LightWeight" allowscroll="true" AllowPaging="True" PageSize="20">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                                DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Sort Order" UniqueName="SortOrder" HeaderStyle-Width="100px"
                                        SortExpression="SortOrder">
                                        <ItemTemplate>
                                            <span>
                                                <%#Container.DataItem("SortOrder")%>&nbsp;</span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label runat="server" ID="lblSortOrder" Text='<%# Eval("SortOrder") %>'></asp:Label>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Display by Default" UniqueName="DefaultDisplay"
                                        HeaderStyle-Width="125px" ItemStyle-Wrap="false" SortExpression="DefaultDisplay"
                                        HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("DefaultDisplay")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("DefaultDisplay") Is System.DBNull.Value, 0, Eval("DefaultDisplay")))%>'
                                                runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-Width="250px"
                                        SortExpression="EventName">
                                        <ItemTemplate>
                                            <span>
                                                <%#IIf(Container.DataItem("EventName").ToString = String.Empty, "&nbsp;", Container.DataItem("EventName").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEventName" MaxLength="100" Width="100%" runat="server" Text='<%# Eval("EventName") %>'>
                                            </asp:TextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="100px"
                                        SortExpression="Inactive">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>'
                                                runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="150px">
                                        <ItemTemplate>

                                            <asp:Label Text="&nbsp;" Width="100%" runat="server" ID="lblColor"></asp:Label>

                                        </ItemTemplate>
                                        <EditItemTemplate>
                                          <telerik:RadColorPicker ShowIcon="true" ID="rcpColor" runat="server" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                                <CommandItemTemplate>
                                    <div style="padding: 2px">

                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                            SecurityButtonType="ItemMode_Edit"
                                            CommandName="EditRows" CssClass="GridCmdEditRows"
                                            Visible='<%# rdgSchedulerEvents.EditIndexes.Count = 0 And (Not rdgSchedulerEvents.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnEditSelectedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server"
                                                Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server"
                                            SecurityButtonType="AddEditMode_Edit"
                                            ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                            Visible='<%# rdgSchedulerEvents.EditIndexes.Count > 0 %>'
                                            meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"
                                                meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                            SecurityButtonType="AddEditMode_Add"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                            Visible='<%# rdgSchedulerEvents.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                            SecurityButtonType="AddEditMode"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                            Visible='<%# rdgSchedulerEvents.EditIndexes.Count > 0 Or rdgSchedulerEvents.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                                                meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"
                                            SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                            Visible='<%# rdgSchedulerEvents.EditIndexes.Count = 0 And (Not rdgSchedulerEvents.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                                                meta:resourcekey="lblAddLineResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                            SecurityButtonType="ItemMode_Delete" Visible='<%# rdgSchedulerEvents.EditIndexes.Count = 0 And (Not rdgSchedulerEvents.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                            SecurityButtonType="ItemMode"
                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                            Visible='<%# rdgSchedulerEvents.EditIndexes.Count = 0 And (Not rdgSchedulerEvents.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                                                meta:resourcekey="lblRefreshResource1"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true" Resizing-AllowColumnResize="False">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                            </ClientSettings>
                            <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                        </telerik:RadGrid>
                    </fieldset>
                </div>
                <div class="col-4">
                    <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblBusinessHours" meta:resourcekey="lblBusinessHours" Text="Business Hours"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblStart" meta:resourcekey="lblStart" Text="Start"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpStart"
                                            runat="server" Skin="Default" Width="100%">
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblEnd" meta:resourcekey="lblEnd" Text="End"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpEnd"
                                            runat="server" Skin="Default" Width="100%">
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" colspan="2">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chbDefaultHour" runat="server"></asp:CheckBox>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblDefaultHour" meta:resourcekey="chbDefaultHour" Text="Default to 24 Hour Calendar" style="padding-left:8px;"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblDefaultView" meta:resourcekey="lblDefaultView" Text="Default View"></asp:Label>

                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox Width="100%" ID="ddldefaultView" runat="server">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Button ID="btnSave" runat="server" Text="<%$ Resources:PMWeb, Save %>" />
                                    </td>
                                    <td class="controlWidth"></td>
                                </tr>
                            </table>
                        </fieldset>
                    </telerik:RadAjaxPanel>
                </div>
            </div>
        </div>

</asp:Content>
