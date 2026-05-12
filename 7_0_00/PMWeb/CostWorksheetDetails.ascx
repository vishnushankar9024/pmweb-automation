<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostWorksheetDetails.ascx.vb"
    Inherits="Website.CostWorksheetDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style>
    .WorksheetHeader > input.rgOptions {
        float: right !important;
        margin-top: -21px !important;
    }

    .WorksheetHeaderWithoutFilterCustomize {
        padding: 0px !important;
        margin: 0px !important;
        height: 50px;
    }

        .WorksheetHeaderWithoutFilter > input.rgOptions,
        .WorksheetHeaderWithoutFilterCustomize > input.rgOptions {
            display: none !important;
        }

    .RadGrid_Default .rgCollapse {
        background-image: url('CSS/Images/PlusMinusWhite.png') !important;
        background-position: 0px -11px !important;
        width: 8px;
        height: 11px;
        right: 3px;
        position: relative;
    }

    input[type="submit"].rgExpand:hover, input[type="submit"].rgCollapse:hover {
        background-color: #afafaf !important;
    }

    @media screen and (min-width:846px) {
        .RadGrid .rgDataDiv {
            height: calc(100vh - 345px) !important;
             overflow: auto !important;
        }
    }

    @media screen and (max-width:845px) {
        .RadGrid .rgDataDiv {
            height: calc(100vh - 403px) !important;
            overflow: auto !important;
        }
    }
