<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="RFI.aspx.vb" Inherits="Website.RFI" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server"> 
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpRFI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRFI" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRFI" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <style>
            .labelWidth div > a.SearchButton {
                line-height: 0;
            }
        </style>
        <script type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function GoToDocument(sender, eventArgs) {
                window.location = eventArgs.getDataKeyValue("Url");
            }

            function rdvContactsFromNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlFrom]")[0].id);
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);
                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }

            function rdvContactsToNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlTo]")[0].id);
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);
                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "GenerateChangeEvent") {

                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("GenerateCE");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Document.RFIInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Document.RFIInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Document.RFIInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.RFIInfo.Description)%>';
                var Id = '<%= PM.Document.RFIInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("RFI")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            var URL = "MergeTemplatePopup.aspx?ObjectType=RFI&Id=" +
                                    '<%= PM.Document.RFIInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.RFIInfo.ProjectId%>' + "&EntityType=0"
                            return OpenPOPUp(URL, 1045, 515, false, '');
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        var URL = "Notification.aspx?ObjectType=RFI&Id=" +
                              '<%= PM.Document.RFIInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.RFIInfo.ProjectId%>' + "&EntityType=0"
                        return OpenPOPUp(URL, 820, 500, false, '');
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            var URL = "ReportsPreviewPopup.aspx?ObjectType=RFI&Id=" +
                                  '<%= PM.Document.RFIInfo.Id%>'
                           + "&RecordDescription=" + RecordDescription
                           + "&EntityId=" + '<%=PM.Document.RFIInfo.ProjectId%>' + "&EntityType=0";
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                        case 'BIReporting':
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            var URL = "ReportsPreviewPopup.aspx?ObjectType=RFI&Id=" +
                                  '<%= PM.Document.RFIInfo.Id%>'
                           + "&RecordDescription=" + RecordDescription
                           + "&EntityId=" + '<%=PM.Document.RFIInfo.ProjectId%>' + "&EntityType=0";
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            var URL = "PMWebReports.aspx?ObjectType=RFI&Id=" + Id
                      + "&EntityId=" + '<%=PM.Document.RFIInfo.ProjectId%>' + "&EntityType=0"
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                    case 'New':
                        window.location = "RFI.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('RFI');
                        break;
                    default:
                        break;
                }
            }

            function MenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
            }

            function CloseAssignMenu(sender, args) {
                forceradmenuToClose = true;
                $find($('.DocumentAssign')[0].id).close()

                return false;
            }

            function OnClientItemClosing(sender, args) {
                if (forceradmenuToClose) {
                    forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function CloseMoreAssignMenu(sender, args) {
                forceMoreMenuToClose = true;
                var MoreMenu = $find($('.MoreMenu')[0].id);
                //only works on mobile because there is no hover.
                MoreMenu.findItemByValue('Assign').close()
                return false;
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    return;
                }
                args.set_cancel(true);
            }

            function OnClientLoad(editor, args) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
            }
            
            function OpenLinkedRecordsPopup() {                
                var Description = '<%=JSEscape(PM.Document.RFIInfo.Description)%>';
                var Id = '<%= PM.Document.RFIInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkedRecordsPopup.aspx?ObjectType=RFI&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkedRecordsPopup);
                return false;
            }

            function CloseLinkedRecordsPopup() {
                var btnRefreshLinkedRecords = $("[id$=btnRefreshLinkedRecords]");
                if (btnRefreshLinkedRecords) {
                    btnRefreshLinkedRecords.click();
                }
            }

            function OpenTransmittalsPopup() {
                var Description = '<%=JSEscape(PM.Document.RFIInfo.Description)%>';
                var Id = '<%= PM.Document.RFIInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('TransmittalsPopup.aspx?ObjectType=RFI&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseTransmittalsPopup);
                return false;
            }

            function CloseTransmittalsPopup() {
                var btnRefreshTransmittals = $("[id$=btnRefreshTransmittals]");
                if (btnRefreshTransmittals) {
                    btnRefreshTransmittals.click();
                }
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="SmallToolbar">
        <tr class="ToolBar">
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint ">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Change Event" Value="GenerateChangeEvent"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>

                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Import" Value="Assign" CssClass="Assign">
                                                    <Items>
                                                        <telerik:RadMenuItem>
                                                            <ItemTemplate>
                                                                <table style="width: 100%">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="MobileMenubtnAssign_Click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                       &nbsp; 
                                                                                                                                                                    </div>
                                                                            </asp:LinkButton>
                                                                            &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseMoreAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                                &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label runat="server" ID="lblAssigned" CssClass="lblAssigned"></asp:Label>
                                                                            <asp:LinkButton runat="server" ID="lnkRemoveAssignment" CssClass="removeAssign" OnClick="lnkRemoveAssignment_click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                                       &nbsp; 
                                                                                                                                                                                    </div>
                                                                            </asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                                                                <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                    SelectedDate='<%# Date.Today %>' Width="105px" Culture="English (United States)"
                                                                                    EnableTyping="True">
                                                                                    <DateInput ID="DateInput2"
                                                                                        runat="server">
                                                                                    </DateInput>
                                                                                    <Calendar ID="Calendar2" runat="server">
                                                                                    </Calendar>
                                                                                </telerik:RadDatePicker>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                                OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                            </telerik:RadComboBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>


                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('RFI');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('RFI');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items> 
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton SecurityButtonType="Add" CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" Value="Generate" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Change Event" Value="GenerateCE" CommandName="GenerateCE" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" SecurityButtonType="Calendar" OuterCssClass="HideOnMobileToolbar" CommandName="Assign" Value="btnAssign" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="DocumentAssign" OnClientItemClosing="OnClientItemClosing" ID="radmen" ClickToOpen="true" OnClientItemClicked="MenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="assign">
                                            <Items>
                                                <telerik:RadMenuItem>
                                                    <ItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="btnAssign_Click">
                                                                                            <div class="Icon">
                                                                                               &nbsp; 
                                                                                            </div>
                                                                    </asp:LinkButton>
                                                                    &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                               &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                                                        <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                            SelectedDate='<%# Date.Today %>' Width="105px" Culture="English (United States)"
                                                                            EnableTyping="True">
                                                                            <DateInput ID="DateInput2"
                                                                                runat="server">
                                                                            </DateInput>
                                                                            <Calendar ID="Calendar2" runat="server">
                                                                            </Calendar>
                                                                        </telerik:RadDatePicker>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                        OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton Value="btnDeleteAssign" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarDeleteAssign" SecurityButtonType="Calendar" ImageUrl="Images/Toolbar/user.png" CommandName="DeleteAssign" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="Hide">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpRFI" Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Team Input" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpRFI" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr valign="top">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server" 
                                            AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProject"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProject"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" Text="Phase" meta:resourcekey="lblPhase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPhase" runat="server" ControlToValidate="ddlPhase"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPhase" runat="server" ControlToValidate="ddlPhase"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" Visible="false" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblWBS" Text="WBS" meta:resourcekey="lblWBS"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgWBS">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">

                                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true"
                                            OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvWBS" runat="server" ControlToValidate="ddlWBS"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvWBS" runat="server" ControlToValidate="ddlWBS"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRFINum" meta:resourcekey="lblRFINum" runat="server" Text="RFI #*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRFINum" runat="server" MaxLength="13"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="cmpRFINum" runat="server" ControlToValidate="txtRFINum"
                                            CssClass="Validator" ErrorMessage="<br/>Enter RFI #" Display="Dynamic" ForeColor=""
                                            ValidationGroup="Save" Operator="NotEqual" meta:resourcekey="cmp_RFINum"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRFINumUnique" meta:resourcekey="lblRFINumUnique" Text="<br>RFI Number should be unique by Project & Phase." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDesctiption" runat="server" MaxLength="1000"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDesctiption"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status/Revision" meta:resourcekey="lblStatusRevision"></asp:Label>

                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server"
                                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" runat="server" MaxLength="9"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRFIDate" meta:resourcekey="lblRFIDate" runat="server" Text="RFI Date"></asp:Label>
                                    </td>
                                    <td class="nowrap controlWidth">
                                        <span runat="server" id="rmd_dtpRFIDate">
                                            <telerik:RadDatePicker ID="dtpRFIDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" EnableTyping="True">
                                                <DateInput ID="DateInput5" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvRFIDate" ControlToValidate="dtpRFIDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" runat="server" Text="Category11" meta:resourcekey="lblCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains"
                                            AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlFromContact'),'Contacts')">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFromContact" runat="server"  DropDownWidth="400px"
                                            CloseDropDownOnBlur="true" AutoPostBack="False" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvFrom" runat="server" ControlToValidate="ddlFromContact"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvFrom" runat="server" ControlToValidate="ddlFromContact"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblTo" runat="server" meta:resourcekey="lblTo" Text="To"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter1" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlToContact'),'Contacts')">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlToContact" runat="server" DropDownWidth="400px"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                                            OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTo" runat="server" ControlToValidate="ddlToContact"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTo" runat="server" ControlToValidate="ddlToContact"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTrade" meta:resourcekey="lblTrade" runat="server" Text="Trade"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTrade" Filter="Contains" AllowCustomText="true" runat="server" Style="font-size: 11px"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTrade" runat="server" ControlToValidate="ddlTrade"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTrade" runat="server" ControlToValidate="ddlTrade" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCSICode" meta:resourcekey="lblCSICode" runat="server" Text="CSI Code"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCSICode" runat="server" MaxLength="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCSICode" ControlToValidate="txtCSICode"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPriority" runat="server" Text="Priority" meta:resourcekey="lblPriority"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPriority" runat="server" Filter="Contains"
                                            AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ControlToValidate="ddlPriority"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPriority" runat="server" ControlToValidate="ddlPriority" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTask" meta:resourcekey="lblTask" runat="server" Text="Task"></asp:Label>

                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTasks" runat="server" Filter="Contains" DropDownWidth="465px"
                                            MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..."
                                            NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px" meta:resourcekey="ddlTasks">
                                            <HeaderTemplate>
                                                <table style="width: 435px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 275px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                        <td style="width: 80px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                        <td style="width: 80px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 435px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 275px;">
                                                            <%# DataBinder.Eval(Container, "Text")%>
                                                        </td>
                                                        <td style="width: 80px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['EarlyStartDate']")%>
                                                        </td>
                                                        <td style="width: 80px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['EarlyFinishDate']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>

                                    <td class="labelWidth">
                                        <asp:Label ID="lblScope" meta:resourcekey="lblScopeOfWork" runat="server" Text="Affects Scope of Work"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkScopeofWork" meta:resourcekey="chkScopeofWork" runat="server" />
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="LblCost" meta:resourcekey="lblAffectsCost" runat="server" Text="Affects Cost"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkCost" meta:resourcekey="chkCost" runat="server" />

                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="LblSchedule" meta:resourcekey="lblAffectsSchedule" runat="server" Text="Affects Schedule"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkSchedule" meta:resourcekey="chkSchedule" runat="server" />

                                    </td>

                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCENum" meta:resourcekey="lblChangeEvent" runat="server" Text="Change event"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCENum" runat="server" Enabled="false" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDateRequired" meta:resourcekey="lblDateRequired" runat="server" Text="Date Required"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDateRequired" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDateRequired" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                EnableTyping="True">
                                                <DateInput ID="DateInput2"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="rfvRequiredDate" ControlToValidate="dtpDateRequired"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDateAnswered" meta:resourcekey="lblDateAnswered" runat="server" Text="Date Answered"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDateAnswered" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDateAnswered" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                EnableTyping="True">
                                                <DateInput ID="DateInput1"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar1" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblLinkedRecords" meta:resourcekey="LblLinkedRecords" runat="server" Text="Linked Records"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedRecords" OnClientClick="return OpenLinkedRecordsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshLinkedRecords" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtLinkedRecords" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblTransmittals" meta:resourcekey="LblTransmittals" runat="server" Text="Transmittals"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtTransmittals" OnClientClick="return OpenTransmittalsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshTransmittals" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtTransmittals" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblQuestion" meta:resourcekey="lblQuestion" runat="server" Text="QUESTION" CssClass="legend"></asp:Label>
                                </legend>
                                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" Height="100%" Width="100%" Style="box-sizing: border-box;" Skin="Default" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    ID="edtQuestion" runat="server"
                                    OnClientLoad="OnClientLoad">
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblProposedSolution" meta:resourcekey="lblProposedSolution" runat="server" Text="PROPOSED SOLUTION" CssClass="legend"></asp:Label>
                                </legend>
                                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" Height="100%" Width="100%" Style="box-sizing: border-box;" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    ID="edtProposedSolution" runat="server"
                                    OnClientLoad="OnClientLoad">
                                    <Content>
                                    </Content>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblAnswer" meta:resourcekey="lblAnswer" runat="server" Text="ANSWER" CssClass="legend"></asp:Label>
                                </legend>
                                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js"  Height="100%" Width="100%" Style="box-sizing: border-box;" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    ID="edtAnswer" runat="server" OnClientLoad="OnClientLoad">
                                    <Content>
                                    </Content>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
