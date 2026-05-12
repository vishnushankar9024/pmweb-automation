<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Estimates.aspx.vb" Inherits="Website.Estimates" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EstimateDetails.ascx" TagName="EstimateDetails" TagPrefix="uc1" %>
<%@ Register Src="EstimateMarkup.ascx" TagName="EstimateMarkup" TagPrefix="uc2" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc7" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc13" %>


<asp:Content ID="C2" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpEstimates">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEstimates" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEstimates" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript" src="JS/Estimates/Markup.js"></script>

        <script language="javascript" type="text/javascript" src="JS/Estimates/ItemDetails.js"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
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
                var RecordCurrencyId = '<%=PM.Estimate.EstimateInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=ESTIMATE&Id=" +
                                     '<%= PM.Estimate.EstimateInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }




            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "AutoCAD") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("AutoCAD");
                        button.click();
                    }
                    if (args.get_item().get_value() == "Navisworks") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Navisworks");
                        button.click();
                    }
                    if (args.get_item().get_value() == "Revit") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Revit");
                        button.click();
                    }
                   <%-- if (args.get_item().get_value() == "ImportEstimates") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Estimate");
                        button.click();
                    }
                    if (args.get_item().get_value() == "ImportEstimateDetails") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("EstimatesDetail");
                        button.click();
                    }--%>
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Estimate.EstimateInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Estimate.EstimateInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Estimate.EstimateInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Estimate.EstimateInfo.Description)%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ESTIMATE")%>';
                var Id = '<%=PM.Estimate.EstimateInfo.Id%>';
                switch (Value) {
                    case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE&Id=" +
                            '<%= PM.Estimate.EstimateInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    
                    <%--case 'Estimate':
                        OpenPOPUp("ObjectImport.aspx?ObjectType=ESTIMATE", 800, 500, true);
                        break;
                    case 'EstimatesDetail':
                        OpenPOPUp("ObjectImport.aspx?ObjectType=ESTIMATE_DETAILS&ParentID=" +
                            '<%=PM.Estimate.EstimateInfo.Id%>' + "&EntityID=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>', 800, 550, true);
                        break;--%>
                    case 'Revit':
                        OpenPOPUp('BimRevitPopup.aspx', 780, 500, true);
                        break;
                    case 'GeneratePMBudgets':
                        OpenPOPUp('EstimatePMBudgets.aspx', 730, 500, true, 'rdgEstimateDetails');
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GeneratePMBudgetsRequest':
                        OpenPOPUp('EstimatePMBudgetsRequests.aspx', 730, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GeneratePMContracts':
                        OpenPOPUp('EstimatePMContracts.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GeneratePMProcurements':
                        OpenPOPUp('EstimatePMProcurement.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GenerateBudgets':
                        OpenPOPUp('EstimateBudgets.aspx', 820, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GenerateBuyoutItems':
                        OpenPOPUp('EstimateBuyoutItem.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GenerateContracts':
                        OpenPOPUp('EstimateContracts.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GeneratePurchaseOrders':
                        OpenPOPUp('EstimateContracts.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'GenerateSubmittals':
                        OpenPOPUp('EstimateSubmittals.aspx', 880, 500, false);
                        //                        eventArgs.set_cancel(true);
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=ESTIMATE&Id=" +
                            '<%= PM.Estimate.EstimateInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=ESTIMATE&Id=" +
                                '<%= PM.Estimate.EstimateInfo.Id%>' + "&Description="
                                                + Description
                                                + "&RecordDescription=" + RecordDescription
                                                + "&EntityId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&EntityType=0", "Notification",
                                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE&Id=" +
                            '<%= PM.Estimate.EstimateInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=ESTIMATE&Id=" +
                        '<%= PM.Estimate.EstimateInfo.Id%>'
                                + "&EntityId=" + '<%=PM.Estimate.EstimateInfo.ProjectId%>' + "&EntityType=0",
                                'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);

                        }
                        break;

                    case 'New':
                        window.location = "Estimates.aspx?Id=0&ModuleId=1&PageId=" + querySt('PageId');
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('ESTIMATE');
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
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


            function AdjustEstimateCostsPrices() {
                if ($("input[id$=txtEstimateUnits]").length == 0) {
                    return false;
                }
                $("input[id$=txtEstimateUnits]").change(function () {
                    UpdateUnitCostPrice($(this));
                });
            }

            function UpdateUnitCostPrice(txtEstimateUnits) {

                if ($("span[id$=lblTotalCost]").length == 0) {
                    return false;
                }
                if ($("input[id$=txtEstimateCostPerUnit]").length == 0) {
                    return false;
                }
                if ($("input[id$=txtEstimatePricePerUnit]").length == 0) {
                    return false;
                }
                if ($("span[id$=lblBidPrice]").length == 0) {
                    return false;
                }

                var TotalCost = CDbl($("span[id$=lblTotalCost]").text());
                var BidPrice = CDbl($("span[id$=lblBidPrice]").text());
                var EstimateUnits = CDbl(txtEstimateUnits.val());
                var Symbol = '<%=PM.CurrencyInfo.Symbol%>';
                var SymbolPosition = '<%=PM.CurrencyInfo.SymbolPosition%>';

                $("input[id$=txtEstimateCostPerUnit]").val(
                            CCCur(CDbl(TotalCost) / CDbl(EstimateUnits), Symbol, SymbolPosition)
                        );

                $("input[id$=txtEstimatePricePerUnit]").val(
                            CCCur(CDbl(BidPrice) / CDbl(EstimateUnits), Symbol, SymbolPosition)
                        );
            }

            function UpdateEstimatetotalMarkup(TotalMarkup) {
                if ($("span[id$=lblTotalMarkup]").length == 0) {
                    return false;
                }
                if ($("span[id$=lblTotalCost]").length == 0) {
                    return false;
                }
                var Symbol = '<%=PM.CurrencyInfo.Symbol%>';
                    var SymbolPosition = '<%=PM.CurrencyInfo.SymbolPosition%>';

                    var lblTotalMarkup = $("span[id$=lblTotalMarkup]");
                    lblTotalMarkup.text(CCCur(TotalMarkup), Symbol, SymbolPosition);
                    var lblTotalCost = $("span[id$=lblTotalCost]");
                    UpdateEstimateCostsPrices(CDbl(lblTotalCost.text()), TotalMarkup);
                    UpdateGrossMarginAndMarkup(CDbl(lblTotalCost.text()), TotalMarkup);
                }

                function UpdateEstimateCostsPrices(TotalCost, TotalMarkup) {
                    if ($("span[id$=lblTotalCost]").length == 0) {
                        return false;
                    }
                    if ($("span[id$=lblTotalMarkup]").length == 0) {
                        return false;
                    }
                    if ($("span[id$=lblBidPrice]").length == 0) {
                        return false;
                    }
                    if ($("input[id$=txtEstimateUnits]").length == 0) {
                        return false;
                    }

                    var lblTotalCost = $("span[id$=lblTotalCost]");
                    var lblTotalMarkup = $("span[id$=lblTotalMarkup]");
                    var lblBidPrice = $("span[id$=lblBidPrice]");
                    var Symbol = '<%=PM.CurrencyInfo.Symbol%>';
                    var SymbolPosition = '<%=PM.CurrencyInfo.SymbolPosition%>';
                    lblTotalCost.text(CCCur(TotalCost, Symbol, SymbolPosition));
                    lblTotalMarkup.text(CCCur(TotalMarkup, Symbol, SymbolPosition));
                    lblBidPrice.text(CCCur(CDbl(TotalCost) + CDbl(TotalMarkup), Symbol, SymbolPosition));
                    UpdateUnitCostPrice($("input[id$=txtEstimateUnits]"));
                    UpdateGrossMarginAndMarkup(TotalCost, TotalMarkup);
                }

                function UpdateGrossMarginAndMarkup(TotalCost, TotalMarkup) {
                    if ($("span[id$=lblGrossMarginValue]").length == 0) {
                        return false;
                    }
                    if ($("span[id$=lblMarkupFooterValue]").length == 0) {
                        return false;
                    }
                    var lblGrossMarginValue = $("span[id$=lblGrossMarginValue]");
                    var lblMarkupFooterValue = $("span[id$=lblMarkupFooterValue]");
                    if ((CDbl(TotalCost) + CDbl(TotalMarkup)) != 0) {
                        lblGrossMarginValue.text(CPrct((CDbl(TotalMarkup) / (CDbl(TotalCost) + CDbl(TotalMarkup))) * 100));
                    }
                    else
                        lblGrossMarginValue.text(CPrct(CDbl(0)));
                    if (CDbl(TotalCost) != 0) {
                        lblMarkupFooterValue.text(CPrct((CDbl(TotalMarkup) / CDbl(TotalCost)) * 100));

                    }
                    else
                        lblMarkupFooterValue.text(CPrct(CDbl(0)));


                }

                var supressDropDownClosing = false;
                function OnClientBlurHandler(sender, eventArgs) {
                    var textInTheCombo = sender.get_text();
                    var item = sender.findItemByText(textInTheCombo);

                    if (supressDropDownClosing != false) {
                        supressDropDownClosing = false;
                        sender.toggleDropDown();
                    }
                    if (!item) {
                        sender.set_text("");
                        setTimeout(function () { var inputElement = sender.get_inputDomElement(); }, 20);
                    }
                }

                function ddlPeriods_OnClientSelectedIndexChanged(sender, eventArgs) {
                    var item = eventArgs.get_item();
                    var itemId = item.get_parent()._clientStateFieldID;

                    var year = item.get_attributes().getAttribute("BudgetYear")
                    var RowContainer = $("#" + itemId).parents(".rgEditForm:first");
                    if (!RowContainer || RowContainer.length == 0)
                        RowContainer = $("#" + itemId).parents("tr:first");
                    var rntYear = $find(RowContainer.find("input[id*='rntYear']")[0].id);

                    if (year.length > 0) {
                        rntYear.set_value(year);
                    }
                    else
                        rntYear.clear();
                }

                function OpenWorkflowSubmitPopup(ObjectType) {
                    OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
                }
        </script>

        <%-- Markup Combo with check boxes --%>
        <style type="text/css">
            #MarkupDiv .rcbScroll {
                overflow: hidden !important;
                position: relative;
            }

            @media screen and (max-width: 930px) and (min-width: 843px) {
                .HideOnMobileToolbar {
                    display: none !important;
                }

                .ToolbarMobileMenu {
                    display: inline-block !important;
                }

                .ShowDropDown.HideOnMobileToolbar {
                    display: table-cell !important;
                }
            }
        </style>
    </telerik:RadCodeBlock>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar EstimateToolBar LargeToolBar"> 
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=2">
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
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar ShowDropDown showOnIpad">
                <telerik:RadComboBox ID="ddlEstimates" runat="server" OnClientTextChange="LOD_DropDownTextChange" NoWrap="True"
                    Skin="Default" AutoPostBack="False" AllowCustomText="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Width="240px" EnableVirtualScrolling="True"
                    meta:resourcekey="ddlEstimates" ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="CreateRevision" ImageUrl="Images/Global/AddLine.png" Width="150px"
                                    CommandName="CreateRevision" Value="Revision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Print" SecurityButtonType="Read" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                   <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
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

                        <telerik:RadToolBarSplitButton CommandName="Generate" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate" ToolTip="Generate">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GeneratePMBudgets"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GeneratePMContracts"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GeneratePMProcurements"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GeneratePMBudgetsRequest"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Visible="False" SecurityButtonType="Prolog" CommandName="GenerateBudgets"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Visible="False" SecurityButtonType="Prolog" CommandName="GenerateBuyoutItems"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Visible="False" SecurityButtonType="Prolog" CommandName="GenerateContracts"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Visible="False" SecurityButtonType="Prolog" CommandName="GeneratePurchaseOrders"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Visible="False" SecurityButtonType="Prolog" CommandName="GenerateSubmittals"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarSplitButton CommandName="CmdBIM" SecurityButtonType="Edit" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarBIM" ToolTip="BIM">
                            <Buttons>
                                <%--<telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="AutoCAD" Value="AutoCAD" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="Navisworks" Value="Navisworks" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="Revit" Value="Revit" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton CommandName="CmdImport" SecurityButtonType="Edit" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarImport" ToolTip="Import">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" CommandName="Estimate" Value="Estimate">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" CommandName="EstimatesDetail" Value="EstimatesDetail">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                         <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="BIM" CssClass="BIM" EnableImageSprite="true">
                                                    <Items>
                                                       <%-- <telerik:RadMenuItem Text="AutoCAD" Value="AutoCAD"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Navisworks" Value="Navisworks"></telerik:RadMenuItem>--%>
                                                        <telerik:RadMenuItem Text="Revit" Value="Revit"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <%--<telerik:RadMenuItem Value="Import" CssClass="Import" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Estimate" Value="ImportEstimates"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Estimate Details" Value="ImportEstimateDetails"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>--%>
                                                <telerik:RadMenuItem Text="Generate" Value="Generate" CssClass="Generate" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Generate Budget" Value="GeneratePMBudgets"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Commitment" Value="GeneratePMContracts"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Procurement" Value="GeneratePMProcurements"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Budget Request" Value="GeneratePMBudgetsRequest"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Budget" Value="GenerateBudgets" Visible="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Buyout Items" Value="GenerateBuyoutItems" Visible="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Contracts" Value="GenerateContracts" Visible="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Purchase Orders" Value="GeneratePurchaseOrders" Visible="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Submittals" Value="GenerateSubmittals" Visible="false"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ESTIMATE');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('ESTIMATE');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
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
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpEstimates" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Value="Adjustments" Text="Adjustments" />
            <telerik:RadTab Value="Markup" Text="Markup" CssClass="Hide" />
            <telerik:RadTab Value="Spec" Text="Specifications" />
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Clauses" Text="Clauses" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Value="DocumentTeam" Text="Collaborate" />
            <telerik:RadTab Value="NotificationLog" Text="Notification" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpEstimates" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project*" meta:resourcekey="lblProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px" UseProjectFilter="1"
                                            CausesValidation="false" EnableLoadOnDemand="True" AutoPostBack="true"
                                            NoWrap="True" AllowCustomText="true" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvProjects" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects" ValidationGroup="Save"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" CssClass="Validator" meta:resourcekey="rfvProjects">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description*" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvtxtDescription" runat="server" ControlToValidate="txtDescription"
                                            CssClass="Validator" Display="Dynamic" ValidationGroup="Save" ForeColor="" meta:resourcekey="rfvtxtDescription">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" runat="server"
                                            Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" Visible="false" runat="server" ControlToValidate="ddlCategory" Display="Dynamic" ForeColor=""
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" Visible="false" runat="server" ControlToValidate="ddlCategory"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="NoWrap controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" runat="server" ValidationGroup="Save" ControlToValidate="txtReference" ForeColor=""
                                            CssClass="Validator" Visible="false" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" Height="24px" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" Style="font-size: 11px" Height="300px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" runat="server" Text="Status" meta:resourcekey="lblStatusRevision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="width: 182px !important"
                                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" runat="server" Width="100%" CssClass="Right"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>

                                <tr>
                                    <td id="GeneratorPane" valign="top" runat="server" colspan="2" style="display: none;">
                                        <table width="100%" cellpadding="1" cellspacing="0" style="background: #fff no-repeat; width: 235px; display: none;" border="0">
                                            <tr>
                                                <td style="height: 39px"></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 12px"></td>
                                                <td>
                                                    <asp:Button ID="btnBudgets" runat="server" OnClientClick="return OpenPOPUp('EstimateBudgets.aspx',820, 500,false);"
                                                        meta:resourcekey="btnBudgets" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnRevisions" runat="server" meta:resourcekey="btnRevisions" />
                                                </td>
                                                <td style="width: 12px"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="btnBuyoutItems" runat="server" OnClientClick="return OpenPOPUp('EstimateBuyoutItem.aspx',880, 500,false);"
                                                        meta:resourcekey="btnBuyoutItems" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnChangeOrders" runat="server" meta:resourcekey="btnChangeOrders" />
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="btnContracts" runat="server" OnClientClick="return OpenPOPUp('EstimateContracts.aspx',880, 500,false);"
                                                        meta:resourcekey="btnContracts" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnWorkOrders" runat="server" meta:resourcekey="btnWorkOrders" />
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="btnPurchaseOrders" runat="server" OnClientClick="return OpenPOPUp('EstimateContracts.aspx',880, 500,false);"
                                                        meta:resourcekey="btnPurchaseOrders" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnTemplates" runat="server" meta:resourcekey="btnTemplates" />
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="btnSubmittals" runat="server" OnClientClick="return OpenPOPUp('EstimateSubmittals.aspx',880, 500,false);"
                                                        meta:resourcekey="btnSubmittals" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEmpty" runat="server" />
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px"></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset id ="flsRecap" runat="server">
                                <legend>
                                    <asp:Label ID="lblRecap" class="legend" runat="server" Text="RECAP" meta:Resourcekey="lblRecap"></asp:Label>
                                </legend>
                                <table id="tblEstimate2" class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEstimateUnitOfMesure" runat="server" meta:resourcekey="lblEstimateUnitsOfMesure"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlUOM" AllowCustomText="true" runat="server" Height="400px" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px;">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEstimateUnits" runat="server" meta:resourcekey="lblUnitsEstimate"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEstimateUnits" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCostUnit" runat="server" meta:resourcekey="lblCostUnit"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEstimateCostPerUnit" CssClass="Double" ReadOnly="true" disabled="disabled" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPriceUnit" runat="server" meta:resourcekey="lblPriceUnit"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEstimatePricePerUnit" CssClass="Double" ReadOnly="true" disabled="disabled" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc13:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:EstimateDetails ID="EstimateDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvMarkup" runat="server" Visible="False">
            <uc2:EstimateMarkup ID="EstimateMarkup" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server" Visible="False">
            <uc6:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </telerik:RadPageView>
         <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc12:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc7:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <asp:Panel ID="pnlEstimateFooter" CssClass="Hide" runat="server">
        <table width="100%">
            <tr>
                <td style="width: 400px"></td>
                <td></td>
                <td style="width: 200px"></td>
                <td align="Left" width="200px">
                    <table width="200px" class="RightLightBlueBorder">
                        <tr>
                            <td>
                                <asp:Label ID="lblTotalCostTitle" runat="server" meta:resourcekey="lblTotalCostTitle"></asp:Label>
                            </td>
                            <td align="Right">
                                <asp:Label ID="lblTotalCost" CssClass="Right" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTotalMarkupTitle" runat="server" meta:resourcekey="lblTotalMarkupTitle"></asp:Label>
                            </td>
                            <td align="Right">
                                <asp:Label ID="lblTotalMarkup" CssClass="Right" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBidPriceTitle" CssClass="Right" Text="Bid Price" runat="server" meta:resourcekey="lblBidPrice"></asp:Label>
                            </td>
                            <td align="Right">
                                <asp:Label ID="lblBidPrice" CssClass="Right" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="Left">
                    <table width="200px">
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblGrossMargin" runat="server" meta:resourcekey="lblGrossMargin"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblGrossMarginValue" CssClass="Right" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMarkupFooter" runat="server" meta:resourcekey="lblMarkupFooter"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblMarkupFooterValue" CssClass="Right" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="5" height="10">&nbsp;</td>
            </tr>
        </table>
    </asp:Panel>

    <telerik:RadAjaxLoadingPanel ID="ldpEstimates" runat="server" />
</asp:Content>
