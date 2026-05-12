<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderResources.ascx.vb" Inherits="Website.WorkOrderResources" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxLoadingPanel ID="ldpLabors" runat="server" Skin="Default" />
 <telerik:RadGrid ID="rdgWorkorderLabors" UseEditFormInMobile="true" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                      HeaderStyle-Font-Size="8" Width="100%"
                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false" PageSize="250"
                    AllowPaging="True" ShowFooter="true"  AllowMultiRowEdit="True" ShowGroupPanel="true" >
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" Width="100%">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Resource" HeaderStyle-HorizontalAlign="Left" GroupByExpression="Labor [GridColumn_Labor] Group By Labor ASC" DataField="Labor"
                                HeaderStyle-Width="150px" UniqueName="Labor" SortExpression="Labor" Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#IIf(Container.DataItem("Labor").ToString = String.Empty, "&nbsp;", Container.DataItem("Labor").ToString)%></span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLabors" runat="server" Width="100%" DropDownWidth="250px" ValidationGroup="Save"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..."
                                   NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" meta:resourcekey="ddlLabors"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Resource Type" HeaderStyle-HorizontalAlign="Left" DataField="ResourceType" GroupByExpression="ResourceType [GridColumn_ResourceType] Group By ResourceType ASC"
                                HeaderStyle-Width="150px" UniqueName="ResourceType" SortExpression="ResourceType" Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#IIf(Container.DataItem("ResourceType").ToString = String.Empty, "&nbsp;", Container.DataItem("ResourceType").ToString)%></span> 
                                </ItemTemplate>
                                <EditItemTemplate>                            
                                    <%#Eval("ResourceType")%> &nbsp;
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Linked Resource" DataField="LinkedResource" HeaderStyle-HorizontalAlign="Left" GroupByExpression="LinkedResource [GridColumn_LinkedResource] Group By LinkedResource ASC"
                                HeaderStyle-Width="150px" UniqueName="LinkedResource" SortExpression="LinkedResource" Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#IIf(Container.DataItem("LinkedResource").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedResource").ToString)%></span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lblLinkedResource" text=<%#Eval("LinkedResource")%>></asp:Label> 
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Date" DataField="Date" UniqueName="Date" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" 
                                HeaderStyle-Width="110px" SortExpression="Date" GroupByExpression="Date [GridColumn_LaborDate] Group By Date ASC">
                                <ItemTemplate>
                                   <span><%#FormatDate(Container.DataItem("Date"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="dpDate" Skin="Default" runat="server" SharedCalendarID="" MinDate="01-01-1901" Width="100%" >
                                        <DateInput ID="DateInput1" runat="server" />
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="LaborId">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Dispatched Start" UniqueName="DispatchedStartTime" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" DataField="DispatchedStartTime"
                                HeaderStyle-Width="110px" SortExpression="DispatchedStartTime" GroupByExpression="DispatchedStartTime [GridColumn_DispatchedStartTime] Group By DispatchedStartTime ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("DispatchedStartTime"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="DispatchedStartDateSelected" ID="tpDispatchedStartTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Dispatched Finish" UniqueName="DispatchedFinishTime" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" DataField="DispatchedFinishTime"
                                HeaderStyle-Width="110px" SortExpression="DispatchedFinishTime" GroupByExpression="DispatchedFinishTime [GridColumn_DispatchedFinishTime] Group By DispatchedFinishTime ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("DispatchedFinishTime"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="DispatchedFinishDateSelected" ID="tpDispatchedFinishTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="WorkOrder" ControlToCompare="tpDispatchedStartTime"
                                        ControlToValidate="tpDispatchedFinishTime" Operator="GreaterThan" Display="Dynamic" meta:resourceKey="cvTime_Labor" ErrorMessage="Finish must be greater Than Start"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Actual Start" UniqueName="ActualStartTime" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" DataField="ActualStartTime"
                                HeaderStyle-Width="110px" SortExpression="ActualStartTime" GroupByExpression="ActualStartTime [GridColumn_ActualStartTime] Group By ActualStartTime ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("ActualStartTime"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="ActualStartDateSelected" ID="tpActualStartTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Actual Finish" UniqueName="ActualFinishTime" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" DataField="ActualFinishTime"
                                HeaderStyle-Width="110px" SortExpression="ActualFinishTime" GroupByExpression="ActualFinishTime [GridColumn_ActualFinishTime] Group By ActualFinishTime ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("ActualFinishTime"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="ActualFinishDateSelected" ID="tpActualFinishTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                    <asp:CompareValidator ID="cvTime" runat="server" ValidationGroup="WorkOrder" ControlToCompare="tpActualStartTime"
                                        ControlToValidate="tpActualFinishTime" Operator="GreaterThan" Display="Dynamic" meta:resourceKey="cvTime_Labor" ErrorMessage="Finish must be greater Than Start"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Classification" DataField="Classification" GroupByExpression="Classification [GridColumn_LaborClassification] Group By Classification ASC"
                                HeaderStyle-Width="160px" UniqueName="LaborClassification" SortExpression="Classification" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Classification").ToString = String.Empty, "&nbsp;", Container.DataItem("Classification").ToString)%> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                     <telerik:RadComboBox ID="ddlClassification" runat="server" Width="100%" Filter="Contains" DropDownWidth="200px" meta:resourcekey="ddlResourceClasses"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"  OnClientItemsRequesting="GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Pay Types" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" Reorderable="true" Groupable="true" DataField="PayType"
                                UniqueName="LaborPayType" SortExpression="PayType" GroupByExpression="PayType [GridColumn_LaborPayType] Group By PayType ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("PayType").ToString = String.Empty, "&nbsp;", Container.DataItem("PayType").ToString)%></span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPayType" runat="server" Width="100%" Filter="Contains" DropDownWidth="150px" meta:resourcekey="ddlResourcePayTypes"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..."
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos" OnClientItemsRequesting="GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                                GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                     <telerik:RadComboBox Width="100%"  DropDownWidth="250px" ID="ddlCurrencies" Height="300px" runat="server" Skin="Default" Style="font-size: 11px">
                                 </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="Rate" HeaderText="Rate" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" DataField="Rate"
                                HeaderStyle-Width="80px" SortExpression="Rate" GroupByExpression="Rate [GridColumn_Rate] Group By Rate ASC" Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#FormatNumber(IIf(Eval("Rate") Is System.DBNull.Value, "0", Eval("Rate")))%> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtRate" runat="server" Width="100%" CssClass="PositiveDouble"
                                        MaxLength="15"  Text='<%#FormatNumber(IIF(Eval("Rate") is system.DBNULL.value, "0", Eval("Rate"))) %>' ></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn UniqueName="DispatchedHours" HeaderText="Dispatched Hours" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" DataField="DispatchedHours"
                                HeaderStyle-Width="80px" SortExpression="DispatchedHours" GroupByExpression="DispatchedHours [GridColumn_DispatchedHours] Group By DispatchedHours ASC"
                                Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#FormatNumber(IIF(Eval("DispatchedHours") is system.DBNULL.value, "0", Eval("DispatchedHours"))) %> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDispatchedHours" runat="server" Width="100%" CssClass="PositiveDouble"
                                        MaxLength="15"  MinNumber="0" Text='<%#FormatNumber(IIF(Eval("DispatchedHours") is system.DBNULL.value, "0", Eval("DispatchedHours"))) %>' ></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="ActualHours" HeaderText="Actual Hours" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" DataField="ActualHours"
                                HeaderStyle-Width="80px" SortExpression="ActualHours" GroupByExpression="ActualHours [GridColumn_ActualHours] Group By ActualHours ASC"
                                Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#FormatNumber(IIF(Eval("ActualHours") is system.DBNULL.value, "0", Eval("ActualHours"))) %> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTotalHours" runat="server" Width="100%" CssClass="PositiveDouble"
                                        MaxLength="15"  MinNumber="0" Text='<%#FormatNumber(IIF(Eval("ActualHours") is system.DBNULL.value, "0", Eval("ActualHours"))) %>' ></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="LaborTotalCost" HeaderText="Total Cost" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" DataField="TotalCost"
                                HeaderStyle-Width="80px" SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_LaborTotalCost] Group By TotalCost ASC"
                                Reorderable="true" Groupable="true">
                                <ItemTemplate>
                                    <span> <%#FormatCurrency(ParseDouble(Eval("TotalCost")),CurrencyId:=Eval("CurrencyId"))%> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTotalCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                        Text='<%# FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal" meta:resourceKey="lblTotal" runat="server" Font-Bold="True" ></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="CostCode" ItemStyle-Wrap="false" HeaderText="Cost Code" Reorderable="true" Groupable="true" DataField="CostCode"
                                SortExpression="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" HeaderStyle-HorizontalAlign="Left"> 
                                <ItemTemplate> 
                                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                    </asp:HyperLink>
                                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                  <telerik:RadComboBox ID="ddlCostCodeLabor" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Period" ItemStyle-Wrap="false" HeaderText="Cost Period" DataField="Period"
                                 Groupable="true" Reorderable="true" HeaderStyle-HorizontalAlign="Left"
                                 SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC" > 
                                <ItemTemplate>
                                    <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                     <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="100px" 
                                                    EnableItemCaching="false"  OnItemsRequested="ddl_ItemsRequested"
                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="LaborNotes" HeaderStyle-HorizontalAlign="Left" Reorderable="true" Groupable="true" DataField="Notes"
                                HeaderStyle-Width="150px" SortExpression="Notes" GroupByExpression="Notes [GridColumn_LaborNotes] Group By Notes ASC">
                                <ItemTemplate>
                                     <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%> </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" 
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                   <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>                                
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" 
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                  <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>                                
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" 
                                    Visible='<%# rdgWorkorderLabors.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" 
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count > 0 Or rdgWorkorderLabors.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" 
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                   <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                 <asp:LinkButton ID="btnAddResource" runat="server"  CausesValidation="False" CommandName="WorkOrderAddResources" CssClass="GridCmdWorkOrderAddResources"
                                    SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=WorkOrder',900,540,true)"
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateDispatchBoard" runat="server"  CausesValidation="False" CommandName="UpdateDispatchBoard" CssClass="GridCmdUpdateDispatchBoard"
                                    SecurityButtonType="ItemMode_Add"
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnUpdateDispatchBoard">
                                   <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateDispatchBoard" runat="server" Text="Update From Dispatch Boards" meta:resourcekey="lblUpdateDispatchBoard"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" 
                                    Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 AND (Not rdgWorkorderLabors.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                   <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
                                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion"  
                                 OnClientClick="return OpenPreviewConversionResources();" style="float:none !important" 
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgWorkorderLabors.EditIndexes.Count = 0 And (Not rdgWorkorderLabors.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                       &nbsp;&nbsp;
                            </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true"
                         AllowDragToGroup="true" AllowColumnsReorder="true"></ClientSettings>
                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true"
                        ValidationGroup="WorkOrder" />
                </telerik:RadGrid>

