<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementOnlineChangeRequests.aspx.vb" Inherits="Website.CostManagementOnlineChangeRequests" %>

<%@ Register Src="CostManagementOnlineChangeRequestDetails.ascx" TagName="CostManagementOnlineChangeRequestDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc12" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc13" %>
<%@ Register Src="CostImpacts.ascx" TagName="CostImpacts" TagPrefix="uc11" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc14" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc15" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc16" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
        .RadComboBox_Default .rcbDisabled .rcbInputCell .rcbInput, .RadComboBoxDropDown_Default .rcbDisabled {
            color: #333;
        }

        li.rtbItem.rtbBtn.rtbDisabled.BorderDisabled {
            border: 1px solid #666666 !important;
        }

        .SubmitHover .rtbWrap .rtbIn {
            background: none !important;
        }

        .SubmitHover .rtbWrap .rtbMid {
            background: none !important;
        }

        .SubmitHover .rtbWrap .rtbOut {
            background: none !important;
        }

        .SubmitToolbarBtn {
            height: 12px !important;
            line-height: 8px !important;
            color: #666666 !important;
        }

        @media screen and (min-width:320px) and (max-width:767px) {
            .HideOnMobile {
                display: none !important;
            }
        }
    </style>
    <script src="JS/Costs/OnlineChangeRequest.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.OnlineChangeRequestsInfo.ProjectId %>';
            var forceMoreMenuToClose = true;
            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(str.indexOf('_') + 1);

                if (DetailId != '0' & DetailId != 'CO_0') {
                    OpenPOPUp("UnitRecap.aspx?Source=ONLINECHANGEREQUESTS&DetailId=" +
        DetailId, 740, 500, false);

                }

                try {
                    event.preventDefault();
                }
                catch (err) {

                }
                try {
                    event.returnValue = false;
                }
                catch (err)
                { }


                return false;

            }
            function SubmitWorkflowError(errorMsg, url) {
                alert("'" + errorMsg + "'");
                window.location = url;
            }
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.OnlineChangeRequestsInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" +
                                  '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.OnlineChangeRequestsInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function maintoolbarClick(Value) {
                var RecordDescription = '<%=mid(JSEscape(PM.CostManagement.OnlineChangeRequestsInfo.RecordNumber & " - " & PM.CostManagement.OnlineChangeRequestsInfo.Description),1,20)%>';
                var Description = '<%=mid(JSEscape(PM.CostManagement.OnlineChangeRequestsInfo.Description),1,20)%>';
                var Id = '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>';
                var left = (screen.width - 900) / 2;
                var top = (screen.height - 500) / 2;
                var HasMergeTemplate = '<%= PM.CostManagement.OnlineChangeRequestsInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.OnlineChangeRequestsInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ONLINECHANGEREQUESTS")%>';
                switch (Value) {

                    //case 'Submit':
                    //    return CheckDirtyWorkflow();
                    //    break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" +
                                    '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.OnlineChangeRequestsInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;



                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" +
                        '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.CostManagement.OnlineChangeRequestsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                        case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" +
                        '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.CostManagement.OnlineChangeRequestsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" + Id
                        + "&EntityId=" + '<%= PM.CostManagement.OnlineChangeRequestsInfo.ProjectId %>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        OpenPOPUp("Notification.aspx?ObjectType=ONLINECHANGEREQUESTS&Id=" +
                         '<%= PM.CostManagement.OnlineChangeRequestsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.OnlineChangeRequestsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        break;

                    case 'GenerateChangeEvent':
                        if (Id == 0) break;
                        OpenPOPUpToRedirect("ChangeRequestsGenerateCommitment.aspx?Source=CE", 850, 500);
                        break;

                    case 'GenerateChangeOrder':
                        if (Id == 0) break;
                        OpenPOPUpToRedirect("ChangeRequestsGenerateCommitment.aspx?Source=CCO", 850, 500);
                        break;

                    case 'New':
                        window.location = "CostManagementOnlineChangeRequests.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('ONLINECHANGEREQUESTS');
                        break;

                    default:
                        break;
                }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateChangeEvent") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("GenerateChangeEvent");
                        button.click();
                    }
                    if (args.get_item().get_value() == "GenerateChangeOrder") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("GenerateChangeOrder");
                        button.click();
                    }
                    <%--if (args.get_item().get_value() == "Submit") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Submit");
                        button.click();
                    }--%>
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>

    </telerik:RadCodeBlock>

