<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinkSetupPrimavera.ascx.vb" Inherits="Website.LinkSetupPrimavera" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPrimavera">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPrimavera" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="chkIsActive">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="chkIsActive" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMMainPage">
    <div class="row">
        <asp:CheckBox ID="chkIsActive" AutoPostBack="True" meta:resourcekey="chkIsActive"
    runat="server" Text="Make Primavera active" />
    </div>


    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgPrimavera" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" UseEditFormInMobile="true" ClientSettings-Scrolling-AllowScroll="true" setWidth="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="250">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default" HeaderStyle-Width="50px"
                            ItemStyle-Wrap="false" SortExpression="IsDefault" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbDefault" Checked='<%# CBool(IIf(Eval("IsDefault") Is System.DBNull.Value, 0, Eval("IsDefault")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Web Service URL*" UniqueName="URL" HeaderStyle-Width="311px"
                            SortExpression="URL">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("URL")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtURL" MaxLength="500" runat="server" Width="100%" Text='<%# Eval("URL") %>'>
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvURL" ControlToValidate="txtURL" ValidationGroup="Save"
                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Use Network <br> credential" UniqueName="UseNetworkCredential" HeaderStyle-Width="90px"
                            SortExpression="UseNetworkCredential">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("UseNetworkCredential")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbUseNetworkCredential" OnClick='EnableDisableCredential(this, event);' Checked='<%# CBool(IIf(Eval("UseNetworkCredential") Is System.DBNull.Value, 0, Eval("UseNetworkCredential")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Web Service<br> User" UniqueName="WebServiceUser" HeaderStyle-Width="100px"
                            SortExpression="WebServiceUser">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("WebServiceUser").ToString = String.Empty, "&nbsp;", Container.DataItem("WebServiceUser").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebServiceUser" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WebServiceUser") %>'>
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Web Service<br> Password" UniqueName="WebServicePassword" HeaderStyle-Width="90px"
                            SortExpression="WebServicePassword">
                            <ItemTemplate>
                                <span>***
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebServicePassword" MaxLength="130" Width="100%" runat="server" TextMode="Password">
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Domain" UniqueName="Domain" HeaderStyle-Width="100px"
                            SortExpression="Domain">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Domain").ToString = String.Empty, "&nbsp;", Container.DataItem("Domain").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDomain" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Domain") %>'>
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Server Name*" UniqueName="ServerName" HeaderStyle-Width="90px"
                            SortExpression="ServerName">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("ServerName")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtServerName" MaxLength="500" runat="server" Width="100%" Text='<%# Eval("ServerName") %>'>
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvServerName" ControlToValidate="txtServerName" ValidationGroup="Save"
                                    runat="server" ForeColor="" Display="Dynamic" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Database*" UniqueName="Database" HeaderStyle-Width="90px"
                            SortExpression="DatabaseName">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("DatabaseName").ToString = String.Empty, "&nbsp;", Container.DataItem("DatabaseName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDatabase" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("DatabaseName") %>'>
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDatabase" ControlToValidate="txtDatabase" ValidationGroup="Save"
                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Login*" UniqueName="Login" HeaderStyle-Width="90px"
                            SortExpression="Login">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Login").ToString = String.Empty, "&nbsp;", Container.DataItem("Login").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLogin" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Login") %>'>
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLogin" ControlToValidate="txtLogin" ValidationGroup="Save"
                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Password*" UniqueName="Password" HeaderStyle-Width="90px"
                            SortExpression="Password">
                            <ItemTemplate>
                                <span>***</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPassword" MaxLength="130" Width="100%" runat="server" TextMode="Password">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" ValidationGroup="Save"
                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="50px"
                            ItemStyle-Wrap="false" SortExpression="IsActive" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsActive")) = CBool(0), "checked.png", "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked="false"
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows"
                    Visible='<%# rdgPrimavera.EditIndexes.Count = 0 And (Not rdgPrimavera.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server"
                        Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="Save" CommandName="UpdateEdited"
                                Visible='<%# rdgPrimavera.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"
                                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert"
                                Visible='<%# rdgPrimavera.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll"
                                Visible='<%# rdgPrimavera.EditIndexes.Count > 0 Or rdgPrimavera.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"
                                    meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow"
                                Visible='<%# rdgPrimavera.EditIndexes.Count = 0 And (Not rdgPrimavera.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid"
                                Visible='<%# rdgPrimavera.EditIndexes.Count = 0 And (Not rdgPrimavera.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
</div>




