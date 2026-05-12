<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="LeaseCharges.aspx.vb" Inherits="Website.LeaseCharges" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Asset/LeaseCharges.js" type="text/javascript"></script>
    <script type="text/javascript">

        function OpenChargeDetailPopup(Id) {
            return OpenPOPUp('LeaseChargesDetailsPopup.aspx?Id=' + Id, 832, 730, true);

        }

    </script>
    <style type="text/css">
        .div_more_menu > table > tbody > tr > td .chkMore {
            margin-left: -3px;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgLeaseCharges">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLeaseCharges" LoadingPanelID="ldpPM" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <div class="PMHeader">
        <div class="row">
            <div class="col-12">
                <telerik:RadGrid ID="rdgLeaseCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" UseEditFormInMobile="true"
        HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        ShowGroupPanel="True" AllowMultiRowEdit="True" PageSize="20" AllowPaging="true" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">

        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
            EnableHeaderContextMenu="true">

            <Columns>

                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Charge ID*" ItemStyle-Wrap="false" UniqueName="ChargeID" DataField="ChargeID"
                    SortExpression="ChargeID" Groupable="false">
                    <ItemTemplate>
                        <span><%# Eval("ChargeID").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtChargeId" runat="server" Text='<%# Eval("ChargeID") %>' Width="100%"></asp:TextBox>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvChargeId" ControlToValidate="txtChargeId"
                                runat="server" CssClass="Validator" Display="Dynamic" meta:resourcekey="rfvChargeId"
                                ValidationGroup="Save"></asp:RequiredFieldValidator>
                        </div>
                    </EditItemTemplate>
                    <HeaderStyle Width="70px" />
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                    SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                    <ItemTemplate>
                        <span><%#Eval("Type").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                    SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                    <ItemTemplate>
                        <span><%#Eval("Description").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="120px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="90px" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                    SortExpression="PostEvery" GroupByExpression="PostEvery [GridColumn_PostEvery] Group By PostEvery ASC">
                    <ItemTemplate>
                        <span><%# Eval("PostEvery").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlPostEvery" runat="server" AllowCustomText="false" OnClientSelectedIndexChanged="dllPostEverySelectedIndexChanged"
                            Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False"
                            TabIndex="2">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                        <asp:HiddenField runat="server" ID="hdnPostEvry" />
                    </EditItemTemplate>
                    <HeaderStyle Width="90px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                    SortExpression="Est" GroupByExpression="Est [GridColumn_Est] Group By Est ASC">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Est")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbEst" Checked='<%# CBool(IIf(Eval("Est") Is System.DBNull.Value, 0, Eval("Est")))%>' runat="server" />
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle Width="70px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                    DataField="UOM">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("Quantity"))%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Unit Cost" DataField="UnitCost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                    SortExpression="UnitCost">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("UnitCost"))%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                            Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Amount" ItemStyle-Wrap="false" UniqueName="Amount" DataField="Amount"
                    SortExpression="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="float: left">
                            <asp:LinkButton ID="imgLeaseChargeDetails" Style="cursor: pointer" meta:resourcekey="imgLeaseCharges"
                                runat="server" CssClass="EmptyDetails">
                                         <span class="Icon"></span>
                            </asp:LinkButton>
                        </div>
                         <div style="float: right">
                            <span><%# FormatCurrency(Eval("Amount"))%>&nbsp;</span>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>

                        <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Amount"))%>'></asp:TextBox>


                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annualized" ItemStyle-Wrap="false" UniqueName="Annualized" DataField="Annualized"
                    SortExpression="Annualized" GroupByExpression="Annualized [GridColumn_Annualized] Group By Annualized ASC" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <span><%# FormatCurrency(Eval("Annualized"))%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAnnualized" Enabled="false" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Annualized"))%>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                    SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                    <ItemTemplate>
                        <span><%# Eval("CostCode").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                            EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                            NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                    SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                    <ItemTemplate>
                        <span><%#Eval("Notes").ToString%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>
                        <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                            CssClass="SearchButton">
                                               <span class="Icon"></span>
                        </asp:LinkButton>
                    </EditItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                    SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>' runat="server" />
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle Width="70px" />
                </telerik:GridTemplateColumn>

            </Columns>

            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 And (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                        Visible='<%# rdgLeaseCharges.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count > 0 Or rdgLeaseCharges.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 And (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 And (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                        Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <span>
                        <asp:Label ID="lblDisplay" runat="server" meta:resourcekey="lblDisplay" Text="Display"></asp:Label>&nbsp;&nbsp; 
                                    <telerik:RadComboBox ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDisplay_OnSelectedIndexChanged" SecurityButtonType="ItemMode">
                                        <Items>
                                                <telerik:RadComboBoxItem meta:Resourcekey="ListItemAll" Value="0" Text="-- All --" Selected="True"></telerik:RadComboBoxItem>
                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemActiveChargesOnly" Value="1" Text="Active Charges Only"></telerik:RadComboBoxItem>
                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemInactiveChargesOnly" Value="2" Text="Inactive Charges Only"></telerik:RadComboBoxItem>
                                        </Items>
                                    
                                    </telerik:RadComboBox>
                    </span>
                    <span style="width: 100%; text-align: right">
                        <asp:CheckBox runat="server" class="chkMore" AutoPostBack="true" OnCheckedChanged="chkUserUnits_OnChekedChanged" ID="ckbUseUnits" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                    </span>
                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                        EnableShadows="true" CausesValidation="false"
                        Visible="true">
                    </telerik:RadMenu>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>
            </div>
        </div>
    </div>
    


</asp:Content>
