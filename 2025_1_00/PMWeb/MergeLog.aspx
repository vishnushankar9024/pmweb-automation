<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="MergeLog.aspx.vb" Inherits="Website.MergeLog" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script type="text/javascript">
        function GoToDocument(sender, eventArgs) {
            var postBackURL = eventArgs.getDataKeyValue("PostBackUrl") || "";
            if (postBackURL != "") {
                window.location = eventArgs.getDataKeyValue("PostBackUrl");
            }

        }
    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgMergeLogs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgMergeLogs" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
  <%--  <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:Label ID="lblTitle" meta:Resourcekey="lblTitle" runat="server" Width="200px"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                <Items>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--%>
                <div class="PMHeader" style="padding-top:0px;">
                    <div class="row ">
                        <div class="col-12" style="margin-left:0px;">
                            <table class="colTable" border="0">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgMergeLogs" runat="server"
                                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250"
                                            AllowPaging="True" ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="false"
                                            AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                ClientDataKeyNames="Id,PostBackUrl" DataKeyNames="Id,PostBackUrl" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                                UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                                                EnableHeaderContextMenu="true" TableLayout="Fixed" Width="100%">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-Wrap="false" Groupable="true" SortExpression="ProjectName"
                                                        GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="ProjectName" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Eval("ProjectName")%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Location" UniqueName="LocationName" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-Wrap="false" Groupable="true" SortExpression="LocationName"
                                                        GroupByExpression="LocationName [GridColumn_LocationName] Group By LocationName ASC"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="LocationName" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Eval("LocationName")%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Program" UniqueName="ProgramName" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-Wrap="false" Groupable="true" SortExpression="ProgramName"
                                                        GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="ProgramName" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Eval("ProgramName")%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Template"
                                                        HeaderStyle-Wrap="true" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Template [GridColumn_Template] Group By Template ASC"
                                                        UniqueName="Template" SortExpression="Template"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="Template" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Container.DataItem("Template")%>&nbsp;</span>
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Record Type" HeaderStyle-Width="110px"
                                                        HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                                                        UniqueName="RecordType" SortExpression="RecordType"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="RecordType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Container.DataItem("RecordType")%></span> &nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="115px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="User" HeaderStyle-Width="150px"
                                                        HeaderStyle-Wrap="false" Groupable="true" SortExpression="UserName"
                                                        GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC" UniqueName="UserName"
                                                        CurrentFilterFunction="Contains"
                                                        DataField="UserName" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span><%#Container.DataItem("UserName")%></span> &nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Merge Date" ItemStyle-HorizontalAlign="Right" SortExpression="MergeDate"
                                                        HeaderStyle-Wrap="false" Groupable="true" CurrentFilterFunction="EqualTo"
                                                        GroupByExpression="MergeDate [GridColumn_MergeDate] Group By MergeDate ASC" UniqueName="MergeDate"
                                                        AutoPostBackOnFilter="true" DataType="System.DateTime" DataField="MergeDate" FilterListOptions="VaryByDataType">
                                                        <ItemTemplate>
                                                            <span><%#FormatDate(Eval("MergeDate"))%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                                        <%--           <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>--%>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Record ID" HeaderStyle-Width="125px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-Wrap="false" UniqueName="RecordId" SortExpression="RecordId" Groupable="true" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC"
                                                        AutoPostBackOnFilter="true" DataType="System.Int64" DataField="RecordId" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType">
                                                        <ItemTemplate>
                                                            <span><%#Eval("RecordId")%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="115px"></HeaderStyle>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Record Name" UniqueName="RecordDescription" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="left"
                                                        HeaderStyle-Wrap="false" Groupable="true" SortExpression="RecordDescription"
                                                        GroupByExpression="RecordDescription [GridColumn_RecordDescription] Group By RecordDescription ASC"
                                                        AutoPostBackOnFilter="true" DataType="System.String" DataField="RecordDescription" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                                        <ItemTemplate>
                                                            <span><%#IIf(IsDBNull(Eval("RecordDescription")), "", Eval("RecordDescription"))%></span>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Wrap="False" Width="265px"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="FileName" HeaderStyle-Width="250px" SortExpression="FileName"
                                                        HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC"
                                                        UniqueName="FileName" AutoPostBackOnFilter="true" DataType="System.String" DataField="FullFileName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                                Text=''
                                                                ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                                            <asp:Label Text="Deleted" ID="lblDeleted" meta:resourcekey="lblDeleted" runat="server" ForeColor="Red" Visible='<%# Not Eval("FileExist")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="File Extension" HeaderStyle-Width="120px" SortExpression="FileExtension"
                                                        HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="FileExtension [GridColumn_FileExtension] Group By FileExtension ASC"
                                                        UniqueName="FileExtension" AutoPostBackOnFilter="true" DataType="System.String" DataField="FileExtension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                                        <ItemTemplate>
                                                            <span><%#Eval("FileExtension")%>&nbsp;</span>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                                            SecurityButtonType="ItemMode"
                                                            CommandName="RebindGrid" Visible="true">
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
                                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                                                <ClientEvents OnRowDblClick="GoToDocument" />
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
</asp:Content>