</style>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCostWS">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostWS" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="PMMainPage">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgCostWS" runat="server" CssClass="WithoutTopBorder " FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" AllowPaging="false" SetWidth="true" AppendMenus="true" ClientSettings-Resizing-AllowResizeToFit="true"
                ShowFooter="True" ShowGroupPanel="True" PageSize="20" AllowMultiRowSelection="True" EnableGroupsExpandAll="true" EnableHierarchyExpandAll="true" ClientSettings-Scrolling-ScrollHeight="300px"
                AllowSorting="True" GridLines="None" ClientSettings-ClientEvents-OnGridCreated="rdgCostWS_OnGridCreated" ClientSettings-Scrolling-AllowScroll="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="<%$Resources:PMWeb, Grid_GroupPanel %>">
                </GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="CostCodeId" Name="WorksheetCostLedgers" CommandItemDisplay="Top"
                    UseAllDataFields="true" GroupLoadMode="Client" HierarchyDefaultExpanded="false">
                    <Columns>
                    </Columns>
                    <HeaderStyle Wrap="false" />
                    <ItemStyle Wrap="false" />
                    <DetailTables>
                        <telerik:GridTableView SkinID="PM" ShowHeader="false" ShowFooter="false" AllowSorting="false"
                            AllowPaging="false" DataKeyNames="Id, CostCodeId,Name" Name="WorksheetSections"
                            CssClass="WorksheetSection" Width="100%">
                            <ParentTableRelation>
                                <telerik:GridRelationFields DetailKeyField="CostCodeId" MasterKeyField="CostCodeId" />
                            </ParentTableRelation>
                            <Columns>
                                <telerik:GridBoundColumn DataField="Description" HeaderStyle-Width="150px">
                                    <ItemStyle CssClass="WorksheetSectionTitle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="SectionFilter">
                                    <ItemTemplate>
                                        &nbsp;
                            <asp:Panel ID="pnlFilters" runat="server" Visible="false" Style="display: inline; width: 100%!important; height: 90%;">
                                <asp:Label ID="lblDisplay" meta:resourcekey="lblDisplay" runat="server" Text="Display"></asp:Label>
                                &nbsp;&nbsp;
                                <telerik:RadComboBox ID="ddlDisplay" runat="server" Width="150px" AutoPostBack="true"
                                    Skin="Default" Style="font-size: 11px; width: 150px !important;" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    OnSelectedIndexChanged="ddlDisplay_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="WorksheetSectionFilter" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <DetailTables>
                                <telerik:GridTableView NoMasterRecordsText="" TableLayout="Fixed" DataKeyNames="Id"
                                    AllowSorting="true" ShowHeader="true" Width="100%" Name="WorksheetDetails" CssClass="WorksheetDetails"
                                    PageSize="10">
                                    <ParentTableRelation>
                                        <telerik:GridRelationFields DetailKeyField="SectionId" MasterKeyField="Id" />
                                    </ParentTableRelation>
                                    <Columns>
                                        <telerik:GridTemplateColumn Groupable="false" AllowFiltering="false" HeaderText="Approved" UniqueName="Approved" meta:Resourcekey="GridColumn_Approved">
                                            <ItemTemplate>
                                                <div class="<%# CStr(IIf(Eval("StatusId") = CInt(Library.Common.Utilities.CostLedgerStatus.Approved), "CheckedDefault", "EmptyButton")) %>">
                                                    <span class="Icon"></span>
                                                </div>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px" />
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Document Type" SortExpression="DocumentType"
                                            DataField="DocumentType" meta:Resourcekey="GridColumn_DocumentType" UniqueName="DocumentType"
                                            Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("DocumentType") = String.Empty, "&nbsp;", Container.DataItem("DocumentType"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="DocumentId" HeaderText="Document ID" SortExpression="DocumentId"
                                            DataField="DocumentId" meta:Resourcekey="GridColumn_DocumentId" Groupable="false">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hliDocumentId" runat="server" Text='<%#IIf(Eval("DocumentTypeId") = 0, "&nbsp;", CStr(IIf(Eval("DocumentTypeId") = 14, CStr(Eval("DocumentType")), CStr(Eval("DocumentId"))))) %>'
                                                    NavigateUrl='<%#Eval("DocumentPage") %>'></asp:HyperLink>
                                                <asp:Label ID="lblDocumentId" runat="server" Text='<%#IIf(Eval("DocumentTypeId") = 0, "&nbsp;", CStr(IIf(Eval("DocumentTypeId") = 14, CStr(Eval("DocumentType")), CStr(Eval("DocumentId"))))) %>'
                                                    Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Date" meta:Resourcekey="GridColumn_Date" CurrentFilterFunction="EqualTo"
                                            DataField="CreateDate" UniqueName="CreateDate" SortExpression="CreateDate" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#If(Container.DataItem("CreateDate") Is DBNull.Value, "&nbsp;", FormatDate(CDate(Container.DataItem("CreateDate"))))%></span>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" meta:Resourcekey="GridColumn_Description"
                                            DataField="Description" UniqueName="Description" SortExpression="Description"
                                            Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="UOM" meta:Resourcekey="GridColumn_UOM" SortExpression="UOM"
                                            DataField="UOM" UniqueName="UOM" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Quantity" meta:Resourcekey="GridColumn_Quantity"
                                            DataField="Quantity" SortExpression="Quantity" UniqueName="Quantity" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#FormatNumber(Container.DataItem("Quantity"))%></span>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right" />
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Unit Cost" meta:Resourcekey="GridColumn_UnitCost"
                                            DataField="UnitCost" SortExpression="UnitCost" UniqueName="UnitCost" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotalText" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <HeaderStyle Width="200px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Total Amount" meta:Resourcekey="GridColumn_TotalAmount"
                                            DataField="TotalAmount" SortExpression="TotalAmount" UniqueName="TotalAmount"
                                            Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#FormatCurrency(Container.DataItem("TotalAmount"))%></span>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <HeaderStyle Width="200px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Document" meta:Resourcekey="GridColumn_Document"
                                            DataField="Document" UniqueName="Document" SortExpression="Document" Groupable="false">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("Document") = String.Empty, "&nbsp;", Container.DataItem("Document"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Ledger ID" meta:Resourcekey="GridColumn_CostLedgerId"
                                            DataField="CostLedgerId" UniqueName="CostLedgerId" SortExpression="CostLedgerId"
                                            Groupable="false">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hliLedgerId" runat="server" NavigateUrl='<%#Eval("CostLedgerPage") %>'
                                                    Text='<%# CStr(Eval("CostLedgerId"))%>'></asp:HyperLink>
                                                <asp:Label ID="lblLedgerId" runat="server" Text='<%# CStr(Eval("CostLedgerId"))%>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                </telerik:GridTableView>
                            </DetailTables>
                        </telerik:GridTableView>
                    </DetailTables>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add" CssClass="GridCmdAdd" OnClientClick="javascript:return OpenCostWorksheetEntryPopup();"
                            SecurityButtonType="ItemMode_Add" meta:resourcekey="btnAddResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnRefresh" Style="display: none" runat="server" CausesValidation="False"
                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode" meta:resourcekey="btnRefreshResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnExportExcel" runat="server"
                            SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                            Visible='<%# rdgCostWS.EditIndexes.Count = 0 And (Not rdgCostWS.MasterTableView.IsItemInserted)%>'>
                            <span class="Icon"></span>
                            <asp:Label ID="Label12" Text="Export To Exel" runat="server"></asp:Label>
                            &nbsp;&nbsp
                        </asp:LinkButton>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Wrap="false" />
                <ItemStyle Wrap="false" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" ColumnsReorderMethod="Reorder"
                    AllowExpandCollapse="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
                    OpenInNewWindow="true">
                </ExportSettings>
                <GroupingSettings RetainGroupFootersVisibility="true" />
                <HierarchySettings CollapseAllTooltip="CollapseAllTooltip" ExpandAllTooltip="ExpandAllTooltip" ExpandTooltip="ExpandTooltip" CollapseTooltip="CollapseTooltip" SelfCollapseTooltip="SelfCollapseTooltip" SelfExpandTooltip="SelfExpandTooltip" />

            </telerik:RadGrid>
        </div>
    </div>
</div>

