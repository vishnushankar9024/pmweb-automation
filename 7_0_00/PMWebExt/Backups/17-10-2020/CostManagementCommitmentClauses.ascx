<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementCommitmentClauses.ascx.vb" Inherits="Website.CostManagementCommitmentClauses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    .style1
    {
        width: 311px;
    }
</style>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgClauses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgClauses" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldNotes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td valign="top" style="width:700px" >
<telerik:RadGrid ID="rdgClauses" AllowMultiRowSelection="true" runat="server" 
      HeaderStyle-Font-Size="8" AllowMultiRowEdit="True"
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="10" UseEditFormInMobile="true">
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="45px" UniqueName="LineNumber"
                HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                <ItemTemplate>
                    <%#Container.DataItem("LineNumber").ToString%>
                </ItemTemplate>
                <EditItemTemplate>
                    <%#Eval("LineNumber").ToString%>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
           <telerik:GridTemplateColumn HeaderText="Clause ID" UniqueName="ClauseId" SortExpression="ClauseId">
                <ItemTemplate>
                    <%#FormatNumber(Container.DataItem("ClauseId"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtClauseId" runat="server" Width="100%" CssClass="Double"
                      MaxLength="15" Text='<%#FormatNumber(IIF(Eval("ClauseId") is system.DBNULL.value, "0", Eval("ClauseId"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
                
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="200px" SortExpression="Description">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount" SortExpression="Amount">
                <ItemTemplate>
                    <%#FormatCurrency(Container.DataItem("Amount"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%"
                        MaxLength="15" Text='<%# FormatCurrency(Eval("Amount")) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="Update" CssClass="GridCmdUpdate" 
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>'
           OnClientClick="return  popUpClause();">
                   <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="ClauseDetails" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  CausesValidation="true"
                    Visible='<%# rdgClauses.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgClauses.EditIndexes.Count > 0 Or rdgClauses.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add Risk" ></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
                    &nbsp;&nbsp;            
            </div>
        </CommandItemTemplate>      
    </MasterTableView>
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings EnableRowHoverStyle="true"    allowdragtogroup="True" allowrowsdragdrop="False" EnablePostBackOnRowClick="true">                   
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" 
             AllowColumnResize="True" />  
    <ClientEvents OnGridCreating="CommitmentClause_Creating"></ClientEvents>
    </ClientSettings>
</telerik:RadGrid>

</td>
<td style="width:300px">&nbsp;</td> 
<td style="height:300px" valign ="top">
    <fieldset id="fldNotes" title="Click on a Clause to preview Notes" runat="server"
        style="text-align: left; margin-bottom: 5px; margin-right: 10px; padding-left: 5px;
        padding-bottom: 15px; width: 500px; height: 100%; border-width: 1; background: white none !important;color: #000000;">
        <legend>
            <asp:Label ID="lblPreviewNotes" runat="server" Text="Preview Notes" meta:resourcekey="lblPreviewNotes"></asp:Label></legend>
        <div style="overflow: auto; height: 100%;">
            <asp:Label ID="lblContent" runat="server"></asp:Label>
        </div>
    </fieldset>
</td>
</tr>
</table>