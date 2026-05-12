<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="WorkflowInbox.aspx.vb" Inherits="Website.WorkflowInbox" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgWorkflowInbox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgWorkflowInbox" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpInbox" runat="server" Skin="Default" />

    <telerik:RadGrid ID="rdgWorkflowInbox" runat="server" Skin="Default" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True" SetWidth="true"
        Width="100%" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True" AllowFilteringByColumn="true" EnableEmbeddedBaseStylesheet="false" EnableEmbeddedSkins="false"
        ShowStatusBar="True" GridLines="None" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" ClientSettings-Scrolling-AllowScroll="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" GroupLoadMode="Client" TableLayout="Fixed"
            Width="100%">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Document Id" UniqueName="DocumentId" Groupable="false" Reorderable="true"
                    SortExpression="RecordNumber" meta:resourcekey="GridColumn_DocumentId" CurrentFilterFunction="EqualTo" DataField="RecordNumber" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <a href='<%#IIf(PM.WORKFLOW_LINK_REDIRECT_MAINTAB, Container.DataItem("MainPage"), Container.DataItem("MainPage") & "&Workflow=O") %>'>
                            <%# Container.DataItem("RecordNumber") %></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Program" UniqueName="ProgramName" GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC"
                    SortExpression="ProgramName" CurrentFilterFunction="Contains" Reorderable="true" DataField="ProgramName" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("ProgramName")%></span> &nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Document Type" UniqueName="RecordType" Reorderable="true" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                    SortExpression="RecordType" CurrentFilterFunction="Contains" DataField="RecordType" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("RecordType")%></span>&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" Reorderable="true" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                    SortExpression="Project" CurrentFilterFunction="Contains" DataField="Project" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("Project")%></span>&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Property" UniqueName="PropertyName" Reorderable="true" GroupByExpression="PropertyName [GridColumn_PropertyName] Group By PropertyName ASC"
                    SortExpression="PropertyName" CurrentFilterFunction="Contains" DataField="PropertyName" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("PropertyName")%></span>&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" Reorderable="true" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                    SortExpression="Description" CurrentFilterFunction="Contains" DataField="Description" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("Description")%></span>&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                    UniqueName="Status" SortExpression="Status" Reorderable="true" CurrentFilterFunction="Contains" DataField="Status" DataType="System.String" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("Status")%></span> &nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Step" GroupByExpression="StepNumber [GridColumn_StepNumber] Group By StepNumber ASC"
                    UniqueName="StepNumber" SortExpression="StepNumber" Reorderable="true" CurrentFilterFunction="EqualTo" DataField="StepNumber" DataType="System.Int64" FilterListOptions="VaryByDataType">
                    <ItemTemplate>
                        <span>
                            <%#String.Format(GetGlobalResourceObject("Workflow", "WorkflowStepNumber"), Container.DataItem("StepNumber"), Container.DataItem("NumberOfSteps"))%></span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DueDate" DataField="DueDate" DataType="System.DateTime"
                    SortExpression="DueDate" GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate ASC"
                    CurrentFilterFunction="EqualTo" Reorderable="true" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Eval("DueDate"))%>
                        </span>&nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
            </Columns>
            <CommandItemTemplate>
                <div style="padding: 2px">
                    &nbsp;&nbsp;
                    <div style="display:inline-block;padding-right:15px;">
                        <b>
                            <asp:Label ID="lblProgram" meta:resourcekey="lblProgram" runat="server"
                                Text="Program"></asp:Label>
                        </b>
                        &nbsp;
                        <telerik:RadComboBox ID="ddlPrograms" runat="server" Skin="Default" DropDownWidth="250px"
                            CausesValidation="false" Filter="Contains" MarkFirstMatch="true" EmptyMessage="Select Program"
                            NoWrap="true" Width="200px" Height="300px" meta:resourcekey="ddlPrograms" EnableLoadOnDemand="true"
                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                        </telerik:RadComboBox>
                    </div>
                    <div style="display:inline-block;padding-right:15px;">
                         <b>
                            <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server"
                                Text="Project"></asp:Label>
                        </b>
                        &nbsp;
                        <telerik:RadComboBox ID="ddlProjects" runat="server" Skin="Default" DropDownWidth="250px"
                            CausesValidation="false" Filter="Contains" MarkFirstMatch="true" EmptyMessage="<%$Resources:CostManagement, WarningMsg_RequiredProject %>"
                            NoWrap="true" Width="200px" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                        </telerik:RadComboBox>
                        <asp:LinkButton ID="btnSearchProject" runat="server" CausesValidation="False" CommandName="SearchProjects" CssClass="GridCmdSearchProjects">
                                <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                    <div style="display:inline-block;padding-right:10px;">
                        <b>
                            <asp:Label ID="lblProperty" meta:resourcekey="lblProperty" runat="server" Text="Property"
                                Style="font-size: 11px"></asp:Label>
                        </b>
                        &nbsp;
                        <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" DropDownWidth="250px"
                            CausesValidation="false" Filter="Contains" MarkFirstMatch="true" EmptyMessage="Select Location"
                            NoWrap="true" Width="200px" Height="300px" meta:resourcekey="ddlProperties" EnableLoadOnDemand="true"
                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                        </telerik:RadComboBox>
                        <asp:LinkButton ID="btnSearchProperty" runat="server" CausesValidation="False" CommandName="SearchProperties" CssClass="GridCmdSearchProperties">
                                <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible="true">
                        <span class="Icon"></span>
                        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
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
        <EditItemStyle Wrap="false" />
        <ItemStyle Wrap="false" />
        <AlternatingItemStyle Wrap="false" />
        <HeaderStyle Font-Size="8pt" Wrap="false" HorizontalAlign="Left" />
        <FooterStyle CssClass="GridFooter" />
        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true"
            ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                AllowColumnResize="True"></Resizing>
        </ClientSettings>
    </telerik:RadGrid>
</asp:Content>
