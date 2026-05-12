<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CheckListSetting.ascx.vb" Inherits="Website.CheckListSetting" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCheckList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCheckList" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div style="padding-top:42px">
<telerik:RadGrid ID="rdgCheckList" runat="server" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" SetWidth="true"
    AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowPaging="true" PageSize="10" FitPageHeightOffset="1"
    AllowMultiRowEdit="True" AllowFilteringByColumn="true" ShowGroupPanel="true" AllowMultiRowSelection="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" AllowSorting="true" EditMode="InPlace">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Record Type" Groupable="false"
                DataField="RecordType" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="RecordType" UniqueName="RecordType">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("RecordType")%></span>
                </EditItemTemplate>
                <HeaderStyle Width="180px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Module" GroupByExpression="Module [GridColumn_Module] Group By Module ASC"
                DataField="Module" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="Module" UniqueName="Module">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Module") = String.Empty, "&nbsp;", Container.DataItem("Module"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("Module")%></span>
                </EditItemTemplate>
                <HeaderStyle Width="180px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Show Checklist" DataField="ShowCheckList" AutoPostBackOnFilter="true" DataType="System.Boolean"
                UniqueName="ShowCheckList" HeaderStyle-Width="120px" ItemStyle-Wrap="false"
                SortExpression="ShowCheckList" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="ShowCheckList [GridColumn_ShowCheckList] Group By ShowCheckList ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("ShowCheckList"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbShowCheckList" Checked='<%# Cbool(IIF(Eval("ShowCheckList") is system.DBNULL.value, 0,Eval("ShowCheckList")))%>' runat="server" class="mobile-switch" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

        </Columns>
        <SortExpressions>
        </SortExpressions>
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgCheckList.EditIndexes.Count = 0 AND (Not rdgCheckList.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"
                    SecurityButtonType="AddEditMode_Edit"
                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCheckList.EditIndexes.Count > 0 %>'>
                    <span class="Icon"></span>
                    <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>


                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgCheckList.EditIndexes.Count > 0 Or rdgCheckList.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>





            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
    </ClientSettings>
    <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="UpdateEdited" />
</telerik:RadGrid>
    </div>