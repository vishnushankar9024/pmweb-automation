<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationInsurances.ascx.vb" Inherits="Website.ApplicationInsurances" %>
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
        <div style="clear:both">&nbsp;</div>
        
<fieldset style="width:100%;">
<legend><asp:Label ID="lblInsurance" runat="server" meta:resourcekey="lblInsurance" Text="Insurance"></asp:Label></legend>

<telerik:RadGrid ID="rdgInsurances" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True"  SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" GroupingEnabled="false"
                        ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" >
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" 
                        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>    
            <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="Type"  ItemStyle-Wrap="false" HeaderText="Type"> 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("TypeName").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeName").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList  ID="ddlType" runat="server"></asp:DropDownList>
                </EditItemTemplate>
                <HeaderStyle Width="90px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Carrier"  ItemStyle-Wrap="false" UniqueName="Carrier">
                         
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Carrier").ToString = String.Empty, "&nbsp;", Container.DataItem("Carrier").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCarrier" MaxLength="100" runat="server" Text='<%# Eval("Carrier") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Policy #"  ItemStyle-Wrap="false" UniqueName="PolicyNumber">
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("PolicyNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("PolicyNumber").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPolicyNumber" MaxLength="100" runat="server" Text='<%# Eval("PolicyNumber") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px"  ItemStyle-Wrap="false"  HeaderText="Start Date" UniqueName="StartDate">
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
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="End Date" UniqueName="EndDate">
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
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Each Occurrence" UniqueName="EachOccurrence" 
                       DataType="System.Decimal" >
                <ItemTemplate> 
                    <%--<span ><%#IIf(Container.DataItem("EachOccurrence").ToString = String.Empty, "&nbsp;", FormatCurrency(ParseDouble(Eval("EachOccurrence"))))%></span>--%>
					<span ><%#IIf(Container.DataItem("EachOccurrence").ToString = String.Empty, "&nbsp;", ParseDouble(Eval("EachOccurrence")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <%--<asp:TextBox ID="txtEachOccurrence" runat="server" MaxLength="15"  Text='<%# FormatCurrency(ParseDouble(Eval("EachOccurrence")))%>' 
                                    Width="100%" CssClass="Currency">--%>
									<asp:TextBox ID="txtEachOccurrence" runat="server" MaxLength="15"  Text='<%# ParseDouble(Eval("EachOccurrence"))%>' 
                                    Width="100%" CssClass="Currency">
                    </asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Aggregate" UniqueName="Aggregate">
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
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgInsurances.EditIndexes.Count = 0 AND (Not rdgInsurances.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>' meta:resourcekey="btnEditSelectedResource1">
                 <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnInsuranceUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgInsurances.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnInsuranceSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                    CommandName="PerformInsert" Visible='<%# rdgInsurances.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                  <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                    CommandName="CancelAll" Visible='<%# rdgInsurances.EditIndexes.Count > 0 Or rdgInsurances.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                        CommandName="InitNewRow" Visible='<%# rdgInsurances.EditIndexes.Count = 0 AND (Not rdgInsurances.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>' 
                        meta:resourcekey="btnAddResource1">
                <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                        Visible='<%# rdgInsurances.EditIndexes.Count = 0 AND (Not rdgInsurances.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid"
                    meta:resourcekey="btnRefreshResource1" Visible='<%# rdgInsurances.EditIndexes.Count = 0 And (Not rdgInsurances.MasterTableView.IsItemInserted) %>'>
                 <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true" >
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
    </ClientSettings>
</telerik:RadGrid>

</fieldset>
<table cellpadding="0" cellspacing="0" runat="server">
<tr>
    <td style="padding-top:10px;">
         <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
    </td>
</tr>
</table>