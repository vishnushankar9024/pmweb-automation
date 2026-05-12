<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EmailProjectSetupDetails.ascx.vb"
    Inherits="Website.EmailProjectSetupDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div class="PMHeader marginBottomOnMobile">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgSetupIncoming" runat="server" FitPageHeightOffset="24"
                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15" UseEditFormInMobile="true"
                ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" setwidth="true" FITABLECONTAINER="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%" CssClass="lightweight">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <HeaderContextMenu EnableViewState="false">
                </HeaderContextMenu>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    ShowGroupFooter="true" FooterStyle-HorizontalAlign="Right"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Location" UniqueName="PropertyName" HeaderStyle-Wrap="false"
                            SortExpression="PropertyName" GroupByExpression="PropertyName [GridColumn_PropertyName] Group By PropertyName ASC">
                            <ItemTemplate>
                                <span>
                                    <%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%# IIf(Container.DataItem("PropertyName") = String.Empty, "&nbsp;", Container.DataItem("PropertyName"))%></span>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" HeaderStyle-Wrap="false"
                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC">
                            <ItemTemplate>
                                <span>
                                    <%# IIf(Container.DataItem("ProjectFullName") = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%# IIf(Container.DataItem("ProjectFullName") = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName"))%></span>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Email Address" SortExpression="ProjectEmail"
                            GroupByExpression="ProjectEmail [GridColumn_ProjectEmail] Group By ProjectEmail ASC"
                            UniqueName="ProjectEmail">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("ProjectEmail")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectEmail" runat="server" Text='<%# Eval("ProjectEmail") %>'
                                    Width="100%">
                                </asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvProjectEmail" meta:resourcekey="rfvProjectEmail" CssClass="Validator"
                                        runat="server" ControlToValidate="txtProjectEmail" ErrorMessage="Required" Display="Dynamic" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div>
                                    <asp:RegularExpressionValidator ID="revProjectEmail" CssClass="Validator" meta:resourcekey="revProjectEmail"
                                        ControlToValidate="txtProjectEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        runat="server" ValidationGroup="Save" Display="Dynamic" ErrorMessage="Invalid Email.">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mail Server (POP3)" SortExpression="POPServer"
                            GroupByExpression="POPServer [GridColumn_POPServer] Group By POPServer ASC" UniqueName="POPServer">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("POPServer")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPOPServer" runat="server" Text='<%# Eval("POPServer") %>' Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPOPServer" meta:resourcekey="rfvPOPServer" CssClass="Validator"
                                    runat="server" ControlToValidate="txtPOPServer" ErrorMessage="Required" Display="Dynamic" ValidationGroup="Save">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Port (POP3)" SortExpression="POPPort" UniqueName="POPPort"
                            GroupByExpression="POPPort [GridColumn_POPPort] Group By POPPort ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("POPPort") = 0, "&nbsp;", Container.DataItem("POPPort"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPOPPort" CssClass="PositiveInteger" runat="server" Text='<%# Eval("POPPort") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Password" SortExpression="ProjectEmailPassword"
                            Groupable="false" UniqueName="ProjectEmailPassword">
                            <ItemTemplate>
                                <span>*******</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectEmailPassword" TextMode="Password" runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Use SSL" UniqueName="UseSSL" GroupByExpression="UseSSL [GridColumn_UseSSL] Group By UseSSL ASC">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIF(Eval("UseSSL"),"checked.png", "unchecked.png")) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkUseSSL" runat="server" Checked='<%# CBool(IIF(Eval("UseSSL") is system.DBNULL.value, False, Eval("UseSSL"))) %>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src='Images/Global/<%# CStr(IIF(Eval("Inactive"),"checked.png","unchecked.png" )) %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkInactive" runat="server" Checked='<%# CBool(IIF(Eval("Inactive") is system.DBNULL.value, False, CBool(Eval("Inactive")))) %>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <%--<asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add"
                            CommandName="InitNewRow" Visible='<%# rdgSetupIncoming.EditIndexes.Count = 0 AND (Not rdgSetupIncoming.MasterTableView.IsItemInserted) %>'>
                            <img style="border: 0px; vertical-align: middle;" alt="Add line" src="Images/Global/AddLine.png" />
                            <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                        </asp:LinkButton>--%>
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgSetupIncoming.EditIndexes.Count = 0 And (Not rdgSetupIncoming.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                ValidationGroup="Save" SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgSetupIncoming.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgSetupIncoming.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgSetupIncoming.EditIndexes.Count > 0 Or rdgSetupIncoming.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                    AllowDragToGroup="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
