<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseAdministratorEscalations.ascx.vb" Inherits="Website.LeaseAdministratorEscalations" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEscalations">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEscalations" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="fldScheduledChargesRecap" />
                <telerik:AjaxUpdatedControl ControlID="fldWhatToPost" />
                <telerik:AjaxUpdatedControl ControlID="tblBatchRecap" />
                 <telerik:AjaxUpdatedControl ControlID="imgBtn" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="imgBtn">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEscalations" LoadingPanelID="ldpPM" />
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
        <telerik:AjaxSetting AjaxControlID="btnEscRefreshGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEscalations" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnEscRefreshGrid" />
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
                            <asp:Label ID="lblNextPostingFrom" meta:resourcekey="lblNextPostingFrom" runat="server" Text="Next Posting From"></asp:Label></td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpNextPostingFrom" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Office2007" EnableTyping="True">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Office2007"></Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput1" Skin="Metro" runat="server" AutoPostBack="true"></DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label></td>
                        <td class="labelWidth">
                            <telerik:RadDatePicker ID="dtpTo" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="104px" Skin="Office2007" EnableTyping="True">
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
                                        <asp:Label runat="server" ID="lblchargesType" AssociatedControlID="chkChargesType"></asp:Label>
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
                                        <asp:Label ID="lblNbrOfLines" meta:resourcekey="lblNbrOfLines" runat="server" Text="#" Width="100%"></asp:Label>
                                    </td>
                                    <td style="width: 116px;">
                                        <asp:Label ID="lblAmount" meta:resourcekey="lblAmount" runat="server" Text="Amount" Width="100%"></asp:Label>
                                    </td>
                                </tr>
                            </table>
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
    <div class="PMHeader">
        <div class="row">
            <div class="col-12" style="margin-bottom:24px;">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblPreview" meta:resourcekey="lblPreview" runat="server" Text="Preview"></asp:Label>
                    </legend>
                    <telerik:RadGrid ID="rdgEscalations" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" UseEditFormInMobile="true"
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
                                <telerik:GridTemplateColumn HeaderText="PropertyName" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="PropertyName" HeaderStyle-Width="115px" DataField="PropertyName"
                                    SortExpression="PropertyName" GroupByExpression="PropertyName [GridColumn_PropertyName] Group By PropertyName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Lease" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Lease" HeaderStyle-Width="115px"
                                    SortExpression="Lease" DataField="Lease" GroupByExpression="Lease [GridColumn_Lease] Group By Lease ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Lease") = String.Empty, "&nbsp;", Container.DataItem("Lease"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label runat="server" ID="lblLease" Text='<%# Eval("Lease")%>'></asp:Label>
                                        <telerik:RadComboBox ID="ddlLeases" runat="server" AllowCustomText="true"
                                            meta:resourcekey="ddlLeases" Visible="false"
                                            Skin="Metro" CloseDropDownOnBlur="true" Height="350px" DropDownWidth="350px"
                                            EmptyMessage="Select Lease..." Width="80%" AutoPostBack="False" NoWrap="true"
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
                                            <%--         <asp:CustomValidator ID="csvLease" runat="server" ControlToValidate="ddlLeases"
                                                                       ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="ChargeSave"           
                                                                       CssClass="Validator"  ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Visible="false">
                                                                    </asp:CustomValidator> --%>
                                        </div>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Suite" DataField="Suite" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="115px"
                                    SortExpression="Suite" GroupByExpression="Suite [GridColumn_Suite] Group By Suite ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("Suite")%></span>&nbsp; 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Tenant" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Tenant" HeaderStyle-Width="115px"
                                    SortExpression="Tenant" DataField="Tenant" GroupByExpression="Tenant [GridColumn_Tenant] Group By Tenant ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# Eval("Tenant")%></span>&nbsp; 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Type" HeaderStyle-Width="115px"
                                    SortExpression="Type" DataField="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("Type").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="90px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" DataField="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="120px"
                                    SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("Description").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
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
                                <telerik:GridTemplateColumn HeaderText="Current Quantity" UniqueName="CurrentQuantity" ItemStyle-HorizontalAlign="Right"
                                    GroupByExpression="CurrentQuantity [GridColumn_CurrentQuantity] Group By CurrentQuantity ASC" SortExpression="CurrentQuantity" DataField="CurrentQuantity">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("CurrentQuantity"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCurrentQuantity" runat="server" Width="100%" CssClass="Double"
                                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("CurrentQuantity") Is System.DBNull.Value, "1", Eval("CurrentQuantity"))) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Current Unit Cost" DataField="CurrentUnitCost" UniqueName="CurrentUnitCost" GroupByExpression="CurrentUnitCost [GridColumn_CurrentUnitCost] Group By CurrentUnitCost ASC"
                                    SortExpression="CurrentUnitCost">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Container.DataItem("CurrentUnitCost"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCurrentUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                            Text='<%# FormatCurrency(Eval("CurrentUnitCost")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" HeaderText="Current Amount" ItemStyle-Wrap="false" UniqueName="CurrentAmount" DataField="CurrentAmount"
                                    SortExpression="CurrentAmount" GroupByExpression="CurrentAmount [GridColumn_CurrentAmount] Group By CurrentAmount ASC" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("CurrentAmount"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCurrentAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("CurrentAmount"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="New Quantity" DataField="NewQuantity" UniqueName="NewQuantity" ItemStyle-HorizontalAlign="Right"
                                    GroupByExpression="NewQuantity [GridColumn_NewQuantity] Group By NewQuantity ASC" SortExpression="NewQuantity">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("NewQuantity"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNewQuantity" runat="server" Width="100%" CssClass="Double"
                                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("NewQuantity") Is System.DBNull.Value, "1", Eval("NewQuantity"))) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="New Unit Cost" DataField="NewUnitCost" UniqueName="NewUnitCost" GroupByExpression="NewUnitCost [GridColumn_NewUnitCost] Group By NewUnitCost ASC"
                                    SortExpression="NewUnitCost">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Container.DataItem("NewUnitCost"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNewUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                            Text='<%# FormatCurrency(Eval("NewUnitCost")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" HeaderText="New Amount" ItemStyle-Wrap="false" UniqueName="NewAmount" DataField="NewAmount"
                                    SortExpression="NewAmount" GroupByExpression="NewAmount [GridColumn_NewAmount] Group By NewAmount ASC" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <div style="float: left">
                                            <span><%# FormatCurrency(Eval("NewAmount"))%>&nbsp;</span>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton ID="imgEscPopup" Style="cursor: pointer" CssClass="FilledDetails" runat="server">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNewAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("NewAmount"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="New Line"
                                    HeaderStyle-Width="70px" ItemStyle-Wrap="false" GroupByExpression="NewLine [GridColumn_NewLine] Group By NewLine ASC"
                                    SortExpression="NewLine" UniqueName="NewLine" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" DataField="NewLine">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("NewLine")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbNewLine" Checked='<%# CBool(IIf(Eval("NewLine") Is System.DBNull.Value, 0, Eval("NewLine")))%>' runat="server" />
                                    </EditItemTemplate>
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

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" HeaderText="Charge System ID" ItemStyle-Wrap="false" UniqueName="ChargeSystemID" DataField="SystemId"
                                    SortExpression="SystemId" Groupable="false">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("SystemId").ToString="0","&nbsp;",Eval("SystemId").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <span><%# IIf(Eval("SystemId").ToString="0","&nbsp;",Eval("SystemId").ToString)%></span>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        Visible='<%# rdgEscalations.EditIndexes.Count = 0 And (Not rdgEscalations.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="ChargeSave" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        Visible='<%# rdgEscalations.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        Visible='<%# rdgEscalations.EditIndexes.Count > 0 Or rdgEscalations.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        Visible='<%# rdgEscalations.EditIndexes.Count = 0 And (Not rdgEscalations.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdgEscalations.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
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
</div>

<asp:Button ID="btnEscRefreshGrid" runat="server" CssClass="Hide" />