<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagersViewExportedFiles.ascx.vb" Inherits="Website.IntegrationManagersViewExportedFiles" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSentFiles">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSentFiles" LoadingPanelID="ldpPM" /> 
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgSentFiles" runat="server"  CssClass="WithoutTopBorder"
     AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="25" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
    ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>
         <telerik:GridTemplateColumn HeaderText="Sent" GroupByExpression="Sent [GridColumn_Sent] Group By Sent ASC"
         ItemStyle-HorizontalAlign="Right" SortExpression="Sent" UniqueName="Sent" DataField="Sent"  >
                <ItemTemplate>
                    <span>
                         <%#IIf(Container.DataItem("Sent").ToString = String.Empty, "&nbsp;", FormatDate(Container.DataItem("Sent")) + " " + FormatTime(Container.DataItem("Sent")))%></span> 
                </ItemTemplate>
             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <HeaderStyle Width="149px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="File Name" SortExpression="FileName" UniqueName="FileName" DataField="FileName"
                GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("FileName") = String.Empty, "&nbsp;", Container.DataItem("FileName"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="226px"></HeaderStyle>
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                UniqueName="RecordType" SortExpression="RecordType" DataField="RecordType">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="228px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn HeaderText="File Size" GroupByExpression="FileSize [GridColumn_FileSize] Group By FileSize ASC"
                UniqueName="FileSize" SortExpression="FileSize" DataField="FileSize" datatype="double">
                <ItemTemplate>
                      <span> <%#FormatNumber(Container.DataItem("FileSize"))%> &nbsp; KB</span></ItemTemplate>
                <HeaderStyle Width="235px"></HeaderStyle>
                      <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Enable Auto Send" UniqueName="EnableAutoSend" HeaderStyle-Width="233px" DataField="EnableAutoSend"
                ItemStyle-Wrap="false" SortExpression="EnableAutoSend" GroupByExpression="EnableAutoSend [GridColumn_EnableAutoSend] Group By EnableAutoSend ASC"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("EnableAutoSend"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
          
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete"
                    Visible='<%# rdgSentFiles.EditIndexes.Count = 0 AND (Not rdgSentFiles.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                    CommandName="RebindGrid" Visible='<%# rdgSentFiles.EditIndexes.Count = 0 And (Not rdgSentFiles.MasterTableView.IsItemInserted)%>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                    EnableShadows="true" CausesValidation="false"
                    Visible="true">
                </telerik:RadMenu>
            </div>
        </CommandItemTemplate>
        <ItemStyle Wrap="false" />
    </MasterTableView>
    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="True">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
    </ClientSettings>
</telerik:RadGrid>
