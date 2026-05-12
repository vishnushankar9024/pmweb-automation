<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsInsurances.ascx.vb" Inherits="Website.VendorApprovalsInsurances" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInsurances">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInsurances" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default" >
            <Calendar Width="200px"></Calendar>
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
       
<telerik:RadGrid ID="rdgInsurances" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" SetWidth="true"
    ShowFooter="false" AllowPaging="true" PageSize="250" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" UseEditFormInMobile="true"
    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8"  >
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
<MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"   
    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
    EnableHeaderContextMenu="true">
        <Columns>    
            <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="Type"  ItemStyle-Wrap="false" HeaderText="Type"
                        SortExpression="TypeName" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="TypeName [GridColumn_Type] Group By TypeName ASC" > 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Carrier"  ItemStyle-Wrap="false" UniqueName="Carrier"
                        SortExpression="Carrier" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Carrier [GridColumn_Carrier] Group By Carrier ASC" > 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Carrier").ToString = String.Empty, "&nbsp;", Container.DataItem("Carrier").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCarrier" MaxLength="100" runat="server" Text='<%# Eval("Carrier") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Policy #"  ItemStyle-Wrap="false" UniqueName="PolicyNumber" 
                        SortExpression="PolicyNumber" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="PolicyNumber [GridColumn_PolicyNumber] Group By PolicyNumber ASC">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("PolicyNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("PolicyNumber").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPolicyNumber" MaxLength="100" runat="server" Text='<%# Eval("PolicyNumber") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="Start Date" UniqueName="StartDate" DataField ="StartDate"
                        SortExpression="StartDate" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC">
                <ItemTemplate> 
                    <asp:Label ID="lblStartDate" Text="&nbsp;" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStartDate"
                            onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                            runat="server" Width="100%">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="End Date" UniqueName="EndDate" DataField ="EndDate"
                        SortExpression="EndDate" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="EndDate [GridColumn_EndDate] Group By EndDate ASC" >
                <ItemTemplate> 
                    <asp:Label ID="lblEndDate" Text="&nbsp;" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEndDate"
                            onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                            runat="server" Width="100%">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Each Occurrence" UniqueName="EachOccurrence" 
                        DataType="System.Decimal" SortExpression="EachOccurrence" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="EachOccurrence [GridColumn_EachOccurrence] Group By EachOccurrence ASC" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("EachOccurrence").ToString = String.Empty, "&nbsp;", FormatCurrency(Container.DataItem("EachOccurrence")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEachOccurrence" runat="server" MaxLength="15"  Text='<%#FormatCurrency(Eval("EachOccurrence"))%>' 
                                    Width="100%" CssClass="Currency">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Aggregate" UniqueName="Aggregate" 
                        SortExpression="Aggregate" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Aggregate [GridColumn_Aggregate] Group By Aggregate ASC">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Aggregate").ToString = String.Empty, "&nbsp;", Container.DataItem("Aggregate").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAggregate" runat="server" MaxLength="50" Text='<%#Eval("Aggregate") %>' Width="100%" ></asp:TextBox>                                
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding:2px">
               
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                     meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                        meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert" >
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                        meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
    </ClientSettings>
</telerik:RadGrid>