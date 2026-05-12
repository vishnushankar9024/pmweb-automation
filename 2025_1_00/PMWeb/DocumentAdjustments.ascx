<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentAdjustments.ascx.vb"
    Inherits="Website.DocumentAdjustments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style>
    tr#ctl00_CPH1_DocumentAdjustments1_rdgAdjustmentsRecap_ctl00__0 {
        background-color: #EDEDED;
    }

    tr#ctl00_CPH1_DocumentAdjustments1_rdgAdjustmentsRecap_ctl00__1 {
        background-color: #EDEDED;
    }

    .div-second-grid-width {
        width: 846px;
    }

    @media screen and (min-width:320px) and (max-width:843px) {
        .div-second-grid-width {
            flex: 0 0 100% !important;
            max-width: 100% !important;
            /*padding-left: 2px !important;*/
        }
    }
</style>
<telerik:RadAjaxManagerProxy ID="RamAdjustment" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAdjustmentDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAdjustmentDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdgAdjustmentsRecap" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpAdjustment" runat="server" Skin="Office2007" meta:resourcekey="ldpAdjustment" />

<asp:Label ID="lblMsgHasAdjustment" runat="server" CssClass="Validator" meta:resourcekey="lblMsgHasAdjustment"></asp:Label>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgAdjustmentDetails" runat="server" CssClass="WithoutTopBorder ResponsiveMargin" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" HeaderStyle-Font-Size="8" PageSize="250" AllowMultiRowSelection="true" AllowMultiRowEdit="true" UseEditFormInMobile="true"
                AllowPaging="True" ShowFooter="False" ShowStatusBar="True" GridLines="None" ShowGroupPanel="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" TableLayout="Fixed" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Project" SortExpression="ProjectName" DataField="ProjectName" UniqueName="ProjectName"
                            GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ProjectName") = "", "&nbsp;", Container.DataItem("ProjectName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="False" CausesValidation="False"
                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                    OnClientSelectedIndexChanged="Adjustment_ResetCombo"
                                    NoWrap="true" Skin="Metro" Width="100%" ShowMoreResultsBox="True"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Column*" DataField="AdjustmentColumn" SortExpression="AdjustmentColumn" GroupByExpression="AdjustmentColumn [GridColumn_AdjustmentColumn] Group By AdjustmentColumn ASC" UniqueName="AdjustmentColumn">
                            <ItemTemplate>
                                <span><%#IIf(CStr(Eval("AdjustmentColumn")) = String.Empty, "&nbsp;", Eval("AdjustmentColumn"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlColumns" runat="server" Width="100%">
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment Group" DataField="AdjustmentGroupCode" SortExpression="AdjustmentGroupCode" GroupByExpression="AdjustmentGroupCode [GridColumn_AdjustmentGroupCode] Group By AdjustmentGroupCode ASC" UniqueName="AdjustmentGroupCode">
                            <ItemTemplate>
                                <span><%#Eval("AdjustmentGroupCode")%></span>&nbsp;
                            </ItemTemplate>

                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Adjustment" DataField="Code" SortExpression="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC" UniqueName="Code">
                            <ItemTemplate>
                                <span><%#Eval("Code")%></span>&nbsp;
                            </ItemTemplate>

                            <HeaderStyle Width="80px" />
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description ASC" DataField="Description">
                            <ItemTemplate>
                                <span>
                                    <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%"
                                    MaxLength="255"></asp:TextBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                    Skin="Metro" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150"></HeaderStyle>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="%" DataField="Percentage" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage ASC" UniqueName="Percentage"
                            SortExpression="Percentage">
                            <ItemTemplate>
                                <span><%#IIf(CStr(Eval("Percentage")) = "0", "&nbsp;", FormatPercent(Container.DataItem("Percentage")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPercentage" CssClass="Percent" runat="server" Width="100%" precision="5"
                                    Text='<%#  FormatPercent(Eval("Percentage"), 5) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="72px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" DataField="CostTypes" SortExpression="CostTypes" GroupByExpression="CostTypes [GridColumn_CostTypes] Group By CostTypes ASC" UniqueName="CostTypes">
                            <ItemTemplate>
                                <span><%#IIf(CStr(Eval("CostTypes")) = String.Empty, "&nbsp;", Eval("CostTypes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostTypes" runat="server" AllowCustomText="True" Width="100%"  Filter="Contains" MarkFirstMatch="true"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Metro" meta:resourcekey="ddlCostTypes">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApply" />
                                            <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply">
                                        <%#Eval("CostType")%>
                                            </asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cumulative" DataField="IsCumulative" GroupByExpression="IsCumulative [GridColumn_IsCumulative] Group By IsCumulative ASC" UniqueName="IsCumulative">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIf(Eval("IsCumulative"), "checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsCumulative" Checked='<%# CBool(IIf(Eval("IsCumulative") Is System.DBNull.Value, 0, Eval("IsCumulative")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Calculated Amount" ItemStyle-Wrap="false" DataField="Amount"
                            ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" UniqueName="CalculatedAmount" Groupable="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCalculatedMarkup" runat="server" Style="text-align: right;" Text='<%# FormatCurrency(ParseDouble(Eval("Amount")), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.DocumentAdjustmentInfo.RecordCurrencyId, Eval("CurrencyId")))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCalculatedAmount" MaxLength="15" runat="server" CssClass="Currency" Text='<%# FormatCurrency(ParseDouble(Eval("Amount")), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.DocumentAdjustmentInfo.RecordCurrencyId, Eval("CurrencyId")))%>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manual" GroupByExpression="IsManual [GridColumn_IsManual] Group By IsManual ASC" UniqueName="IsManual" DataField="IsManual">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIf(Eval("IsManual"), "checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsManual" Checked='<%# CBool(IIf(Eval("IsManual") Is System.DBNull.Value, 0, Eval("IsManual")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Adjustment Amount" DataField="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC" UniqueName="Amount"
                            SortExpression="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Style="text-align: right;" Text='<%# FormatCurrency(Eval("Amount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.DocumentAdjustmentInfo.RecordCurrencyId, Eval("CurrencyId")))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("Amount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.DocumentAdjustmentInfo.RecordCurrencyId, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn GroupByExpression="AppliedToField [GridColumn_AppliedToField] Group By AppliedToField ASC" DataField="AppliedToField"
                            AutoPostBackOnFilter="true" HeaderText="Applied To" SortExpression="AppliedToField" UniqueName="AppliedToField">
                            <ItemTemplate>
                                <%#Container.DataItem("AppliedToField")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAppliedTo" runat="server"
                                    Width="100%">
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Recuring" DataField="Recuring" GroupByExpression="Recuring [GridColumn_Recuring] Group By Recuring ASC" UniqueName="Recuring">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIf(Eval("Recuring"), "checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkRecuring" Checked='<%# CBool(IIf(Eval("Recuring") Is System.DBNull.Value, 0, Eval("Recuring")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="New Line" DataField="AppendLine" GroupByExpression="AppendLine [GridColumn_AppendLine] Group By AppendLine ASC" UniqueName="AppendLine">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIf(Eval("AppendLine"), "checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAppendLine" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Cost Code" DataField="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" UniqueName="CostCode">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" Filter="Contains"
                                    EnableItemCaching="false" MarkFirstMatch="true"
                                    Skin="Metro" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" OnClientItemsRequesting="Adjustment_GetValueToReturn"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                                    MaxLength="200"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment Company" SortExpression="ADJCompany" UniqueName="ADJCompany" DataField="ADJCompany"
                            GroupByExpression="ADJCompany [GridColumn_ADJCompany] Group By ADJCompany ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ADJCompanyId") = -1 Or Container.DataItem("ADJCompanyId") = 0, "&nbsp;", Container.DataItem("ADJCompany"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlADJCompanies" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Metro" CloseDropDownOnBlur="true" EnableItemCaching="False" EmptyMessage="Select Company..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="Adjustment_GetValueToReturn"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Group Company" SortExpression="ADJGCompany" UniqueName="ADJGCompany" DataField="ADJGCompany"
                            GroupByExpression="ADJGCompany [GridColumn_ADJGCompany] Group By ADJGCompany ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ADJGCompanyId") = -1 Or Container.DataItem("ADJGCompanyId") = 0, "&nbsp;", Container.DataItem("ADJGCompany"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlADJGCompanies" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Metro" CloseDropDownOnBlur="true" EnableItemCaching="False" EmptyMessage="Select Company..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="Adjustment_GetValueToReturn"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment Type" DataField="AdjustmentType" SortExpression="AdjustmentType" HeaderStyle-Width="100px" GroupByExpression="AdjustmentType [GridColumn_AdjustmentType] Group By AdjustmentType ASC" UniqueName="AdjustmentType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AdjustmentType") = String.Empty, "&nbsp;", Container.DataItem("AdjustmentType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAdjustmentType" CausesValidation="False"
                                    runat="server" Skin="Metro" Width="100%" AllowCustomText="True">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <EditItemStyle Wrap="false" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" Font-Size="8pt" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="EstimateAdjustment" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateAdjustment" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgAdjustmentDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count > 0 Or rdgAdjustmentDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddAdjustments" CommandName="AddAdjustments" CssClass="GridCmdAddAdjustments" runat="server" CausesValidation="False"
                                Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenAdjustmentsSelector(880, 500);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddAdjustments" Text="Add Adjustments" meta:resourcekey="lblAddAdjustments" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="return ConfirmDelete()" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdjustmentsRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                            <asp:CheckBox runat="server" ID="chkAutoCalculate" Text="Auto Calculate" meta:resourcekey="chkAutoCalculate" SecurityButtonType="ItemMode_Edit" CssClass="MenuAlignDetail AdjAutoCalculate" />
                            <asp:Button runat="server" ID="btnAutoCalculate" CausesValidation="false"
                                CssClass="Hide" OnClick="chkAutoCalculate_OnChekedChanged" />
                            <asp:Button ID="btnCalculateNow" runat="server" CausesValidation="False" CommandName="CalculateNow" CssClass="MenuAlignDetail AdjCalculateNow"
                                SecurityButtonType="ItemMode_Edit" Text="Calculate Now" meta:resourcekey="btnCalculateNow" Width="120px" Height="25px"
                                Visible='<%# rdgAdjustmentDetails.EditIndexes.Count = 0 And (Not rdgAdjustmentDetails.MasterTableView.IsItemInserted) %>' />
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowDragToGroup="true" AllowColumnsReorder="true"
                    Resizing-AllowColumnResize="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>

                <ValidationSettings ValidationGroup="EstimateAdjustment" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
    </div>
<div class="PMMainPage">
    <div class="row" >
        <div class="div-second-grid-width">
            <fieldset style="width: 100%;">
                <legend>
                    <asp:Label ID="lblAdjustmentsRecap" runat="server" Text="Adjustments Recap" meta:resourcekey="lblAdjustmentsRecap"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgAdjustmentsRecap" runat="server" allow-scroll="true" SetWidth="true" CssClass="ResponsiveMargin" Style="margin-top: 0px;"
                    AutoGenerateColumns="False" ShowStatusBar="false"
                    Font-Size="8px" ShowFooter="False" AllowPaging="false" ShowGroupPanel="False"
                    AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="False" GridLines="None">
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" TableLayout="Fixed"
                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                        EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="" UniqueName="GridName">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("GridName") = String.Empty, "&nbsp;", Container.DataItem("GridName"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="131px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Adjustments 1 Column" UniqueName="Adjustment1">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatCurrency(Container.DataItem("Adjustment1"), CurrencyId:=PM.DocumentAdjustmentInfo.RecordCurrencyId)%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="111px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />

                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Tax Column" UniqueName="Tax">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatCurrency(Container.DataItem("Tax"), CurrencyId:=PM.DocumentAdjustmentInfo.RecordCurrencyId)%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="111px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Adjustments 2 Column" UniqueName="Adjustment2">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatCurrency(Container.DataItem("Adjustment2"), CurrencyId:=PM.DocumentAdjustmentInfo.RecordCurrencyId)%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="111px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />

                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="(New Line)" UniqueName="NewLine">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatCurrency(Container.DataItem("NewLine"), CurrencyId:=PM.DocumentAdjustmentInfo.RecordCurrencyId)%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="111px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />

                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatCurrency(Container.DataItem("NewLine") + Container.DataItem("Adjustment2") + Container.DataItem("Adjustment1") + Container.DataItem("Tax"), CurrencyId:=PM.DocumentAdjustmentInfo.RecordCurrencyId)%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="111px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />

                            </telerik:GridTemplateColumn>

                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />


                    </MasterTableView>
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                    </ClientSettings>
                </telerik:RadGrid>



            </fieldset>
        </div>
    </div>
</div>
<%--<div style="overflow: auto; width: 100%;" id="AdjustmentDiv">--%>



<br />




<%--</div>--%>
