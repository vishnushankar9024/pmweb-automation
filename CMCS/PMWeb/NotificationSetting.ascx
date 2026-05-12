<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="NotificationSetting.ascx.vb" Inherits="Website.NotificationSetting" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgNotification">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgNotification" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div >


    <telerik:RadGrid ID="rdgNotification" runat="server" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" SetWidth="true"
        AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowPaging="true" PageSize="250" FitPageHeightOffset="1"
        AllowMultiRowEdit="True" AllowFilteringByColumn="true" ShowGroupPanel="true" AllowMultiRowSelection="true"
        FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" AllowSorting="true" EditMode="InPlace">

            <Columns>
                <telerik:GridTemplateColumn HeaderText="Record Type" Groupable="false" DataField="RecordType" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="RecordType" UniqueName="RecordType">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span><%#Eval("RecordType")%></span>
                    </EditItemTemplate>
                    <HeaderStyle Width="180px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Module" GroupByExpression="Module [GridColumn_Module] Group By Module ASC" DataField="Module" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="Module" UniqueName="Module">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("Module") = String.Empty, "&nbsp;", Container.DataItem("Module"))%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span><%#Eval("Module")%></span>
                    </EditItemTemplate>
                    <HeaderStyle Width="180px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Show Notification" DataField="ShowNotification" AutoPostBackOnFilter="true" DataType="System.Boolean" UniqueName="ShowNotification" HeaderStyle-Width="120px" ItemStyle-Wrap="false"
                    SortExpression="ShowNotification" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="ShowNotification [GridColumn_ShowNotification] Group By ShowNotification ASC">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("ShowNotification"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbShowNotification" Checked='<%# Cbool(IIF(Eval("ShowNotification") is system.DBNULL.value, 0,Eval("ShowNotification")))%>' runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="right" GroupByExpression="ReviewTime [GridColumn_ReviewTime] Group By ReviewTime ASC" DataField="ReviewTime" AutoPostBackOnFilter="true" DataType="System.Int64" HeaderText="Review Time (days)" SortExpression="ReviewTime" UniqueName="ReviewTime">
                    <ItemTemplate>
                        <%#Container.DataItem("ReviewTime")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtReviewTime" runat="server" Width="100%" CssClass="Integer" MaxLength="9" Text='<%#IIF(Eval("ReviewTime") is system.DBNULL.value, "0", Eval("ReviewTime")) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="120px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Lock After Send" DataField="LockAfterSend" AutoPostBackOnFilter="true" DataType="System.Boolean" UniqueName="LockAfterSend" HeaderStyle-Width="120px" ItemStyle-Wrap="false"
                    SortExpression="LockAfterSend" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="LockAfterSend [GridColumn_LockAfterSend] Group By LockAfterSend ASC">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("LockAfterSend"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbLockAfterSend" Checked='<%# Cbool(IIF(Eval("LockAfterSend") is system.DBNULL.value, 0,Eval("LockAfterSend")))%>' runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>

            <CommandItemTemplate>
                <div style="padding: 2px">

                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows" Visible='<%# rdgNotification.EditIndexes.Count = 0 AND (Not rdgNotification.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" CssClass="GridCmdUpdateEdited"
                        SecurityButtonType="AddEditMode_Edit"
                        CommandName="UpdateEdited" Visible='<%# rdgNotification.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll" Visible='<%# rdgNotification.EditIndexes.Count > 0 Or rdgNotification.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>

                </div>
            </CommandItemTemplate>

        </MasterTableView>

        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
        </ClientSettings>
        <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="UpdateEdited" />
    </telerik:RadGrid>

</div>
