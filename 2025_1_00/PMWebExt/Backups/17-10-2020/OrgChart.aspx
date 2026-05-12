<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="OrgChart.aspx.vb" Inherits="Website.OrgChart" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="OrgChartDetails.ascx" TagName="OrgChartDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc3" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            var IsExpanded = '<%= PM.HomeInfo.IsOrgChartHeaderExpanded%>';
            var ShowHeader = '<%= GetLocalResourceObject("ShowHeader") %>';
            var HideHeader = '<%= GetLocalResourceObject("HideHeader")%>';
            var HasMergeTemplate = '<%= PM.OrgChartInfo.HasMergeTemplate%>';
            var HasReports = '<%= PM.OrgChartInfo.HasReports%>';
            var RecordDescription = '<%=JSEscape(PM.OrgChartInfo.RecordDescription)%>';
            var Description = '<%=JSEscape(PM.OrgChartInfo.Description)%>';
            var Id = '<%= PM.OrgChartInfo.Id%>';
            var BasedOnId = '<%= PM.OrgChartInfo.BasedOnId%>';
            var ProjectId = '<%= PM.OrgChartInfo.ProjectId%>';
            var LocationId = '<%= PM.OrgChartInfo.LocationId%>';
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

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                //              $("span[id*='lblRating']").html("(" +rating +")");
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=OrgChart');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(450, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(RefreshRating);
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
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=RESOURCES_ORGCHART&Id=" +
                                    '<%= PM.OrgChartInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + EntityId + "&EntityType=" + EntityType, 1045, 515, false);

                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;

                        OpenPOPUp("Notification.aspx?ObjectType=RESOURCES_ORGCHART&Id=" +
                           Id + "&Description="
                     + Description
                     + "&RecordDescription=" + RecordDescription
                     + "&EntityId=" + EntityId + "&EntityType=" + EntityType, "Notification", 900, 500, false);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=RESOURCES_ORGCHART&Id=" +
                                    '<%= PM.OrgChartInfo.Id%>' + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + EntityId + "&EntityType=" + EntityType, 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 890) / 2;
                        var top = (screen.height - 430) / 2;
                        if (HasReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=RESOURCES_ORGCHART&Id=" + Id, 890, 430, false);

                        }
                        break;
                }
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function ToggleOrgChartHeaderSection(sender) {
                //if (sender.src.indexOf("Plus") > 0) {
                //    IsExpanded = 'True';
                //    sender.src = 'Images/Workflow/wMinus.png';
                //    $("[id$='lblOrgChartHeader']").html(HideHeader);
                //    $("[id$='tblOrgChartHeader']").show(50, function () {
                //        this.style.display = '';
                //        $.ajax({
                //            type: "POST",
                //            url: "AjaxService.aspx/ToggleOrgChartHeaderSection",
                //            contentType: "application/json; charset=utf-8",
                //            data: "{'blnVisible':" + true + "}",
                //            dataType: "json",
                //            async: true
                //        });
                //    });
                //} else {
                //    IsExpanded = 'False';
                //    sender.src = 'Images/Workflow/wPlus.png';
                //    $("[id$='lblOrgChartHeader']").html(ShowHeader);
                //    $("[id$='tblOrgChartHeader']").hide(50, function () {
                //        $.ajax({
                //            type: "POST",
                //            url: "AjaxService.aspx/ToggleOrgChartHeaderSection",
                //            contentType: "application/json; charset=utf-8",
                //            data: "{'blnVisible':" + false + "}",
                //            dataType: "json",
                //            async: true
                //        });
                //    });

                //}
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .controlWidth {
            width: 100%;
            min-width: 120px;
        }
    </style>
    <telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Web20.OrgChart.Web20.css" />
        </StyleSheets>
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpOrgChart" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpOrgChart">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpOrgChart" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="OrgChartDetails1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpOrgChart" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <script src="JS/Toolbox/OrgChart.js" type="text/javascript"></script>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar SmallToolbar">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=290">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlOrgChart" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Width="240px" AutoPostBack="False" NoWrap="True" AllowCustomText="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    meta:resourcekey="ddlRequirements" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=290" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                            Value="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="CreateRevision" CommandName="CreateRevision"
                                    ImageUrl="Images/ToolBar/Revision.png">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewTemplates">
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('RESOURCES_ORGCHART');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="false" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton CssClass="HideOnMobileToolbar" PostBack="False" Text="" Value="Rating"  style="display:none">
                            <ItemTemplate>
                                <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                    <table style="padding-right: 20px; width: 100px; height: 100%" border="0">
                                        <tr>
                                            <td align="center" style="padding-left: 5px">
                                                <div>
                                                    <span style="padding-bottom: 0px">
                                                    <telerik:RadRating Style="padding-top: 0px" ID="rdrating1" runat="server" ItemCount="5"
                                                        OnClientRated="OnClientRated" Value="3" SelectionMode="Continuous" Height="10px"
                                                        Precision="half" Orientation="Horizontal" />
                                                </div>
                                            </td>
                                            <td valign="bottom">
                                                <asp:Label runat="server" ID="lblRating" Style="font-size: 10pt" Text="(3)"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadAjaxPanel>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpOrgChart" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Skin="Default" Width="100%">
        <Tabs>
            <telerik:RadTab Text="Details" PageViewID="pvHeader" Value="Header" Selected="true" />
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Scoring" Value="Scoring" />
            <telerik:RadTab Text="Ratings" Value="Rating" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpOrgChart" runat="server" SelectedIndex="0" CssClass="documentMultiPages" Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBasedOn" runat="server" meta:Resourcekey="lblBasedOn" Text="Based On*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBasedOn" runat="server" Width="100%" AutoPostBack="true"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trProgram" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" meta:Resourcekey="lblProgram" Text="Program*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPrograms" AllowCustomText="true" runat="server" AutoPostBack="true"
                                            meta:resourcekey="ddlPrograms"
                                            NoWrap="true" Height="300px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPrograms" meta:Resourcekey="rfvPrograms" runat="server" ControlToValidate="ddlPrograms"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvPrograms" ID="csvPrograms" runat="server" ControlToValidate="ddlPrograms"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr id="trProject" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" meta:Resourcekey="lblProject" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" Width="100%" UseProjectFilter="1" runat="server" meta:resourcekey="ddlProjects"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="300px" CausesValidation="false"
                                            NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" meta:Resourcekey="rfvPrograms" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvPrograms" ID="CustomValidator1" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOrgChartId" runat="server" meta:Resourcekey="lblOrgChartId" Text="Org Chart ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOrgChartId" runat="server" meta:Resourcekey="txtOrgChartId" />
                                        <asp:Label ID="lblUnique" meta:resourcekey="lblUnique" Text="<br>Org Char Id should be unique." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                         <asp:RequiredFieldValidator ID="rfvOrgChartId" runat="server" meta:Resourcekey="rfvOrgChartId"
                                            ValidationGroup="Save" ControlToValidate="txtOrgChartId" CssClass="Validator" Display="Dynamic"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" meta:Resourcekey="lblDescription" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDecription" runat="server" meta:Resourcekey="txtDecription" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%" id="tblStatus" runat="server">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="Right" ReadOnly="true" Width="100%" Text=""></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="fldOptions">
                                <legend class="legend">
                                    <asp:Label runat="server" ID="lblOptions" meta:Resourcekey="lblOptions" Text="Options"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRecapBy" runat="server" meta:Resourcekey="lblRecapBy" Text="Recap By"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlRecapBy" runat="server" AutoPostBack="true" Width="100%"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefaultResourceCategoryFrom" runat="server" meta:Resourcekey="lblDefaultResourceCategoryFrom" Text="Default resource category from" ToolTip="Default resource category from"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlDefaultResourceCategoryFrom" runat="server" Width="100%"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                                <table class="colTable">
                                    <tr>
                                        <td width="95%" style="color: #666666;">
                                            <asp:Label ID="lblDisplayResourceIDsInChart" runat="server" Text="Display Resource IDs in chart" meta:resourcekey="ckbDisplayResourceIDsInChart"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox runat="server" CssClass="chkAlignMiddle" ID="ckbDisplayResourceIDsInChart" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="95%" style="color: #666666;">
                                            <asp:Label ID="lblAllowAResourceToBeAddedMoreThanOnce" runat="server" Text="Allow a resource to be added more than once" meta:resourcekey="ckbAllowAResourceToBeAddedMoreThanOnce"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox runat="server" CssClass="chkAlignMiddle" ID="ckbAllowAResourceToBeAddedMoreThanOnce" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="95%" style="color: #666666;">
                                            <asp:Label ID="lblDisplayResourceImg" runat="server" Text="Display Resource images" meta:resourcekey="chkDisplayResourceImg"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox runat="server" CssClass="chkAlignMiddle" ID="chkDisplayResourceImg" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <uc10:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <fieldset runat="server" id="fldRecap">
                                            <legend class="legend">
                                                <asp:Label runat="server" ID="lblRecap" meta:Resourcekey="lblRecap" Text="Recap"></asp:Label>
                                            </legend>
                                            <div style="max-height: 150px; overflow-y: scroll; width: 100%">
                                                <asp:Repeater ID="rptRecap" runat="server" Visible="true">
                                                    <ItemTemplate>
                                                        <table class="linedTable" width="100%" cellspacing="0" style="max-height: 150px; overflow: auto;" width="100%">
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label runat="server" ID="lblRecapBy" Text='<%# DataBinder.Eval(Container.DataItem, "RecapBy")%>' />
                                                                </td>
                                                                <td class="controlWidth" align="right">
                                                                    <asp:Label runat="server" ID="lblCount" Text='<%# DataBinder.Eval(Container.DataItem, "Count")%>' />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                            <table width="100%" style="margin-top: 5px;" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label runat="server" ID="lblTotal" meta:Resourcekey="lblTotal" Text="Total"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox Style="text-align: right" ReadOnly="true" runat="server" ID="txtTotal" meta:Resourcekey="txtTotal"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive" style="margin-top:24px;">
            <uc1:OrgChartDetails ID="OrgChartDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScorings" runat="server">
            <uc3:DocumentScoring ID="Scoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc4:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc7:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
