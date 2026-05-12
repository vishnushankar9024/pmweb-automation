<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FormulaDetails.ascx.vb"
    Inherits="Website.FormulaDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgFormulaDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgFormulaDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table width="100%" style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td valign="top">
            <telerik:RadGrid ID="rdgFormulaDetails" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                HeaderStyle-Font-Size="8" Width="99%" AutoGenerateColumns="False" ShowStatusBar="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
     
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                            Groupable="false" DataField="DetailOrder" allowfiltering="false">
                            <ItemTemplate>
                                <%#Container.DataItem("DetailOrder").ToString%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("DetailOrder").ToString%>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" HeaderStyle-Width="88px" Groupable="false" DataField="Variable">
                            <ItemTemplate>
                                <%#IIF(Container.DataItem("Variable") = String.Empty ,"&nbsp;",Container.DataItem("Variable"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtVariable" MaxLength="50" runat="server" Text='<%# Eval("Variable") %>' Width="99%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvVariable" runat="server" ControlToValidate="txtVariable"
                                    CssClass="Validator" ErrorMessage="Enter the Variable" Display="Dynamic" ForeColor=""
                                    meta:resourcekey="rfvVariable"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="88px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description" HeaderStyle-Width="135px" Groupable="false">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text='<%# Eval("Description") %>' Width="99%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="135px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" HeaderStyle-Width="80px" Groupable="false" DataField="UOM">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOM" runat="server" AllowCustomText="true" Width="99%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Calculation / Quantity" UniqueName="CalculationQuantity" HeaderStyle-Width="170px" DataField="Calculation"
                            Groupable="false">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Calculation") = String.Empty, "&nbsp;", RestoreCalculationFromUS(Container.DataItem("Calculation")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCalculation" MaxLength="500" runat="server" Text='<%# RestoreCalculationFromUS(IIF(Eval("Calculation") Is system.DBNULL.value,"",Eval("Calculation"))) %>'
                                    Width="99%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="170px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-Width="175px" Groupable="false" DataField="Notes">
                            <ItemTemplate>
                                <span><%#IIF(Container.DataItem("Notes") = String.Empty ,"&nbsp;",Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>' Width="99%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="175px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="DetailOrder"></telerik:GridSortExpression>
                    </SortExpressions>
                    <EditFormSettings>
                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                            CancelImageUrl="Cancel.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                CommandName="EditRows" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 AND (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                CommandName="UpdateEdited" Visible='<%# rdgFormulaDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                CommandName="PerformInsert" Visible='<%# rdgFormulaDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                CommandName="CancelAll" Visible='<%# rdgFormulaDetails.EditIndexes.Count > 0 Or rdgFormulaDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 AND (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                OnClientClick="return ConfirmDelete()" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 AND (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                CommandName="RebindGrid" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 AND (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;
                           <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                               CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                               runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                               EnableShadows="true" CausesValidation="false"
                               Visible="true">
                           </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </td>
        <td width="365px" valign="top">
            <uc1:PMRotator ID="PMRotator1" runat="server" />
        </td>
    </tr>
</table>
