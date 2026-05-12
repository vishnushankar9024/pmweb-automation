<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DocumentRisks.aspx.vb" Inherits="Website.DocumentRisks" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentRiskDetails.ascx" TagName="DocumentRiskDetails" TagPrefix="uc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc6" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Toolbox/Risk.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateChangeEvent") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("GenerateCE");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var RecordDescription = '<%=JSEscape(PM.RiskAnalysisInfo.ProjectName)%>';
                var Description = '<%=JSEscape(PM.RiskAnalysisInfo.Description)%>';
                var HasReports = '<%= PM.RiskAnalysisInfo.HasReports%>';
                RecordDescription = RecordDescription + ' - ' + Description;
                var Id = '<%= PM.RiskAnalysisInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("RISKANALYSIS")%>';
                switch (Value) {

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=RISKANALYSIS&Id=" +
                               '<%= PM.RiskAnalysisInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.RiskAnalysisInfo.ProjectId%>' + "&EntityType=0", "Notification",900,500,false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=RISKANALYSIS&Id=" + Id
                        + "&EntityId=" + '<%=PM.RiskAnalysisInfo.ProjectId%>' + "&EntityType=0",900,500,false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=RISKANALYSIS&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.RiskAnalysisInfo.ProjectId%>' + "&EntityType=0",890,460,false);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=RISKANALYSIS&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.RiskAnalysisInfo.ProjectId%>' + "&EntityType=0", 890, 460, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'New':
                        window.location = "DocumentRisks.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('RISKANALYSIS');
                        break;
                    default:
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
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

            function OpenCEPOPWindow(URL, Width, Height) {
                debugger;
                var left = (screen.width - Width) / 2 ;
                var top = (screen.height - Height) / 2;
                var wnd= window.radopen(URL);
                wnd.setSize(Width, Height);
                wnd.moveTo(left,top)
                wnd.Center();
            }
            
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>   
           <telerik:AjaxSetting AjaxControlID="mlpRisks">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRisks" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRisks" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/EmailMessage.gif"
                            CommandName="Notification" PostBack="false" CausesValidation="false" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                 <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
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
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Change Event" Value="GenerateChangeEvent"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('RISKANALYSIS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('RISKANALYSIS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" CssClass="ToolbarGenerate" OuterCssClass="HideOnMobileToolbar" SecurityButtonType="Add" Value="Generate">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Change Event" Value="GenerateCE" CommandName="GenerateCE" ImageUrl="Images/ToolBar/PMWebW.gif"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>

    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpRisks" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments"  />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpRisks" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages" RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProjects" meta:resourcekey="lblProjects" runat="server" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True"
                                            
                                            NoWrap="true" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvProjectRequired"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfvProject">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase" Text="Phase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhases" runat="server" AutoPostBack="True" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAnalysis" meta:resourcekey="lblAnalysis" runat="server" Text="Analysis #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="13" ID="txtAnalysis" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvAnalysisNumber" runat="server" ControlToValidate="txtAnalysis"
                                            CssClass="Validator" ErrorMessage="<br/>Required" Display="Dynamic"
                                            ForeColor="" ValidationGroup="Save" meta:resourcekey="rfvAnalysisNumber">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label runat="server" ID="lblAnalysisError" CssClass="Validator" Text=""></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="200" ID="txtDescription" Text=""></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAnalysisDate" meta:resourcekey="lblAnalysisDate" runat="server" Text="AnalysisDate1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpAnalysisDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpAnalysisDate" runat="server" SharedCalendarID=""
                                                MinDate="01-01-1900">
                                                <DateInput ID="DateInput2" runat="server" />
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliChangeRequest" Text="Change Request"
                                            meta:Resourcekey="lblChangeRequest">
                                        </asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ReadOnly="true" ID="txtChangeRequest"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliChangeEvent" Text="Change Event"
                                            meta:Resourcekey="lblChangeEvent"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ReadOnly="true" ID="txtChangeEvent"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="font-size: 11px">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox runat="server" ReadOnly="true" CssClass="PositiveInteger" ID="txtRevision"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" meta:resourcekey="lblDate" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDate" runat="server" SharedCalendarID=""
                                                MinDate="01-01-1900">
                                                <DateInput ID="DateInput1" runat="server" />
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                </table>
                                <table class="colTable">
                                <tr >
                                    <td class="labelColor NoWrap"  style="height:24px">
                                        <asp:Label ID="lblUpdateRiskCost" runat="server" Text="Update higher level risk cost111" meta:ResourceKey="chkUpdateRiskCost"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="width: 20px" align="right">
                                        <asp:CheckBox ID="chkUpdateRiskCost" runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelColor NoWrap"  style="height:24px">
                                        <asp:Label ID="lblUpdateRiskDelay" runat="server" Text="Update higher level risk delay111" meta:ResourceKey="chkUpdateRiskDelay"></asp:Label>
                                    </td>
                                    <td class="controlWidth" align="right">
                                        <asp:CheckBox ID="chkUpdateRiskDelay" runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelColor NoWrap"  style="height:24px">
                                        <asp:Label ID="lblUpdateRiskImpact" runat="server" Text="Update higher level risk impact111" meta:ResourceKey="chkUpdateRiskImpact"></asp:Label>
                                    </td>
                                    <td class="controlWidth" align="right">
                                        <asp:CheckBox ID="chkUpdateRiskImpact" runat="server" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <div style="width: 100%; overflow: auto; max-width: calc(100vw - 40px)">
                                <telerik:RadChart ID="rdcRisk" runat="server" Height="250px"
                                    AutoTextWrap="true" Width="400px">
                                </telerik:RadChart>
                            </div>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc12:AssetRotator ID="PMrot" runat="server" />
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:DocumentRiskDetails ID="DocumentRiskDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc6:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc2:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
