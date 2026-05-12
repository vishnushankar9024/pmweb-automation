<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ResourceClassificationMatrix.aspx.vb" Inherits="Website.ResourceClassificationMatrix" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgClassMatrix">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgClassMatrix" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadGrid ID="rdgClassMatrix" CssClass="TopMarginWhenMobileMenuShown" runat="server" SetWidth="true" AppendMenus="true"
        AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
        PageSize="25" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" UseEditFormInMobile="true"
        AllowMultiRowEdit="false" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <GroupPanel Text="Group by"></GroupPanel>
        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id, RateId" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
            EditMode="InPlace" EnableHeaderContextMenu="true">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="ID*" SortExpression="ClassificationCode" UniqueName="ID" Groupable="false">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("ClassificationCode") = String.Empty, "&nbsp;", Container.DataItem("ClassificationCode"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtClassificationId" MaxLength="100" runat="server" Text='<%#Eval("ClassificationCode")%>' Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="txtClassificationId"
                            CssClass="Validator" ErrorMessage="<br/>Enter The ID." Display="Dynamic" ForeColor=""
                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Description*" SortExpression="Description" UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="255" runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            CssClass="Validator" ErrorMessage="<br/>Enter The Description." Display="Dynamic" ForeColor=""
                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="250px"></HeaderStyle>
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
            <CommandItemTemplate>
                <div style="padding: 2px">

                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgClassMatrix.EditIndexes.Count = 0 And (Not rdgClassMatrix.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                        SecurityButtonType="AddEditMode_Edit"
                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgClassMatrix.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgClassMatrix.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgClassMatrix.EditIndexes.Count > 0 Or rdgClassMatrix.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgClassMatrix.EditIndexes.Count = 0 And (Not rdgClassMatrix.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                        Visible='<%# rdgClassMatrix.EditIndexes.Count = 0 And (Not rdgClassMatrix.MasterTableView.IsItemInserted) %>'
                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                        <span class="Icon"></span>
                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgClassMatrix.EditIndexes.Count = 0 And (Not rdgClassMatrix.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false"
            AllowDragToGroup="true">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        </ClientSettings>
        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
    </telerik:RadGrid>

</asp:Content>
