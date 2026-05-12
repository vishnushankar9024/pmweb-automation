<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IssueDetails.ascx.vb" Inherits="Website.IssueDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgIssues">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgIssues" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgIssues" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" UseEditFormInMobile="true"
                AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder"
                Font-Size="8px" PageSize="20" ShowFooter="false" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" Name="Master">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_RecordNumber %>"
                            UniqueName="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC" SortExpression="RecordNumber">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliCode" runat="server" CssClass="NoWrap"
                                    Text='<%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%>'
                                    NavigateUrl='<%#CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                                <asp:Label ID="lblCode" Text='<%#Eval("RecordNumber")%>' runat="server"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRecordNumber" MaxLength="30" Width="100%" runat="server" Text='<%#Eval("RecordNumber")%>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvRecordNumber" meta:resourcekey="rfvRecordNumberRequired" runat="server"
                                    ControlToValidate="txtRecordNumber" CssClass="Validator" ErrorMessage="Required." Display="Dynamic"
                                    ValidationGroup="Detail">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_RecordType %>"
                            UniqueName="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC" SortExpression="RecordType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRecordType" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("RecordType")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ProjectNumber %>"
                            GroupByExpression="ProjectNumber [GridColumn_ProjectNumber] Group By ProjectNumber ASC" UniqueName="ProjectNumber" SortExpression="ProjectNumber">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectNumber") = String.Empty, "&nbsp;", Container.DataItem("ProjectNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectNumber" MaxLength="50" Width="100%" runat="server" Text='<%#Eval("ProjectNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ProjectName %>"
                            UniqueName="ProjectName" SortExpression="ProjectName" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectName") = String.Empty, "&nbsp;", Container.DataItem("ProjectName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectName" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("ProjectName")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>"
                            GroupByExpression="Description [GridColumn_Description] Group By Description ASC" UniqueName="Description" SortExpression="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                    Width="100%" MaxLength="1000"></asp:TextBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Value %>" UniqueName="Value" Groupable="false"
                            SortExpression="Value" GroupByExpression="Value [GridColumn_Value] Group By Value ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblValue" runat="server"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtValue" CssClass="Double" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatNumber(Eval("Value")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="244px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <ItemStyle Wrap="false" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgIssues.EditIndexes.Count = 0 And (Not rdgIssues.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="Detail"
                                Visible='<%# rdgIssues.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" ValidationGroup="Detail"
                                Visible='<%# rdgIssues.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgIssues.EditIndexes.Count > 0 Or rdgIssues.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgIssues.EditIndexes.Count = 0 And (Not rdgIssues.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgIssues.EditIndexes.Count = 0 And (Not rdgIssues.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgIssues.EditIndexes.Count = 0 And (Not rdgIssues.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            </span>
                        </div>
                    </CommandItemTemplate>
                    <DetailTables>
                    </DetailTables>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="False" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>


