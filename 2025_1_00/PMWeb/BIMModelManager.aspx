<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="BIMModelManager.aspx.vb" Inherits="Website.BIMModelManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc7" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc8" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="PMWebModelViewer2.ascx" TagName="PMWebModelViewer2" TagPrefix="uc10" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:radajaxmanagerproxy id="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="mlpBIMModelManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBIMModelManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBIMModelManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:radajaxmanagerproxy>

    <asp:PlaceHolder ID="phModelManager" runat="server"></asp:PlaceHolder>
    <telerik:radcodeblock id="CodeBlock" runat="server">
        <script src="JS/Scoring.js" type="text/javascript"></script>
    <style type="text/css">
        .header-table td {
            padding: 2px;
        }

        /* The following CSS needs to be copied to the page to produce textbox-like RadEditor */
        .RadGrid_PM .rgActiveRow td, .RadGrid_PM .rgHoveredRow td, .RadGrid_PM .rgEditRow td {
            border-bottom-color: #D0D7E5;
            white-space: normal;
        }

        .reLeftVerticalSide, .reRightVerticalSide, .reToolZone, .reToolCell {
            background: white !important;
        }



        .reContentCell {
            border-width: 0 !important;
        }

        .formInput {
            border: solid 1px black;
        }

        .RadEditor {
            filter: chroma(color=c2dcf0);
            width: 100% !important;
            height: 100% !important;
            min-width: 100% !imprtant;
            min-height: 100% !important;
        }

        .reWrapper_corner, .reWrapper_center {
            display: none !important; /* for FF */
            width: 100% !important;
            height: 100% !important;
        }

        td.reWrapper_corner, td.reWrapper_center {
            display: none\9 !important; /* for all versions of IE */
        }

        .reModule {
            display: none !important;
        }

        .RadWindow .rwTitleRow em {
            font: 16px "Segoe UI" !important;
            color: #FFFFFF !important;
            padding: 0 0 0 24px !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            float: left !important;
            text-transform: uppercase !important;
        }
         .ShowHeaderButton .Icon {
                background-image: url(css/Images/ResponsiveIcons/16Enabled.png) !important;
                background-position: 192px 0px !important;
                display: inline-block !important;
                width: 16px !important;
                height: 16px !important;
                margin-right: 8px !important;
            }

            .HideHeaderButton .Icon {
                background-image: url(css/Images/ResponsiveIcons/16Enabled.png) !important;
                background-position: 176px 0px !important;
                display: inline-block !important;
                width: 16px !important;
                height: 16px !important;
                margin-right: 8px !important;
            }
    </style>
        <script type="text/javascript">



            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
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
                var HasMergeTemplate = '<%= PM.BIM.BIMModelManagerInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.BIM.BIMModelManagerInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.BIM.BIMModelManagerInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.BIM.BIMModelManagerInfo.Description)%>';
                var Id = '<%= PM.BIM.BIMModelManagerInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BIMModelManager")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=BIMModelManager&Id=" +
                            '<%= PM.BIM.BIMModelManagerInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.BIM.BIMModelManagerInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=BIMModelManager&Id=" +
                 '<%= PM.BIM.BIMModelManagerInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.BIM.BIMModelManagerInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BIMModelManager&Id=" +
                            '<%= PM.BIM.BIMModelManagerInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BIMModelManager&Id=" +
                            '<%= PM.BIM.BIMModelManagerInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);

                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=BIMModelManager&Id=" + Id
                    + "&EntityId=0&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "BIMModelManager.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('BIMModelManager');
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=BMM');
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
          
          
            function pageLoad() {
                if ($("[id$='tblModelManagerHeader']").length == 0) return;
                if (IsExpanded == 'True') {
                    $("[id$='tblModelManagerHeadering']")[0].src = 'Images/Workflow/wMinus.png';
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    $("[id$='tblModelManagerHeader']").show();
                }
                if (IsExpanded == 'False') {
                    $("[id$='tblModelManagerHeadering']")[0].src = 'Images/Workflow/wPlus.png';
                    var ShowHeaderButton = $(".HideHeaderButton");
                    ShowHeaderButton.removeClass("HideHeaderButton").addClass("ShowHeaderButton");
                    $("[id$='tblModelManagerHeader']").hide();
                }
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get("Id") == null) {
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    $("[id$='tblModelManagerHeadering']")[0].src = 'Images/Workflow/wMinus.png';
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    document.querySelector("#ctl00_CPH1_tblModelManagerHeader").style.display = 'block';
                }
            }

            function ToggleModelManagerHeaderSection(sender) {
                if (sender.src.indexOf("Plus") > 0) {
                    IsExpanded = 'True';
                    sender.src = 'Images/Workflow/wMinus.png';
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    $("[id$='tblModelManagerHeader']").show(50, function () {
                        this.style.display = '';
                        FloatDivs(false, true);
                        $.ajax({
                            type: "POST",
                            url: "AjaxService.aspx/ToggleModelManagerHeaderSection",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ blnVisible: true }),
                            dataType: "json",
                            async: true
                        });
                    });
                } else {
                    IsExpanded = 'False';
                    sender.src = 'Images/Workflow/wPlus.png';
                    var ShowHeaderButton = $(".HideHeaderButton");
                    ShowHeaderButton.removeClass("HideHeaderButton").addClass("ShowHeaderButton");
                    $("[id$='tblModelManagerHeader']").hide(50, function () {
                        $.ajax({
                            type: "POST",
                            url: "AjaxService.aspx/ToggleModelManagerHeaderSection",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ blnVisible: false }),
                            dataType: "json",
                            async: true
                        });
                    });
                }
                return false;
            }

        </script>
    </telerik:radcodeblock>
    <telerik:radstylesheetmanager id="SSH1" enablestylesheetcombine="true" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Editor.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Editor.Office2007.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Window.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Window.Office2007.css" />
        </StyleSheets>
    </telerik:radstylesheetmanager>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="True" onclientbuttonclicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord"
                                    ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png"
                                    Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print"  CssClass="Print">
                                                    <Items>

                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Word Templates" Value="ViewTemplates"></telerik:RadMenuItem>

                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BIMModelManager');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('BIMModelManager');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png"
                            CausesValidation="false" Value="Activate" CommandName="Activation" ToolTip="Activate" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:radtoolbar>
            </td>
            <td></td>
        </tr>
    </table>

    <asp:Panel ID="pnlModelManagerHeader" runat="server">
        <%--    <tr>
                        <td valign="middle" style="padding: 5px 0px 0px 5px">
                            <img id="tblModelManagerHeaderimg" alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleModelManagerHeaderSection(this);" />
                            <span style="color: #09296C; font-size: 11px; font-weight: bold">
                                <asp:Label ID="lblModelManagerHeader" runat="server" meta:resourcekey="lblModelManagerHeader"></asp:Label></span>
                            <img alt="" src="Images/Workflow/wSperator.png" />
                        </td>
                    </tr>--%>


        <telerik:radtabstrip onclienttabselecting="onTabSelecting" id="tbsDocument" selectedindex="0"
            runat="server" multipageid="mlpBIMModelManager" skin="Default" width="100%" scrollchildren="true" scrollbuttonsposition="Left" cssclass="documentTabs"
            enableviewstate="True" causesvalidation="False">
            <Tabs>
                <telerik:RadTab Text="Header" Value="Header" />
                <telerik:RadTab Text="3D Viewer" Value="3DViewer" CssClass="HideTabWhenDetailShownInHeader" />
                <telerik:RadTab Text="Specifications" Value="Spec" />
                <telerik:RadTab Text="Tasks" Value="Checklists" />
                <telerik:RadTab Text="Scoring" Value="Scoring" />
                <telerik:RadTab Text="Ratings" Value="Rating" TabIndex="2" />
                <telerik:RadTab Value="Notes" Text="Notes" />
                <telerik:RadTab Value="Attachments" Text="Attachments" />
                <telerik:RadTab Value="Workflow" Text="Workflow" />
                <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
                <telerik:RadTab Text="Notification" Value="NotificationLog" />
            </Tabs>
        </telerik:radtabstrip>
        <telerik:radmultipage id="mlpBIMModelManager" runat="server" selectedindex="0" width="100%" cssclass="documentMultiPages"
            renderselectedpageonly="True">
            <telerik:RadPageView ID="pvHeader" runat="server">
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                    <div class="PMMainPage">
                        <div class="row" style="padding-top: 4px; padding-bottom: 4px;">
                                    <div class="col-4">
                                         <asp:LinkButton CssClass="ShowHeaderButton" src="Images/Workflow/wMinus.png" runat="server" ID="tblModelManagerHeadering" OnClientClick="return ToggleModelManagerHeaderSection(this);">
                                             <span class="Icon"></span>
                                        </asp:LinkButton>
                                        </div>
                            </div>
                    </div>
                   <%--       <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="padding: 5px 0px 0px 5px">
                                <img id="tblModelManagerHeaderimg" alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleModelManagerHeaderSection(this);" />
                                <span style="color: #09296C; font-size: 11px; font-weight: bold">
                                    <asp:Label ID="lblModelManagerHeader" runat="server" meta:resourcekey="lblModelManagerHeader"></asp:Label></span>
                                <img alt="" src="Images/Workflow/wSperator.png" />
                            </td>
                        </tr>
                             </table>--%>

                    <div class="PMMainPage "  id="tblModelManagerHeader" runat="server">
                        <div class="row JustifyContent R3Cols">
                            <div class="col-4 col-4-left ">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLocation" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested" SkipValue="0">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlLocation"
                                                CssClass="Validator" InitialValue="" meta:resourcekey="rfvLocations" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlLocation"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" meta:resourcekey="csvLocations">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvProject" runat="server" ControlToValidate="ddlProject"
                                                CssClass="Validator" InitialValue="" meta:resourcekey="rfvProjects" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvProject" runat="server" ControlToValidate="ddlProject"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" meta:resourcekey="csvProjects">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBuilding" runat="server" meta:resourcekey="lblBuilding"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBuilding" runat="server" Skin="Default"
                                                AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                                                Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" ShowMoreResultsBox="True"
                                                EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblID" runat="server" meta:resourcekey="lblID"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtID" runat="server" CausesValidation="False"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="TxtID" CssClass="Validator"
                                                InitialValue="" meta:resourcekey="rfvIds" ValidationGroup="Save" Display="Dynamic"
                                                ForeColor=""></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDescription" runat="server" meta:resourcekey="LblDescription"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblBIMApplication" runat="server" meta:resourcekey="LblBIMApplication"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBIMApplication" runat="server" AutoPostBack="False" AllowCustomText="true"
                                                Filter="Contains" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                MarkFirstMatch="True" NoWrap="True" Skin="Default">
                                                <CollapseAnimation Duration="150" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblBIMModel" runat="server" meta:resourcekey="LblBIMModel"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtBIMModel" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblOwner" runat="server" meta:resourcekey="LblOwner"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOwner" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblType" runat="server" Text="Type" meta:resourcekey="lblType"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="True"
                                                Skin="Default" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                                Skin="Default" Style="font-size: 11px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLOD" meta:resourcekey="lblLOD" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLOD" AllowCustomText="true" Filter="Contains" runat="server"
                                                Skin="Default" Style="font-size: 11px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblStatusRev" runat="server" meta:resourcekey="LblStatusRev"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlStatus" runat="server" AllowCustomText="True" AutoPostBack="False"
                                                            Filter="Contains" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                            MarkFirstMatch="True" NoWrap="True" Skin="Default" Width="100%">
                                                            <CollapseAnimation Duration="150" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width:50px; padding-left: 8px">
                                                        <asp:TextBox ID="TxtRevision" CssClass="PositiveInteger" runat="server"
                                                            MaxLength="9"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-middle">
                                <table class="colTable">
                                    <tr>
                                        <td>
                                            <uc7:AssetRotator ID="PMrot" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table class="colTable">
                                    <tr>
                                        <td>
                                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="PV3DViewer" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
                <uc10:PMWebModelViewer2 ID="PMWebModelViewer21" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="PvSpec" runat="server">
                <uc1:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvChecklist" runat="server">
                <uc11:DocumentCheckList ID="DocumentCheckList1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvScorings" runat="server">
                <uc2:DocumentScoring ID="Scoring1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvRating" runat="server">
                <uc8:DocumentRating ID="DocumentRating1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                <uc4:DocumentAttachments ID="DocumentAttachments" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkflow" runat="server">
                <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotificationLog" runat="server">
                <uc6:NotificationLog ID="NotificationLog1" runat="server" />
            </telerik:RadPageView>
        </telerik:radmultipage>


    </asp:Panel>
</asp:Content>
