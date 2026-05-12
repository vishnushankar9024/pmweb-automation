<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="HomeSettings.aspx.vb" Inherits="Website.HomeSettings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OpenAddSQLReport() {

                var left = (screen.width - 600) / 2;
                var top = (screen.height - 400) / 2;
                window.open('Home_AddSQLReportLink.aspx',
                                    'SQLReportLink', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=1040,height=400,top=' + top + ',left=' + left);
                return false;

            }

            function OpenAddPMWebReport() {
                OpenPOPUp('Home_AddPMWebReportLink.aspx', 1040, 435, true, 'rdgLinks');
                return false;
            }

            function OpenAddBIReporting() {
                OpenPOPUp('Home_AddSQLReportLink.aspx', 1040, 435, true, 'rdgLinks');
                return false;
            }
            function OpenAddBIReportingForTab(Id, txtReportId, txtProjectId, txtPathId) {
                var left = (screen.width - 755) / 2;
                var top = (screen.height - 435) / 2;
                window.open('Home_AddSQLReportLink.aspx?Id=' + Id + '&Source=Tabs&txtReportId=' + txtReportId + '&txtProjectId=' + txtProjectId + '&txtUrl=' + txtPathId, '',
                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1040,height=435,top=' + top + ',left=' + left);


                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgLinks">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLinks" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgTabs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgTabs" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table style="width: 100%; padding: 0px;" cellpadding="5" cellspacing="0">
        <tr class="ToolBar">
            <td class="Padding7">
                <b>
                    <asp:Label meta:resourcekey="lblSettings" ID="lblSettings" runat="server" Text="My Settings">
                    </asp:Label></b>
            </td>
        </tr>
        <tr>
            <td>
                <div style="width: 600px;">
                    <fieldset style="height: 200;" runat="server" visible="false" id="fldHomeTabs">
                        <legend>
                            <asp:Label ID="lblHomeTabs" runat="server" meta:resourcekey="lblHomeTabs" Text="Home Tabs"></asp:Label></legend>

                        <telerik:RadGrid ID="rdgTabs" AllowMultiRowSelection="true" runat="server"
                            HeaderStyle-Font-Size="8" Width="99%" Height="99%" AutoGenerateColumns="False"
                            AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True"
                            PageSize="10">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Tab #" UniqueName="TabNumber" HeaderStyle-Wrap="false" SortExpression="TabNumber"
                                        Groupable="false" Reorderable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("TabNumber").ToString%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("TabNumber").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tab" UniqueName="Tab" HeaderStyle-Width="100px"
                                        SortExpression="Tab">
                                        <ItemTemplate>
                                            <span>
                                                <%#Container.DataItem("Tab")%>&nbsp;</span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("Tab").ToString%>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tab Name*" UniqueName="TabName" HeaderStyle-Width="100px"
                                        SortExpression="TabName">
                                        <ItemTemplate>
                                            <span>
                                                <%#Container.DataItem("TabName")%>&nbsp;</span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTabName" Width="100%" runat="server" Text='<%# Eval("TabName") %>'>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTabName" ControlToValidate="txtTabName"
                                                ValidationGroup="TabSave" runat="server" ForeColor="" CssClass="Validator" Display="Dynamic"
                                                ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="visible"
                                        HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                                        SortExpression="visible" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("visible"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chbvisible" Checked='<%# Cbool(IIF(Eval("visible") is system.DBNULL.value, 0,Eval("visible")))%>' runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="URL*" UniqueName="URL" HeaderStyle-Width="220px"
                                        SortExpression="URL">
                                        <ItemTemplate>
                                            <span>
                                                <%#IIf(Container.DataItem("URL").ToString = String.Empty, "&nbsp;", Container.DataItem("URL").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div style="width: 100%">
                                                <asp:TextBox ID="txtURL" Enabled="false" Width="80%" runat="server" Text='<%# Eval("URL") %>'>
                                                </asp:TextBox>
                                                <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton">
                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                                <asp:HiddenField runat="server" ID="hdnReportId" />
                                                <asp:HiddenField runat="server" ID="hdnProjectIds" />
                                            </div>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                    CommandName="EditRows" Visible='<%# rdgTabs.EditIndexes.Count = 0 AND (Not rdgTabs.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnEditSelectedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1">
                                                    </asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" securitybuttontype="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                            ValidationGroup="TabSave" CommandName="UpdateEdited" Visible='<%# rdgTabs.EditIndexes.Count > 0 %>'
                                            meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" securitybuttontype="AddEditMode" CssClass="GridCmdCancelAll"
                                            CommandName="CancelAll" Visible='<%# rdgTabs.EditIndexes.Count > 0 Or rdgTabs.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" securitybuttontype="ItemMode" CssClass="GridCmdRebindGrid"
                                            CommandName="RebindGrid" Visible='<%# rdgTabs.EditIndexes.Count = 0 AND (Not rdgTabs.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1">
                                            </asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false"
                                Resizing-AllowColumnResize="False">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                            </ClientSettings>
                            <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                        </telerik:RadGrid>


                    </fieldset>
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblNewsBox" runat="server" meta:resourcekey="lblNewsBox" Text="NewsBox">
                            </asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowNewsBox" runat="server" meta:resourcekey="lblShowNewsBox" Text="Show Box">
                                    </asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkShowNewsBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblRssFeed" runat="server" meta:resourcekey="lblRssFeed" Text="Rss Feed">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRssFeed" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblWeatherBox" runat="server" meta:resourcekey="lblWeatherBox" Text="Weather Box">
                            </asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowWeatherBox" runat="server" meta:resourcekey="lblShowWeatherBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkShowWeatherBox" runat="Server"></asp:CheckBox>
                                </td>
                                <td>
                                    <asp:RadioButton ID="rdbCelsius" runat="server" Text="Celsius" GroupName="Unit" meta:resourcekey="rdbCelsius" CssClass="RadioCss" />&nbsp;&nbsp;&nbsp;
                                     <asp:RadioButton ID="rdbFahrenheit" runat="server" Text="Fahrenheit" GroupName="Unit" meta:resourcekey="rdbFahrenheit" CssClass="RadioCss" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCityCodes" runat="server" meta:resourcekey="lblCityCodes" Text="City Codes (Semicolon Separeted)">
                                    </asp:Label>
                                </td>
                                <td colspan="2" style="width: 400px;">
                                    <asp:TextBox ID="txtCityCodes" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblSQLReportBox" runat="server" meta:resourcekey="lblSQLReportBox"
                                Text="SQL Report Box"></asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowSQLReportTab" runat="server" meta:resourcekey="lblShowSQLReportTab"
                                        Text="Show"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkShowSQLReportBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSQLReportServer" runat="server" meta:resourcekey="lblSQLReportServer"
                                        Text="Report Server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSQLReportServer" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSQLReportUrl" runat="server" meta:resourcekey="lblSQLReportUrl"
                                        Text="Report Url"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSQLReportUrl" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblLinks" runat="server" meta:resourcekey="lblLinks" Text="Links"></asp:Label></legend>
                        <table>
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowLinksBox" runat="server" meta:resourcekey="lblShowLinksBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkShowlinkBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="rdgLinks" AllowMultiRowSelection="true" runat="server" UseEditFormInMobile="true"
                                        HeaderStyle-Font-Size="8" Width="99%" Height="99%" AutoGenerateColumns="False"
                                        AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True"
                                        PageSize="10">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Description*" UniqueName="Description" HeaderStyle-Width="100px"
                                                    SortExpression="Description">
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#Container.DataItem("Description")%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtDescription" Width="100%" runat="server" Text='<%# Eval("Description") %>'>
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                                            ValidationGroup="Save" runat="server" ForeColor="" CssClass="Validator" Display="Dynamic"
                                                            ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                        </asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="URL*" UniqueName="URL" HeaderStyle-Width="220px"
                                                    SortExpression="URL">
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#IIf(Container.DataItem("URL").ToString = String.Empty, "&nbsp;", Container.DataItem("URL").ToString)%></span>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtURL" Width="100%" runat="server" Text='<%# Eval("URL") %>'>
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvURL" ControlToValidate="txtURL" ValidationGroup="Save"
                                                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                        </asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="New Window" UniqueName="NewWindow" HeaderStyle-Width="90px"
                                                    SortExpression="NewWindow">
                                                    <ItemTemplate>
                                                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("NewPage"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                                            alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chbNewWindow" Checked='<%# Cbool(IIF(Eval("NewPage") is system.DBNULL.value, 0,Eval("NewPage")))%>'
                                                            runat="server" />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <FooterStyle CssClass="GridFooter" />
                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                    CommandName="EditRows" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnEditSelectedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1">
                                                    </asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" securitybuttontype="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                        ValidationGroup="Save" CommandName="UpdateEdited" Visible='<%# rdgLinks.EditIndexes.Count > 0 %>'
                                                        meta:resourcekey="btnUpdateEditedResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" securitybuttontype="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                                        CommandName="PerformInsert" Visible='<%# rdgLinks.MasterTableView.IsItemInserted %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" securitybuttontype="AddEditMode" CssClass="GridCmdCancelAll"
                                                        CommandName="CancelAll" Visible='<%# rdgLinks.EditIndexes.Count > 0 Or rdgLinks.MasterTableView.IsItemInserted %>'
                                                        meta:resourcekey="btnCancelResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                                        CommandName="InitNewRow" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                        meta:resourcekey="btnAddResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                        securitybuttontype="ItemMode_Delete" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" securitybuttontype="ItemMode" CssClass="GridCmdRebindGrid"
                                                        CommandName="RebindGrid" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                        meta:resourcekey="btnRefreshResource1">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1">
                                                        </asp:Label>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnAddPMWebReport" runat="server" CausesValidation="False" securitybuttontype="ItemMode" CssClass="GridCmdAddPMWebReport"
                                                        CommandName="AddPMWebReport" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                        meta:resourcekey="btnAddPMWebReport" OnClientClick="javascript:return OpenAddPMWebReport();">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddPMWebReport" runat="server" Text="AddPMWebReport" meta:resourcekey="lblAddPMWebReport">
                                                        </asp:Label>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnAddSQLReport" runat="server" CausesValidation="False" securitybuttontype="ItemMode" CssClass="GridCmdAddSQLReport"
                                                        CommandName="AddSQLReport" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                                        meta:resourcekey="btnAddSQLReport" OnClientClick="javascript:return OpenAddBIReporting();">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddSQLReport" runat="server" Text="AddSQLReport" meta:resourcekey="lblAddSQLReport">
                                                        </asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false"
                                            Resizing-AllowColumnResize="False">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                                AllowColumnResize="True" />
                                        </ClientSettings>
                                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblCalendar" runat="server" meta:resourcekey="lblCalendar" Text="Calendar Box">
                            </asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowCalendarBox" runat="server" meta:resourcekey="lblShowCalendarBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkShowCalendarBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblWorkflowInbox" runat="server" meta:resourcekey="lblWorkflowInbox"
                                Text="WorkFlow Inbox Box"></asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowWorkfowInboxBox" runat="server" meta:resourcekey="lblShowWorkfowInboxBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkShowWorkfowInboxBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblDocumentTeamInbox" runat="server" meta:resourcekey="lblDocumentTeamInbox"
                                Text="Document Team Inbox Box"></asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowDocumentTeamInboxBox" runat="server" meta:resourcekey="lblShowDocumentTeamInboxBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkDocumentTeamInboxBox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblNotificationInbox" runat="server" meta:resourcekey="lblNotificationInbox"
                                Text="Notification Inbox"></asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">
                            <tr>
                                <td style="width: 200px;">
                                    <asp:Label ID="lblShowNotificationInboxBox" runat="server" meta:resourcekey="lblShowNotificationInboxBox"
                                        Text="Show Box"></asp:Label>
                                </td>
                                <td style="width: 400px;">
                                    <asp:CheckBox ID="chkNotificationInbox" runat="Server"></asp:CheckBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <fieldset style="height: 200;">
                        <legend>
                            <asp:Label ID="lblPortfolioSQLReportBox" runat="server" meta:resourcekey="lblPortfolioSQLReportBox"
                                Text="Portfolio Report"></asp:Label></legend>
                        <table style="width: 100%;" cellspacing="0" border="0" cellpadding="3">

                            <tr>
                                <td>
                                    <asp:Label ID="lblPortfolioSQLReportServer" runat="server" meta:resourcekey="lblPortfolioSQLReportServer"
                                        Text="Report Server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPortfolioSQLReportServer" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPortfolioSQLReportUrl" runat="server" meta:resourcekey="lblPortfolioSQLReportUrl"
                                        Text="Report Url"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPortfolioSQLReportUrl" runat="Server" Width="90%">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                    <div style="text-align: right; padding-top: 5px">
                        <asp:Button ID="btnSave" runat="Server" Text="Save" meta:resourcekey="btnSave" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>
</asp:Content>
