<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="IntegrationManager.aspx.vb" Inherits="Website.IntegrationManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="IntegrationManagerConfigure.ascx" TagName="IntegrationManagerConfigure" TagPrefix="uc1" %>
<%@ Register Src="IntegrationManagerProjects.ascx" TagName="IntegrationManagerProjects" TagPrefix="uc2" %>
<%@ Register Src="IntegrationManagerSchedule.ascx" TagName="IntegrationManagerSchedule" TagPrefix="uc3" %>
<%@ Register Src="IntegrationManagersViewExportedFiles.ascx" TagName="IntegrationManagersViewExportedFiles" TagPrefix="uc4" %>
<%@ Register Src="IntegrationManagerReleaseRecords.ascx" TagName="IntegrationManagerReleaseRecords" TagPrefix="uc5" %>
<%@ Register Src="IntegrationManagerRejectionlog.ascx" TagName="IntegrationManagerRejectionlog" TagPrefix="uc6" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">


            function OpenImportTemplate() {
                window.open('http://www.pmweb.com/Pages/IntegrationManagerDownloads.aspx',
                            'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes,resizable=yes');

                return false;
            }
            function onSelectedIndexChanging(sender, eventArgs) {
                if (sender.get_value() == '0') {
                    var ddlReCordTypes = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlRecordType');
                    var textId = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('ddlSelectFields')) + 'txtId' + "]")[0];
                    var RecordTypeId = ddlReCordTypes.get_value();
                    var ExportRecordId = textId.value;
                    var Page = "SelectFieldsPopup.aspx?objectTypeId=" + RecordTypeId
                     + "&ExportRecordId=" + ExportRecordId + "&Type=0";
                    OpenPOPUp(Page, 593, 620, false);
                }
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function OpenSelectFieldPopup(Page) {
                OpenPOPUp(Page, 690, 475, false);
            }
            function OpenSelectFieldPopupFromLink(Page) {
                var rdgRecords = $find($("[id$=rdgRecords]")[0].id);
                if (rdgRecords.MasterTableView.get_isItemInserted() == 'true')
                    return;
                if (rdgRecords._editIndexes.length > 0)
                    return;
                OpenPOPUp(Page, 593, 620, true, 'rdgRecords');
            }

            function OpenMapFields(Page) {
                OpenPOPUp(Page, 800, 600, false);
                return false;
            }
            function SetfileName(combobox, eventArgs) {
                var SelecteText;

                var txtfileName = $("[id$=" + combobox.get_id().substring(0, combobox.get_id().lastIndexOf('ddlRecordType')) + 'txtFileName' + "]")[0];
                var ddlSelectFields = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlSelectFields');
                var chkDeletePrevious = $("[id$=" + combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_chbDeletePrevious]');
                SelectedText = combobox.get_text();

                if (combobox.get_value() == "0" || combobox.get_value() == "") {
                    txtfileName.value = "";
                }
                else {
                    if (txtfileName)
                        txtfileName.value = SelectedText.replace(" ", "_");
                    if (ddlSelectFields) {
                        ddlSelectFields.trackChanges();
                        ddlSelectFields.findItemByValue("1").select();
                        ddlSelectFields.set_text(ddlSelectFields.findItemByValue("1").get_text());
                        ddlSelectFields.commitChanges();
                    }

                    if (combobox.get_value() == "1" || combobox.get_value() == "9" || combobox.get_value() == "52" || combobox.get_value() == "112" || combobox.get_value() == "80" || combobox.get_value() == "115") {
                        chkDeletePrevious.attr("disabled", "disabled");
                    }
                    else {
                        chkDeletePrevious.removeAttr("disabled");
                    }

                }
            }
            function showContextMenu(sender, e) {
                var menu = $find($("[id$=cm1]")[0].id);
                var rawEvent = e.get_domEvent().rawEvent;
                menu.show(rawEvent);
                if (e.get_item() != null)
                    e.get_item().select();
                $telerik.cancelRawEvent(rawEvent);
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(value) {
                var Id = '<%=PM.IntegrationManagerInfo.Id%>';
                var HasReports = '<%= PM.IntegrationManagerInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.IntegrationManagerInfo.ProfileID & " - " & PM.IntegrationManagerInfo.Description)%>';
                switch (value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var browserWidth = $telerik.$(window).width();
                            var browserHeight = $telerik.$(window).height();
                            var wnd = window.radopen("ReportsPreviewPopup.aspx?ObjectType=INTEGRATIONMANAGER&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0&EntityType=0");
                            if (isMobileScreen()) {
                                wnd.setSize(browserWidth - 10, browserHeight - 10);
                                wnd.moveTo(8, 0);
                            }
                            else {
                                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                                wnd.Center();
                            }
                            return false;
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            var browserWidth = $telerik.$(window).width();
                            var browserHeight = $telerik.$(window).height();
                            var wnd = window.radopen("ReportsPreviewPopup.aspx?ObjectType=INTEGRATIONMANAGER&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0&EntityType=0");
                            if (isMobileScreen()) {
                                wnd.setSize(browserWidth - 10, browserHeight - 10);
                                wnd.moveTo(8, 0);
                            }
                            else {
                                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                                wnd.Center();
                            }
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'WebServiceInstaller':
                        return OpenImportTemplate();
                    default:

                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }

            }
            var forceMoreMenuToClose = true;
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

        </script>
    </telerik:RadCodeBlock>
    <script src="JS/Portfolio/IntegrationManager.js" type="text/javascript"></script>

    <table style="width: 100%; vertical-align: top;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar SmallToolbar">
            <td style="vertical-align: middle; width: 80%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Add"
                            CommandName="New" AccessKey="n" CausesValidation="false" EnableImageSprite="true" CssClass="ToolbarNew">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                            Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" ToolTip="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CausesValidation="false"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton meta:resourcekey="btnWebServInstaller" runat="server" CausesValidation="false" CommandName="WebServiceInstaller"
                            CssClass="lnkButtonBar" Width="190px" Text="Get WEB SERVICE INSTALLER" OuterCssClass="HideOnMobileToolbar" Visible="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Get WEB SERVICE INSTALLER" Value="WebServiceInstaller" CssClass="lnkButtonBar"
                                                     EnableImageSprite="true" Visible="false">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%" align="right"></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" CssClass="documentTabs"
        runat="server" MultiPageID="mlpIntegration" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="false" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Configure" Value="Configure" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Projects" Value="Projects"></telerik:RadTab>
            <telerik:RadTab Text="Schedule" Value="Schedule"></telerik:RadTab>
            <telerik:RadTab Text="Exported Files" Value="ExportedFiles"></telerik:RadTab>
            <telerik:RadTab Text="Release Records for Export" Value="ReleaseRecordsForExport"></telerik:RadTab>
            <telerik:RadTab Text="Rejection Logs" Value="RejectionLogs"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpIntegration" runat="server" SelectedIndex="0" Width="100%"
        RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvConfigure" runat="server" Width="100%" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%"
                LoadingPanelID="ldpPM">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4">
                            <table id="tblCheckListInfo" class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProfileId" runat="server" Text="Profile ID*" meta:Resourcekey="lblProfileId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" Text="SAP" MaxLength="15"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvCode" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" meta:Resourcekey="lblCommIDUnique"
                                            Visible="False" Class="Validator" Text="Profile ID must be unique."></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" Text="Description" meta:Resourcekey="lblDescription" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" Text="SAP Profile" runat="server" MaxLength="250"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr style="display: none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblNotify" Visible="false" Text="Notify" meta:Resourcekey="lblNotify" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlUsers" Visible="false" runat="server" AllowCustomText="true" meta:Resourcekey="ddlUsers"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                            Height="200px" Width="100%" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <fieldset>
                                <legend>
                                    <asp:Label runat="server" Text="Out From PMWeb" CssClass="legend" meta:resourcekey="lblOutFromPMweb" ID="lblOutFromPMweb"></asp:Label>
                                </legend>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row row-8-4-fit8" style="padding-top: 0px">
                        <div class="col-4">
                            <table class="colTable" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutputileAS" runat="server" meta:resourcekey="lblOutputileAS" Text="Output File As"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlOutputFile" Width="100%" runat="server">
                                            <Items>
                                                <telerik:RadComboBoxItem Selected="True" Text="MS Excel" Value="1"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Text(Comma Delimited)" Value="2"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Text(Tab Delimited)" Value="3"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Text(Pipe Delimited)" Value="5"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="XML" Value="4"></telerik:RadComboBoxItem>
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" Text="Overwrite Files" CssClass="legend" meta:resourcekey="chkOverwriteFiles" ID="lblOverwriteFiles"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <label class="switch">
                                            <input id="chkOverwriteFiles" runat="server" type="checkbox" />
                                            <span class="slider round"></span>
                                        </label>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutWebserviceUrl" Text="Web Service URL" meta:Resourcekey="lblOutWebserviceUrl" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOutWebserviceUrl" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutUseCredential" Text="Use Network Credentials" meta:Resourcekey="lblOutUseCredential" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <label class="switch">
                                            <input id="chkOutUseCredential" runat="server" type="checkbox" onchange="EnableDisableOutCredential(this, event);" />
                                            <span class="slider round"></span>
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutUser" Text="User" meta:Resourcekey="lblOutUser" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOutUser" MaxLength="500" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutPassword" Text="Password" meta:Resourcekey="lblOutPassword" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOutPassword" MaxLength="130" runat="server" TextMode="Password" Enabled="false" Style="box-sizing: border-box; width: 100%; line-height: 20px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOutFilePath" Text="Folder Path*" meta:Resourcekey="lblOutFolderPath" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOutFilePath" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-8 AddTopPaddWhenUnfit">

                            <telerik:RadGrid ID="rdgRecords" runat="server" SetWidth="true" AppendMenus="true" UseEditFormInMobile="true"
                                AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="250"
                                ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True"
                                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="True" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                    EditMode="InPlace" EnableHeaderContextMenu="false">
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Record Type" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                                            UniqueName="RecordType" SortExpression="RecordType">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlRecordType" MarkFirstMatch="true" runat="server" OnClientSelectedIndexChanged="SetfileName"
                                                    Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True" Filter="Contains"
                                                    CausesValidation="False">
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="txtId" Value='<%#Eval("Id")%>' runat="server"></asp:HiddenField>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Select Fields" UniqueName="SelectFields" SortExpression="SelectFields"
                                            GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields">

                                            <ItemTemplate>
                                                <asp:HyperLink ID="hplSelectFields" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                    Text='<%#IIf(Container.DataItem("SelectFields") = String.Empty, "&nbsp;", Container.DataItem("SelectFields"))%>'></asp:HyperLink>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox OnClientDropDownClosed="onSelectedIndexChanging"
                                                    ID="ddlSelectFields" Width="100%" runat="server">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Record Status" UniqueName="RecordStatus" SortExpression="RecordStatus"
                                            GroupByExpression="RecordStatus [GridColumn_RecordStatus] Group By RecordStatus ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("RecordStatus") = String.Empty, "&nbsp;", Container.DataItem("RecordStatus"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlRecordStatus" runat="server" Height="250px" Filter="Contains" MarkFirstMatch="true"
                                                    AllowCustomText="True" Width="100%" DropDownWidth="300px">
                                                    <ItemTemplate>
                                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                                            <asp:CheckBox runat="server" ID="chkApplySkills" />
                                                            <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                                            <%#Eval("Value")%>
                                                        </div>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="File Name" SortExpression="FileName" UniqueName="FileName"
                                            GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("FileName") = String.Empty, "&nbsp;", Container.DataItem("FileName"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtFileName" runat="server" Text='<%# Eval("FileName") %>' Width="100%"
                                                    MaxLength="4000"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFileName" ValidationGroup="Record"
                                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Decimal Places" UniqueName="DecimalPalces"
                                            SortExpression="DecimalPalces" GroupByExpression="DecimalPalces [GridColumn_DecimalPalces] Group By DecimalPalces ASC">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("DecimalPalces")%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDecimalPalces" runat="server" Width="100%" CssClass="Integer"
                                                    MaxLength="15" MinNumber="2" MaxNumber="6" Text='<%# IIF(Eval("DecimalPalces") is system.DBNULL.value, "2", Eval("DecimalPalces")) %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="70px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Enable Auto <br> Send" UniqueName="EnableAutoSend" HeaderStyle-Width="50px"
                                            ItemStyle-Wrap="false" SortExpression="EnableAutoSend" GroupByExpression="EnableAutoSend [GridColumn_EnableAutoSend] Group By EnableAutoSend ASC"
                                            ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("EnableAutoSend"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                                    alt="" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chbEnableAutoSend" Checked='<%# Cbool(IIF(Eval("EnableAutoSend") is system.DBNULL.value, 0,Eval("EnableAutoSend")))%>'
                                                    runat="server" />
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <ItemStyle Wrap="false" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnEditSelectedResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgRecords.EditIndexes.Count > 0 %>'
                                                meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Record">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgRecords.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                SecurityButtonType="AddEditMode" Visible='<%# rdgRecords.EditIndexes.Count > 0 Or rdgRecords.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnAddResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnRefreshResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSendNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="GridCmdAward"
                                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnSendNow">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSendNow" runat="server" Text="Send Selected Lines" meta:resourcekey="btnSendNow"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <%--<asp:Button ID="btnSendNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="LargeButton"
                                                                            SecurityButtonType="ItemMode_Add" Text="Manual Send" meta:resourcekey="btnSendNow"
                                                                            Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>' />--%>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="False">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                        AllowColumnResize="True" />
                                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Record" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                            </telerik:RadGrid>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblInToPmweb" Text="In To PMWeb" CssClass="legend" meta:resourcekey="lblInToPmweb" runat="server"></asp:Label>
                                </legend>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row row-8-4-fit8">
                        <div class="col-4">
                            <table cellpadding="0" cellspacing="0" class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInWebserviceUrl" Text="Web Service URL" meta:Resourcekey="lblInWebserviceUrl" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInWebserviceUrl" runat="server" Width="99%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInUseCredential" Text="Use Network Credentials" meta:Resourcekey="lblInUseCredential" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                            <label class="switch">
                                            <input id="chkInUseCredential" runat="server" type="checkbox" onchange="EnableDisableCredential(this, event);" />
                                            <span class="slider round"></span>
                                        </label>
                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInUser" Text="User" meta:Resourcekey="lblInUser" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInUser" MaxLength="500" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInPassword" Text="Password" meta:Resourcekey="lblInPassword" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInPassword" MaxLength="130" TextMode="Password" runat="server" Enabled="false" Style="box-sizing: border-box; width: 100%; line-height: 20px"></asp:TextBox>
                                    </td>
                                </tr>
                        <%--        <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInFilePath" Text="FOLDER PATH*" meta:Resourcekey="lblInFolderPath" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInFilePath" runat="server"></asp:TextBox>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth">
                                        <asp:Button ID="btnViewTemplate" meta:resourcekey="btnViewTemplate" Width="100%" runat="server" CausesValidation="false"
                                            OnClientClick="return OpenImportTemplate();"
                                            Text="GET FILE TEMPLATES"></asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-8 AddTopPaddWhenUnfit">

                            <telerik:RadGrid ID="rdgImportRecords" runat="server" SetWidth="true" AppendMenus="true" UseEditFormInMobile="true"
                                AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="250"
                                ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True"
                                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="True" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                    EditMode="InPlace" EnableHeaderContextMenu="false">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Record Type" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                                            UniqueName="RecordType" SortExpression="RecordType">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlRecordType" MarkFirstMatch="true" runat="server" Filter="Contains" OnClientSelectedIndexChanged="SetfileName"
                                                    Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                                                    CausesValidation="False">
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="txtId" Value='<%#Eval("Id")%>' runat="server"></asp:HiddenField>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Download Template" UniqueName="DownloadTemplate"
                                            GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields" Groupable="false">

                                            <ItemTemplate>
                                                <asp:HyperLink ID="hplDownloadTemplate" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                    Text="Download Template" Target="_blank"
                                                    NavigateUrl='http://www.pmweb.com/pages/integrationmanagerdownloads.aspx'></asp:HyperLink>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                &nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Map Fields" UniqueName="MapFileds"
                                            GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields" Groupable="false">

                                            <ItemTemplate>
                                                <asp:HyperLink ID="hplMapFileds" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                    Text='<%#IIf( Container.DataItem("MapFields") is dbnull.value orelse Container.DataItem("MapFields")=string.empty, "&nbsp;", Container.DataItem("MapFields"))%>'></asp:HyperLink>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                &nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="File Path*" SortExpression="ImportFileName" UniqueName="FilePath"
                                            GroupByExpression="ImportFileName [GridColumn_ImportFileName] Group By ImportFileName ASC" DataField="ImportFileName">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("ImportFileName") = String.Empty, "&nbsp;", Container.DataItem("ImportFileName"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtImportFileName" runat="server" Text='<%# Eval("ImportFileName") %>' Width="100%"
                                                    MaxLength="4000"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtImportFileName" ValidationGroup="Record"
                                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Enable Auto <br> Receive" UniqueName="EnableAutoReceive" HeaderStyle-Width="50px"
                                            ItemStyle-Wrap="false" SortExpression="EnableAutoReceive" GroupByExpression="EnableAutoReceive [GridColumn_EnableAutoReceive] Group By EnableAutoReceive ASC"
                                            ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EnableAutoReceive")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                    alt="" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chbEnableAutoReceive" Checked='<%# CBool(IIf(Eval("EnableAutoReceive") Is System.DBNull.Value, 0, Eval("EnableAutoReceive")))%>'
                                                    runat="server" />
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Delete Previous" UniqueName="DeletePrevious" HeaderStyle-Width="50px"
                                            ItemStyle-Wrap="false" SortExpression="DeletePreviousRecord" GroupByExpression="DeletePreviousRecord [GridColumn_DeletePrevious] Group By DeletePreviousRecord ASC"
                                            ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("DeletePreviousRecord")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                    alt="" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chbDeletePrevious" Checked='<%# CBool(IIf(Eval("DeletePreviousRecord") Is System.DBNull.Value, 0, Eval("DeletePreviousRecord")))%>'
                                                    runat="server" />
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <ItemStyle Wrap="false" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnEditSelectedResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgImportRecords.EditIndexes.Count > 0 %>'
                                                meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Record">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgImportRecords.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                SecurityButtonType="AddEditMode" Visible='<%# rdgImportRecords.EditIndexes.Count > 0 Or rdgImportRecords.MasterTableView.IsItemInserted %>'
                                                meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnAddResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnRefreshResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnReceiveNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="GridCmdAward"
                                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                                meta:resourcekey="btnReceiveNow">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblReceiveNow" runat="server" Text="Receive Selected Lines" meta:resourcekey="btnReceiveNow"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <%--<asp:Button ID="btnReceiveNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="LargeButton"
                                                                            SecurityButtonType="ItemMode_Add" Text="Receive Selected Lines" meta:resourcekey="btnReceiveNow"
                                                                            Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>' />--%>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="False">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                        AllowColumnResize="True" />
                                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Record" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                            </telerik:RadGrid>

                        </div>

                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvProjects" runat="server" Visible="False">
            <uc2:IntegrationManagerProjects ID="IntegrationManagerProjects1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSchedule" runat="server" Visible="False">
            <uc3:IntegrationManagerSchedule ID="IntegrationManagerSchedule1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvViewExportedFiles" runat="server" Visible="False">
            <uc4:IntegrationManagersViewExportedFiles ID="IntegrationManagersViewExportedFiles1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvReleaseRecordsForExport" runat="server" Visible="False">
            <uc5:IntegrationManagerReleaseRecords ID="IntegrationManagerReleaseRecords1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRejectionLogs" runat="server" Visible="False">
            <uc6:IntegrationManagerRejectionlog ID="IntegrationManagerRejectionlog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
