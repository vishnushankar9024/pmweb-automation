<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationNotes.ascx.vb" Inherits="Website.ApplicationNotes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxNotes1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgNotes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgNotes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<fieldset style="width:100%;" runat="server" id="fldNotes">
<legend><asp:Label ID="lblNotes" runat="server" meta:resourcekey="lblNotes" Text="Notes"></asp:Label></legend>

<telerik:RadGrid ID="rdgNotes" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
     ShowFooter="False" ShowGroupPanel="false" AllowMultiRowEdit="True" AllowMultiRowSelection="True"  Width="100%"
    ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" GroupingEnabled="false" >
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

<MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
    EnableHeaderContextMenu="true">

<Columns>    

    <telerik:GridTemplateColumn HeaderStyle-Width="100%" UniqueName="Description"  ItemStyle-Wrap="false" HeaderText="Description" > 
        <ItemTemplate> 
            <asp:HyperLink ID="hliDescription" runat="server" style="cursor :pointer " CssClass="NoWrap,Link" Text='<%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>'></asp:HyperLink>  &nbsp;
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
        </EditItemTemplate>
        <HeaderStyle Width="100%" />
    </telerik:GridTemplateColumn>
    
</Columns>

<CommandItemTemplate>
    <div style="padding:2px">
        &nbsp;&nbsp;

        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                        Visible='<%# rdgNotes.EditIndexes.Count = 0 %>' meta:resourcekey="btnEditSelectedResource1">
                       <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" 
                        meta:resourcekey="btnAddResource1" Visible='<%# rdgNotes.EditIndexes.Count = 0 AND (Not rdgNotes.MasterTableView.IsItemInserted) And (Not PM.Application.ApplicationInfo.Submitted.HasValue) %>'
                        OnClientClick="return OpenApplicationNotesPopup(0);" >
            <span class="Icon"></span>
            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"  CssClass="GridCmdDeleteRows" 
            runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1" Visible='<%# rdgNotes.EditIndexes.Count = 0 AND (Not rdgNotes.MasterTableView.IsItemInserted) And (Not PM.Application.ApplicationInfo.Submitted.HasValue)%>'>
            <span class="Icon"></span>
            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>
        
        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
            meta:resourcekey="btnRefreshResource1" Visible='<%# rdgNotes.EditIndexes.Count = 0 Or Not rdgNotes.MasterTableView.IsItemInserted %>'>
             <span class="Icon"></span>
            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
        </asp:LinkButton>
    </div>
</CommandItemTemplate>
</MasterTableView>
<ClientSettings ClientEvents-OnRowDblClick="RowDblClick"  Resizing-AllowColumnResize="true" >
    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
</ClientSettings>
<ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
</telerik:RadGrid>
<telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
</telerik:RadWindowManager>

</fieldset>
<div id="S_11">
<table cellpadding="0" cellspacing="0" runat="server" >
<tr>
    <td style="padding-top:10px;">
            <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
    </td>
</tr>
</table>
</div>