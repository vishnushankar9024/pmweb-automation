<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AdvancedList.ascx.vb" Inherits="Website.AdvancedList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAvancedListDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<telerik:RadAjaxLoadingPanel ID="ldpPeriods" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />


<div class="PMMainPage">
    <div class="row">
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblAdvancedList" meta:Resourcekey="lblAdvancedList" runat="server" Text="Advanced List"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlAdvancedList" runat="server" meta:resourcekey="ddlAdvancedList" Skin="Default" CloseDropDownOnBlur="true"
                            EmptyMessage="Select List..." Width="100%" AutoPostBack="True" AllowCustomText="true"
                            CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" checkfordirt="True">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                    </td>
            </table>
        </div>

    </div>
</div>
<div class="PMHeader">
    <div class="row">
        <div class="col-8" style="min-width:408px !important;">
            <telerik:RadGrid ID="rdgAvancedListDetails" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowSorting="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowPaging="true" PageSize="20" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Code*" UniqueName="Code" SortExpression="Code">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCode" MaxLength="20" runat="server" Text='<%#Eval("Code")%>' Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                    CssClass="Validator" ErrorMessage="<br />Required." Display="Dynamic"
                                    ForeColor="" ValidationGroup="AvancedList" meta:resourcekey="rfvCode"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="300px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" HeaderStyle-Width="55px" ItemStyle-Wrap="false" DataField="Inactive" DataType="System.Boolean"
                            SortExpression="Inactive" UniqueName="Inactive"
                            GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkInactive" Checked='<%# Eval("Inactive")%>' runat="server" class="mobile-switch" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <SortExpressions>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" Visible='<%# rdgAvancedListDetails.EditIndexes.Count = 0 And (Not rdgAvancedListDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="AvancedList"
                                CommandName="UpdateEdited" Visible='<%# rdgAvancedListDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" ValidationGroup="AvancedList"
                                CommandName="PerformInsert" Visible='<%# rdgAvancedListDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                CommandName="CancelAll" Visible='<%# rdgAvancedListDetails.EditIndexes.Count > 0 Or rdgAvancedListDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" Visible='<%# rdgAvancedListDetails.EditIndexes.Count = 0 And (Not rdgAvancedListDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgAvancedListDetails.EditIndexes.Count = 0 And (Not rdgAvancedListDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="GridCmdRebindGrid" CausesValidation="false" CommandName="RebindGrid" Visible='<%# rdgAvancedListDetails.EditIndexes.Count = 0 And (Not rdgAvancedListDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                            </asp:LinkButton>



                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="AvancedList" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
            <telerik:RadGrid ID="rdgAvancedListBillingTerms" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                AutoGenerateColumns="False" ShowStatusBar="true" Width="100%"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowPaging="true" PageSize="20" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Sort Order" UniqueName="SortOrder" SortExpression="SortOrder" Groupable="false" Reorderable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <%#Container.DataItem("SortOrder").ToString%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblSortOrder" runat="server" Text='<%#Eval("SortOrder")%>' Width="50%"></asp:Label>
                            </EditItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="50px" />
                            
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Terms" UniqueName="Terms" SortExpression="Terms">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Terms") = String.Empty, "&nbsp;", Container.DataItem("Terms"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTerms" MaxLength="500" runat="server" Text='<%#Eval("Terms")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="300px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Discount Due" UniqueName="DiscountDue" SortExpression="DiscountDue">
                            <ItemTemplate>
                                <%#FormatNumber(Container.DataItem("DiscountDue"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDiscountDue" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("DiscountDue")))%>' Width="100%" CssClass="Right"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Units" UniqueName="Units" SortExpression="Units">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UnitName") = String.Empty, "&nbsp;", Container.DataItem("UnitName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUnit" runat="server" Width="100%"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Discount %" UniqueName="Discount" SortExpression="Discount">
                            <ItemTemplate>
                                <%#FormatPercent(Container.DataItem("Discount"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDiscount" runat="server" Text='<%# FormatPercent(ParseDouble(Eval("Discount")))%>' Width="100%" CssClass="Percent"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Net Due" UniqueName="NetDue" SortExpression="NetDue">
                            <ItemTemplate>
                                <%#Container.DataItem("NetDue")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNetDue" runat="server" Text='<%# Eval("NetDue")%>' Width="100%" CssClass="Integer"></asp:TextBox>
                            </EditItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" HeaderStyle-Width="55px" ItemStyle-Wrap="false" DataField="Inactive" DataType="System.Boolean"
                            SortExpression="Inactive" UniqueName="Inactive"
                            GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkInactive" Checked='<%# Eval("Inactive")%>' runat="server" class="mobile-switch" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <SortExpressions>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count = 0 And (Not rdgAvancedListBillingTerms.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="AvancedList" CssClass="GridCmdUpdateEdited"
                                CommandName="UpdateEdited" Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true"
                                SecurityButtonType="AddEditMode_Add" ValidationGroup="AvancedList" CssClass="GridCmdPerformInsert"
                                CommandName="PerformInsert" Visible='<%# rdgAvancedListBillingTerms.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count > 0 Or rdgAvancedListBillingTerms.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count = 0 And (Not rdgAvancedListBillingTerms.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count = 0 And (Not rdgAvancedListBillingTerms.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;

                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="GridCmdRebindGrid" CausesValidation="false" CommandName="RebindGrid" Visible='<%# rdgAvancedListBillingTerms.EditIndexes.Count = 0 And (Not rdgAvancedListBillingTerms.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                            </asp:LinkButton>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="AvancedList" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
            <telerik:RadGrid ID="rdgClauses" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                AutoGenerateColumns="False" ShowStatusBar="true" ShowGroupPanel="true" AllowSorting="true" Width="100%" AppendMenus="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowPaging="true" PageSize="20" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Module" UniqueName="Module" SortExpression="Module" GroupByExpression="Module [GridColumn_Module] Group By Module ASC" Reorderable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <%#Container.DataItem("Module").ToString%>
                            </ItemTemplate>

                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Record Type" UniqueName="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC" SortExpression="RecordType" Reorderable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <%#Container.DataItem("RecordType").ToString%>
                            </ItemTemplate>

                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgCat" Style="cursor: pointer" meta:resourcekey="imgCat"
                                    ToolTip="Category" runat="server">
                                               <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgType" Style="cursor: pointer" meta:resourcekey="imgType" ToolTip="Type" runat="server">   
                                            <span class="Icon"></span>
                                </asp:LinkButton>

                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Responsible" UniqueName="Responsible" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgResponsible" Style="cursor: pointer" meta:resourcekey="imgResponsible" ToolTip="Responsible" runat="server">
                                              <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="true">
                </ClientSettings>
                <ValidationSettings ValidationGroup="AvancedList" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
        </div>
    </div>
</div>

