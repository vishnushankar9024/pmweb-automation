<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinkedSchedule.ascx.vb" Inherits="Website.LinkedSchedule" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <telerik:RadAjaxManagerProxy ID="RadAjaxProxy1" runat="server">
    <ajaxsettings>
        <telerik:AjaxSetting AjaxControlID="rdglinkedRecord">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdglinkedRecord"  LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </ajaxsettings>
</telerik:RadAjaxManagerProxy>
<table style="width:500px" cellpadding="4">
<tr>
<td style="width:70px">
 <b><asp:label id="lblLinkedTo"  meta:resourcekey="lblLinkedTo" runat="server" text="Linked to:"></asp:label></b>
</td>
<td style="width:330px" class="NoWrap">
<asp:label id="lblLinkedProject" runat="server"></asp:label>
</td>
<td style="width:100px" class="NoWrap">
<asp:label id="lblError" cssclass="Validator" visible="false"  meta:resourcekey="lblError" runat="server" text="Unable to get Project Name"></asp:label>
</td>
</tr>
</table>
<telerik:RadGrid ID="rdglinkedRecord" runat="server"   
            AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
            PageSize="10" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
            AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <GroupPanel Text="Group by"></GroupPanel>
        <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
            EditMode="InPlace" EnableHeaderContextMenu="false">
            <Columns>
             <telerik:GridTemplateColumn HeaderText="ID" UniqueName="Id" Groupable="false"
                    Reorderable="false" SortExpression="Id">
                    <ItemTemplate>
                        <span>
                            <%#Eval("Id")%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="75px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Parent ID" UniqueName="ParentId" Groupable="false"
                    Reorderable="false" SortExpression="ParentId">
                    <ItemTemplate>
                        <span>
                            <%#Eval("ParentId")%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="70px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Summary" GroupByExpression="IsSummary [GridColumn_IsSummary] Group By IsSummary ASC"
                HeaderStyle-Width="75px" SortExpression="IsSummary" UniqueName="IsSummary">
                    <ItemTemplate>
                          <img alt="" src='Images/Global/<%# CStr(IIF(Eval("IsSummary"),"checked.png" , "unchecked.png")) %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                   <HeaderStyle Width="75px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Code" UniqueName="Code" Groupable="false"
                    Reorderable="false" SortExpression="Code">
                    <ItemTemplate>
                        <span>
                            <%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" UniqueName="Name"
                    GroupByExpression="Name [GridColumn_Name] Group By Name ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="170px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                   <telerik:GridTemplateColumn HeaderText="Start" 
                    HeaderStyle-Width="100px"  GroupByExpression="Start [GridColumn_Start] Group By Start ASC" SortExpression="Start" UniqueName="Start">
                    <ItemTemplate>
                        <span>
                            <%#FormatDate(Container.DataItem("Start"))%>&nbsp;</span>
                    </ItemTemplate>
                       <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Finish" GroupByExpression="Finish [GridColumn_Finish] Group By Finish ASC"
                    HeaderStyle-Width="100px" SortExpression="Finish" UniqueName="Finish">
                    <ItemTemplate>
                        <span>
                            <%#FormatDate(Container.DataItem("Finish"))%>&nbsp;</span>
                    </ItemTemplate>
                           <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Duration" GroupByExpression="Duration [GridColumn_Duration] Group By Duration ASC"
                    HeaderStyle-Width="100px" SortExpression="Duration" UniqueName="Duration">
                    <ItemTemplate>
                        <span>
                            <%#FormatNumber(Container.DataItem("Duration"))%>&nbsp;</span>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Actual Start" 
                    HeaderStyle-Width="100px"  GroupByExpression="ActualStart [GridColumn_ActualStart] Group By ActualStart ASC" SortExpression="ActualStart" UniqueName="ActualStart">
                    <ItemTemplate>
                        <span>
                            <%#FormatDate(Container.DataItem("ActualStart"))%>&nbsp;</span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Actual Finish" GroupByExpression="ActualFinish [GridColumn_ActualFinish] Group By ActualFinish ASC"
                    HeaderStyle-Width="100px" SortExpression="ActualFinish" UniqueName="ActualFinish">
                    <ItemTemplate>
                        <span>
                            <%#FormatDate(Container.DataItem("ActualFinish"))%>&nbsp;</span>
                    </ItemTemplate>
                           <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Actual Duration" GroupByExpression="ActualDuration [GridColumn_ActualDuration] Group By ActualDuration ASC"
                    HeaderStyle-Width="100px" SortExpression="ActualDuration" UniqueName="ActualDuration">
                    <ItemTemplate>
                        <span>
                            <%#FormatNumber(Container.DataItem("ActualDuration"))%>&nbsp;</span>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                   <telerik:GridTemplateColumn HeaderText="Remaining Duration" GroupByExpression="RemainingDuration [GridColumn_RemainingDuration] Group By RemainingDuration ASC"
                    HeaderStyle-Width="100px" SortExpression="RemainingDuration" UniqueName="RemainingDuration">
                    <ItemTemplate>
                        <span>
                            <%#FormatNumber(Val(Container.DataItem("RemainingDuration")))%>&nbsp;</span>
                    </ItemTemplate>
                       <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                      <telerik:GridTemplateColumn HeaderText="Complete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                    HeaderStyle-Width="100px" SortExpression="PctComplete" UniqueName="PctComplete">
                    <ItemTemplate>
                           <span><%#FormatPercent(Val(Container.DataItem("PctComplete")))%></span>
                    </ItemTemplate>
                          <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Total Float" GroupByExpression="TotalFloat [GridColumn_TotalFloat] Group By TotalFloat ASC"
                    HeaderStyle-Width="100px" SortExpression="TotalFloat" UniqueName="TotalFloat">
                    <ItemTemplate>
                           <span><%#FormatNumber(Container.DataItem("TotalFloat"))%></span>
                    </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
            </Columns>
                  <CommandItemTemplate>
            <div style="padding: 2px">
                  <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                    Visible='<%# rdglinkedRecord.EditIndexes.Count = 0 AND (Not rdglinkedRecord.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                      <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows" 
                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdglinkedRecord.EditIndexes.Count = 0 AND (Not rdglinkedRecord.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows">
                        <span class="Icon"></span>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                       <asp:LinkButton ID="btnUnlik" CausesValidation="False" OnClientClick="return ConfirmUnlink()"
                       SecurityButtonType="ItemMode_Edit" Visible='<%# rdglinkedRecord.EditIndexes.Count = 0 AND (Not rdglinkedRecord.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="Unlink">
                    <%--    <img style="border: 0px; vertical-align: middle;" src="Images/Global/DeleteLine.png" />--%>
                        <asp:Label ID="lblUnlink" meta:resourcekey="lblUnlink" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
            </div>
        </CommandItemTemplate>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
            <FooterStyle CssClass="GridFooter" />
        </MasterTableView>
        <ClientSettings
            AllowDragToGroup="false">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
           </ClientSettings>
        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
    </telerik:RadGrid>