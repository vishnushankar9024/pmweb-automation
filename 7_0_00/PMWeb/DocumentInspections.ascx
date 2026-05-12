<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentInspections.ascx.vb" Inherits="Website.DocumentInspections" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInspectionDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssetInspections" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
<telerik:RadGrid ID="rdgAssetInspections" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    AutoGenerateColumns="False" ShowStatusBar="False" CssClass="WithoutTopBorder" ClientSettings-AllowColumnsReorder="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
    Font-Size="8px" PageSize="15" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowSorting="True" GridLines="None">

    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="InspectionDetailId" CommandItemDisplay="Top" TableLayout="Fixed"
         UseAllDataFields="true"
        EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Record #" HeaderStyle-Width="60px" UniqueName="RecordNumber" AllowFiltering="false" DataField="RecordNumber"
                HeaderStyle-Wrap="false" Groupable="false" Reorderable="True">
                <ItemTemplate>
                    <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                        Text='<%#IIf(Eval("RecordNumber") Is DBNull.Value OrElse String.IsNullOrEmpty(Eval("RecordNumber")), "", Eval("RecordNumber"))%>' NavigateUrl='<%#IIf(Eval("InspectionPostbackURL") Is DBNull.Value, "", Eval("InspectionPostbackURL"))%>'></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Inspection<br />Description" AllowFiltering="true" UniqueName="InspectionDescription"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="InspectionDescription"
                GroupByExpression="InspectionDescription [GridColumn_InspectionDescription] Group By InspectionDescription">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("InspectionDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("InspectionDescription").ToString)%></span>
                </ItemTemplate>
                <HeaderStyle Width="150px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Date" SortExpression="Date" DataField="Date" AllowFiltering="true"
                UniqueName="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("Date"))%>&nbsp;</span>
                </ItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" DataField="Project"
                SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Project").ToString = String.Empty, "&nbsp;", Container.DataItem("Project").ToString)%></span>
                </ItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="75px" UniqueName="LineNumber" AllowFiltering="true" DataField="LineNumber" SortExpression="LineNumber"
                GroupByExpression="LineNumber [GridColumn_LineNumber] Group By LineNumber ASC">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineNumber")%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Line Description" UniqueName="LineDescription" AllowFiltering="true" DataField="LineDescription" SortExpression="LineDescription"
                HeaderStyle-Wrap="false" GroupByExpression="LineDescription [GridColumn_LineDescription] Group By LineDescription ASC" Reorderable="True">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineDescription")%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Material" SortExpression="Material" UniqueName="Material" DataField="Material"
                GroupByExpression="Material [GridColumn_Material] Group By Material ASC" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Material") = "", "&nbsp;", Container.DataItem("Material"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Condition" SortExpression="Condition" UniqueName="Condition" DataField="Condition"
                GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Condition") = "", "&nbsp;", Container.DataItem("Condition"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Recommend" SortExpression="Recommend" UniqueName="Recommend" DataField="Recommend"
                GroupByExpression="Recommend [GridColumn_Recommend] Group By Recommend ASC" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Recommend") = "", "&nbsp;", Container.DataItem("Recommend"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" UniqueName="Priority" DataField="Priority"
                GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Priority") = "", "&nbsp;", Container.DataItem("Priority"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>


            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" DataField="Notes"
                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>



        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode" Visible='<%# rdgAssetInspections.EditIndexes.Count = 0 And (Not rdgAssetInspections.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                    EnableShadows="true" CausesValidation="false"
                    Visible="true">
                </telerik:RadMenu>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <ClientEvents />
    </ClientSettings>
</telerik:RadGrid>
            </div>
        </div>
    </div>