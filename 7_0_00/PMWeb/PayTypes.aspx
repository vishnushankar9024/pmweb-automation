<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PayTypes.aspx.vb" Inherits="Website.PayTypes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Portfolio/PayTypes.js" type="text/javascript"></script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgPayTypes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgPayTypes" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadGrid ID="rdgPayTypes" runat="server" SetWidth="true" AppendMenus="true" CssClass="TopMarginWhenMobileMenuShown"
        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="35"
        ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="false"
        AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" EnableHeaderContextMenu="true">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Sort Order" UniqueName="SortOrder" ItemStyle-HorizontalAlign="Right"
                    SortExpression="SortOrder" GroupByExpression="SortOrder [GridColumn_SortOrder] Group By SortOrder ASC"
                    Groupable="false" Reorderable="true">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("SortOrder")%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <span>
                            <%#Eval("SortOrder")%></span>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="ID*" ItemStyle-HorizontalAlign="LEFT" Groupable="false"
                    SortExpression="PayTypeId" UniqueName="ID">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("PayTypeId") = String.Empty, "&nbsp;", Container.DataItem("PayTypeId"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPayTypeId" MaxLength="100" runat="server" Text='<%# Eval("PayTypeId") %>' Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="txtPayTypeId"
                            CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor="" meta:resourcekey="rfvRequired"
                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Description*" Groupable="false" UniqueName="Description"
                    SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            CssClass="Validator" ErrorMessage="Required" Display="Dynamic" meta:resourcekey="rfvRequired"
                            ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Abbreviation*" Groupable="false" UniqueName="Abbreviation"
                    SortExpression="Abbreviation" GroupByExpression="Abbreviation [GridColumn_Abbreviation] Group By Abbreviation">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Abbreviation") = String.Empty, "&nbsp;", Container.DataItem("Abbreviation"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAbbreviation" MaxLength="100" Width="100%" runat="server" Text='<%#Eval("Abbreviation")%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAbbreviation" runat="server" ControlToValidate="txtAbbreviation"
                            CssClass="Validator" ErrorMessage="Required" Display="Dynamic" meta:resourcekey="rfvRequired"
                            ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Notes" Groupable="false" SortExpression="Notes"
                    UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                    meta:resourcekey="GridTemplateColumnResource15">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                            MaxLength="500"></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="250px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Default" Groupable="false" UniqueName="Default"
                    HeaderStyle-Width="100px" ItemStyle-Wrap="false" SortExpression="IsDefault" ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-Wrap="false">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsDefault"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbIsDefault" Checked='<%# Cbool(IIF(Eval("IsDefault") is system.DBNULL.value, 0,Eval("IsDefault")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
            <FooterStyle CssClass="GridFooter" />
            <SortExpressions>
                <telerik:GridSortExpression FieldName="SortOrder"></telerik:GridSortExpression>
            </SortExpressions>
            <CommandItemTemplate>
                <div style="padding: 2px">

                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                        SecurityButtonType="ItemMode_Edit" Visible='<%# rdgPayTypes.EditIndexes.Count = 0 And (Not rdgPayTypes.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                        ValidationGroup="Save" CausesValidation="true" Visible='<%# rdgPayTypes.EditIndexes.Count > 0 %>'
                        meta:resourcekey="btnUpdateEditedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                        ValidationGroup="Save" CausesValidation="true" Visible='<%# rdgPayTypes.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnSaveResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                        SecurityButtonType="AddEditMode" Visible='<%# rdgPayTypes.EditIndexes.Count > 0 Or rdgPayTypes.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                        SecurityButtonType="ItemMode_Add" Visible='<%# rdgPayTypes.EditIndexes.Count = 0 And (Not rdgPayTypes.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdgPayTypes.EditIndexes.Count = 0 And (Not rdgPayTypes.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                        SecurityButtonType="ItemMode" Visible='<%# rdgPayTypes.EditIndexes.Count = 0 And (Not rdgPayTypes.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnRefreshResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowRowsDragDrop="true"
            AllowDragToGroup="false">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        </ClientSettings>
        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
    </telerik:RadGrid>

</asp:Content>
