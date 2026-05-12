<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CustomFormTypePreviewPopup.aspx.vb" Inherits="Website.CustomFormTypePreviewPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CustomFormDetails.ascx" TagName="CustomFormDetails" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title>PMWeb</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>

    <script type="text/javascript">

        function OpenApplicationNotesPopup(Id) {
            OpenPOPUp('ApplicationNotesPopup.aspx?Id=' + Id, 946, 545, true, 'rdgNotes');
            return false;
        }

        function GoToTop() {
            $("html").scrollTop();
        }

    </script>
    <style type="text/css">
        .details {
            white-space: normal;
            width: 205px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">

                function click_handler(sender, args) {
                    var HasReports = '<%= PM.Workflow.CustomFormInfo.HasReports%>';
                    var HasMergeTemplate = '<%= PM.Workflow.CustomFormInfo.HasMergeTemplate%>';
                    var RecordDescription = '<%=JSEscape(PM.Workflow.CustomFormInfo.RecordDescription)%>';
                    var Description = '<%=JSEscape(PM.Workflow.CustomFormInfo.Subject)%>';
                    var Id = '<%= PM.Workflow.CustomFormInfo.Id%>';
                    var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports(PM.Workflow.CustomFormInfo.ObjectType)%>';
                    var ObjectType = '<%= HttpUtility.UrlEncode(PM.Workflow.CustomFormInfo.ObjectType) %>';
                    var UseTemplate = '<%= PM.Workflow.CustomFormInfo.UseTemplate%>';
                    switch (args.get_item().get_commandName()) {
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
                        default:
                            //                        eventArgs.set_cancel(false);
                            break;
                    }
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
        <telerik:RadAjaxLoadingPanel ID="ldpCustomForms" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />


        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <%--     <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" CssClass="lnkPage" PostBackUrl="SearchDocument.aspx?C=" + "'<%=PM.Workflow.CustomFormInfo.CustomFormTypeId%>'">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>--%>
                <td class="ToolbarTd" style="width: 240px !important;">
                    <telerik:RadComboBox ID="ddlCustomForms" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                        EmptyMessage="Select Custom Form ..." Width="100%" AutoPostBack="True" AllowCustomText="true"
                        CausesValidation="False" Height="400px" NoWrap="true"
                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientTextChange="LOD_DropDownTextChange"
                        EnableVirtualScrolling="True">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Read" PostBack="false" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                Value="Search" CausesValidation="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save"
                                ValidationGroup="Save" AccessKey="s" ToolTip="Save (Alt+s)">
                            </telerik:RadToolBarButton>

                            <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" Value="New" 
                                            CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                                SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                <Buttons>
                                    <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                        CommandName="New" SecurityButtonType="Add">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Copy"
                                        CommandName="Copy" Value="CopyRecord" ValidationGroup="Save">
                                    </telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>

                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                                CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                            <%--<telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png"></telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" CausesValidation="false" PostBack="false" CommandName="Notification" OuterCssClass="HideOnMobileToolbar"
                                ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                                EnableDefaultButton="false" PostBack="false">
                                <Buttons>
                                    <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewPMWebReports">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewTemplates">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="PrintCustomFormToWord" Visible="false">
                                    </telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td></td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <asp:Panel ID="pnlDetailPane1" runat="server" Width="100%">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDate"></asp:Label></td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_calCustomFormTypeDate" style="display: block">
                                        <telerik:RadDatePicker ID="calCustomFormTypeDate" runat="server"
                                            Width="104px" Skin="Default">
                                            <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                            <Calendar Skin="Default"></Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="rfvDate" runat="server" ValidationGroup="Save" ControlToValidate="calCustomFormTypeDate" meta:resourcekey="rfvSubject"
                                            CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSubject" runat="server" Text="Subject*" meta:resourcekey="lblSubject"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ValidationGroup="Save" ControlToValidate="txtSubject" meta:resourcekey="rfvSubject"
                                        CssClass="Validator" ErrorMessage="Enter a subject" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlProjects" runat="server" 
                                        Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                        CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="True">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>" ValidationGroup="Save"
                                        Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                        ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRecordNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRecordNumber" runat="server" Text=""></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" Display="Dynamic" ValidationGroup="Save"
                                        runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                        Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference" Display="Dynamic" ValidationGroup="Save"
                                        runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default">
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
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default">
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
                                    <asp:Label ID="lblBudgetTotal" runat="server" Text="Budget Total" meta:resourcekey="lblBudgetTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBudgetTotal" CssClass="Currency" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvBudgetTotal" ControlToValidate="txtBudgetTotal" Display="Dynamic" ValidationGroup="Save"
                                        runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCreatedBy" runat="server" Text="Created By" meta:resourcekey="lblCreatedBy" />
                                </td>
                                <td class="controlWidth">
                                    <asp:Label ID="lblCreatedByUser" CssClass="AllLightBlueBorder" Width="100%" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRecordDate" runat="server" Text="Record Date" meta:resourcekey="lblRecordDate" />
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadDatePicker ID="rdpRecordDate" runat="server"
                                        Width="100%" Skin="Default">
                                        <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                        <Calendar ID="Calendar1" runat="server" Skin="Default"></Calendar>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="rfvRecordDate" ControlToValidate="rdpRecordDate" Display="Dynamic" ValidationGroup="Save"
                                        runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRevision" runat="server" Text="Revision" meta:resourcekey="lblRevision" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRevision" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevision" Display="Dynamic" ValidationGroup="Save"
                                        runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCompany" runat="server" Text="Company" meta:resourcekey="lblCompany" />
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCompanies" runat="server" EmptyMessage="Select Company..."
                                        Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                        CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="True">
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
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlTypes" runat="server" EmptyMessage="Select..."
                                        Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                        CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="True">
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
                    </asp:Panel>
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <table class="colTable">
                        <tr id="trCustomFormDetails" runat="server">
                            <td>
                                <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1"
                                    runat="server" MultiPageID="mlpCustomForm" Skin="Default"
                                    Width="100%" EnableViewState="True" CausesValidation="false">
                                    <Tabs>
                                        <telerik:RadTab Text="Details" Value="Details" Selected="True" />
                                    </Tabs>
                                </telerik:RadTabStrip>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <table class="colTable">
                        <tr valign="top">
                            <td>
                                <telerik:RadMultiPage ID="mlpCustomForm" runat="server" SelectedIndex="0" Width="100%"
                                    RenderSelectedPageOnly="true">
                                    <telerik:RadPageView ID="pvDetails" runat="server">
                                        <uc1:CustomFormDetails ID="CustomFormDetails1" runat="server" />
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
