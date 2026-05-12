<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WidgetPopup.aspx.vb" Inherits="Website.WidgetPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function OpenAddSQLReport() {
                var querystring = '<%=QueryStringSource %>'
                OpenPOPUp('Home_AddSQLReportLink.aspx',
                                'SQLReportLink');
                return false;

            }

            function OpenAddPMWebReport() {

                var left = (screen.width - 600) / 2;
                var top = (screen.height - 435) / 2;
                var querystring = '<%=QueryStringSource %>'
                if (querystring == "MySettingsLinks") {
                    OpenPOPUp('Home_AddPMWebReportLink.aspx?Id=0&Source=MySettingsLink', 1040, 435, null, null)
                }
                else {
                    OpenPOPUp('Home_AddPMWebReportLink.aspx?Id=0', 1040, 435, null, null)
                }

                //            OpenPOPUp('Home_AddPMWebReportLink.aspx', 755, 435, true, 'rdgLinks');
                return false;
            }

            function OpenAddBIReporting() {
                //OpenPOPUp('Home_AddSQLReportLink.aspx', 755, 435, true, 'rdgLinks');
                var left = (screen.width - 600) / 2;
                var top = (screen.height - 435) / 2;
                var querystring = '<%=QueryStringSource %>'
                if (querystring == "MySettingsLinks") {
                    OpenPOPUp('Home_AddSQLReportLink.aspx?Id=0&Source=MySettingsLink',
                                        'SQLReportLink');
                }
                else {
                    OpenPOPUp('Home_AddSQLReportLink.aspx?Id=0', '');
                }
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
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgLinks">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinks" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="btnRebindLinkGrid" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnRebindLinkGrid">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinks" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="btnRebindLinkGrid" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <asp:Panel runat="server" ID="pnlToolbar">
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                            <Items>
                                <telerik:RadToolBarButton Value="Save" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Value="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                    Value="Close">
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlNews" class="documentSplitter" Style="padding: 24px !important; position: relative !important; margin-top: 50px;">
            <table>
                <tr>
                    <td style="width: 160px; color: #666666 !important;">
                        <asp:Label runat="server" ID="lblRSSFeed" meta:resourcekey="lblRSSFeed" Text="RSS Feed"></asp:Label>
                    </td>
                    <td style="width: 440px">
                        <asp:TextBox runat="server" ID="txtRSSFeed" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlWebPage" Visible="false" class="documentSplitter" Style="padding: 24px !important; position: relative !important; margin-top: 50px;">
            <table>
                <tr>
                    <td style="width: 160px; color: #666666 !important;">
                        <asp:Label ID="lblWebPageUrl" runat="server" meta:resourcekey="lblWebPageUrl" Text="URL">
                        </asp:Label>
                    </td>
                    <td style="width: 440px">
                        <asp:TextBox runat="server" ID="txtWebPageUrl" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlWeather">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblCityCodes" runat="server" meta:resourcekey="lblCityCodes" Text="City Codes (Semicolon Separeted)">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCityCodes" runat="Server" Width="400px">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>

                        <asp:RadioButton ID="rdbCelsius" runat="server" Text="Celsius" GroupName="Unit" meta:resourcekey="rdbCelsius" CssClass="RadioCss" />&nbsp;&nbsp;&nbsp;
                        <asp:RadioButton ID="rdbFahrenheit" runat="server" Text="Fahrenheit" GroupName="Unit" meta:resourcekey="rdbFahrenheit" CssClass="RadioCss" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlLinks" runat="server">
            <telerik:RadGrid ID="rdgLinks" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true" UseEditFormInMobile="true"
                HeaderStyle-Font-Size="8" Width="99%" Height="99%" AutoGenerateColumns="False"
                AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True"
                PageSize="5">
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
                            SortExpression="NewPage">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("NewPage"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbNewWindow" Checked='<%# Cbool(IIF(Eval("NewPage") is system.DBNULL.value, 0,Eval("NewPage")))%>'
                                    runat="server" class="mobile-switch" />
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
                            <asp:LinkButton ID="btnAddPMWebReport" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Add" CssClass="GridCmdAddPMWebReport"
                                CommandName="AddPMWebReport" Visible='<%# rdgLinks.EditIndexes.Count = 0 AND (Not rdgLinks.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddPMWebReport" OnClientClick="javascript:return OpenAddPMWebReport();">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddPMWebReport" runat="server" Text="AddPMWebReport" meta:resourcekey="lblAddPMWebReport">
                                </asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddSQLReport" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Add" CssClass="GridCmdAddSQLReport"
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
            <asp:Button runat="server" ID="btnRebindLinkGrid" CssClass="Hide" />
            <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
                ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
                IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
                Top="">
            </telerik:RadWindowManager>
        </asp:Panel>
    </form>
</body>
</html>
