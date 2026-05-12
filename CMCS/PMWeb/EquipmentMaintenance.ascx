<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentMaintenance.ascx.vb" Inherits="Website.EquipmentMaintenance" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadGrid ID="rdgEquMaintenance" runat="server" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
     AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250"
    ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="false"
    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile ="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" EnableHeaderContextMenu="true" >
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right"
                SortExpression="LineNumber" GroupByExpression="LineNumber [GridColumn_Line] Group By LineNumber ASC"
                Groupable="false" Reorderable="true" DataField="LineNumber" allowfiltering="false">
                <ItemTemplate>
                    <span>
                        <%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Equipment/Item" UniqueName="Item" SortExpression="Item"
                 GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC" DataField="Item">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Item") = string.empty , "&nbsp;", Container.DataItem("Item"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="lblItemCode" Text="" Width="100%"></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="200px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Stock #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false"
                Groupable="false" Reorderable="false" UniqueName="StockNumber" DataField="StockNumber">
                <ItemTemplate>
                    <%#Container.DataItem("StockNumber")%>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <%#Eval("StockNumber")%>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Manufacturer" HeaderStyle-Width="80px" UniqueName="ManufacturerName"
                SortExpression="ManufacturerName" HeaderStyle-HorizontalAlign="Left" DataField="ManufacturerName">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("ManufacturerName") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerName"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlManufacturer" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                        EmptyMessage="Select Manufacturer..." Width="200px" NoWrap="true" CausesValidation="False">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Mfr. Number" UniqueName="MfrNumber" HeaderStyle-Width="70px"
                SortExpression="MfrNumber" HeaderStyle-HorizontalAlign="Left" DataField="MfrNumber">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("MfrNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("MfrNumber").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMfrNumber" OnclientLoad="MfrNumberLoad(this,events);" runat="server"
                        Text='<%# Eval("MfrNumber") %>' Width="120px"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Serial #" HeaderStyle-Wrap="false" HeaderStyle-Width="70px"
                SortExpression="SerialNumber" UniqueName="SerialNumber" HeaderStyle-HorizontalAlign="Left" DataField="SerialNumber">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("SerialNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("SerialNumber").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtSerialNumber" runat="server" Text='<%# Eval("SerialNumber") %>'
                        Width="120px"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="WO ID" HeaderStyle-HorizontalAlign="left"
                HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Right" SortExpression="WorkOrderId" UniqueName="WorkOrder" DataField="WorkOrderId">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("WorkOrderId") = 0, "&nbsp;", Container.DataItem("WorkOrderId").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlWorkOrders" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                        EmptyMessage="Select WorkOrders..." Width="200px" NoWrap="true" CausesValidation="False">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Expected<br>Life" UniqueName="ExpectedLife"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="left" SortExpression="ExpectedLife"  DataField="ExpectedLife">
                <ItemTemplate>
                    <span>
                        <%#FormatNumber(Container.DataItem("ExpectedLife"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("ExpectedLife") is system.DBNULL.value, "1", Eval("ExpectedLife"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="66px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Installed<br>Date" UniqueName="InstalledDate"
                ItemStyle-HorizontalAlign="Right" SortExpression="InstalledDate" HeaderStyle-HorizontalAlign="left" DataField="InstalledDate">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(iif(Container.DataItem("InstalledDate")=String.Empty,DBNull.Value,Container.DataItem("InstalledDate")))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <%#FormatDate(iif(Eval("InstalledDate")=String.Empty,DBNull.Value,Eval("InstalledDate")))%>
                </EditItemTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
          <%--      <ItemStyle HorizontalAlign="left"></ItemStyle>--%>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Usage at<br>Install" UniqueName="Usage" HeaderStyle-Width="70px"
                SortExpression="Usage" HeaderStyle-HorizontalAlign="left"  DataField="Usage">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Usage").ToString = String.Empty, "&nbsp;", Container.DataItem("Usage"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtUsage" runat="server" Text='<%# Eval("Usage") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Removed<br>Date" UniqueName="RemovedDate" ItemStyle-HorizontalAlign="Right"
                SortExpression="RemovedDate" DataField="RemovedDate">
                <ItemTemplate>
                    <span>
                       <span>
                        <%#FormatDate(iif(Container.DataItem("RemovedDate")=String.Empty,DBNull.Value,Container.DataItem("RemovedDate")))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <%#FormatDate(Eval("RemovedDate"))%>
                </EditItemTemplate>
                <HeaderStyle Width="66px" HorizontalAlign="Left"></HeaderStyle>
       <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Usage at<br>Removal" UniqueName="RemovalUsage"
                ItemStyle-HorizontalAlign="Right" SortExpression="RemovalUsage" HeaderStyle-HorizontalAlign="left" DataField="RemovalUsage">
                <ItemTemplate>
                       <span>
                        <%#IIf(FormatNumber(Container.DataItem("RemovalUsage")) = FormatNumber(0), "&nbsp;", FormatNumber(Container.DataItem("RemovalUsage")))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("RemovalUsage") is system.DBNULL.value, "1", Eval("RemovalUsage"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="66px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Life to Date" UniqueName="LifeToDate" SortExpression="LifeToDate"  DataField="LifeToDate">
                <ItemTemplate>
                    <span>
                        <%#IIf(FormatNumber(Container.DataItem("LifeToDate")) = FormatNumber(0), "&nbsp;", FormatNumber(Container.DataItem("LifeToDate")))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <%#FormatNumber(Eval("LifeToDate"))%>
                </EditItemTemplate>
                <HeaderStyle Width="66px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lot #" HeaderStyle-Wrap="false" UniqueName="LotNumber"  DataField="LotNumber" 
                HeaderStyle-Width="40px" SortExpression="LotNumber">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("LotNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("LotNumber").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLotNumber" runat="server" Text='<%# Eval("LotNumber") %>' Width="120px"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="right" />
        <CommandItemTemplate>
            <table style="display: inline; padding: 0px; height: 15px; width:100%;" border="0"
                cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width:100%">
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgEquMaintenance.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgEquMaintenance.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgEquMaintenance.EditIndexes.Count > 0 Or rdgEquMaintenance.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=PrimeContract', 910, 580, true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                              <asp:LinkButton ID="LinkButton1" CommandName="AddEquipment" runat="server" CausesValidation="False" CssClass="GridCmdAddEquipment"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddEquipments" runat="server" Text="Add Equipment"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                CommandName="SaveState" Visible='true'>
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </td>
                    <td align="right" style="width:100%"  >
                        <telerik:RadComboBox ID="ddlFilter" runat="server" SecurityButtonType="ItemMode"
                            Width="205px" AutoPostBack="true"   Style="font-size: 11px"
                            Visible='<%# rdgEquMaintenance.EditIndexes.Count = 0 AND (Not rdgEquMaintenance.MasterTableView.IsItemInserted) %>'>
                            <Items>
                                <telerik:RadComboBoxItem Text="Installed Only" Value="INSTALLED" meta:resourcekey="ddlFilter_INSTALLED" Selected="true" />
                                <telerik:RadComboBoxItem Text="Removed Only" Value="REMOVED" meta:resourcekey="ddlFilter_REMOVED" />
                                <telerik:RadComboBoxItem Text="Installed & Removed" Value="BOTH" meta:resourcekey="ddlFilter_BOTH" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
        <Selecting AllowRowSelect="true" />  
    </ClientSettings>
</telerik:RadGrid>