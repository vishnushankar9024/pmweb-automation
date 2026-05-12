<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentCostWorkSheet.ascx.vb"
    Inherits="Website.EquipmentCostWorkSheet" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="CostTable" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgCostToOwn">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostToOwn" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalpercost" />
                <telerik:AjaxUpdatedControl ControlID="txtCostToOwn" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalOwnership" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlCostToOwnPeriod">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostToOwn" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalpercost" />
                <telerik:AjaxUpdatedControl ControlID="txtCostToOwn" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalOwnership" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgCostToOperate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostToOperate" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtOperateCostPeriod" />
                <telerik:AjaxUpdatedControl ControlID="txtOperate" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalOwnership" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlCostToOperatePeriod">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostToOperate" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtOperateCostPeriod" />
                <telerik:AjaxUpdatedControl ControlID="txtOperate" />
                <telerik:AjaxUpdatedControl ControlID="txtTotalOwnership" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMMainPage">
    <div class="row JustifyContent R3Cols">
        <div class="col-4  col-4-left">


            <fieldset>
                <legend>
                    <asp:Label ID="lblDepreciation" runat="server" meta:resourcekey="lblLineDepreciation" Text="Straight Line Depreciation"></asp:Label></legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCost" meta:resourcekey="lblCost" runat="server" Text="Cost"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCost" onChange="CostWorkSheetChanged();" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblSalvage" runat="server" meta:resourcekey="lblSalvage" Text="Salvage"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtSalvage" MaxLength="15" onChange="CostWorkSheetChanged();" CssClass="Currency" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLife" runat="server" meta:resourcekey="lblLife" Text="Life (years)"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtLife" MaxLength="4" onChange="CostWorkSheetChanged();" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" width="100%">
                            <fieldset class="legend">
                                <legend>
                                    <asp:Label ID="lblDepreciationMethod" meta:resourcekey="lblDepreciationMethod" runat="server" Text="Depreciation Method"></asp:Label></legend>
                                <asp:RadioButtonList ID="rblDepreciationMethods" runat="server" RepeatLayout="Table" CssClass="RadioCss RadioPadding"
                                    RepeatColumns="1" RepeatDirection="Vertical">
                                    <asp:ListItem Text="Straight line" Value="STRAIGHTLINE" Selected="True" meta:resourcekey="rblDepreciationMethods_STRAIGHTLINE"></asp:ListItem>
                                    <asp:ListItem Text="Double-declining balance " Value="BALANCE" meta:resourcekey="rblDepreciationMethods_BALANCE"></asp:ListItem>
                                    <asp:ListItem Text="Sum of years digits" Value="DIGITS" meta:resourcekey="rblDepreciationMethods_DIGITS"></asp:ListItem>
                                </asp:RadioButtonList>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadAjaxPanel ID="rdpCostWorkSheet" LoadingPanelID="ldpPM" runat="server"
                                Height="100%" Width="100%">
                                <telerik:RadGrid ID="rdgPastLocations" runat="server"
                                    HeaderStyle-Font-Size="8" AutoGenerateColumns="False" AllowMultiRowEdit="True"
                                    AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="15">
                                    <PagerStyle Mode="NextPrevAndNumeric"
                                        AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        Width="100%" DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace">

                                        <Columns>
                                            <telerik:GridTemplateColumn UniqueName="Year" HeaderText="Year" HeaderStyle-Width="7%">
                                                <ItemTemplate>
                                                    <%#Container.DataItem("Year")%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="BeginingBookValue" HeaderText="Book Value <br> Begining of Year" HeaderStyle-Wrap="True" HeaderStyle-Width="20%">
                                                <ItemTemplate>
                                                    <%#FormatCurrency(ParseDouble(Container.DataItem("BeginingBookValue")))%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Depreciation Expense" UniqueName="DepreciationExpenxce" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="20%">
                                                <ItemTemplate>
                                                    <%#FormatCurrency(ParseDouble(Container.DataItem("DepreciationExpenxce")))%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Accumulated<br>Depreciation" UniqueName="AccumulatedDepreciation" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="20%" HeaderStyle-Wrap="True">
                                                <ItemTemplate>
                                                    <%#FormatCurrency(ParseDouble(Container.DataItem("AccumulatedDepreciation")))%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Book Value <br> End of Year" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="20%" HeaderStyle-Wrap="True" UniqueName="EndBookValue">
                                                <ItemTemplate>
                                                    <%#FormatCurrency(ParseDouble(Container.DataItem("EndBookValue")))%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <AlternatingItemStyle HorizontalAlign="Right" />
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings Resizing-AllowColumnResize="true">
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </telerik:RadAjaxPanel>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </fieldset>

        </div>
        <div class="col-4 col-4-middle">

            <fieldset style="width: 100%">
                <legend>
                    <asp:Label ID="lblCostToOwn" runat="server" meta:resourcekey="lblCostToOwn" Text="Cost to own"></asp:Label></legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCostPeriod" runat="server" meta:resourcekey="lblCostPeriods" Text="Cost period: Amount Per"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlCostToOwnPeriod" AutoPostBack="true" runat="server" Width="100%"
                                Skin="Metro" Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadGrid ID="rdgCostToOwn" AllowMultiRowSelection="true" runat="server"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False"
                                AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="10" UseEditFormInMobile="true">
                                <PagerStyle Mode="NextPrev" Height="20px"
                                    AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Left"
                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Cost Type" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="25%" SortExpression="CostType" UniqueName="CostType">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CostType").ToString = String.Empty, "&nbsp;", Container.DataItem("CostType").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtCostType" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Amount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-Wrap="false" HeaderStyle-Width="20%" UniqueName="Amount" SortExpression="Amount">
                                            <ItemTemplate>
                                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("Amount")))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmmount" MaxLength="15" Text='<%#FormatCurrency(Eval("Amount")) %>' Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rvCostToOwn" ValidationGroup="CostToOwn" Display="Dynamic"
                                                    runat="server" ControlToValidate="txtAmmount" meta:resourcekey="rvCostToOwn" ErrorMessage="Enter The Ammount"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;                                            
                                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="CostToOwn" CausesValidation="true" CssClass="GridCmdPerformInsert"
                                                                        SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" Visible='<%# rdgCostToOwn.MasterTableView.IsItemInserted %>'
                                                                        meta:resourcekey="btnSaveResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                                        &nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                Visible='<%# rdgCostToOwn.EditIndexes.Count > 0 Or rdgCostToOwn.MasterTableView.IsItemInserted %>'
                                                SecurityButtonType="AddEditMode" meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                Visible='<%# rdgCostToOwn.EditIndexes.Count = 0 And (Not rdgCostToOwn.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Add" meta:resourcekey="btnAddResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                Visible='<%# rdgCostToOwn.EditIndexes.Count = 0 And (Not rdgCostToOwn.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="False"
                                    Resizing-AllowColumnResize="false">
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTotalPerCostPeriod" runat="server" meta:resourcekey="lblTotalPerCostPeriods" Text="Total Per Cost Period"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtTotalpercost" ReadOnly="true"
                                CssClass="Currency" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblConvert" meta:resourcekey="lblConvert" runat="server" Text="Hours Per Cost Period"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadNumericTextBox ID="txthoursRate" Type="Number" MinValue="1" runat="server"
                                Style="width: 100% !important; text-align: right;" MaxLength="9">
                                <ClientEvents OnValueChanged="HoursRateValueChanged" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCostToOwnPerHour" meta:resourcekey="lblCostToOwnPerHours" runat="server" Text="Cost To Own Per Hour"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCostToOwn" MaxLength="15"
                                CssClass="Currency" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>

        </div>

        <div class="col-4 col-4-right">

            <fieldset style="width: 100%">
                <legend>
                    <asp:Label ID="lblCostToOperate" meta:resourcekey="lblCostToOperate" runat="server" Text="Cost to operate"></asp:Label></legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblOperatePeriod" runat="server" meta:resourcekey="lblCostPeriods" Text="Cost period: Amount Per"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlCostToOperatePeriod" runat="server" AutoPostBack="true"
                                Skin="Metro" Style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadGrid ID="rdgCostToOperate" AllowMultiRowSelection="true" runat="server"
                                HeaderStyle-Font-Size="8" Width="100%" UseEditFormInMobile="true"
                                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="10">
                                <PagerStyle Mode="NextPrev" Height="20px"
                                    AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Left"
                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CostType %>" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="25%" SortExpression="CostType">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CostType").ToString = String.Empty, "&nbsp;", Container.DataItem("CostType").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtCostType" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Amount %>" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-Wrap="false" HeaderStyle-Width="20%" SortExpression="Amount">
                                            <ItemTemplate>
                                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("Amount")))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmmount" MaxLength="15" Text='<%#FormatCurrency(Eval("Amount")) %>' Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rvCostToOperate" ValidationGroup="CostToOwn" Display="Dynamic"
                                                    runat="server" ControlToValidate="txtAmmount" meta:resourcekey="rvCostToOperate" ErrorMessage="Enter The Ammount"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="CostToOwn" CausesValidation="true" CssClass="GridCmdPerformInsert"
                                                SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" Visible='<%# rdgCostToOperate.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnSaveResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                Visible='<%# rdgCostToOperate.EditIndexes.Count > 0 Or rdgCostToOperate.MasterTableView.IsItemInserted %>'
                                                SecurityButtonType="AddEditMode" meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                Visible='<%# rdgCostToOperate.EditIndexes.Count = 0 And (Not rdgCostToOperate.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Add" meta:resourcekey="btnAddResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                Visible='<%# rdgCostToOperate.EditIndexes.Count = 0 And (Not rdgCostToOperate.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="False"
                                    Resizing-AllowColumnResize="false">
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="LblOperiateCostPeriod" meta:resourcekey="lblTotalPerCostPeriods" runat="server" Text="Total Per Cost Period"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtOperateCostPeriod" ReadOnly="true"
                                CssClass="Currency" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblOperateConverte" meta:resourcekey="lblOperateConvert" runat="server" Text="Conversion Factor"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadNumericTextBox ID="txtOperateHourRate" Type="Number" MinValue="1" runat="server" Style="text-align: right;"
                                MaxLength="9">
                                <ClientEvents OnValueChanged="OperateHourRatechanged" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lbloperate" meta:resourcekey="lblOperatePerHour" runat="server" Text="Cost To Operate Per Hour"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtOperate" ReadOnly="true"
                                CssClass="Currency" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <b>
                                <asp:Label ID="lbltotalCostOfOwnership" meta:resourcekey="lbltotalCostOfOwnerships" runat="server" Text="Total Cost Of Ownership"></asp:Label>
                            </b>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtTotalOwnership" ReadOnly="true"
                                CssClass="Currency" runat="server"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <asp:Button ID="btnSave" Text="Save" meta:resourcekey="btnSave" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

        </div>
    </div>
</div>

