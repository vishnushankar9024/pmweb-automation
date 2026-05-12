<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementPayments.aspx.vb" Inherits="Website.CostManagementPayments" %>

<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="ucNotes" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="UcAttachements" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="ucWorflow" %>
<%@ Register Src="~/CostManagementAPPaymentLedger.ascx" TagName="APPaymentLedger" TagPrefix="uc2" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc1" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc12" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc13" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc14" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.PaymentsInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=APPayments&Id=" +
                                     '<%= PM.CostManagement.PaymentsInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {

                var HasMergeTemplate = '<%= PM.CostManagement.PaymentsInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.PaymentsInfo.RecordNumber & " - " & PM.CostManagement.PaymentsInfo.Description)%>';
                var Description = '<%=JSEscape(PM.CostManagement.PaymentsInfo.Description)%>';
                var Id = '<%= PM.CostManagement.PaymentsInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("APPayments")%>';
                var HasReports = '<%= PM.CostManagement.PaymentsInfo.HasReports%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=APPayments&Id=" +
                     '<%= PM.CostManagement.PaymentsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                    break;

                case 'ViewTemplates':
                    if (HasMergeTemplate == 'True') {
                        OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=APPayments&Id=" +
                            '<%= PM.CostManagement.PaymentsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=APPayments&Id=" + Id
                            + "&EntityId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=APPayments&Id=" +
                                '<%= PM.CostManagement.PaymentsInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                        case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=APPayments&Id=" +
                                '<%= PM.CostManagement.PaymentsInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PaymentsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'New':
                        window.location = "CostManagementPayments.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('APPayments');
                        break;

                    default:
                        break;
                }
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <style>
        input#ctl00_CPH1_chkAppliedInFull{
            margin-left:0px
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>         
             <telerik:AjaxSetting AjaxControlID="mlpPayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPayment" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPayment" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <%--        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbldropdown">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Comp" />
                    <telerik:AjaxUpdatedControl ControlID="tblmain" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbldropdown" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar SmallToolbar">
        <tr>
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=199">
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
            <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlPayments" runat="server" AllowCustomText="true" Skin="Default"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlPayments"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" AutoPostBack="false" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" ToolTip="Save (Alt+s)"
                            CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                       <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false"
                            SecurityButtonType="Add" EnableDefaultButton="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification"
                            ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint HideOnMobileToolbar">
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

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="radmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('APPayments');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('APPayments');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#payments"></telerik:RadToolBarButton>
                    
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpPayment" Skin="Default"
        Width="100%" EnableViewState="true" CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Additional Applications" Value="AdditionalApplications" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpPayment" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" EnableAJAX="false" Width="100%">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvProgram" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true"  Height="300px" meta:Resourcekey="ddlProjects"
                                            NoWrap="true" Skin="Default" Width="100%" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:Resourcekey="rfvProgram"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliAPContract" meta:Resourcekey="lblAPContract" Text="Commitment"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlAPContract" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%" EnableVirtualScrolling="True"
                                            Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitment" runat="server" ControlToValidate="ddlAPContract"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCommitment" runat="server" ControlToValidate="ddlAPContract"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliLinkedAPInvoice" meta:Resourcekey="lblLinkedAPInvoice" Text="Linked A/P Invoice"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLinkedAPInvoice" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%" EnableVirtualScrolling="True"
                                            Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLinkedInvoice" runat="server" ControlToValidate="ddlLinkedAPInvoice"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" Visible="false" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLinkedInvoice" runat="server" ControlToValidate="ddlLinkedAPInvoice"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Required" meta:Resourcekey="rfvProgram"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>"
                                            Visible="False" Class="Validator">
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" Height="18px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Skin="Default">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPaymentBatch" meta:Resourcekey="lblPaymentBatch" Text="Payment Batch"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentBatch" runat="server" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" Text="Status / Revision" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                        Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>
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
                                    <td class="labelWidth" id="tdCompany">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton"
                                                OnClientClick="return OpenCompanyFilterPopupProjectNotRequired1(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlCompanies'),'Companies')">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:HiddenField ID="HiddenField2" runat="server" />
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div style="width: 100%; white-space: nowrap">
                                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%" ShowMoreResultsBox="true"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies"  NoWrap="False"
                                                EnableLoadOnDemand="True" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
                                                ClientValidationFunction="ValidateComboWithimgfilter" ValidationGroup="Save" Display="Dynamic"
                                                CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" CausesValidation="False" AutoPostBack="false" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>

                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" AutoPostBack="false" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" runat="server" ControlToValidate="txtReference"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" valign="top">
                                        <asp:Label ID="lblNotes" runat="server" Text="Notes" meta:resourcekey="lblNotes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" TextMode="MultiLine" ID="txtNotes" Height="82px" Style="width: 100%; box-sizing: border-box"></asp:TextBox>

                                        <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="txtNotes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAppliedInFull" runat="server" Text="Applied In Full" meta:resourcekey="lblAppliedInFull"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkAppliedInFull" runat="server" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <table runat="server" id="tblmain" class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOpenBalance" runat="server" Text="Open Balance" meta:Resourcekey="lblOpenBalance"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOpenBalance" CssClass="Currency" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvOpenBalance" runat="server" ControlToValidate="txtOpenBalance"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentAmount" runat="server" Text="Payment Amount" meta:Resourcekey="lblPaymentAmount"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentAmount" CssClass="Currency"  runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPaymentAmount" runat="server" ControlToValidate="txtPaymentAmount"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblCostCode" runat="server" meta:Resourcekey="lblCostCode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="hplCostCode" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" Filter="Contains"
                                            EnableItemCaching="false" MarkFirstMatch="true" meta:Resourcekey="ddlCostCode"
                                            Skin="Default" CloseDropDownOnBlur="true" OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="True" AllowCustomText="true" ValidationGroup="Save" Style="font-size: 11px" Height="250px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPeriod" runat="server" Text="<%$Resources:CostManagement, Label_Period %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
                                            Skin="Default" Width="100%" Height="300px" NoWrap="true" CausesValidation="false"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceNumber" meta:resourcekey="lblInvoiceNumber" runat="server" Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInvoice" runat="server" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceNumber" runat="server" ControlToValidate="txtInvoice"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentMethod" meta:Resourcekey="lblPaymentMethod" runat="server" Text="Payment Method"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPaymentMethod" AllowCustomText="true" Filter="Contains" runat="server"
                                            Skin="Default" Style="font-size: 11px" Width="100%">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPaymentMethod" runat="server" ControlToValidate="ddlPaymentMethod"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPaymentMethod" runat="server" ControlToValidate="ddlPaymentMethod" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentNumber" meta:Resourcekey="lblPaymentNumber" runat="server" Text="Payment #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentNumber" runat="server" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPaymentNumber" runat="server" ControlToValidate="txtPaymentNumber"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentDate" meta:Resourcekey="lblPaymentDate" runat="server" Text="Payment Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpPaymentDate" style="display: block">
                                            <telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvPaymentDate" runat="server" ControlToValidate="rdpPaymentDate"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblHidenRows" runat="server" Text="" Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvLedger" runat="server" CssClass="ShowInHeaderWhenFit Responsive" style="padding-bottom:20px;">
            <uc2:APPaymentLedger ID="APPaymentLedger1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc12:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc13:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <ucNotes:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <UcAttachements:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <ucWorflow:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc14:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc1:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <%--    <table id="Table1" style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
