<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagerRejectionlog.ascx.vb" Inherits="Website.IntegrationManagerRejectionlog" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRejectionLog">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRejectionLog" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgRejectionLog" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
      HeaderStyle-Font-Size="8" AllowMultiRowEdit="True"  CssClass="WithoutTopBorder ResponsiveMargin"
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="25">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
        Name="Master">
   
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Received" HeaderStyle-HorizontalAlign="Center" UniqueName="ReceivedDate" 
                HeaderStyle-Width="200px" SortExpression="ReceivedDate" >
                <ItemTemplate>
                    <span>  <%#IIf(Container.DataItem("ReceivedDate").ToString = String.Empty, "&nbsp;", FormatDate(Container.DataItem("ReceivedDate")) + " " + FormatTime(Container.DataItem("ReceivedDate")))%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="File Name" SortExpression="FileName"  HeaderStyle-Width="300px" UniqueName="FileName" >
                <ItemTemplate>
                     <span><%#IIf(Container.DataItem("FileName") = String.Empty, "&nbsp;", Container.DataItem("FileName"))%></span>
                </ItemTemplate>
            </telerik:GridTemplateColumn>     
            <telerik:GridTemplateColumn HeaderText="File Size" UniqueName="FileSize"  SortExpression="FileSize" HeaderStyle-Width="220px">
                <ItemTemplate>
                   <span> <%#FormatNumber(Container.DataItem("FileSize"))%> &nbsp; KB</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete"
                    Visible='<%# rdgRejectionLog.EditIndexes.Count = 0 AND (Not rdgRejectionLog.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
            </div>
        </CommandItemTemplate>
        <DetailTables>
        <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="Top"  AllowSorting="false"  AllowPaging="True"
                DataKeyNames="Id,RejectionlogId" PageSize="10"  Width="100%"  EditMode="InPlace" Name="Logdetails">
                 <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="RejectionlogId" MasterKeyField="Id" />
                </ParentTableRelation>
              <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                 <Columns>
            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LineNumber %>" HeaderStyle-Width="60px" 
                HeaderStyle-Wrap="false" Groupable="false" UniqueName="LineNumber" Reorderable="false" SortExpression="LineNumber">
                <ItemTemplate>
                   <span><%#Container.DataItem("LineNumber").ToString%></span>  
                </ItemTemplate>
                <EditItemTemplate>
                    <%#Eval("LineNumber").ToString%>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_RequiredField %>" HeaderStyle-HorizontalAlign="left"
               HeaderStyle-Width="150px" SortExpression="RequiredField"  Groupable="false" Reorderable="false">
                <ItemTemplate>
                   <span> <%#IIf(Container.DataItem("RequiredField").ToString = String.Empty, "&nbsp;", Container.DataItem("RequiredField").ToString)%></span>  
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_DataType %>" 
            Groupable="false" HeaderStyle-Width="150px" SortExpression="DataType" Reorderable="false">
                <ItemTemplate>
                  <span>  <%#IIf(Container.DataItem("DataType") = String.Empty, "&nbsp;", Container.DataItem("DataType"))%></span>  
                </ItemTemplate>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_NotInList %>" 
                        Groupable="false" HeaderStyle-Width="150px" SortExpression="NotInList" Reorderable="false">
                <ItemTemplate>
                   <span> <%#IIf(Container.DataItem("NotInList") = String.Empty, "&nbsp;", Container.DataItem("NotInList"))%></span>  
                </ItemTemplate>
            </telerik:GridTemplateColumn>     
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                            <div style="padding: 2px">
                                
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    Visible="true" runat="server" CommandName="DeleteRows"
                                    meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                                </asp:LinkButton>
                            </div>
                     </CommandItemTemplate>
                </telerik:GridTableView>
        </DetailTables>
    </MasterTableView>
    <HeaderStyle Width="50px" Font-Size="8pt"></HeaderStyle>
    <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
         
                    <Scrolling UseStaticHeaders="true" />   
                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />     
                </ClientSettings>
    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
</telerik:RadGrid>