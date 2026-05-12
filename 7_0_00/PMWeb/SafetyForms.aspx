<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SafetyForms.aspx.vb" Inherits="Website.SafetyForms" %>

<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="SafetyFormDetails.ascx" TagName="SafetyFormDetails" TagPrefix="uc2" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc3" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc4" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc5" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc6" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc7" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc8" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc9" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>

<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.Document.SafetyFormsInfo.ProjectId %>';
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Document.SafetyFormsInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("SAFETYFORMS")%>';
                var RecordDescription = '<%=JSEscape(PM.Document.SafetyFormsInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.SafetyFormsInfo.Description)%>';
                var Id = '<%= PM.Document.SafetyFormsInfo.Id%>';
                var HasReports = '<%= PM.Document.SafetyFormsInfo.HasReports%>';
                //                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("SafetyFORMS") %>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=SAFETYFORMS&Id=" +
                            '<%= PM.Document.SafetyFormsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.SafetyFormsInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=SAFETYFORMS&Id=" + Id
                    + "&EntityId=" + '<%=PM.Document.SafetyFormsInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=SAFETYFORMS&Id=" +
                        Id + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Document.SafetyFormsInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=SAFETYFORMS&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.SafetyFormsInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=SAFETYFORMS&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.SafetyFormsInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'New':
                        window.location = "SafetyForms.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('SAFETYFORMS');
                        break;


                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }


            function OnClientLoad(editor) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";

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
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpSafetyForms">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSafetyForms" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSafetyForms" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=198">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlSafetyForms" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlSafetyForms"
                    Width="240px" AutoPostBack="false" NoWrap="true" CausesValidation="False" OnItemsRequested="ddl_ItemsRequested"
                    Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                        Value="Search" NavigateUrl="SearchDocument.aspx?O=198" CausesValidation="false">
                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
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
                                                                            <%-- <telerik:RadDateInput Width="150px" ID="rdCalendar" runat="server" InvalidStyleDuration="100" EmptyMessage="Date">
                                                                                                                                                                </telerik:RadDateInput>--%>
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

                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('SAFETYFORMS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('SAFETYFORMS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
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
                                                                    <%-- <telerik:RadDateInput Width="150px" ID="rdCalendar" runat="server" InvalidStyleDuration="100" EmptyMessage="Date">
                                                                                        </telerik:RadDateInput>--%>
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
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" runat="server" MultiPageID="mlpSafetyForms" CssClass="documentTabs"
        ScrollChildren="true" ScrollButtonsPosition="Left" Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpSafetyForms" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" EnableAJAX="false" runat="server" Width="100%" LoadingPanelID="ldpPM">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true"
                                            meta:resourcekey="ddlProjects" OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvRequired"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfvProjects">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase" Text="Phase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            AutoPostBack="true" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPhaseName" runat="server" ControlToValidate="ddlPhase"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPhaseName" runat="server" ControlToValidate="ddlPhase"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" AutoPostBack="false"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
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
                                        <asp:Label ID="lblId" runat="server" Text="Record #*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvRequired" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" meta:Resourcekey="lblCommIDUnique" Visible="False" CssClass="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblSubmittedBy" runat="server" meta:ResourceKey="lblSubmittedBy" Text="Submitted By"></asp:Label>

                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgfiltersubmitted" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfiltersubmitted','HiddenField2'),this.id.replace('imgfiltersubmitted','ddlSubmittedBy'),'Contacts')"
                                                CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSubmittedBy" runat="server" DropDownWidth="400px"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
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
                                        <asp:RequiredFieldValidator ID="rfvSubmittedBy" runat="server" ControlToValidate="ddlSubmittedBy"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvSubmittedBy" runat="server" ControlToValidate="ddlSubmittedBy"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic" InitialValue=""
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="CsvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; min-width: 20px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" runat="server" MaxLength="9" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevisionNumber"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblIncidentDate" meta:resourcekey="lblIncidentDate" runat="server" Text="Incident Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpIncidentDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpIncidentDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                EnableTyping="True" Width="100%">
                                                <DateInput ID="DateInput5" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvIncidentDate" ControlToValidate="dtpIncidentDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblIncidentTime" meta:resourcekey="lblIncidentTime" runat="server" Text="Incident Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpIncidentTime" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>" Width="100%">
                                            <DateInput ID="DateInput1" runat="server"></DateInput>
                                            <Calendar ID="Calendar1" runat="server"></Calendar>
                                        </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvIncidentTime" ControlToValidate="dtpIncidentTime"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportDate" meta:resourcekey="lblReportDate" runat="server" Text="Report Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpReportDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpReportDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                EnableTyping="True" Width="100%">
                                                <DateInput ID="DateInput2" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvDocumentDate" ControlToValidate="dtpReportDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportTime" meta:resourcekey="lblReportTime" runat="server" Text="Report Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpReportTime" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Width="100%">
                                            <DateInput ID="DateInput3" runat="server"></DateInput>
                                            <Calendar ID="Calendar2" runat="server"></Calendar>
                                        </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvDocumentTime" ControlToValidate="dtpReportTime"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" meta:Resourcekey="lblCompany" runat="server" Text="Company"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter"
                                                OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')"
                                                CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" MarkFirstMatch="true"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                            OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" OnClientDropDownClosed="dllcompClientClosed">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies" InitialValue=""
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompanies" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateComboWithimgfilter" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:Resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" Height="250px" runat="server" AllowCustomText="true" Width="99%" Filter="Contains" MarkFirstMatch="true">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chkApply" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApply"></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTypes" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTypes" runat="server" ControlToValidate="ddlType"
                                            ClientValidationFunction="ValidateComboWithMultipleSelection" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:Resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" Height="250px" runat="server" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chkApply" />
                                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply"></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategories" ControlToValidate="ddlCategory" InitialValue=""
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategorie" runat="server" ControlToValidate="ddlCategory"
                                            ClientValidationFunction="ValidateComboWithMultipleSelection" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" meta:Resourcekey="lblReference" runat="server" Text="Reference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <fieldset id="fsWeather" runat="server">
                                <legend>
                                    <asp:Label runat="server" meta:resourcekey="lblWeather" ID="lblWeather" Text="Weather11" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblConditions" meta:resourcekey="lblConditions" runat="server" Text="Conditions"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlConditions" Height="250px" runat="server" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkApply" />
                                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvConditions" ControlToValidate="ddlConditions" InitialValue=""
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvConditions" runat="server" ControlToValidate="ddlConditions"
                                                ClientValidationFunction="ValidateComboWithMultipleSelection" ValidationGroup="Save" Display="Dynamic"
                                                CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTemperature" meta:resourcekey="lblTemperature" runat="server" Text="Temperature"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 8px;">
                                                        <asp:TextBox ID="txtTemperature" runat="server" CssClass="Double" MaxLength="15"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvTemperature" ControlToValidate="txtTemperature"
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 20px">
                                                        <asp:RadioButtonList ID="rblFrequency" AutoPostBack="False" CssClass="RadioCss RadioPadding" runat="server" RepeatLayout="Table" RepeatColumns="2" RepeatDirection="Horizontal" Width="100%">
                                                            <asp:ListItem Selected="True" Text="F" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="C" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPrecip" meta:resourcekey="lblPrecipitation" runat="server" Text="Precipitation Amount"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 8px;">
                                                        <asp:TextBox ID="txtPrecip" runat="server" CssClass="Double" MaxLength="15"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvPrecip" ControlToValidate="txtPrecip"
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td style="width: 50%;">
                                                        <telerik:RadComboBox ID="ddlUOM" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="rfvUOM" ControlToValidate="ddlUOM" InitialValue=""
                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CustomValidator ID="csvUOM" runat="server" ControlToValidate="ddlUOM"
                                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                        </asp:CustomValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset id ="fldsetWorkActivity" runat="server"> 
                                <legend>
                                    <asp:Label runat="server" class="legend" meta:resourcekey="lblWorkActivity" ID="Label3" Text="WorkActivity11"></asp:Label>
                                </legend>
                                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    Width="100%" Height="100%"
                                    ID="edtWorkActivity" runat="server" OnClientLoad="OnClientLoad">
                                    <Content></Content>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </fieldset>
                            <fieldset id ="fldsetIncident" runat="server">
                                <legend>
                                    <asp:Label runat="server" class="legend" meta:resourcekey="lblIncidentDescription" ID="lblIncidentDescription" Text="IncidentDescription11"></asp:Label>
                                </legend>
                                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                                    Width="100%" Height="100%"
                                    ID="edtIncident" runat="server" OnClientLoad="OnClientLoad">
                                    <Content></Content>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                </telerik:RadEditor>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc1:AssetRotator ID="PMrot" runat="server" />
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc2:SafetyFormDetails ID="SafetyFormDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc3:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc4:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc5:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc6:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc7:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc8:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc9:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
