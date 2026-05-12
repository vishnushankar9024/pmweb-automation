<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseAdministratorRecoveries.ascx.vb" Inherits="Website.LeaseAdministratorRecoveries" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCosts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCosts" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="imgBtn">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCosts" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="dtpCostFrom">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="dtpNextPostingFrom">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="dtpTo">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="dtpCostsTo">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRecovRefreshGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCosts" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRecovRefreshGrid" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="PMMainPage">
    <div class="row">
        <div class="col-4 col-4-left">
            <fieldset id="fldWhatToPost" runat="server">
                <legend>
                    <asp:Label ID="lblWhatToPost" runat="server" meta:resourcekey="lblWhatToPost" Text="What To Post"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCostsForm" meta:resourcekey="lblCostsForm" runat="server" Text="Cost From"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpCostFrom" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Office2007" EnableTyping="True">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput3" Skin="Metro" runat="server" AutoPostBack="true"></DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCostsTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpCostsTo" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Office2007" EnableTyping="True">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput4" Skin="Metro" runat="server" AutoPostBack="true"></DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblChargeTypes" meta:resourcekey="lblChargeTypes" runat="server" Text="Charge Types"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlChargeTypes" Height="250px" runat="server" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true" Width="100%" Skin="Metro">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkChargesType" />
                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkChargesType"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblNextPostingFrom" meta:resourcekey="lblNextPostingFrom" runat="server" Text="Next Posting From"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpNextPostingFrom" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Office2007" EnableTyping="True">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput1" Skin="Metro" runat="server" AutoPostBack="true"></DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpTo" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Office2007" EnableTyping="True">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput2" Skin="Metro" runat="server" AutoPostBack="true"></DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPostEvery" meta:resourcekey="lblPostEvery" runat="server" Text="Post Every"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlPostEvery" Height="250px" runat="server" AllowCustomText="True" Width="100%" Skin="Metro" Filter="Contains" MarkFirstMatch="true">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkPostEvery" />
                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chkPostEvery"></asp:Label>
                                        <%#DataBinder.Eval(Container, "Text")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblDocumentType" meta:resourcekey="lblDocumentType" runat="server" Text="Document Type"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlDocumentType" Height="250px" runat="server" AllowCustomText="True" Width="100%" Skin="Metro" Filter="Contains" MarkFirstMatch="true">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkDoc" />
                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chkDoc"></asp:Label>
                                        <%#DataBinder.Eval(Container, "Text")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <fieldset id="fldScheduledChargesRecap" runat="server">
                <legend>
                    <asp:Label ID="lblRecoveriesRecap" meta:resourcekey="lblRecoveriesRecap" runat="server" Text="Recoveries Recap"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth"></td>
                        <td class="controlWidth">
                            <table style="width: 100%; text-align: center; color: #666666; text-transform: uppercase;" class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 116px; padding-right: 8px;">
                                        <asp:Label ID="lblNbrOfLines" meta:resourcekey="lblNbrOfLines" runat="server" Text="#"></asp:Label>
                                    </td>
                                    <td style="width: 116px;">
                                        <div>
                                            <asp:Label ID="lblAmount" meta:resourcekey="lblAmount" runat="server" Text="Amount"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTotalCosts" meta:resourcekey="lblTotalCosts" runat="server" Text="Total Costs"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 116px; padding-right: 8px;">
                                        <asp:TextBox ID="txtLineNumbersTotalCosts" Enabled="false" runat="server" CssClass="Integer" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                    <td style="width: 116px;">
                                        <div>
                                            <asp:TextBox ID="txtAmountTotalCosts" Enabled="false" runat="server" CssClass="Currency" Width="100%" MaxLength="15"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTotalRecovered" meta:resourcekey="lblTotalRecovered" runat="server" Text="Total Recovered"></asp:Label></td>
                        <td class="controlWidth">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 116px; padding-right: 8px;">
                                        <asp:TextBox ID="txtLineNumbersTotalRecovered" Enabled="false" runat="server" CssClass="Integer" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                    <td style="width: 116px;">
                                        <asp:TextBox ID="txtAmountTotalRecovered" Enabled="false" runat="server" CssClass="Currency" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="color: #666666 !important; height: 24px;">

                            <asp:Label ID="lblIncludeEstCharges" meta:Resourcekey="chkIncludeEstCharges" runat="server" Text="Include Estimated Charges in Calculations"></asp:Label>
                            <div style="float: right;">
                                <asp:CheckBox runat="server" ID="chkIncludeEstCharges" Width="100%" Style="color: #666666;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div style="float: right;">
                                <asp:LinkButton runat="server" ID="imgBtn" CssClass="filterButtonLease"><span class="Icon"></span></asp:LinkButton>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
    <div class="PMHeader">
        <div class="row">
            <div class="col-12" style="margin-bottom:24px;">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblCosts" meta:resourcekey="lblCosts" runat="server" Text="Costs"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgCosts" AllowMultiRowSelection="true" runat="server" Width="100%" ShowGroupPanel="true" UseEditFormInMobile="true"
                        HeaderStyle-Font-Size="8" AllowMultiRowEdit="True" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="False" ShowFooter="true" AllowPaging="true" PageSize="10">
                        <GroupPanel Text="<%$Resources:PMWeb, Grid_GroupPanel %>"></GroupPanel>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id,OperatingProjectId" ClientDataKeyNames="Id,OperatingProjectId" CommandItemDisplay="Top" ShowGroupFooter="true"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace" ShowFooter="true" Name="Master">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" SortExpression="LineNumber"
                                    Groupable="false" Reorderable="true" DataField="LineNumber">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%#Eval("LineNumber").ToString%></span>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="OperatingProject" ItemStyle-Wrap="false" HeaderText="Operating Project"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true" DataField="OperatingProjectName"
                                    SortExpression="OperatingProjectName" GroupByExpression="OperatingProjectName [GridColumn_OperatingProjectName] Group By OperatingProjectName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(CStr(Eval("OperatingProjectName")) = String.Empty, "&nbsp;", Eval("OperatingProjectName"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("OperatingProjectName")%></span>
                                        <%--                   <telerik:RadComboBox ID="ddlProjects" runat="server" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged" AutoPostBack="True" CausesValidation="False"
                                                                             CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                                                             NoWrap="true" Skin="Metro" Width="100%" DropDownWidth="400px" ShowMoreResultsBox="True"
                                                                             EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                        </telerik:RadComboBox>--%>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="80px" ItemStyle-Wrap="false" HeaderText="Date" UniqueName="Date" DataField="Date" SortExpression="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Eval("Date"))%></span>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="dtpDate" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Office2007" EnableTyping="True">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput2" Skin="Metro" runat="server" AutoPostBack="false"></DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                    <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Document" UniqueName="Document" DataField="Document" SortExpression="Document" GroupByExpression="Document [GridColumn_Document] Group By Document ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("Document").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDocument" MaxLength="500" runat="server" Text='<%# Eval("Document") %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Document Type" UniqueName="DocumentType" DataField="DocumentType" SortExpression="DocumentType" GroupByExpression="DocumentType [GridColumn_DocumentType] Group By DocumentType ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("DocumentType").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlDocumentType" Skin="Metro" AllowCustomText="true" Filter="Contains" Height="400px" DropDownWidth="250px" runat="server" Width="100%"></telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" HeaderText="Item" ItemStyle-Wrap="false" UniqueName="Item" DataField="Item" SortExpression="Item" GroupByExpression="Item [GridColumn_Item] Group By Item ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Item").ToString = "0", "", Eval("Item").ToString) %></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtItem" MaxLength="500" runat="server" Enabled="false" Text='<%#IIf(Eval("Item").ToString = "0", "", Eval("Item").ToString) %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="60px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description" SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("Description").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="170px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" ItemStyle-Wrap="false" HeaderText="UOM" UniqueName="UOM" DataField="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("UOM").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlUOM" Skin="Metro" DropDownWidth="250px" Height="300px" AllowCustomText="true" Filter="Contains" runat="server" Width="100%"></telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="60px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Quantity" ItemStyle-Wrap="false" UniqueName="Quantity" DataField="Quantity" SortExpression="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC">
                                    <ItemTemplate>
                                        <span><%# FormatNumber(Eval("Quantity"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# FormatNumber(Eval("Quantity")) %>' Width="100%" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="70px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Unit Cost" ItemStyle-Wrap="false" UniqueName="UnitCost" DataField="UnitCost" SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("UnitCost"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtUnitCost" runat="server" Text='<%# FormatCurrency(Eval("UnitCost")) %>' Width="100%" CssClass="Currency"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Total Amount" DataField="TotalAmount" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" ItemStyle-Wrap="false" UniqueName="TotalAmount" SortExpression="TotalAmount" GroupByExpression="TotalAmount [GridColumn_TotalAmount] Group By TotalAmount ASC">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("TotalAmount"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTotalAmount" runat="server" Text='<%# FormatCurrency(Eval("TotalAmount")) %>' Width="100%" CssClass="Currency"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                    <FooterStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode" SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                        </asp:HyperLink>
                                        <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlCostCodes" Height="400px" Width="100%" DropDownWidth="300px" runat="server" Skin="Metro" CloseDropDownOnBlur="true"
                                            NoWrap="False" AllowCustomText="False" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ItemsLoadRequested">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Cost Ledger ID" ItemStyle-Wrap="false" UniqueName="CostLedgerId" DataField="CostLedgerId"
                                    SortExpression="CostLedgerId" GroupByExpression="CostLedgerId [GridColumn_CostLedgerId] Group By CostLedgerId ASC">
                                    <ItemTemplate>
                                        <span><%# iif(Eval("CostLedgerId").ToString="0","",Eval("CostLedgerId").ToString)%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCostLedgerId" runat="server" Enabled="false" Text='<%# iif(Eval("CostLedgerId").ToString="0","",Eval("CostLedgerId").ToString) %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="110px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalAmount" Visible="False" />

                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        SecurityButtonType="ItemMode_Edit"
                                        Visible='<%# rdgCosts.EditIndexes.Count = 0 And (Not rdgCosts.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                        SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=RecoveryTab',910,580,true)">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited" Visible='<%# rdgCosts.EditIndexes.Count > 0 %>'
                                        meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                        SecurityButtonType="AddEditMode_Add"
                                        Visible='<%# rdgCosts.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        SecurityButtonType="AddEditMode"
                                        Visible='<%# rdgCosts.EditIndexes.Count > 0 Or rdgCosts.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        SecurityButtonType="ItemMode_Add"
                                        Visible='<%# rdgCosts.EditIndexes.Count = 0 And (Not rdgCosts.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server" Text="Add"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        SecurityButtonType="ItemMode_Delete"
                                        Visible='<%# rdgCosts.EditIndexes.Count = 0 And (Not rdgCosts.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRecalculate" Style="padding-bottom: 1px" runat="server" CausesValidation="False" CommandName="RecalculateCostLines" CssClass="GridCmdRecalculateCostLines"
                                        SecurityButtonType="ItemMode_Add"
                                        Visible='<%# rdgCosts.EditIndexes.Count = 0 And (Not rdgCosts.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label3" runat="server" Text="Add"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        SecurityButtonType="ItemMode"
                                        Visible='<%# rdgCosts.EditIndexes.Count = 0 And (Not rdgCosts.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    </asp:LinkButton>
                                    <span style="width: 100%; text-align: right">&nbsp;&nbsp;
                                                            <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkUserUnits_OnChekedChanged" ID="ckbUseUnits" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                    </span>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                        EnableShadows="true" CausesValidation="false"
                                        Visible="true">
                                    </telerik:RadMenu>
                                </div>
                            </CommandItemTemplate>

                            <DetailTables>
                                <telerik:GridTableView SkinID="PM" ShowHeader="True" CommandItemDisplay="Top" AllowSorting="false" AllowPaging="false"
                                    DataKeyNames="Id" Width="100%" EditMode="InPlace" Name="Charges">
                                    <ParentTableRelation>
                                        <telerik:GridRelationFields DetailKeyField="RecoveryCostId" MasterKeyField="Id" />
                                    </ParentTableRelation>
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" Reorderable="true" HeaderText="" DataField="Post" HeaderStyle-HorizontalAlign="Center" Groupable="false">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblPost" runat="server" Text="Post" meta:resourcekey="lblPost"></asp:Label>
                                                <asp:CheckBox ID="chkSelectAll" AutoPostBack="true" OnCheckedChanged="chkSelectAll_OnChekedChanged" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkSectionUserUnits_OnChekedChanged" runat="server" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chbPost" Checked='<%# Cbool(IIF(Eval("Post") is system.DBNULL.value, 0,Eval("Post")))%>' runat="server" />
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle Width="70px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_PropertyName %>" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="PropertyName" HeaderStyle-Width="160px"
                                            Reorderable="true" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label runat="server" ID="lblProperties" Text='<%# Eval("PropertyName")%>'></asp:Label>
                                                <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Metro" CloseDropDownOnBlur="true"
                                                    AllowCustomText="true" Width="150px" NoWrap="true" DropDownWidth="280px" Height="300px"
                                                    CausesValidation="False" AutoPostBack="false" EmptyMessage="<%$Resources:Asset, ddlLocation_EmptyMsg %>"
                                                    ShowMoreResultsBox="True" OnClientDropDownClosed="ScheduleLeaseddlClose" OnClientSelectedIndexChanged="ClearCostCodeAndLeaseddl"
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="hdnPropertyId" runat="server" />

                                                <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                                    CssClass="Validator" InitialValue="" meta:resourcekey="rfvLocation" ErrorMessage="Required"
                                                    Display="Dynamic" ValidationGroup="ChargeSave" Visible="false" ForeColor="">
                                                </asp:RequiredFieldValidator>
                                                <%--       <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                                                        ErrorMessage="<br/>Select a Location" ClientValidationFunction="ValidateCombo"
                                                                        ValidationGroup="Save" Display="Dynamic" CssClass="Validator" meta:resourcekey="rfvLocation">
                                                                    </asp:CustomValidator>--%>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Lease %>" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Lease" HeaderStyle-Width="120px" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Lease") = String.Empty, "&nbsp;", Container.DataItem("Lease"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label runat="server" ID="lblLease" Text='<%# Eval("Lease")%>'></asp:Label>
                                                <telerik:RadComboBox ID="ddlLeases" OnClientItemsRequesting="GetValueToReturnScheduleCharge" runat="server" AllowCustomText="true"
                                                    meta:resourcekey="ddlLeases" Visible="false"
                                                    Skin="Metro" CloseDropDownOnBlur="true" Height="350px" DropDownWidth="350px"
                                                    EmptyMessage="Select Lease..." Width="100px" AutoPostBack="True" NoWrap="true"
                                                    CausesValidation="False" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>

                                                <asp:LinkButton runat="server" ID="imgLease" CssClass="SearchButton" Visible="false">
                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                                <div>
                                                    <asp:RequiredFieldValidator ID="rfvLease" runat="server" ControlToValidate="ddlLeases"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" ValidationGroup="ChargeSave"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <%--       <asp:CustomValidator ID="csvLease" runat="server" ControlToValidate="ddlLeases"
                                                                           ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="ChargeSave"           
                                                                           CssClass="Validator"  ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Visible="false">
                                                                        </asp:CustomValidator> --%>
                                                </div>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Suite %>" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="100px" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%# Eval("Suite")%></span>&nbsp;
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Tenant %>" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Tenant" HeaderStyle-Width="100px" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%#Eval("Tenant")%></span> &nbsp;
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Type %>" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Type" HeaderStyle-Width="100px" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#Eval("Type").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="120px" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#Eval("Description").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="90px" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_PostEvery %>" UniqueName="PostEvery" DataField="Postvery" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# Eval("PostEvery").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%# Eval("PostEvery").ToString%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UOM %>" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                                            DataField="UOM">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Quantity %>" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity">
                                            <ItemTemplate>
                                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UnitCost %>" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                                            SortExpression="UnitCost">
                                            <ItemTemplate>
                                                <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                                    Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="135px" Reorderable="true" HeaderText="<%$Resources: GridColumn_RecoveryAmount %>" UniqueName="Amount" Groupable="false" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <div style="float: left">
                                                    <%# FormatCurrency(Eval("Amount"))%>
                                                </div>
                                                <div style="float: right">
                                                    <asp:LinkButton ID="imgAmount" Style="cursor: pointer" CssClass="FilledDetails" runat="server">
                                                                             <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# FormatCurrency(Eval("Amount")) %>' Width="100%" CssClass="Currency"></asp:TextBox>

                                            </EditItemTemplate>
                                            <FooterTemplate>

                                                <asp:Label ID="lblSumTotalAmount" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <HeaderStyle Width="135px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" Reorderable="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_CostCode %>" UniqueName="CostCode" DataField="CostCode" Groupable="false">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                                </asp:HyperLink>
                                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlCostCodes" Height="400px" Width="100%" DropDownWidth="300px" runat="server" Skin="Metro" CloseDropDownOnBlur="true"
                                                    NoWrap="False" AllowCustomText="False" EnableItemCaching="false" OnClientItemsRequesting="GetValueToReturnScheduleCharge" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ItemsLoadRequested">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" Reorderable="true" HeaderStyle-HorizontalAlign="Center" HeaderText="<%$Resources: GridColumn_Notes %>" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#Eval("Notes").ToString%>&nbsp; </span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" Reorderable="true" HeaderStyle-HorizontalAlign="Center" HeaderText="<%$Resources: GridColumn_ChargeSystemID %>" ItemStyle-Wrap="false" UniqueName="ChargeSystemID" DataField="ChargeSystemID"
                                            SortExpression="ChargeSystemID" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Eval("SystemId").ToString = "0", "&nbsp;", Eval("SystemId").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%# Eval("SystemId").ToString%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="btnEditSelected1" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                Visible='<%# HideShow(container) %>' SecurityButtonType="ItemMode_Edit" meta:resourcekey="btnEditSelectedResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines1" runat="server" Text="<%$ Resources:PMWeb, EditSelectedLines %>"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                                Visible='<%# NOT HideShow(container) %>' meta:resourcekey="btnSaveResource1" ValidationGroup="ChargeSave">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="<%$ Resources:PMWeb, PerformInsert %>"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                Visible='<%# HideShow(container) %>' SecurityButtonType="ItemMode_Add">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server" Text="<%$ Resources:PMWeb, InitNewRow %>"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited1" runat="server" CommandName="UpdateEdited" Visible='<%# HideShowUpdate(container) %>' CssClass="GridCmdUpdateEdited"
                                                meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit" ValidationGroup="ChargeSave">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdate1" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                Visible='<%# HideShow(container) %>' runat="server" CommandName="DeleteRows"
                                                meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel1" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                Visible='<%# NOT HideShow(container) %>' meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel1" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnReverse" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="ReverseSelection" CssClass="GridCmdReverseSelection">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblReverse" runat="server" Text="Reverse Selection1" meta:resourcekey="lblReverse"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </telerik:GridTableView>
                            </DetailTables>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>
                </fieldset>
            </div>
        </div>
    </div>
</div>

<asp:HiddenField runat="server" ID="hdnCostCodeSelectedMsg" />
<asp:Button ID="btnRecovRefreshGrid" runat="server" CssClass="Hide" />