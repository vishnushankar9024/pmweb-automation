<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ResourcesRequirements.aspx.vb" Inherits="Website.ResourcesRequirements" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ResourcesRequirementDetails.ascx" TagName="ResourcesRequirementDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc3" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%--<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>--%>
<%--<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc8" %>--%>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>


<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Scoring.js" type="text/javascript"></script>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRequirements" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpRequirements">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRequirements" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <script src="JS/Portfolio/ResourcesRequirements.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <style>
            html body .RadInput .riTextBox:disabled {
                opacity: 1;
                background-color: rgb(235, 235, 228) !important;
                color: black;
            }
        </style>

        <script type="text/javascript" id="ScrDetails">

            var rateHeader = '<%= PM.ResourcesRequirementsInfo.Amount%>';
            var Rate;

            function ValidateDetailsHoursPerDay(sender, args) {
                var value = sender.get_value();
                if (value > 24) {
                    sender.set_value(24);
                } else if (value < 0.01) {
                    sender.set_value(0.01);
                }
            }

            function ValidateDetailCombinedDate(sender, args) {
                var row = $(sender).parents(".rgEditForm:first");
                if (!row || row.length == 0)
                    row = $(sender).parents("tr:first");
                var dpStartDate = $find(row.find("input[id$='dtpStartDate']")[0].id)._dateInput.get_selectedDate();
                var dpFinishDate = $find(row.find("input[id$='dtpFinishDate']")[0].id)._dateInput.get_selectedDate();
                var dpStartTime = $find(row.find("input[id$='dtpStartTime']")[0].id)._dateInput.get_selectedDate();
                var dpFinishTime = $find(row.find("input[id$='dtpFinishTime']")[0].id)._dateInput.get_selectedDate();

                if (dpStartDate == null || dpFinishDate == null || dpStartTime == null || dpFinishTime == null) {
                    return
                }

                var combinedStartDate = new Date(dpStartDate.getFullYear(), dpStartDate.getMonth(), dpStartDate.getDate(), dpStartTime.getHours(), dpStartTime.getMinutes(), dpStartTime.getSeconds());
                var combinedFinishDate = new Date(dpFinishDate.getFullYear(), dpFinishDate.getMonth(), dpFinishDate.getDate(), dpFinishTime.getHours(), dpFinishTime.getMinutes(), dpFinishTime.getSeconds());

                if (combinedFinishDate.getTime() >= combinedStartDate.getTime()) {
                    args.IsValid = true;
                } else {
                    args.IsValid = false;
                    //alert("Start Date must be before End date");
                }

            }

            function Requirement_GetValueToReturn(combobox, eventArgs) {
                var ddlResourceTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResourceTypes');
                var selectedValue = ddlResourceTypes.get_value();
                var context = eventArgs.get_context();
                context["FilterString"] = selectedValue;

            }

            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();
                if (combobox.get_id().indexOf('ddlResources') > 0) {
                    var dtpStartTime = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_dtpStartTime');
                    var date = new Date();
                    var defaultStartTime = new Date(item.get_attributes().getAttribute("DefaultStartTime"))
                    dtpStartTime.get_dateInput().set_value(defaultStartTime.getHours() + ':' + defaultStartTime.getMinutes());

                    var costCodeheaderId = '<%= PM.ResourcesRequirementsInfo.CostCodeId%>';
                    if (costCodeheaderId <= 0) {
                        var ddlCostCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCostCodes');
                        ddlCostCodes.clearItems();
                        ddlCostCodes.set_text(item.get_attributes().getAttribute("DefaultCostCode"));
                        ddlCostCodes.set_value(item.get_attributes().getAttribute("ClassificationId"));
                    }

                } else if (combobox.get_id().indexOf('ddlResourceTypes') > 0) {
                    var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResources');
                    ddlResources.clearItems();
                    ddlResources.set_text('');
                    ddlResources.set_value('');

                    var ddlPayTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPayTypes');
                    ddlPayTypes.clearItems();
                    ddlPayTypes.set_text('');
                    ddlPayTypes.set_value('');

                    var ddlClassifications = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlClassifications');
                    ddlClassifications.clearItems();
                    ddlClassifications.set_text('');
                    ddlClassifications.set_value('');
                }

            }
        </script>

        <script type="text/javascript">
            function ValidateHoursPerDay(sender, args) {
                var value = sender.get_value();
                if (value > 24) {
                    sender.set_value(24);
                } else if (value < 0.01) {
                    sender.set_value(0.01);
                }
            }

            function ValidateCombinedDate(sender, args) {

                var dpStartDate = $find("<%= dtpStart.ClientID%>").get_selectedDate();
                var dpFinishDate = $find("<%= dtpFinish.ClientID%>").get_selectedDate();
                var dpStartTime = $find("<%= dtpStartTime.ClientID%>").get_selectedDate();
                var dpFinishTime = $find("<%= dtpFinishTime.ClientID%>").get_selectedDate();

                if (dpStartDate == null || dpFinishDate == null || dpStartTime == null || dpFinishTime == null) {
                    return
                }

                var combinedStartDate = new Date(dpStartDate.getFullYear(), dpStartDate.getMonth(), dpStartDate.getDate(), dpStartTime.getHours(), dpStartTime.getMinutes(), dpStartTime.getSeconds());
                var combinedFinishDate = new Date(dpFinishDate.getFullYear(), dpFinishDate.getMonth(), dpFinishDate.getDate(), dpFinishTime.getHours(), dpFinishTime.getMinutes(), dpFinishTime.getSeconds());

                if (combinedFinishDate.getTime() >= combinedStartDate.getTime()) {

                    args.IsValid = true;
                    document.getElementById('ctl00_CPH1_cmpTime').style.display = 'none'
                } else if ((combinedFinishDate.getTime() <= combinedStartDate.getTime()) && (combinedStartDate.getDate() == combinedFinishDate.getDate())) {
                    if (combinedStartDate.getMonth() == combinedFinishDate.getMonth()) {
                        args.IsValid = false;
                        document.getElementById('ctl00_CPH1_cmpTime').style.display = 'block'
                    }
                    else {
                        document.getElementById('ctl00_CPH1_cmpTime').style.display = 'none'
                    }

                }
                //return;
            }

            function InvokeCustomValidator() {
                ValidatorValidate(document.getElementById('<%=csvDate.ClientID %>'));
            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.ResourcesRequirementsInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=RESOURCES_REQUIREMENTS&Id=" +
                                                 '<%= PM.ResourcesRequirementsInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.ResourcesRequirementsInfo.ProjectId%>' + "&LocationId=" + '<%=PM.ResourcesRequirementsInfo.LocationId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;

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

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.ResourcesRequirementsInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.ResourcesRequirementsInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("RESOURCES_REQUIREMENTS")%>';
                var RecordDescription = '<%=JSEscape(PM.ResourcesRequirementsInfo.RecordDescription)%>';
                var Description = '<%=mid(JSEscape(PM.ResourcesRequirementsInfo.Description),1,20)%>';
                var Id = '<%= PM.ResourcesRequirementsInfo.Id%>';
                var BasedOnId = '<%= PM.ResourcesRequirementsInfo.BasedOnId%>';
                var ProjectId = '<%= PM.ResourcesRequirementsInfo.ProjectId%>';
                var LocationId = '<%= PM.ResourcesRequirementsInfo.LocationId%>';
                var EntityId = '0'
                var EntityType = '0';
                switch (BasedOnId) {
                    case '1':
                        EntityId = ProjectId;
                        EntityType = '0';
                        break;
                    case '9':
                        EntityId = LocationId;
                        EntityType = '1';
                        break;
                    default:
                        break;
                }
                var left = (screen.width - 1045) / 2;
                var top = (screen.height - 515) / 2;
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=RESOURCES_REQUIREMENTS&Id=" +
                            '<%= PM.ResourcesRequirementsInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + EntityId + "&EntityType=" + EntityType, 1045, 515, false);
                        }
                        break;


                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=RESOURCES_REQUIREMENTS&Id=" +
                                        '<%= PM.ResourcesRequirementsInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + EntityId + "&EntityType=" + EntityType, 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=RESOURCES_REQUIREMENTS&Id=" +
                        '<%= PM.ResourcesRequirementsInfo.Id%>'
              + "&EntityId=" + EntityId + "&EntityType=" + EntityType, 890, 430, false);

                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;

                        OpenPOPUp("Notification.aspx?ObjectType=RESOURCES_REQUIREMENTS&Id=" +
                               '<%= PM.ResourcesRequirementsInfo.Id%>' + "&Description="
                     + Description
                     + "&RecordDescription=" + RecordDescription
                     + "&EntityId=" + EntityId + "&EntityType=" + EntityType, "Notification", 890, 430, false);
                        break;

                    case 'NewInitiative':
                        window.location = "ResourcesRequirements.aspx";
                        break;

                    case 'New':
                        window.location = "ResourcesRequirements.aspx";
                        break;

                    default:
                        break;
                }
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                //              $("span[id*='lblRating']").html("(" +rating +")");
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=ResourcesRequirements');
                wnd.setSize(424, 435);
                wnd.add_close(RefreshRating);
                wnd.Center();
                return false;
            }
            function RefreshRating(Opener) {
                var updatePanel = $find($("[id$=pnlRating]")[0].id);
                var btnRefreshRating = $("a[id*=rdgRating][id$=btnRefreshRating]")[0];;
                if (updatePanel && btnRefreshRating == null) { __doPostBack(updatePanel.get_id()); }
                else if (btnRefreshRating) {
                    eval(btnRefreshRating.href.split(":")[1]);;
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
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }


        </script>
    </telerik:RadCodeBlock>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=285">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent ">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlRequirements" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Width="240px" AutoPostBack="False" NoWrap="True" AllowCustomText="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CommandName="Search"
                                        Value="Search" PostBackUrl="SearchDocument.aspx?O=285" CausesValidation="false" CssClass="ToolbarSearch">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" ValidationGroup="Save"
                            CommandName="Save" AccessKey="s" CssClass="ToolbarSave">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add"
                                    CommandName="New" AccessKey="n" CausesValidation="false" EnableImageSprite="true" PostBack="false" CssClass="ToolbarNew">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" PostBack="true" CommandName="Copy" ImageUrl="Images/ToolBar/Revision.png">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" EnableImageSprite="true"
                            CommandName="Delete" AccessKey="d" Value="Delete" CssClass="ToolbarDelete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" PostBack="false" CausesValidation="false"
                            CommandName="Notification" Visible="true" CssClass="ToolbarNotification">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton EnableImageSprite="true" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="ViewReports" EnableImageSprite="true" CssClass="ToolbarButtonViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="ViewPMWebReports" EnableImageSprite="true" CssClass="ToolbarButtonViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="ViewTemplates" EnableImageSprite="true" CssClass="ToolbarButtonViewTemplates">
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
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('RESOURCES_REQUIREMENTS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>

    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
        runat="server" MultiPageID="mlpRequirements" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Main" Value="pvHeader" Selected="true" />
            <telerik:RadTab Text="Assignments" Value="RequirementAssignments" CssClass="HideTabWhenDetailShownInHeader"/>
            <telerik:RadTab Text="Spec" Value="Spec" />
            <telerik:RadTab Text="Scoring" Value="Scoring" />
            <telerik:RadTab Text="Ratings" Value="Rating" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <%--<telerik:RadTab Text="Workflow" Value="Workflow" />--%>
            <%--                        <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />--%>
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpRequirements" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="true">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBasedOn" runat="server" Text="Based On*" meta:resourcekey="lblBasedOn" Width="100px"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBasedOn" runat="server" Width="100%" AutoPostBack="true"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trProgram">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPrograms" AllowCustomText="true" runat="server" AutoPostBack="true"
                                            Width="100%" NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPrograms" meta:Resourcekey="rfvProgram" runat="server" ControlToValidate="ddlPrograms"
                                            CssClass="Validator" InitialValue=""
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPrograms" runat="server" meta:Resourcekey="csvProgram" ControlToValidate="ddlPrograms"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Program required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trProject">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" Width="100%" UseProjectFilter="1" runat="server"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="390px" CausesValidation="false"
                                            NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLocationProgram">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocationProgram" runat="server" Text="Location Program*" meta:resourcekey="lblLocationProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocationPrograms" AllowCustomText="true" runat="server" AutoPostBack="true" Width="100%"
                                            NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocationPrograms" meta:Resourcekey="rfvLocationProgram" runat="server" ControlToValidate="ddlLocationPrograms"
                                            CssClass="Validator" InitialValue="" Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvLocationProgram" ID="csvLocationPrograms" runat="server" ControlToValidate="ddlLocationPrograms"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic" CssClass="Validator">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLocation">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocations" Width="100%" runat="server"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="390px" CausesValidation="false"
                                            NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLinkType">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkType" runat="server" Text="Link Type" meta:resourcekey="lblLinkType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLinkTypes" Width="100%" runat="server" Height="400px" AutoPostBack="true"
                                            NoWrap="True" AllowCustomText="True" ShowMoreResultsBox="True"
                                            CausesValidation="False" OnItemsRequested="ddl_ItemsRequested" EnableLoadOnDemand="true" EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLinkedTo">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkedTo" runat="server" Text="Linked To" meta:resourcekey="lblLinkedTo"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLinkedTo" Width="100%" AllowCustomText="true" runat="server" AutoPostBack="true"
                                            NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLinkedLine">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkedLine" runat="server" Text="Linked Line" meta:resourcekey="lblLinkedLine"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLinkedLine" Width="100%" AllowCustomText="true" runat="server" AutoPostBack="true"
                                            NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRequirementID" runat="server" Text="Requirement ID*" meta:resourcekey="lblRequirementID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRequirementID" MaxLength="500" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRequirementID" runat="server" ValidationGroup="Save" ControlToValidate="txtRequirementID"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID %>" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUnique" runat="server" Text="ID must be unique."
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" Height="24px" meta:Resourcekey="hplCurrency" Text="Currency1"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                                    <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                        <%--<asp:HyperLink runat="server" CssClass="Link" ID="hplCurrency" Height="16px" meta:Resourcekey="hplCurrency" Text="Currency"></asp:HyperLink>--%>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox Width="100%" ID="ddlCurrencies" runat="server" Height="300px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategories" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains" runat="server">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%--     <tr>
                                        <td>
                                            <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status / Rev."></asp:Label>
                                        </td>
                                        <td>
                                            <table id="tblStatus" runat="server" border="0" cellpadding="0" cellspacing="0" width="255px">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="200px"></telerik:RadComboBox>
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox runat="server" ID="txtRevisionNumber" style="margin-left:12px" CssClass="Right" Width="40px" Text=""></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>--%>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblScope" runat="server" Text="Scope" meta:resourcekey="lblScope"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtScope" runat="server" MaxLength="4000" TextMode="MultiLine" Height="60px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblResourceType" runat="server" Text="Resource Type" meta:resourcekey="lblResourceType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlResourceTypes" runat="server" Width="100%" AutoPostBack="true"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblClassification" runat="server" Text="Classification" meta:resourcekey="lblClassification"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlClassifications" MarkFirstMatch="False" Filter="Contains" AllowCustomText="True"
                                            runat="server" Width="100%" Height="200px"
                                            CloseDropDownOnBlur="true" NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSkills" runat="server" Text="Skills" meta:resourcekey="lblSkills"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSkills" runat="server" AllowCustomText="True" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chkApplySkills" />
                                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                                    <%#Eval("Skills")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hdnSkills" Value="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountries" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains"
                                            runat="server">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRegion" meta:resourcekey="lblRegion" runat="server" Text="Region"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRegions" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains"
                                            runat="server">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPriority" runat="server" Text="Priority" meta:resourcekey="lblPriority"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPriorities" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains"
                                            runat="server">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPayType" runat="server" Text="Pay Type" meta:resourcekey="lblPayType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPayTypes" runat="server" Width="100%" Filter="Contains"
                                            MarkFirstMatch="true" CloseDropDownOnBlur="true"
                                            NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                            Height="200px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr> 
                                <tr>
                                    <td class="labelWidth">
                                        <telerik:RadComboBox DropDownWidth="106px" Width="106px" ID="ddlRateBasis" runat="server" meta:resourcekey="ddlRateBasis"></telerik:RadComboBox>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtRateBasisAmount" CssClass="Currency"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                                                <td>
                                                                    <asp:RadioButton ID="rdbFixedAmount" style="margin-left:-4px" runat="server" Text="Fixed Amount" GroupName="AmountType" meta:resourcekey="rdbFixedAmount"/>
                                                                </td>
                                                                <td>
                                                                     <table border="0" cellpadding="0" cellspacing="0" width="204px">
                                                                    <tr>
                                                                    <td>
                                                                    <asp:RadioButton ID="rdbRate" style="margin-left:-4px" runat="server" Text="Rate" GroupName="AmountType" Checked="true" meta:resourcekey="rdbRate"/>
                                                                    </td>
                                                                    <td align="right">
                                                                           <asp:TextBox runat="server" ID="txtAmount" CssClass="Currency"  Width="100px"
                                                                                        Text=""></asp:TextBox>
                                                                    </td>
                                                                    </tr>                                       
                                                                    </table>
                                                                </td>
                                                            </tr>  --%>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink ID="hplCostCode" runat="server" meta:Resourcekey="lblCostCode"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                            AllowCustomText="true" Height="300px"
                                            AutoPostBack="False" NoWrap="true"
                                            CausesValidation="False" OnClientTextChange="Requirements_CostCodeTextChanged"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanged="Requirements_CostCodeChanged"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%-- <tr>
                                        <td>
                                            <asp:Label ID="lblWorksheetColumn" meta:Resourcekey="lblWorksheetColumn" runat="server" Text="Worksheet Column"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlWorksheetColumn" runat="server" width="204px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>--%>
                                <tr style="display: none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPostAs" meta:Resourcekey="lblPostAs" runat="server" Text="Worksheet Column"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <telerik:RadComboBox ID="ddlPostAs" runat="server" Width="100%">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRequestedBy" meta:Resourcekey="lblRequestedBy" runat="server" Text="Requested By"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRequestedBy" runat="server" Width="100%"
                                            AllowCustomText="true" Height="300px"
                                            AutoPostBack="False" NoWrap="true"
                                            CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgress" meta:resourcekey="lblProgress" runat="server" Text="Progress"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgress" Width="100%" Height="350px" AllowCustomText="true" Filter="Contains" runat="server">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStart" meta:resourcekey="lblStart" runat="server" Text="Start*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 50%; padding-right: 8px;">
                                                    <span runat="server" id="rmd_dtpStart" style="display: block">
                                                        <telerik:RadDatePicker ID="dtpStart" runat="server" MinDate="1901-01-01"
                                                            MaxDate="2100-01-01" Style="display: inline" EnableTyping="true">
                                                            <ClientEvents OnDateSelected="InvokeCustomValidator" />
                                                            <DateInput CssClass="Right" runat="server" />
                                                        </telerik:RadDatePicker>
                                                        <asp:RequiredFieldValidator ID="rfvStart" runat="server" ValidationGroup="Save" ControlToValidate="dtpStart"
                                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvStarts" ForeColor="">
                                                        </asp:RequiredFieldValidator>
                                                    </span>
                                                </td>
                                                <td style="width: 50%;">
                                                    <telerik:RadTimePicker ID="dtpStartTime" runat="server" Culture="English (United States)"
                                                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                        Width="100%">
                                                        <DateInput ID="DateInput1" runat="server"></DateInput>
                                                        <Calendar ID="Calendar1" runat="server"></Calendar>
                                                        <DateInput ID="DateInput3" CssClass="Right" runat="server" />
                                                        <ClientEvents OnDateSelected="InvokeCustomValidator" />
                                                    </telerik:RadTimePicker>
                                                    <asp:RequiredFieldValidator ID="rfvStartTime" runat="server" ValidationGroup="Save" ControlToValidate="dtpStartTime"
                                                        CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvStartTime" ErrorMessage="required" ForeColor="">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <%-- <td style="min-width:130px">
                                            <asp:CustomValidator Display="Dynamic" ID="csvStartTime" runat="server" ControlToValidate="dtpStartTime" ValidationGroup="Save"
                                                 ErrorMessage="Start date must be before end date" ClientValidationFunction="ValidateCombinedDate" />
                                            <asp:CustomValidator Display="Dynamic" ID="csvStart" runat="server" ControlToValidate="dtpStart" ValidationGroup="Save" 
                                                 ErrorMessage="Start date must be before end date" ClientValidationFunction="ValidateCombinedDate" />
                                        </td>--%>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinish" meta:resourcekey="lblFinish" runat="server" Text="Finish*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%" border="0">
                                            <tr>
                                                <td style="width: 50%; padding-right: 8px;">
                                                    <span runat="server" id="rmd_dtpFinish" style="display: block;">
                                                        <telerik:RadDatePicker ID="dtpFinish" runat="server" MinDate="1901-01-01" DateInput-LabelCssClass="Right"
                                                            MaxDate="2100-01-01" Style="display: inline" EnableTyping="true">
                                                            <ClientEvents OnDateSelected="InvokeCustomValidator" />
                                                            <DateInput ID="DateInput4" CssClass="Right" runat="server" />
                                                        </telerik:RadDatePicker>
                                                        <asp:RequiredFieldValidator ID="rfvFinish" runat="server" ValidationGroup="Save" ControlToValidate="dtpFinish"
                                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvFinishs" ForeColor="">
                                                        </asp:RequiredFieldValidator>
                                                    </span>
                                                </td>
                                                <td width="50%">
                                                    <telerik:RadTimePicker ID="dtpFinishTime" runat="server" Culture="English (United States)"
                                                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                        Width="100%">
                                                        <DateInput ID="DateInput2" runat="server"></DateInput>
                                                        <ClientEvents OnDateSelected="InvokeCustomValidator" />
                                                        <Calendar ID="Calendar2" runat="server"></Calendar>
                                                        <DateInput ID="DateInput5" CssClass="Right" runat="server" />
                                                    </telerik:RadTimePicker>
                                                    <asp:RequiredFieldValidator ID="rfvFinishTime" runat="server" ValidationGroup="Save" ControlToValidate="dtpFinishTime"
                                                        CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvFinishTime" ErrorMessage="required" ForeColor="">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                              
                            </table>
                                   <table>
                                            <tr>
                                                <td>
                                                    <asp:CompareValidator meta:resourcekey="cmpstartTofinsh" ID="cmpFromToDates" runat="server" Style="margin-bottom: 5px;"
                                                        ControlToValidate="dtpFinish" ControlToCompare="dtpStart" Type="Date" CssClass="Validator" ValidationGroup="Save"
                                                        ErrorMessage="Start date must be before or equal to Finish date" Display="Dynamic"
                                                        ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                                </td>
                                                <td>
                                                    <asp:CompareValidator ID="cmpTime" runat="server" Display="Dynamic" ControlToValidate="dtpFinishTime" ErrorMessage="Start time must be before end time" ControlToCompare="dtpStartTime" Operator="GreaterThanEqual">
                    </asp:CompareValidator>
                                                </td>
                                            </tr>
                                        </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc10:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                            <table class="colTable">
                                  <tr>
                                    <td colspan="2" style="width: 100%">
                                        <asp:CustomValidator Display="Dynamic" ID="csvDate" runat="server" ControlToValidate="dtpFinish" ValidationGroup="Save"
                                            ErrorMessage="Start date must be before end date" ClientValidationFunction="ValidateCombinedDate" />
                                        <%-- <asp:CustomValidator Display="Dynamic" ID="csvFinishTime" runat="server" ControlToValidate="dtpFinishTime" ValidationGroup="Save" 
                                                 ErrorMessage="Start date must be before end date" ClientValidationFunction="ValidateCombinedDate" />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" style="text-align: center; width: 100%; text-transform: uppercase; color: #666666;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRequired" meta:resourcekey="lblRequired" runat="server" Text="Required" Width="100%"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAssigned" meta:resourcekey="lblAssigned" runat="server" Text="Assigned" Width="100%"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblVariance" meta:resourcekey="lblVariance" runat="server" Text="Variance" Width="100%"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblNbrOfResources" meta:resourcekey="lblNbrOfResources" runat="server" Text="# of Resources"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtNbrOfResourcesRequired" runat="server" Width="100%" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtNbrOfResourcesAssigned" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNbrOfResourcesVariance" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblWorkDays" meta:resourcekey="lblWorkDays" runat="server" Text="Work Days"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtWorkDaysRequired" runat="server" Width="100%" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtWorkDaysAssigned" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWorkDaysVariance" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblHoursPerDay" meta:resourcekey="lblHoursPerDay" runat="server" Text="Hours Per Day"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="padding-right: 5px">
                                                    <telerik:RadTextBox ID="txtHoursPerDayRequired" ClientEvents-OnBlur="ValidateHoursPerDay" MinValue="0.01" MaxValue="24"
                                                        runat="server" MaxLength="9" Width="100%" CssClass="PositiveIntegerDouble Right">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtHoursPerDayAssigned" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtHoursPerDayVariance" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTotalHours" meta:resourcekey="lblTotalHours" runat="server" Text="Hours Total"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtTotalHoursRequired" runat="server" Enabled="false" Width="100%" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td style="padding-right: 5px">
                                                    <asp:TextBox ID="txtTotalHoursAssigned" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTotalHoursVariance" runat="server" Width="100%" Enabled="false" CssClass="PositiveIntegerDouble Right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblWarnOfOverBooking" runat="server" Text="Warn of Overbooking" meta:resourcekey="lblWarnOfOverBooking"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkWarnOfOverBooking" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblClosed" runat="server" Text="Closed" meta:resourcekey="lblClosed"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkClosed" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAssignments" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:ResourcesRequirementDetails ID="ResourcesRequirementDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server" Visible="False">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server" Visible="False">
            <uc3:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRatings" runat="server" Visible="False">
            <uc4:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc6:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <%--  <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
                        <uc7:WorkflowDocument ID="WorkflowDocument1" runat="server" />
                    </telerik:RadPageView>--%>
        <%-- <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                        <uc8:DocumentTeam ID="DocumentTeam1" runat="server" />
                    </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvNotificationLog" runat="server" Visible="False">
            <uc9:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
