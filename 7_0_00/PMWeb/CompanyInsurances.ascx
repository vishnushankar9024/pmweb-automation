<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyInsurances.ascx.vb" Inherits="Website.CompanyInsurances" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInsurance">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInsurance" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadGrid ID="rdgInsurance" runat="server"
    AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    Font-Size="8px" PageSize="20" ShowFooter="false" AllowPaging="True" ShowGroupPanel="true"
    AllowSorting="True" GridLines="None" AllowMultiRowSelection="true" AllowMultiRowEdit="true" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" AllowFiltering="false"
                Groupable="false" Reorderable="true">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="55px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Property" SortExpression="Property" UniqueName="Property" DataField="Property"
                GroupByExpression="Property [GridColumn_Property] Group By Property ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Property") = "", "&nbsp;", Container.DataItem("Property"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlProperties" runat="server" Width="100%" Filter="Contains" DropDownWidth="250px" ValidationGroup="Save"
                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage=""
                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"
                        Style="font-size: 11px" Height="200px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="180px"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Project" SortExpression="ProjectName" UniqueName="Project" DataField="ProjectName"
                GroupByExpression="ProjectName [GridColumn_Project] Group By ProjectName ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("ProjectName") = "", "&nbsp;", Container.DataItem("ProjectName"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlProjects" runat="server" Width="100%" Filter="Contains" DropDownWidth="250px"
                        MarkFirstMatch="True" Skin="Default" CloseDropDownOnBlur="true"
                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                        OnClientSelectedIndexChanged="ddlProjects_OnClientSelectedIndexChanged"
                        Style="font-size: 11px" Height="200px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="180px"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="Type" DataField="Type"
                GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Type") = "", "&nbsp;", Container.DataItem("Type"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTypes" AllowCustomText="true" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="80px"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Carrier" SortExpression="Carrier" UniqueName="Carrier" DataField="Carrier"
                GroupByExpression="Carrier [GridColumn_Carrier] Group By Carrier ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Carrier") = String.Empty, "&nbsp;", Container.DataItem("Carrier"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCarrier" runat="server" Text='<%# Eval("Carrier") %>'
                        Width="100%" MaxLength="255"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Policy #" SortExpression="PolicyNumber" UniqueName="PolicyNumber" DataField="PolicyNumber"
                GroupByExpression="PolicyNumber [GridColumn_PolicyNumber] Group By PolicyNumber ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("PolicyNumber") = String.Empty, "&nbsp;", Container.DataItem("PolicyNumber"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPolicyNumber" runat="server" Text='<%# Eval("PolicyNumber") %>'
                        Width="100%" MaxLength="255"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Start Date" HeaderStyle-HorizontalAlign="left" DataField="StartDate"
                HeaderStyle-Width="70px" SortExpression="StartDate" UniqueName="StartDate"
                GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC">
                <ItemTemplate>
                    <%#FormatDate(Container.DataItem("StartDate"))%>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStartDate" Width="100%" Text='<%#FormatDate(Eval("StartDate"))%>'
                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                        runat="server"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="End Date" HeaderStyle-HorizontalAlign="left" DataField="EndDate"
                HeaderStyle-Width="70px" SortExpression="EndDate" UniqueName="EndDate"
                GroupByExpression="EndDate [GridColumn_EndDate] Group By EndDate ASC">
                <ItemTemplate>
                    <%#FormatDate(Container.DataItem("EndDate"))%>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFinishDate" Width="100%" Text='<%#FormatDate(Eval("EndDate"))%>'
                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                        runat="server"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount" DataField="Amount"
                SortExpression="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("Amount"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAmount" runat="server" MaxLength="15" Width="100%" CssClass="Currency"
                        Text='<%# FormatCurrency(Eval("Amount")) %>'></asp:TextBox>
                </EditItemTemplate>
                <%--                <FooterTemplate>
                    <asp:Label ID="lblAmmount" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>'
                        Width="100%" MaxLength="500"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Inactive" HeaderStyle-Width="55px" ItemStyle-Wrap="false" DataField="Inactive" DataType="System.Boolean"
                SortExpression="Inactive" UniqueName="Inactive"
                GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkInactive" Checked='<%# Cbool(IIF(Eval("Inactive") is system.DBNULL.value, 0,Eval("Inactive")))%>' runat="server" CssClass="mobile-switch" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit"
                    Visible='<%# rdgInsurance.EditIndexes.Count = 0 AND (Not rdgInsurance.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    SecurityButtonType="AddEditMode_Edit"
                    Visible='<%# rdgInsurance.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" ValidationGroup="Save" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add"
                    Visible='<%# rdgInsurance.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode"
                    Visible='<%# rdgInsurance.EditIndexes.Count > 0 Or rdgInsurance.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add"
                    Visible='<%# rdgInsurance.EditIndexes.Count = 0 AND (Not rdgInsurance.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgInsurance.EditIndexes.Count = 0 AND (Not rdgInsurance.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgInsurance.EditIndexes.Count = 0 AND (Not rdgInsurance.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
    <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
        <Selecting AllowRowSelect="true" />
    </ClientSettings>
    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
</telerik:RadGrid>