<tr class="ToolBar">

<td style="padding-left: 5px; width: 330px;">
<telerik:RadComboBox ID="ddlPayments" runat="server" AllowCustomText="true" Skin="Default"
Height="400px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="Select a Payment..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
Width="300px" DropDownWidth="400px" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlPayments"
ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" AutoPostBack="false">
                    
<CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
</telerik:RadComboBox>
</td>

<td valign="middle" style="padding-left: 5px;">
<telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
<Items>
<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
Value="Search" NavigateUrl="SearchDocument.aspx?O=199" CausesValidation="false">
</telerik:RadToolBarButton>

<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false">
</telerik:RadToolBarButton>

<telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save"
ToolTip="Save (Alt+s)">
</telerik:RadToolBarButton>

<telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
</telerik:RadToolBarButton>

<telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>


<telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
</telerik:RadToolBarButton>

<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
EnableDefaultButton="false" PostBack="false">
<Buttons>
<telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
</telerik:RadToolBarButton>
<telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
</telerik:RadToolBarButton>
<telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
</telerik:RadToolBarButton>
</Buttons>
</telerik:RadToolBarSplitButton>
<telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#payments"></telerik:RadToolBarButton>
</Items>
</telerik:RadToolBar>
</td>

</tr>
</table>

