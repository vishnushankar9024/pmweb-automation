<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseAdministratorOverages.ascx.vb" Inherits="Website.LeaseAdministratorOverages" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgOverages">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOverages" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
                <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="imgBtn">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOverages" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
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
        <telerik:AjaxSetting AjaxControlID="btnOverageRefreshGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOverages" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnOverageRefreshGrid" />
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
            <fieldset runat="server" id="fldWhatToPost">
                <legend>
                    <asp:Label ID="lblWhatToPost" meta:resourcekey="lblWhatToPost" runat="server" Text="What To Post"></asp:Label>
                </legend>
                <table class="colTable">
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
                            <asp:Label ID="lblChargeTypes" meta:resourcekey="lblChargeTypes" runat="server" Text="Charge Types"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlChargeTypes" Height="250px" runat="server" AllowCustomText="True" Width="100%" Skin="Metro" Filter="Contains" MarkFirstMatch="true">
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
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <fieldset id="fldScheduledChargesRecap" runat="server">
                <legend>
                    <asp:Label ID="lblScheduledChargesRecap" meta:resourcekey="lblScheduledChargesRecap" runat="server" Text="Scheduled Charges Recap"></asp:Label>
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
                                        <asp:Label ID="lblAmount" meta:resourcekey="lblAmount" runat="server" Text="Amount"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTotalCharges" meta:resourcekey="lblTotalCharges" runat="server" Text="Total Charges"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 116px; padding-right: 8px;">
                                        <asp:TextBox ID="txtLineNumbersTotalCharges" Enabled="false" runat="server" CssClass="Integer" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                    <td style="width: 116px;">
                                        <asp:TextBox ID="txtAmountTotalCharges" Enabled="false" runat="server" CssClass="Currency" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblSelectedToPost" meta:resourcekey="lblSelectedToPost" runat="server" Text="Selected To Post"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 116px; padding-right: 8px;">
                                        <asp:TextBox ID="txtLineNumbersSelectedToPost" Enabled="false" runat="server" CssClass="Integer" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                    <td style="width: 116px;">
                                        <asp:TextBox ID="txtAmountSelectedToPost" Enabled="false" runat="server" CssClass="Currency" Width="100%" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
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
        <div class="row">
            <div class="col-12" style="margin-bottom:24px;">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblPreview" meta:resourcekey="lblPreview" runat="server" Text="Preview"></asp:Label>
                    </legend>
                    <telerik:RadGrid ID="rdgOverages" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" UseEditFormInMobile="true"
                        HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        ShowGroupPanel="True" AllowMultiRowEdit="True" PageSize="20" AllowPaging="true" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">

                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace" EnableHeaderContextMenu="true">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="" UniqueName="Post" DataField="Post"
                                    HeaderStyle-HorizontalAlign="Center" SortExpression="Post" GroupByExpression="Post [GridColumn_Post] Group By Post ASC">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPost" runat="server" Text="Post" meta:resourcekey="lblPost"></asp:Label>
                                        <asp:CheckBox ID="chkSelectAll" AutoPostBack="true" OnCheckedChanged="chkSelectAll_OnChekedChanged" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkSectionUserUnits_OnChekedChanged" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbPost" Checked='<%# CBool(IIf(Eval("Post") Is System.DBNull.Value, 0, Eval("Post")))%>' runat="server" />
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="PropertyName" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="PropertyName" HeaderStyle-Width="115px"
                                    SortExpression="PropertyName" DataField="PropertyName" GroupByExpression="PropertyName [GridColumn_PropertyName] Group By PropertyName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Lease" DataField="Lease" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Lease" HeaderStyle-Width="115px"
                                    SortExpression="Lease" GroupByExpression="Lease [GridColumn_Lease] Group By Lease ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Lease") = String.Empty, "&nbsp;", Container.DataItem("Lease"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("Lease")%></span>&nbsp; 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="115px" DataField="Suite"
                                    SortExpression="Suite" GroupByExpression="Suite [GridColumn_Suite] Group By Suite ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("Suite")%></span>&nbsp; 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tenant" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Tenant" HeaderStyle-Width="115px"
                                    SortExpression="Tenant" GroupByExpression="Tenant [GridColumn_Tenant] Group By Tenant ASC" DataField="Tenant">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("Tenant")%></span>&nbsp; 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Type" HeaderStyle-Width="115px"
                                    SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC" DataField="Type">
                                    <ItemTemplate>
                                        <span><%# Eval("Type").ToString%></span>&nbsp; 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="90px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="120px"
                                    SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC" DataField="Description">
                                    <ItemTemplate>
                                        <span><%#Eval("Description").ToString%></span>&nbsp; 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                                    SortExpression="PostEvery" GroupByExpression="PostEvery [GridColumn_PostEvery] Group By PostEvery ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("PostEvery").ToString%></span>&nbsp; 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("PostEvery").ToString%></span>

                                    </EditItemTemplate>
                                    <HeaderStyle Width="90px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                                    SortExpression="Est" GroupByExpression="Est [GridColumn_Est] Group By Est ASC">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Est")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Image ID="imgEst" runat="server" />

                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" HeaderText="ActualAmount" ItemStyle-Wrap="false" UniqueName="ActualAmount" DataField="ActualAmount"
                                    SortExpression="ActualAmount" GroupByExpression="ActualAmount [GridColumn_ActualAmount] Group By ActualAmount ASC" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("ActualAmount"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtActualAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ActualAmount"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
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
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                                    GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
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
                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="" UniqueName="OverageAmount" SortExpression="OverageAmount" GroupByExpression="OverageAmount [GridColumn_OverageAmount] Group By OverageAmount ASC" ItemStyle-Wrap="false" DataField="OverageAmount">
                                    <ItemTemplate>
                                        <div style="float: left">
                                            <span><%# FormatCurrency(Eval("OverageAmount"))%>&nbsp;</span>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton ID="imgOveragePopup" Style="cursor: pointer" runat="server" CssClass="FilledDetails">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtOverageAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("OverageAmount"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                                    SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                        </asp:HyperLink>
                                        <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" EnableItemCaching="false"
                                            Skin="Metro" CloseDropDownOnBlur="true" meta:resourcekey="ddlCostCode" NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ItemsLoadRequested">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                    SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("Notes").ToString%>&nbsp;</span>
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
                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" HeaderText="Charge System ID" ItemStyle-Wrap="false" UniqueName="SystemId" DataField="SystemId"
                                    SortExpression="SystemId" Groupable="false">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("SystemId").ToString="0","&nbsp;",Eval("SystemId").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("SystemId").ToString%></span>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        Visible='<%# rdgOverages.EditIndexes.Count = 0 And (Not rdgOverages.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="ChargeSave" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        Visible='<%# rdgOverages.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        Visible='<%# rdgOverages.EditIndexes.Count > 0 Or rdgOverages.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        Visible='<%# rdgOverages.EditIndexes.Count = 0 And (Not rdgOverages.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdgOverages.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnReverse" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="ReverseSelection" CssClass="GridCmdReverseSelection">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblReverse" runat="server" Text="Reverse Selection1" meta:resourcekey="lblReverse"></asp:Label>
                                        &nbsp;&nbsp;
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
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>
                </fieldset>
            </div>
        </div>
</div>

<asp:Button ID="btnOverageRefreshGrid" runat="server" CssClass="Hide" />