<%--    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpOnlineChangeRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpOnlineChangeRequests" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpOnlineChangeRequests" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="CreateRevision"
                                    CommandName="CreateRevision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarSplitButton CommandName="Generate" Value="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png" EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Generate Change Event" Width="150px" Value="GenerateChangeEvent" CommandName="GenerateChangeEvent" ImageUrl="Images/ToolBar/PMWebW.gif" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Text="Generate Change Order" Width="150px" Value="GenerateChangeOrder" CommandName="GenerateChangeOrder" ImageUrl="Images/ToolBar/PMWebW.gif" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                         <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="true" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print" PostBack="false">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports" PostBack="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports" PostBack="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates" PostBack="false"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate" PostBack="false">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Change Event" Value="GenerateChangeEvent" PostBack="false"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Change Order" Value="GenerateChangeOrder" PostBack="false"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('ONLINECHANGEREQUESTS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ONLINECHANGEREQUESTS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" PostBack="false"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpOnlineChangeRequests"
        Width="100%" EnableViewState="true" CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Detail" Value="Details" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Cost Impact" Value="CostImpact"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpOnlineChangeRequests" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" runat="server" Text="<%$Resources:CostManagement, Label_Company %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                                OnClientClick="return OpenCompanyFilterPopupWithSource(this.id.replace('imgfilter','hdnComp'),this.id.replace('imgfilter','ddlCompanies'),'Companies','OnlineChangeRequest')">
                                                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:Button ID="btnFillCompanies" runat="server" CssClass="Hide" />
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server"
                                            CloseDropDownOnBlur="true" AutoPostBack="True"
                                            NoWrap="True" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="hdnComp" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" Height="300px"
                                            NoWrap="true" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvProjectRequired" ErrorMessage="Required."
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommitment" runat="server" Text="<%$Resources:CostManagement, Label_Commitment %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCommitments" runat="server" CloseDropDownOnBlur="true"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True"
                                            Height="400px" AutoPostBack="True" NoWrap="true" CausesValidation="False">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitments" runat="server" ControlToValidate="ddlCommitments"
                                            CssClass="Validator" InitialValue=""  meta:resourcekey="rfvCommitmentRequired" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCommitments" runat="server" ControlToValidate="ddlCommitments"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator"  meta:resourcekey="rfvCommitmentRequired" ErrorMessage="Required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" MaxLength="500" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ValidationGroup="Save" ControlToValidate="txtDescription"
                                            CssClass="Validator" Display="Dynamic" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" runat="server" ValidationGroup="Save" ControlToValidate="txtReference"
                                            CssClass="Validator" Visible="false" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                        <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Style="font-size: 11px" Height="300px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordNumber" runat="server" Text="Record #" meta:resourcekey="lblRecordNumber"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtRecordNumber"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            meta:resourcekey="lblRecordNumberAlreadyExist"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="font-size: 11px"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevisionNumber"
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
                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Style="font-size: 11px"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvType" Visible="false" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" Visible="false" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Style="font-size: 11px"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" Visible="false" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" Visible="false" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPostAs" meta:resourcekey="lblPostAs" runat="server" Text="Post As"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPostAs" AllowCustomText="false" runat="server" Style="font-size: 11px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliChangeEvent" meta:Resourcekey="lblChangeEvent" Text="Change Event"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlChangeEvent"
                                            runat="server" AutoPostBack="false" NoWrap="true"
                                            Height="200px" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvChangeEvent" runat="server" ControlToValidate="ddlChangeEvent"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvChangeEvent" runat="server" ControlToValidate="ddlChangeEvent"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliRiskAnalysis" meta:Resourcekey="lblRiskAnalysis" Text="Risk Analysis"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRiskAnalysis"
                                            runat="server" AutoPostBack="false" NoWrap="true"
                                            Height="200px" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvRiskAnalysis" runat="server" ControlToValidate="ddlRiskAnalysis"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="cvvRiskAnalysis" runat="server" ControlToValidate="ddlRiskAnalysis"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliCommitmentChangeOrder" meta:Resourcekey="lbl_CommitmentChangeOrder" Text="Commitment CO"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCommitmentChangeOrder"
                                            runat="server" AutoPostBack="false" NoWrap="true"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitmentCO" runat="server" ControlToValidate="ddlCommitmentChangeOrder"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCommitmentCO" runat="server" ControlToValidate="ddlCommitmentChangeOrder"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset id="fldRequested" runat="server">
                                <legend>
                                    <asp:Label ID="lblRequested" CssClass="legend" runat="server" meta:resourcekey="lblRequested" Text="Requested"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRequestDate" runat="server" Text="Request Date" meta:resourcekey="lblRequestDate"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_rdpRequestDate" style="display: block">
                                                <telerik:RadDatePicker ID="rdpRequestDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'>
                                                    <DateInput ID="DateInput1" runat="server"></DateInput>
                                                    <Calendar ID="Calendar1" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </span>
                                            <asp:RequiredFieldValidator ID="rfvRequestedDate" runat="server" ControlToValidate="rdpRequestDate"
                                                CssClass="Validator" InitialValue="" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblNeededBy" runat="server" Text="Needed By" meta:resourcekey="lblNeededBy"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_rdpNeededBy" style="display: block">
                                                <telerik:RadDatePicker ID="rdpNeededBy" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'>
                                                    <DateInput ID="DateInput2" runat="server"></DateInput>
                                                    <Calendar ID="Calendar2" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </span>
                                            <asp:RequiredFieldValidator ID="rfvNeededByDate" runat="server" ControlToValidate="rdpNeededBy"
                                                CssClass="Validator" Visible="false" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCause" runat="server" Text="Cause" meta:resourcekey="lblCause"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCause" AllowCustomText="true" Filter="Contains" runat="server" Style="font-size: 11px"></telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvCause" Visible="false" runat="server" ControlToValidate="ddlCause"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvCause" runat="server" ControlToValidate="ddlCause"
                                                ClientValidationFunction="Validateddl" Visible="false" ValidationGroup="Save" Display="Dynamic"
                                                CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContact" runat="server" Text="Contact" meta:resourcekey="lblContact"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtContact" MaxLength="500" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvContact" ControlToValidate="txtContact"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblComment" runat="server" Text="Comment" meta:resourcekey="lblComment"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtComment" MaxLength="2000" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvComment" ControlToValidate="txtComment" Display="Dynamic"
                                                runat="server" CssClass="Validator" Visible="false"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset id="fldChangeRequestRecap" runat="server">
                                <legend>
                                    <asp:Label ID="lblChangeRequestRecap" CssClass="legend" runat="server" meta:resourcekey="lblChangeRequestRecap" Text="Change Request Recap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0" style="text-align: center; color: #666666; text-transform: uppercase;">
                                                <tr>
                                                    <td style="width: 60%;" class="NoWrap">
                                                        <asp:Label ID="lblCosts" runat="server" Text="Costs" meta:resourcekey="lblCosts"></asp:Label>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px" class="NoWrap">
                                                        <asp:Label ID="lblDays" runat="server" Text="Days" meta:resourcekey="lblDays"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOriginalValue" runat="server" Text="Original Value" meta:resourcekey="lblOriginalValue"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtOriginalValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtOriginalValueDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblApprovedChanges" runat="server" Text="Approved Changes" meta:resourcekey="lblApprovedChanges"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtApprovedChanges" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtApprovedChangesDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRevisedValue" runat="server" Text="Revised Value" meta:resourcekey="lblRevisedValue"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtRevisedValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtRevisedValueDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblThisRequest" runat="server" Text="This Request" meta:resourcekey="lblThisRequest"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtThisRequest" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtThisRequestDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc16:AssetRotator ID="PMrot" runat="server" />
                            <uc15:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc1:CostManagementOnlineChangeRequestDetails ID="CostManagementOnlineChangeRequestDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc12:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc13:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCostImpact" runat="server">
            <uc11:CostImpacts ID="CostImpacts1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc14:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <asp:Button runat="server" ID="btnReloadWorkflowDoc" CssClass="Hide" />
</asp:Content>