<table style="width: 100%;" cellpadding="0" cellspacing="0">
<tr>
<td>
<telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" EnableAJAX="false" Width="100%">
<table border="0" style="padding-top: 5px;">
<tr>
<td valign="top">
<table runat="server" id="tbldropdown" style="width: 380px;" border="0">
<tr>
<td style="width: 100px;">
<asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="255px"
Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
</telerik:RadComboBox>

<asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvProgram" runat="server" ControlToValidate="ddlProgram"
CssClass="Validator" InitialValue="" ErrorMessage="Program required"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

</td>
</tr>
<tr>
<td>
<asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True" CausesValidation="False"
CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:Resourcekey="ddlProjects"
NoWrap="true" Skin="Default" Width="255px" DropDownWidth="400px" ShowMoreResultsBox="True"
EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
</telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_ProjectRequired%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

</td>
</tr>
<tr>
<td>
<asp:HyperLink runat="server" CssClass="Link" ID="hliAPContract" meta:Resourcekey="lblAPContract" Text="Commitment"></asp:HyperLink>
</td>
<td>
<telerik:RadComboBox ID="ddlAPContract" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="255px"
Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
</telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvCommitment" runat="server" ControlToValidate="ddlAPContract"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvCommitment" runat="server" ControlToValidate="ddlAPContract"
ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:HyperLink runat="server" CssClass="Link" ID="hliLinkedAPInvoice" meta:Resourcekey="lblLinkedAPInvoice" Text="Linked A/P Invoice"></asp:HyperLink>
</td>
<td>
<telerik:RadComboBox ID="ddlLinkedAPInvoice" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="255px"
Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
</telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvLinkedInvoice" runat="server" ControlToValidate="ddlLinkedAPInvoice"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvLinkedInvoice" runat="server" ControlToValidate="ddlLinkedAPInvoice"
ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtCode" runat="server" MaxLength="30" Width="147px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_IDIsRequired %>"
ForeColor=""></asp:RequiredFieldValidator>

<asp:Label ID="lblCommIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>"
Visible="False" Class="Validator"></asp:Label>

</td>
</tr>
<tr>
<td>
<asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>

