<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseCharges.ascx.vb" Inherits="Website.LeaseCharges1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssetUserDefinedFields.ascx" TagName="AssetUserDefinedFields" TagPrefix="uc1" %>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

    <style type="text/css">
        .div_more_menu > table > tbody > tr > td .chkMore {
            margin-left: -3px;
        }
    </style>
<telerik:RadGrid ID="rdgLeaseCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" UseEditFormInMobile ="true"
     HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" CssClass="WithoutTopBorder" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    ShowGroupPanel="True" AllowMultiRowEdit="True" PageSize="250" AllowPaging="true" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id,HasDetails,HasRecurrences" CommandItemDisplay="Top" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                Groupable="false" Reorderable="true" AllowFiltering="True"
                GroupByExpression="LineNumber [GridColumn_LineNumber] Group By LineNumber ASC"
                DataField="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <%#Eval("LineNumber").ToString%>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate" ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="120px" SortExpression="StartDate" GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC"
                DataField="StartDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                Reorderable="true" Groupable="true" AllowFiltering="true">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("StartDate"))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpStart" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="End" UniqueName="EndDate" ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="120px" SortExpression="EndDate" GroupByExpression="EndDate [GridColumn_EndDate] Group By EndDate ASC"
                DataField="EndDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                AllowFiltering="true" Groupable="true" Reorderable="true">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("EndDate"))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpEnd" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                    </telerik:RadDatePicker>
                    <asp:CompareValidator ID="cvTime" runat="server" ValidationGroup="ChargeSave" ControlToCompare="dtpStart"
                        ControlToValidate="dtpEnd" Operator="GreaterThanEqual" Display="Dynamic" meta:resourceKey="cvEnd" ErrorMessage="End must be greater Than Start">
                    </asp:CompareValidator>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC" Groupable="true" Reorderable="true" AllowFiltering="true"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#Eval("Type").ToString%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC" AllowFiltering="true"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Reorderable="true" Groupable="true">
                <ItemTemplate>
                    <span><%#Eval("Description").ToString%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                SortExpression="PostEvery" GroupByExpression="PostEvery [GridColumn_PostEvery] Group By PostEvery ASC" AllowFiltering="true" Reorderable="true"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true">
                <ItemTemplate>
                    <span><%# Eval("PostEvery").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPostEvery" runat="server" AllowCustomText="false" OnClientSelectedIndexChanged="dllPostEverySelectedIndexChanged"
                        Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                    <asp:HiddenField runat="server" ID="hdnPostEvry" />
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                SortExpression="Est" GroupByExpression="Est [GridColumn_Est] Group By Est ASC" Reorderable="true" Groupable="true" AllowFiltering="true"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Est")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbEst" Checked='<%# CBool(IIf(Eval("Est") Is System.DBNull.Value, 0, Eval("Est")))%>' runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" AllowFiltering="true"
                DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Reorderable="true" Groupable="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right" Reorderable="true" Groupable="true"
                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity" AllowFiltering="true"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'>
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC" Reorderable="true"
                SortExpression="UnitCost" DataField="UnitCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                Groupable="true" AllowFiltering="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Amount" ItemStyle-Wrap="True" UniqueName="Amount" DataField="Amount"
                SortExpression="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC" ItemStyle-HorizontalAlign="Right"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <div style="float: Left">
                        <span><%# FormatCurrency(Eval("Amount"))%>&nbsp;</span>
                    </div>
                    <div style="float: right">
                        <asp:LinkButton ID="imgLeaseChargeDetails" Style="cursor: pointer"
                            meta:resourcekey="imgLeaseCharges"
                            runat="server" CssClass="SearchButton">
                                               <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Amount"))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Annualized" ItemStyle-Wrap="false" UniqueName="Annualized" DataField="Annualized"
                SortExpression="Annualized" GroupByExpression="Annualized [GridColumn_Annualized] Group By Annualized ASC" ItemStyle-HorizontalAlign="Right"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# FormatCurrency(Eval("Annualized"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAnnualized" Enabled="false" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Annualized"))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Annual" ItemStyle-Wrap="false" UniqueName="Annual" DataField="Annual"
                SortExpression="Annual" GroupByExpression="Annual [GridColumn_Annual] Group By Annual ASC" ItemStyle-HorizontalAlign="Right"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# FormatCurrency(Eval("Annual"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblAnnual" runat="server" Width="100%" Text='<%#FormatCurrency(Eval("Annual"))%>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnDetailRentable" />
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                    </asp:HyperLink>
                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode" NoWrap="True" AllowCustomText="False"
                        Style="font-size: 11px" Height="250px" EnableLoadOnDemand="True" ShowMoreResultsBox="False" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Last Posted" UniqueName="LastPostedDate" DataField="LastPostedDate"
                HeaderStyle-Width="120px" SortExpression="LastPostedDate" GroupByExpression="LastPostedDate [GridColumn_LastPostedDate] Group By LastPostedDate ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("LastPostedDate"))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <span><%#FormatDate(Eval("LastPostedDate"))%>&nbsp;</span>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Next Posting" UniqueName="NextPostingDate" DataField="NextPostingDate"
                HeaderStyle-Width="120px" SortExpression="NextPostingDate" GroupByExpression="NextPostingDate [GridColumn_NextPostingDate] Group By NextPostingDate ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("NextPostingDate"))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpNextPostingDate" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Next Scheduled Amount" ItemStyle-Wrap="True" UniqueName="NextScheduledAmount" DataField="NextScheduledAmount"
                SortExpression="NextScheduledAmount" GroupByExpression="NextScheduledAmount [GridColumn_NextScheduledAmount] Group By NextScheduledAmount ASC" ItemStyle-HorizontalAlign="Right"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# FormatCurrency(Eval("NextScheduledAmount"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%# FormatCurrency(Eval("NextScheduledAmount"))%>&nbsp;</span>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Asset(s)" UniqueName="LinkedAssets" HeaderStyle-Width="175px" DataField="LinkedAssets"
                SortExpression="LinkedAssets" GroupByExpression="LinkedAssets [GridColumn_LinkedAssets] Group By LinkedAssets ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <div style="width: 130px; float: left" title='<%#IIf(Container.DataItem("LinkedAssets").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedAssets").ToString)%>'><%#IIf(Container.DataItem("LinkedAssets").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedAssets").ToString)%></div>
                </ItemTemplate>
                <EditItemTemplate>
                    <div style="width: 130px; float: left" title='<%# Eval("LinkedAssets") %>'>

                        <asp:Label ID="lblLinkedAssets" Text='<%# Eval("LinkedAssets") %>' runat="server"> </asp:Label>
                    </div>
                    <div style="width: 20px; float: right">
                        <asp:LinkButton runat="server" ID="imgLinkAsset" meta:resourcekey="imgLinkAsset"
                            CssClass="EmptyDetails">
                                               <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                    <asp:HiddenField runat="server" Value="" ID="hdnLinkedAssetIds" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Charge ID" ItemStyle-Wrap="false" UniqueName="ChargeID" DataField="ChargeID"
                SortExpression="ChargeID" GroupByExpression="ChargeID [GridColumn_ChargeID] Group By ChargeID ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# Eval("ChargeID").ToString%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%# Eval("ChargeID").ToString%>&nbsp;</span>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="60px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC"
                Reorderable="true" Groupable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("Inactive") is system.DBNULL.value, 0,Eval("Inactive")))%>' runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="60px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="System Id" ItemStyle-Wrap="false" UniqueName="Id" DataField="Id"
                SortExpression="Id" Groupable="false" GroupByExpression="Id [GridColumn_Id] Group By Id ASC"
                Reorderable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# Eval("Id").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%# Eval("Id").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" HeaderText="Base charge System Id1" ItemStyle-Wrap="false" UniqueName="BaseChargeId" DataField="BaseChargeId"
                SortExpression="BaseChargeId" Groupable="false" GroupByExpression="BaseChargeId [GridColumn_BaseChargeId] Group By BaseChargeId ASC"
                Reorderable="true" AllowFiltering="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# IIF(CInt(Eval("BaseChargeId").ToString) = 0 ,"&nbsp;" ,Eval("BaseChargeId").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%# Eval("BaseChargeId")%></span>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field1" AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                Groupable="false">
                <ItemTemplate>
                    <uc1:AssetUserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:AssetUserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 AND (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="ChargeSave" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="ChargeSave" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
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
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 AND (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddCharges" CssClass="GridCmdAddCharges"
                    OnClientClick="javascript:return ChargesPopup();"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 AND (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label3" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRecur" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="RecurCharges" CssClass="GridCmdRecurCharges"
                    OnClientClick="javascript:return OpenGenerateRecurringChargesPopup();"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 AND (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label5" runat="server" Text="Recur" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 And (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="LinkButton2" CausesValidation="False" SecurityButtonType="ItemMode" OnClientClick="javascript:return OpenLeaseAnalyzer();" CssClass="GridCmdAnalyzeLease"
                    Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 And (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="AnalyzeLease" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label4" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
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
                                                            <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkUserUnits_OnChekedChanged" CssClass="chkMore" ID="ckbUseUnits" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                </span>
                <span style="width: 100%; text-align: right">
                                                            <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkHiderecurrences_OnChekedChanged" CssClass="chkMore" ID="chkHideRecurrences" Text="Hide Recurrences" meta:resourcekey="chkHideRecurrences" SecurityButtonType="ItemMode_Edit" />
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