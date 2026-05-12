<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetComponents.ascx.vb" Inherits="Website.AssetComponents" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="TreeListComponents.ascx" TagName="TreeListComponents" TagPrefix="uc3" %>
<%@ Register Src="TreeListLinearComponents.ascx" TagName="TreeListLinearComponents" TagPrefix="uc2" %>
<%@ Register Src="AssetUserDefinedFields.ascx" TagName="AssetUserDefinedFields" TagPrefix="uc1" %>

<style type="text/css">
    a:link {
        text-decoration: none;
    }

    .tblCommandRow a, .tblCommandRow a:visited, .tblCommandRow a:active {
    font-size: 12px;
    cursor: pointer;
    color: #666666 !important;
}
</style>


<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEquComponents">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquComponents" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnDeleteComponents">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquComponents" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnDeleteAndReturnQuantity">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquComponents" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents" />
                <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnGenerateWorkOrder">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquComponents" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnGenerateWorkOrder" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12" id="tblComponents" runat="server">
            <telerik:RadGrid ID="rdgEquComponents" runat="server" CssClass="WithoutTopBorder RDGAssetsGrid" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="250" setWidth="true" appendMenus="true" allow-scroll="true"
                ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="InventoryStockId,Id,InventoryQuantityReturned" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" AllowFiltering="false"
                            SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>'></asp:Label>
                                <asp:HiddenField runat="server" ID="hdnCurrentUsage"></asp:HiddenField>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" AllowFiltering="false"
                            Groupable="True" Reorderable="true" UniqueName="RecordNumber"
                            GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                            <ItemTemplate>
                                <%#Container.DataItem("RecordNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRecordNumber" runat="server" Width="100%"
                                    MaxLength="100" Text='<%#Eval("RecordNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset ID" UniqueName="AssetId" DataField="AssetId"
                            SortExpression="AssetId" GroupByExpression="AssetId [GridColumn_AssetId] Group By AssetId ASC"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("EquipmentPostBackUrl").ToString%>'></asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HyperLink ID="hliAssetEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("EquipmentPostBackUrl").ToString%>'></asp:HyperLink>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Component Type" UniqueName="ComponentType" SortExpression="ComponentType" DataField="ComponentType"
                            GroupByExpression="ComponentType [GridColumn_ComponentType] Group By ComponentType ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("ComponentType") = String.Empty, "&nbsp;", Container.DataItem("ComponentType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlComponentTypes" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="left" UniqueName="Description" DataField="Description"
                            HeaderStyle-Width="190px" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="4000" runat="server" Text='<%# Eval("Description") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Condition" UniqueName="Condition" SortExpression="Condition" DataField="Condition"
                            GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Condition") = String.Empty, "&nbsp;", Container.DataItem("Condition"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAssetConditions" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Condition Date" UniqueName="ConditionDate" DataField="ConditionDate"
                            ItemStyle-HorizontalAlign="left" GroupByExpression="ConditionDate [GridColumn_ConditionDate] Group By ConditionDate ASC"
                            SortExpression="ConditionDate" HeaderStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("ConditionDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpConditionDate" MinDate="01/01/1901"
                                    MaxDate="12/31/2100" runat="server" Skin="Default" Width="100%">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Last WO" UniqueName="LastWOId" AllowFiltering="false"
                            SortExpression="LastWOId" GroupByExpression="LastWOId [GridColumn_LastWOId] Group By LastWOId ASC"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliLastWo" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#Eval("LastWOId").ToString%>' NavigateUrl='<%#Eval("LastWoPostbackUrl").ToString%>'></asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HyperLink ID="hliLastWOEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#Eval("LastWOId").ToString%>' NavigateUrl='<%#Eval("LastWoPostbackUrl").ToString%>'></asp:HyperLink>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Life Remaining" UniqueName="LifeRemaining" DataField="LifeRemaining"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="LifeRemaining [GridColumn_LifeRemaining] Group By LifeRemaining ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="LifeRemaining">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLifeRemaining" Text='<%#FormatNumber(Container.DataItem("LifeRemaining"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblLifeRemaining" Text='<%#FormatNumber(IIf(Eval("LifeRemaining") Is System.DBNull.Value, "0", Eval("LifeRemaining"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="% Remaining" UniqueName="RemainingPercentage" DataField="RemainingPercentage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RemainingPercentage [GridColumn_RemainingPercentage] Group By RemainingPercentage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="RemainingPercentage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRemainingPercentage" Text='<%#FormatPercent(Container.DataItem("RemainingPercentage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblRemainingPercentage" Text='<%#FormatPercent(IIf(Eval("RemainingPercentage") Is System.DBNull.Value, "0", Eval("RemainingPercentage"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Service Interval Usage" UniqueName="ServiceIntervalUsage" DataField="ServiceIntervalUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="ServiceIntervalUsage [GridColumn_ServiceIntervalUsage] Group By ServiceIntervalUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="ServiceIntervalUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblServiceIntervalUsage" Text='<%#FormatNumber(Container.DataItem("ServiceIntervalUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtServiceIntervalUsage" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("ServiceIntervalUsage") Is System.DBNull.Value, "0", Eval("ServiceIntervalUsage"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Installed Usage" UniqueName="InstalledUsage" DataField="InstalledUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="InstalledUsage [GridColumn_InstalledUsage] Group By InstalledUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="InstalledUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblInstalledUsage" Text='<%#FormatNumber(Container.DataItem("InstalledUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtInstalledUsage" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("InstalledUsage") Is System.DBNull.Value, "0", Eval("InstalledUsage"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Service Usage" UniqueName="LastServiceUsage" DataField="LastServiceUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="LastServiceUsage [GridColumn_LastServiceUsage] Group By LastServiceUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="LastServiceUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLastServiceUsage" Text='<%#FormatNumber(Container.DataItem("LastServiceUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLastServiceUsage" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("LastServiceUsage") Is System.DBNull.Value, "0", Eval("LastServiceUsage"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Service Due Usage" UniqueName="ServiceDueUsage" DataField="ServiceDueUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="ServiceDueUsage [GridColumn_ServiceDueUsage] Group By ServiceDueUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="ServiceDueUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblServiceDueUsage" Text='<%#FormatNumber(Container.DataItem("ServiceDueUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblServiceDueUsage" Text='<%#FormatNumber(IIf(Eval("ServiceDueUsage") Is System.DBNull.Value, "0", Eval("ServiceDueUsage"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Life to Date Usage" UniqueName="LifeToDateUsage" DataField="LifeToDateUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="LifeToDateUsage [GridColumn_LifeToDateUsage] Group By LifeToDateUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="LifeToDateUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLifeToDateUsage" Text='<%#FormatNumber(Container.DataItem("LifeToDateUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblLifeToDateUsage"
                                    Text='<%#FormatNumber(IIf(Eval("LifeToDateUsage") Is System.DBNull.Value, "0", Eval("LifeToDateUsage"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Service by Days" SortExpression="ServiceByDays" UniqueName="ServiceByDays" DataField="ServiceByDays"
                            GroupByExpression="ServiceByDays [GridColumn_ServiceByDays] Group By ServiceByDays ASC">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkServiceByDays" runat="server" Checked='<%# CBool(IIf(Eval("ServiceByDays") Is System.DBNull.Value, 0, Eval("ServiceByDays"))) %>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIf(Container.DataItem("ServiceByDays"), "checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Service Interval Days" UniqueName="ServiceIntervalDays" DataField="ServiceIntervalDays"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="ServiceIntervalDays [GridColumn_ServiceIntervalDays] Group By ServiceIntervalDays ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="ServiceIntervalDays">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblServiceIntervalDays" Text='<%#FormatNumber(Container.DataItem("ServiceIntervalDays"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtServiceIntervalDays" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("ServiceIntervalDays") Is System.DBNull.Value, "0", Eval("ServiceIntervalDays"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn> 

                        <telerik:GridTemplateColumn HeaderText="Installed Date" UniqueName="InstalledDate" DataField="InstalledDate"
                            ItemStyle-HorizontalAlign="left" GroupByExpression="InstalledDate [GridColumn_InstalledDate] Group By InstalledDate ASC"
                            SortExpression="InstalledDate" HeaderStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("InstalledDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpInstalledDate" MinDate="01/01/1901"
                                    MaxDate="12/31/2100" runat="server" Skin="Default" Width="100%">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <ClientEvents OnDateSelected="InstalledDateSelected" />
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Service Date" UniqueName="LastServiceDate" DataField="LastServiceDate"
                            ItemStyle-HorizontalAlign="left" GroupByExpression="LastServiceDate [GridColumn_LastServiceDate] Group By LastServiceDate ASC"
                            SortExpression="LastServiceDate" HeaderStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("LastServiceDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpLastServiceDate" MinDate="01/01/1901"
                                    runat="server" Skin="Default" Width="100%">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <ClientEvents OnDateSelected="LastServiceDate" />
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Service Due Date" UniqueName="ServiceDueDate" DataField="ServiceDueDate"
                            ItemStyle-HorizontalAlign="left" GroupByExpression="ServiceDueDate [GridColumn_ServiceDueDate] Group By ServiceDueDate ASC"
                            SortExpression="ServiceDueDate" HeaderStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("ServiceDueDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpServiceDueDate" MaxDate="1-1-3000"
                                    runat="server" Skin="Default" Width="100%">
                                    <DateInput ReadOnly="true" CssClass="ReadOnlyCalendar"></DateInput>
                                    <Calendar Visible="false"></Calendar>
                                    <DatePopupButton Visible="false" />
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Life to Date Days" UniqueName="LifeToDateDays" DataField="LifeToDateDays"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="LifeToDateDays [GridColumn_LifeToDateDays] Group By LifeToDateDays ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="LifeToDateDays">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLifeToDateDays1" Text='<%#FormatNumber(Container.DataItem("LifeToDateDays"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblLifeToDateDays" Text='<%#FormatNumber(IIf(Eval("LifeToDateDays") Is System.DBNull.Value, "0", Eval("LifeToDateDays"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Removed Usage" UniqueName="RemovedUsage" DataField="RemovedUsage"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RemovedUsage [GridColumn_RemovedUsage] Group By RemovedUsage ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="RemovedUsage">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRemovedUsage" Text='<%#FormatNumber(Container.DataItem("RemovedUsage"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRemovedUsage" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("RemovedUsage") Is System.DBNull.Value, "0", Eval("RemovedUsage"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Removed Date" UniqueName="RemovedDate" DataField="RemovedDate"
                            ItemStyle-HorizontalAlign="left" GroupByExpression="RemovedDate [GridColumn_RemovedDate] Group By RemovedDate ASC"
                            SortExpression="RemovedDate" HeaderStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("RemovedDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpRemovedDate" MinDate="01/01/1901"
                                    MaxDate="12/31/2100" runat="server" Skin="Default" Width="100%">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <ClientEvents OnDateSelected="RemovedDateSelected" />
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" SortExpression="Manufacturer" DataField="Manufacturer"
                            GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlManufacturers"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="400px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Mfr. #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="ManufacturerNumber"
                            Groupable="True" Reorderable="true" UniqueName="ManufacturerNumber" SortExpression="ManufacturerNumber"
                            GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber ASC">
                            <ItemTemplate>
                                <%#Container.DataItem("ManufacturerNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtManufacturerNumber" runat="server" Width="100%"
                                    MaxLength="100" Text='<%#Eval("ManufacturerNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity UOM" UniqueName="QuantityUOM" SortExpression="QuantityUOM" DataField="QuantityUOM"
                            GroupByExpression="QuantityUOM [GridColumn_QuantityUOM] Group By QuantityUOM ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("QuantityUOM") = String.Empty, "&nbsp;", Container.DataItem("QuantityUOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlQuantityUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right" DataField="Quantity"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC" DataField="UnitCost"
                            SortExpression="UnitCost">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC" DataField="TotalCost"
                            SortExpression="TotalCost">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalCost"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblTotalCost" runat="server" Text='<%# FormatCurrency(Eval("TotalCost")) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Begin" UniqueName="Begin" DataField="Begin"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="Begin [GridColumn_Begin] Group By Begin ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="Begin">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblBegin" Text='<%#FormatNumber(Container.DataItem("Begin"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBegin" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Begin") Is System.DBNull.Value, "0", Eval("Begin"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="End" UniqueName="End" DataField="End"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="End [GridColumn_End] Group By End ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="End">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblEnd" Text='<%#FormatNumber(Container.DataItem("End"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEnd" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("End") Is System.DBNull.Value, "0", Eval("End"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Length" UniqueName="Length" DataField="Length"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="Length [GridColumn_Length] Group By Length ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="Length">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLength" Text='<%#FormatNumber(Container.DataItem("Length"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLength" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Length") Is System.DBNull.Value, "0", Eval("Length"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Direction" UniqueName="Direction" SortExpression="Direction" DataField="Direction"
                            GroupByExpression="Direction [GridColumn_Direction] Group By Direction ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Direction") = String.Empty, "&nbsp;", Container.DataItem("Direction"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlDirections" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Lateral Offset" UniqueName="LateralOffset" DataField="LateralOffset"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="LateralOffset [GridColumn_LateralOffset] Group By LateralOffset ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="LateralOffset">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLateralOffset" Text='<%#FormatNumber(Container.DataItem("LateralOffset"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLateralOffset" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("LateralOffset") Is System.DBNull.Value, "0", Eval("LateralOffset"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="LO UOM" UniqueName="LateralOffsetUOM" SortExpression="LateralOffsetUOM" DataField="LateralOffsetUOM"
                            GroupByExpression="LateralOffsetUOM [GridColumn_LateralOffsetUOM] Group By LateralOffsetUOM ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("LateralOffsetUOM") = String.Empty, "&nbsp;", Container.DataItem("LateralOffsetUOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLateralOffsetUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Vertical Offset" UniqueName="VerticalOffset" DataField="VerticalOffset"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="VerticalOffset [GridColumn_VerticalOffset] Group By VerticalOffset ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="VerticalOffset">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblVerticalOffset" Text='<%#FormatNumber(Container.DataItem("VerticalOffset"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtVerticalOffset" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("VerticalOffset") Is System.DBNull.Value, "0", Eval("VerticalOffset"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="VO UOM" UniqueName="VerticalOffsetUOM" SortExpression="VerticalOffsetUOM" DataField="VerticalOffsetUOM"
                            GroupByExpression="VerticalOffsetUOM [GridColumn_VerticalOffsetUOM] Group By VerticalOffsetUOM ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("VerticalOffsetUOM") = String.Empty, "&nbsp;", Container.DataItem("VerticalOffsetUOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlVerticalOffsetUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Radial Offset" UniqueName="RadialOffset" DataField="RadialOffset"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RadialOffset [GridColumn_RadialOffset] Group By RadialOffset ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="RadialOffset">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRadialOffset" Text='<%#FormatNumber(Container.DataItem("RadialOffset"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRadialOffset" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("RadialOffset") Is System.DBNull.Value, "0", Eval("RadialOffset"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Latitude" UniqueName="Latitude" DataField="Latitude"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="Latitude [GridColumn_Latitude] Group By Latitude ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="Latitude">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCompLatitude" Text='<%#IIf(FormatLongtitude(Container.DataItem("Latitude"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Latitude"), false))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLatitude" runat="server" Width="100%" CssClass="Longtitude"
                                    MaxLength="25" Text='<%#FormatLongtitude(IIf(Eval("Latitude") Is System.DBNull.Value, "0", Eval("Latitude")), True) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Longitude" UniqueName="Longitude" DataField="Longitude"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="Longitude [GridColumn_Longitude] Group By Longitude ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="Longitude">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCompLongitude" Text='<%#IIf(FormatLongtitude(Container.DataItem("Longitude"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Longitude"), false))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLongitude" runat="server" Width="100%" CssClass="Longtitude"
                                    MaxLength="25" Text='<%#FormatLongtitude(IIf(Eval("Longitude") Is System.DBNull.Value, "0", Eval("Longitude")), True) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Elevation" UniqueName="Elevation" DataField="Elevation"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="Elevation [GridColumn_Elevation] Group By Elevation ASC"
                            HeaderStyle-HorizontalAlign="left" SortExpression="Elevation">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCompElevation" Text='<%#IIf(FormatLongtitude(Container.DataItem("Elevation"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Elevation"), false))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtElevation" runat="server" Width="100%" CssClass="Longtitude"
                                    MaxLength="25" Text='<%#FormatLongtitude(IIf(Eval("Elevation") Is System.DBNull.Value, "0", Eval("Elevation")), True) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Asset Type" UniqueName="AssetType" SortExpression="AssetType" DataField="AssetType"
                            GroupByExpression="AssetType [GridColumn_AssetType] Group By AssetType ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblAssetType" runat="server" Text='<%#IIf(Container.DataItem("AssetType") = String.Empty, "&nbsp;", Container.DataItem("AssetType"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblAssetType1" runat="server" Text='<%#IIf(Eval("AssetType") is system.DBNULL.value ORELSE Eval("AssetType") = String.Empty, "&nbsp;", Eval("AssetType"))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemId" DataField="ItemId"
                            SortExpression="ItemId" GroupByExpression="ItemId [GridColumn_ItemId] Group By ItemId ASC"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliItem" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block; text-decoration: underline;"
                                    Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                                <asp:Label runat="server" Text='<%#Eval("ItemId")%>' ID="lblItem"></asp:Label>&nbsp;
                  
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HyperLink ID="hliItemEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                                <asp:Label runat="server" Text='<%#Eval("ItemId")%>' ID="lblItemEdit"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Stock #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="InventoryPostbackUrl"
                            Groupable="True" Reorderable="true" UniqueName="StockNumber" SortExpression="StockNumber"
                            GroupByExpression="StockNumber [GridColumn_StockNumber] Group By StockNumber ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hlistock" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block; text-decoration: underline;"
                                    Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
                                <asp:Label runat="server" Text="&nbsp;" ID="lblstock"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HyperLink ID="hlistockEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block; text-decoration: underline;"
                                    Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
                                <asp:Label runat="server" Text="&nbsp;" ID="lblstockdit"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Serial #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="SerialNumber"
                            Groupable="True" Reorderable="true" UniqueName="SerialNumber" SortExpression="SerialNumber"
                            GroupByExpression="SerialNumber [GridColumn_SerialNumber] Group By SerialNumber ASC">
                            <ItemTemplate>
                                <%#Container.DataItem("SerialNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSerialNumber" runat="server" Width="100%"
                                    MaxLength="100" Text='<%#Eval("SerialNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Lot #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="LotNumber"
                            Groupable="True" Reorderable="true" UniqueName="LotNumber" SortExpression="LotNumber"
                            GroupByExpression="LotNumber [GridColumn_LotNumber] Group By LotNumber ASC">
                            <ItemTemplate>
                                <%#Container.DataItem("LotNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLotNumber" runat="server" Width="100%"
                                    MaxLength="100" Text='<%#Eval("LotNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" DataField="Notes"
                            UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					<span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
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
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="right" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgEquComponents.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgEquComponents.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgEquComponents.EditIndexes.Count > 0 Or rdgEquComponents.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return DeleteComponentLines();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode_Add" CssClass="GridCmdAddItems"
                                Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenComponentItemPopup();">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPickInventory" runat="server" CommandName="PickInventory" OnClientClick="return OpenPOPUp('PickInventory.aspx?Id=1',900, 600,true,'rdgEquComponents');"
                                SecurityButtonType="ItemMode_Add" CssClass="GridCmdPickInventory"
                                Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPickInventory" meta:resourceKey="lblPickInventory" runat="server" Text="Pick Inventory"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnlinkAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdlinkAsset" CommandName="linkAsset" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=5',1035, 710,true,'rdgEquComponents');"
                                Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <span>
                            <asp:LinkButton ID="btnCreateWorkOrder" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdCreateWorkOrder" CommandName="CreateWorkOrder" OnClientClick="return OpenGenerateWorkOrderPopup('GenerateWorkOrderPopup.aspx',450, 310);"
                                Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblCreateWorkOrder" Text="Create Work Order"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            </span>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <span>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                                </span>
                            <span>
                            <asp:LinkButton ID="btnTreeListView" runat="server" CausesValidation="False" CommandName="TreeListView" CssClass="GridCmdTreeListView" OnClientClick="return ClickSwitchComponentsButton()"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquComponents.EditIndexes.Count = 0 And (Not rdgEquComponents.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnTreeListView">
                                <span class="Icon"></span>
                                <asp:Label ID="lblTreeListView" runat="server" Text="Tree List View" meta:resourcekey="lblTreeListView"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            </span>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
        <asp:HiddenField runat="server" ID="hdnComponentTodayDate"></asp:HiddenField>
        <asp:Button runat="server" ID="btnDeleteAndReturnQuantity" CssClass="Hide" />
        <asp:Button runat="server" ID="btnDeleteComponents" CssClass="Hide" />

        <div class="col-12">
            <table id="tblTreelistComponents" runat="server" cellpadding="0" cellspacing="0" visible="False">
                <tr>
                    <td>
                        <uc3:TreeListComponents ID="TreeListComponents1" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-12">
            <table id="tblTreeListLinearComponents" runat="server" cellpadding="0" cellspacing="0" visible="False">
                <tr>
                    <td>
                        <uc2:TreeListLinearComponents ID="TreeListLinearComponents1" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>


<asp:Button ID="btnGenerateWorkOrder" runat="server" CssClass="Hide" />