</td>
<td>
<asp:TextBox runat="server" ID="txtDescription" Width="251px" Text=""></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvDescription" runat="server" ValidationGroup="Save" ControlToValidate="txtDescription"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
ForeColor=""></asp:RequiredFieldValidator>
</td>
</tr>
<tr runat="server" id="trCurrency">
<td>
<asp:HyperLink runat="server" CssClass="Link" ID="hplCurrency" Height="16px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:HyperLink>
</td>
<td>
<telerik:RadComboBox ID="ddlCurrencies" Width="255px" Height="300px" runat="server" Skin="Default" Style="font-size: 11px" AutoPostBack="true">
</telerik:RadComboBox>
</td>
</tr>
<tr>
<td>
<asp:HyperLink runat="server" CssClass="Link" ID="hliPaymentBatch" meta:Resourcekey="lblPaymentBatch" Text="Payment Batch"></asp:HyperLink>
</td>
<td>
<asp:TextBox ID="txtPaymentBatch" runat="server" ReadOnly="true" Width="146px"></asp:TextBox>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_Status %>"></asp:Label>
</td>
<td>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<telerik:RadComboBox ID="ddlStatus" runat="server" Width="150px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
<td style="padding-left: 10px;">
<asp:Label ID="lblRevision" runat="server" Text="<%$Resources:CostManagement, Label_Revision %>"></asp:Label>
</td>
<td align="right" style="width: 48px">
<asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="35px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevisionNumber"
runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:RequiredFieldValidator>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
<td valign="top">
<table runat="server" id="tblmain" width="280px" border="0">
<tr>
<td style="width: 100px;">
<asp:Label ID="lblOpenBalance" runat="server" Text="Open Balance" meta:Resourcekey="lblOpenBalance"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtOpenBalance" CssClass="Currency" runat="server" Width="129px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvOpenBalance" runat="server" ValidationGroup="Save" ControlToValidate="txtOpenBalance"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ForeColor="">
</asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentAmount" runat="server" Text="Payment Amount" meta:Resourcekey="lblPaymentAmount"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtPaymentAmount" CssClass="Currency" MinNumber="0" runat="server" Width="129px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvPaymentAmount" runat="server" ValidationGroup="Save" ControlToValidate="txtPaymentAmount"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
ForeColor=""></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
<asp:HyperLink ID="hplCostCode" runat="server" meta:Resourcekey="lblCostCode"></asp:HyperLink>
</td>
<td>
<telerik:RadComboBox ID="ddlCostCode" runat="server" Width="133px" DropDownWidth="300px" Filter="Contains"
EnableItemCaching="false" MarkFirstMatch="true" meta:Resourcekey="ddlCostCode"
Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." OnItemsRequested="ddl_ItemsRequested"
NoWrap="True" AllowCustomText="true" ValidationGroup="Save" Style="font-size: 11px" Height="250px"
EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
</telerik:RadComboBox>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPeriod" runat="server" Text="<%$Resources:CostManagement, Label_Period %>"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
Skin="Default" Width="133px" Height="300px" NoWrap="true" CausesValidation="false"
EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
OnItemsRequested="ddl_ItemsRequested">
</telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblInvoiceNumber" meta:resourcekey="lblInvoiceNumber" runat="server" Text="Invoice #"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtInvoice" runat="server" MaxLength="50" Width="129px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvInvoiceNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtInvoice"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
ForeColor=""></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentMethod" meta:Resourcekey="lblPaymentMethod" Width="100px" runat="server" Text="Payment Method"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlPaymentMethod" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="133px"></telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvPaymentMethod" runat="server" ControlToValidate="ddlPaymentMethod"
CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvPaymentMethod" runat="server" ControlToValidate="ddlPaymentMethod" ValidateEmptyText="true"
ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentNumber" meta:Resourcekey="lblPaymentNumber" Width="100px" runat="server" Text="Payment #"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtPaymentNumber" runat="server" MaxLength="50" Width="129px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvPaymentNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtPaymentNumber"
CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
ForeColor=""></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblPaymentDate" meta:Resourcekey="lblPaymentDate" Width="100px" runat="server" Text="Payment Date"></asp:Label>
</td>
<td>
<span runat="server" id="rmd_rdpPaymentDate" style="display: block">
<telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="130px" Skin="Default">
<DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
<Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
</telerik:RadDatePicker>
</span>
<asp:RequiredFieldValidator ID="rfvPaymentDate" runat="server" ControlToValidate="rdpPaymentDate"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save">
</asp:RequiredFieldValidator>
</td>
</tr>

