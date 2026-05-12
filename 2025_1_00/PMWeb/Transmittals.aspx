<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Transmittals.aspx.vb" Inherits="Website.Transmittals1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="TransmittlesItems.ascx" TagName="TransmittlesItems" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .controlWidth > .RadAjaxPanel {
            height:100%;
        }
    </style>
    <script type="text/javascript">
        function GoToDocument(page) {
            window.location = page;
            return false;
        }

        var forceradmenuToClose = false;
        var forceMoreMenuToClose = true;
        function rdvFromClicking(sender, args) {
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

        function rdvToClicking(sender, args) {
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

        function OnClientItemClosing(sender, args) {
            if (forceradmenuToClose) {
                forceradmenuToClose = false;
                return;
            }
            args.set_cancel(true);
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

    </script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateTransmittal") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Generate");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Document.DocumentTransmittalsInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Document.DocumentTransmittalsInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Document.DocumentTransmittalsInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.DocumentTransmittalsInfo.Description)%>';
                var Id = '<%= PM.Document.DocumentTransmittalsInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("TRANSMITTALS")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=TRANSMITTALS&Id=" +
                                    '<%= PM.Document.DocumentTransmittalsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.DocumentTransmittalsInfo.ProjectId%>' + "&EntityType=0",
                              'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=TRANSMITTALS&Id=" +
                               '<%= PM.Document.DocumentTransmittalsInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Document.DocumentTransmittalsInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TRANSMITTALS&Id=" +
                                    '<%= PM.Document.DocumentTransmittalsInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.DocumentTransmittalsInfo.ProjectId%>' + "&EntityType=0",
                             'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('TRANSMITTALS');
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TRANSMITTALS&Id=" +
                                    '<%= PM.Document.DocumentTransmittalsInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.DocumentTransmittalsInfo.ProjectId%>' + "&EntityType=0",
                             'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=TRANSMITTALS&Id=" + Id
                        + "&EntityId=" + '<%=PM.Document.DocumentTransmittalsInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "Transmittals.aspx";
                        break;

                    default:
                        break;
                }
            }

            function CloseMoreAssignMenu(sender, args) {
                forceMoreMenuToClose = true;
                var MoreMenu = $find($('.MoreMenu')[0].id);
                MoreMenu.findItemByValue('Assign').close()
                return false;
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>  
             <telerik:AjaxSetting AjaxControlID="mlpTransmittls">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTransmittls" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTransmittls" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server" Skin="Default">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlPhase">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlPhase" />
                    <telerik:AjaxUpdatedControl ControlID="txtTransmittalNumber" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlToContact">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlToContact" />
                    <telerik:AjaxUpdatedControl ControlID="txtAddress" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTransmittls" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpTransmittls">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTransmittls" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle; width: 70%;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                            Value="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" SecurityButtonType="Copy" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="CreateRevision" SecurityButtonType="Add" Visible="false">
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

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint rtbWrap rtbExpandDown rtbIconOnly"
                            EnableDefaultButton="false" PostBack="false">
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
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
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
                                                                            <span runat="server" id="rmd_rdCalendar" style="display: block">
                                                                                <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                    SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                    EnableTyping="True">
                                                                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                        runat="server">
                                                                                    </DateInput>
                                                                                    <Calendar ID="Calendar2" Skin="Default" runat="server">
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
                                                 <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('TRANSMITTALS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>                                                    
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('TRANSMITTALS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" SecurityButtonType="Calendar" CommandName="Assign" OuterCssClass="HideOnMobileToolbar" Value="btnAssign" ImageUrl="Images/ToolBar/PMWebW.gif">
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
                                                                    <span runat="server" id="rmd_rdCalendar" style="display: block">
                                                                        <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                            SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                            EnableTyping="True">
                                                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                runat="server">
                                                                            </DateInput>
                                                                            <Calendar ID="Calendar2" Skin="Default" runat="server">
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
                         <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%;"></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpTransmittls" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpTransmittls" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" LoadingPanelID="ldpPM" Width="100%" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$ Resources:ProjectManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server" 
                                            Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
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
                                        <asp:Label ID="lblPhase" runat="server" Text="<%$ Resources:ProjectManagement, Label_Phase %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" AutoPostBack="true" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPhase" runat="server" ControlToValidate="ddlPhase"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPhase" runat="server" ControlToValidate="ddlPhase"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label runat="server" meta:Resourcekey="lblTransmittlasNumber" ID="lblTransmittlasNumber" Text="Transmittal #*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="13" ID="txtTransmittalNumber"></asp:TextBox>
                                        <asp:RequiredFieldValidator meta:Resourcekey="rfvTransmittalNumbers" ID="rfvTransmittalNumber" ValidationGroup="Save" ControlToValidate="txtTransmittalNumber"
                                            Display="Dynamic" runat="server" ErrorMessage="Enter the Transmittal Number"
                                            CssClass="Validator"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblTransmittalNumUnique" meta:Resourcekey="lblTransmittalNumUniques" Text="<br>Transmittal Number should be unique by Project & Phase." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:ProjectManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" MaxLength="1000" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision%>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="width: 182px !important">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevision" runat="server" MaxLength="9" CssClass="PositiveInteger" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDocumentDate" runat="server" Text="<%$ Resources:ProjectManagement, Label_DocumentDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDocumentDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Width="99%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" Width="99%"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvRevisionDate" ControlToValidate="dtpDocumentDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
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
                                        <div style="float: left;">
                                            <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <%-- When Swap button is fixed remove display: none; from the Style --%>
                                                        <asp:LinkButton ID="imgSwap" Style="margin-left: 1px; display: none;" meta:resourcekey="imgSwap" CausesValidation="False" runat="server" ToolTip="Swap To & From"
                                                            CssClass="SwitchButton">
                                                                    <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton runat="server" ID="imgfilter1" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlToContact'),'Contacts')"
                                                            CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlToContact" runat="server" Width="200px" DropDownWidth="385px"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" AutoPostBack="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                                            OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
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
                                        <asp:RequiredFieldValidator ID="rfvContactToName" runat="server" ControlToValidate="ddlToContact"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvContactToName" runat="server" ControlToValidate="ddlToContact"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAdress" meta:resourcekey="lblAdress" runat="server" Text="Address"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtAddress" MaxLength="1000" TextMode="MultiLine" Height="60px" Style="box-sizing: border-box; width: 100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="txtAddress"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblFrom" meta:resourcekey="lblFrom" runat="server" Text="From"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlFromContact'),'Contacts')"
                                                CssClass="SearchButton">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFromContact" runat="server" Width="200px" DropDownWidth="385px"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
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
                                        <asp:RequiredFieldValidator ID="rfvContactFromName" runat="server" ControlToValidate="ddlFromContact"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvContactFromName" runat="server" ControlToValidate="ddlFromContact"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true"
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
                                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblShippedDate" meta:resourcekey="lblShippedDate" Text="Shipped Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpShippedDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpShippedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Width="99%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" Width="99%"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar1" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>

                                        <asp:RequiredFieldValidator ID="rfvShippedDate" ControlToValidate="txtShippedDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblShippedTime" meta:resourcekey="lblShippedTime" Text="Shipped Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpShippedTime" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                            SelectedDate='<%# Date.Today %>' Width="99%" Skin="Default" Culture="English (United States)"
                                            EnableTyping="True">
                                            <DateInput ID="DateInput5" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                runat="server">
                                            </DateInput>
                                            <Calendar ID="Calendar5" Skin="Default" runat="server">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvShippedTime" ControlToValidate="dtpShippedTime"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblVia" ID="lblVia" Text="Via"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlVia" AllowCustomText="True" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                            CloseDropDownOnBlur="true" Width="100%" NoWrap="true"
                                            ShowToggleImage="true">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvShippingCompanyName" runat="server" ControlToValidate="ddlVia"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvShippingCompanyName" runat="server" ControlToValidate="ddlVia"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblTrakingNumber" meta:resourcekey="lblTrakingNumber" Text="Tracking #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="100" ID="txtTrackingNumber"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvTrackingNumber" ControlToValidate="txtTrackingNumber"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblQuantity" runat="server" meta:resourcekey="lblQuantity" Text="Quantity"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtQuantity" CssClass="PositiveDouble" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvQuantity" ControlToValidate="txtQuantity"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTransmittalDueDate" meta:resourcekey="lblDueDate" runat="server" Text="Due Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtDueDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" Width="99%"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>

                                        <asp:RequiredFieldValidator ID="rfvDueDate" ControlToValidate="txtDueDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-4 col-4-middle" style="margin-top: 5px;">
                            <telerik:RadGrid ID="rdgRemarks" runat="server"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True"
                                AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="X" UniqueName="Select" HeaderStyle-Width="40px" Groupable="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelected" AutoPostBack="true" OnCheckedChanged="ChkboxSelected_Changed"
                                                    Checked='<%# CBool(IIf(Eval("Selected") Is System.DBNull.Value, 0, Eval("Selected")))%>'
                                                    runat="server" class="mobile-switch" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Remarks" UniqueName="Remark" HeaderStyle-Width="140px" Groupable="false"
                                            SortExpression="Remark">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Remark") = String.Empty, "&nbsp;", Container.DataItem("Remark"))%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
                                </ClientSettings>
                            </telerik:RadGrid>
                            <table class="colTable" style="margin-top: 28px">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblComment" meta:resourcekey="lblComment" runat="server" Text="Comment"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Height="82px" Style="box-sizing: border-box; width: 100%"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td valign="top">
                                        <uc15:AssetRotator ID="PMrot" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:TransmittlesItems ID="TransmittlesItems1" runat="server" />
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
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
