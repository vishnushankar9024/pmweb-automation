<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CustomForms.aspx.vb" Inherits="Website.CustomForms" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="CustomFormDetails.ascx" TagName="CustomFormDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc7" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <style>
        /*.Custom input[type=text] {
            width: 99% !important;
        }

        .rgDataDiv {
            height: 100% !important;
        }

      */
        /*.UseTemplate > table:first-child,
        .UseTemplate table:first-child > tbody > tr > td > img {
            width: 100% !important;
        }*/

        textarea{
            resize:both !important;
        }

        .RadGrid .RadPicker.RadPicker_Default > input,
        .UseTemplate .RadPicker.RadPicker_Default > input {
            display: none !important;
        }

        .controlWidth input {
            width: 100% !important;
        }

        .PMMainPage .row .col-4 {
            position: relative;
            min-height: 1px;
            width: 400px;
        }

        .PMMainPage .row {
            overflow: unset !important;
        }

        .RadGrid .rgPagerCell .RadComboBox {
            width: 46px !important;
        }

        .RadGrid .rgRow input[type=checkbox],
        .RadGrid .rgAltRow input[type=checkbox] {
            width: 14px !important;
        }

        .UseTemplate br {
            content: " ";
            margin: 2em;
            display: block;
            font-size: 24%;
        }

        /*.UseTemplate .RadGrid .rgPager .RadComboBox {
            width: 75px !important;
        }*/

        /*.UseTemplate .RadComboBox,
        .UseTemplate .RadPicker,
        .UseTemplate tr td > input,
        .UseTemplate > input,
        .UseTemplate input {
            width: 240px !important;
        }*/

        /*.UseTemplate .RadComboBox tr td > input,
            .UseTemplate body .riSingle .riTextBox,
            .UseTemplate .RadPicker input {
                width: 100% !important;
            }*/

        .UseTemplate input[type=checkbox] {
            width: 14px !important;
        }




        .UseTemplate .RadGrid .rgPageFirst,
        .UseTemplate .RadGrid .rgPagePrev,
        .UseTemplate .RadGrid .rgPageNext,
        .UseTemplate .RadGrid .rgPageLast {
            width: 16px !important;
            height: 16px !important;
        }

        .UseTemplate .PMHeader .row {
            padding-top: 0 !important;
        }

        /*.UseTemplate table tbody tr td {
            min-width: 160px;
            max-width: 240px;
           
        }*/
        .UseTemplate .RadPicker {
            max-width: 400px;
        }

        .UseTemplate .RadComboBox_Default .rcbArrowCell,
        .RadPicker table.rcTable td {
            min-width: 100%;
        }
    </style>


    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function CustomFormComboLoad(sender, args) {
                if (sender.get_selectedItem()) {
                    sender.set_text(sender.get_selectedItem().get_text());
                    sender.set_value(sender.get_selectedItem().get_value());
                }
            }

            function ApplicationCreationNotAllowed() {
                radalert("wefwefwef", 450, 200, "wefwefwefwe");
                return false;
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
                var HasReports = '<%= PM.Workflow.CustomFormInfo.HasReports%>';
                var HasMergeTemplate = '<%= PM.Workflow.CustomFormInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.Workflow.CustomFormInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Workflow.CustomFormInfo.Subject)%>';
                var Id = '<%= PM.Workflow.CustomFormInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports(PM.Workflow.CustomFormInfo.ObjectType)%>';
                var ObjectType = '<%= HttpUtility.UrlEncode(PM.Workflow.CustomFormInfo.ObjectType) %>';
                var UseTemplate = '<%= PM.Workflow.CustomFormInfo.UseTemplate%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=" + ObjectType + "&Id=" +
                                '<%= PM.Workflow.CustomFormInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0"
                            + "&CustomFormTypeId=" + '<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>', 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        window.open("Notification.aspx?ObjectType=" + ObjectType + "&Id=" +
                              '<%= PM.Workflow.CustomFormInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0"
                                      + "&CustomFormTypeId=" + '<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>'
                                      , "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);

                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=" + ObjectType + "&Id=" +
                                    '<%= PM.Workflow.CustomFormInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=" + ObjectType + "&Id=" +
                                    '<%= PM.Workflow.CustomFormInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
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
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            window.open("PMWebReports.aspx?ObjectType=" + ObjectType + "&Id=" + Id
                        + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'PrintCustomFormToWord':
                        if (UseTemplate == 'True' && Id > 0) {
                            window.open('MergeProcessing.aspx?ObjectType=' + ObjectType + "&Id=" +
                                '<%= PM.Workflow.CustomFormInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Workflow.CustomFormInfo.ProjectId%>' + "&EntityType=0"
                            + "&CustomFormTypeId=" + '<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>' + '&TemplateId=0&OfficeType=doc&PrintCustomForm=1',
                           'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');
                        }
                        break;
                    case 'Search':
                        window.location = "SearchDocument.aspx?C=" + "<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>";
                        break;

                    case 'New':
                        window.location = "CustomForms.aspx?TypeId=" + "<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>" + "&Id=0&ModuleId=" + "<%=PM.intCurrModuleId%>" + "&PageId=" + "<%=PM.intCurrPageId%>";
                        break;

                    case 'NewInitiative':
                        window.location = "CustomForms.aspx?TypeId=" + "<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>" + "&Id=0&ModuleId=" + "<%=PM.intCurrModuleId%>" + "&PageId=" + "<%=PM.intCurrPageId%>";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup("GENERALCUSTOMFORM_" + "<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>");
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
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlProjects" />
                    <telerik:AjaxUpdatedControl ControlID="txtRecordNumber" />
                    <telerik:AjaxUpdatedControl ControlID="CustomFormDetails1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <%--<td style="width: 240px" class="ToolbarTd HideOnMobileToolbar">
                            <telerik:RadComboBox ID="ddlCustomForms" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                EmptyMessage="Select Custom Form ..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                                CausesValidation="False" Height="400px" NoWrap="true"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientTextChange="LOD_DropDownTextChange"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>--%>

                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                <Items>
                                   <%-- <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" Value="Save" ValidationGroup="Save" AccessKey="s"
                                        ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png" PostBack="false" Value="New"
                                                CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton SecurityButtonType="Copy" Width="150px"
                                                CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" CausesValidation="false" PostBack="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                                        EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewPMWebReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewTemplates">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="PrintCustomFormToWord" Visible="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('GENERALCUSTOMFORM_' + '<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
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
            </td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpCustomForm" Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Details" Value="Header" Selected="True" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpCustomForm" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvDetails" runat="server">
            <asp:Panel ID="pnlDetailPane1" runat="server" Width="100%">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="Date*" meta:resourcekey="lblDate"></asp:Label>
                                    </td>
                                    <td class="customDate">
                                        <span runat="server" id="rmd_calCustomFormTypeDate" style="display: inline-block; width: 100%;">
                                            <telerik:RadDatePicker ID="calCustomFormTypeDate" runat="server"
                                                MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Style="width: 100%" Culture="English (United States)"
                                                EnableTyping="True">
                                                <DateInput ID="DateInput2"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="rfvDate" runat="server" ValidationGroup="Save" ControlToValidate="calCustomFormTypeDate" meta:resourcekey="rfvSubject"
                                                CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubject" runat="server" Text="Subject*" meta:resourcekey="lblSubject"></asp:Label>
                                    </td>
                                    <td class="">
                                        <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ValidationGroup="Save" ControlToValidate="txtSubject" meta:resourcekey="rfvSubject"
                                            CssClass="Validator" ErrorMessage="Enter a subject" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                    </td>
                                    <td class="">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server"
                                            Skin="Default" AutoPostBack="True" AllowCustomText="True" Width="100%"
                                            CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" Height="250px"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvProject" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" meta:resourcekey="rfvProject">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordNumber" runat="server"
                                            Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="">
                                        <asp:TextBox ID="txtRecordNumber" runat="server"
                                            Text="" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" meta:resourcekey="rfvRecordNumber" CssClass="Validator"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" EmptyMessage="Select..."
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" ControlToValidate="ddlCategory" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSatus" runat="server" Text="Status" meta:resourcekey="lblSatus"></asp:Label>
                                    </td>
                                    <td class="">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%"
                                            Skin="Default" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBudgetTotal" runat="server" Text="Budget Total" meta:resourcekey="lblBudgetTotal"></asp:Label></td>
                                    <td class="">
                                        <asp:TextBox ID="txtBudgetTotal" CssClass="Currency" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvBudgetTotal" ControlToValidate="txtBudgetTotal" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCreatedBy" runat="server" Text="Created By" meta:resourcekey="lblCreatedBy" />
                                    </td>
                                    <td class="">
                                        <asp:Label ID="lblCreatedByUser" Width="100%" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordDate" runat="server" Text="Record Date" meta:resourcekey="lblRecordDate" />
                                    </td>
                                    <td class="">
                                        <telerik:RadDatePicker ID="rdpRecordDate" runat="server" MinDate="1901-01-01"
                                            Width="100%" Skin="Default">
                                            <DateInput runat="server" LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                            <Calendar runat="server" Skin="Default"></Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="rfvRecordDate" ControlToValidate="rdpRecordDate" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevision" runat="server" Text="Revision" meta:resourcekey="lblRevision" /></td>
                                    <td class="">
                                        <asp:TextBox ID="txtRevision" runat="server" CssClass="Integer"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevision" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" Text="Company" meta:resourcekey="lblCompany" /></td>
                                    <td class="">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" EmptyMessage="Select Company..."
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCompanies" ControlToValidate="ddlCompanies" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompanies" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:resourcekey="lblType" />
                                    </td>
                                    <td class="">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" EmptyMessage="Select..."
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTypes" ControlToValidate="ddlTypes" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTypes" runat="server" ControlToValidate="ddlTypes"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
            </asp:Panel>
            <div class="PMMainPage">
                <uc1:CustomFormDetails ID="CustomFormDetails1" runat="server" />
            </div>

        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc7:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