<tr>
<td colspan="2">
<asp:Label ID="lblHidenRows" runat="server" Text="Some of the detail lines are hidden for security reasons." Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label></td>
</tr>
</table>
</td>
<td valign="top">
<table id="Comp" runat="server" border="0" width="365px">
<tr>
<td style="width: 80px;">
<asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
</td>
<td class="NoWrap">
<table cellpadding="0" cellspacing="0">
<tr>
<td>
<div style="width: 100%; white-space: nowrap">
<telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="250px" DropDownWidth="320px"
CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
<CollapseAnimation Duration="200" Type="OutQuint" />
</telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
ClientValidationFunction="ValidateComboWithimgfilter" ValidationGroup="Save" Display="Dynamic"
CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
<asp:HiddenField ID="HiddenField2" runat="server" />
</div>
</td>
<td>

<asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton"
OnClientClick="return OpenCompanyFilterPopupProjectNotRequired1(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlCompanies'),'Companies')">
<span class="Icon"></span>
</asp:LinkButton>
                                                    
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="250px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="250px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
<asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save">
</asp:RequiredFieldValidator>
<asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
</asp:CustomValidator>
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtReference" runat="server" Width="247px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvReference" runat="server" ControlToValidate="txtReference"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save">
</asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td valign="top">
<asp:Label ID="lblNotes" runat="server" Text="Notes" meta:resourcekey="lblNotes"></asp:Label>
</td>
<td>
<asp:TextBox runat="server" TextMode="MultiLine" ID="txtNotes" Height="60px" Width="247px"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="txtNotes"
CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
Display="Dynamic" ForeColor="" ValidationGroup="Save">
</asp:RequiredFieldValidator>
                                            
</td>
</tr>
<tr>
<td>
<asp:Label ID="lblAppliedInFull" runat="server" Text="Applied In Full" meta:resourcekey="lblAppliedInFull"></asp:Label>
</td>
<td>
<asp:CheckBox ID="chkAppliedInFull" runat="server" />
</td>
</tr>
</table>
</td>
<td valign="top">
<uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
</td>
</tr>
</table>
</telerik:RadAjaxPanel>
</td>
</tr>
<tr>
<td style="height: 8px"></td>
</tr>
<tr id="trTbsDetails" runat="server">
<td>
<table width="100%">
<tr>
<td>
<telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting"
runat="server" MultiPageID="mlpPayment" Skin="Default"
Width="100%" EnableViewState="true" CausesValidation="false">
                                
<Tabs>
<telerik:RadTab Text="Additional Applications" Value="AdditionalApplications" Selected="true"></telerik:RadTab>
<telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
<telerik:RadTab Text="Tasks" Value="Checklists" />
<telerik:RadTab Text="Clauses" Value="Clauses" />
<telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
<telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
<telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
<telerik:RadTab Text="Collaborate" Value="DocumentTeam" /> 
<telerik:RadTab Text="Notification" Value="NotificationLog"></telerik:RadTab>
</Tabs>
</telerik:RadTabStrip>

<telerik:RadMultiPage ID="mlpPayment" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true">


<telerik:RadPageView ID="pvLedger" runat="server">
<uc2:APPaymentLedger ID="APPaymentLedger1" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="PvSpec" runat="server">
<uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvChecklist" runat="server">
<uc12:DocumentCheckList ID="DocumentCheckList1" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvClauses" runat="server">
<uc13:DocumentClauses ID="DocumentClauses1" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvNotes" runat="server">
<ucNotes:DocumentNotes ID="DocumentNotes" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvAttachments" runat="server">
<UcAttachements:DocumentAttachments ID="DocumentAttachments" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvWorkflow" runat="server">
<ucWorflow:WorkflowDocument ID="WorkflowDocument" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
<uc14:DocumentTeam ID="DocumentTeam1" runat="server" />
</telerik:RadPageView>

<telerik:RadPageView ID="pvNotificationLog" runat="server">
<uc1:NotificationLog ID="NotificationLog1" runat="server" />
</telerik:RadPageView>
</telerik:RadMultiPage>
</td>
</tr>
</table>
</td>
</tr>
</table>--%>
</asp:Content>
