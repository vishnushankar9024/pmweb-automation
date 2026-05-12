<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementMasterCommitments.aspx.vb" Inherits="Website.CostManagementMasterCommitments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc3" %>
<%@ Register Src="MasterCommitmentCommitments.ascx" TagName="Commitments" TagPrefix="uc1" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc7" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            var forceMoreMenuToClose = true;
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.CostManagement.MasterCommitmentInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.MasterCommitmentInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.MasterCommitmentInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.MasterCommitmentInfo.Description)%>';
                var Id = '<%= PM.CostManagement.MasterCommitmentInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("MASTERCOMMITMENTS") %>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=MASTERCOMMITMENTS&Id=" +
                                    '<%= PM.CostManagement.MasterCommitmentInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.MasterCommitmentInfo.ProgramId%>' + "&EntityType=2", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=MASTERCOMMITMENTS&Id=" +
                               '<%= PM.CostManagement.MasterCommitmentInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.MasterCommitmentInfo.ProgramId%>' + "&EntityType=2", 890, 430, false);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=MASTERCOMMITMENTS&Id=" +
                        '<%= PM.CostManagement.MasterCommitmentInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.CostManagement.MasterCommitmentInfo.ProgramId%>' + "&EntityType=2", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=MASTERCOMMITMENTS&Id=" + Id, 890, 430, false);
                        }
                        break;

                    case 'New':
                        window.location = "CostManagementMasterCommitments.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function ValidateProgramCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();

                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value >= 0) {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                        if (value.length == 0)
                            args.IsValid = false;
                    }
                }
                else
                    args.IsValid = true;
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
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
        </script>
    </telerik:RadCodeBlock>
    <script src="JS/Costs/MasterCommitment.js" type="text/javascript"></script>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpCommitments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCommitments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCommitments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpContractsCommitments" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center" Skin="Default" />

    <table class="ToolBar SmallToolbar" style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=149">
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
                <telerik:RadComboBox ID="ddlCommitments" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" 
                    Width="100%" AutoPostBack="false" NoWrap="true" CausesValidation="False"
                    Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=149" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" PostBack="false"
                                        CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                    </telerik:RadToolBarButton>



                     <%--   <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                            </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add" Visible="false"
                                    CommandName="CreateRevision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>


                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                            Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
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

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('MASTERCOMMITMENTS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#master_commitments"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" CssClass="documentTabs"
        runat="server" MultiPageID="mlpCommitments" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Commitments" Value="Commitments" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpCommitments" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <div class="PMMainPage">
                <div class="row JustifyContent R3Cols">
                    <div class="col-4 col-4-left ">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlProgram" AllowCustomText="true" runat="server" AutoPostBack="true"
                                        Skin="Default" NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                        ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                        EnableVirtualScrolling="True">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvProjects" meta:Resourcekey="rfvRequired" runat="server" ControlToValidate="ddlProgram"
                                        CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator meta:Resourcekey="csvProjects" ID="csvProjects" runat="server" ControlToValidate="ddlProgram"
                                        ClientValidationFunction="ValidateProgramCombo" ValidationGroup="Save" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="Program required">
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
                                        CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID %>"
                                        ForeColor=""></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblCommIDUnique" meta:Resourcekey="lblCommIDUnique" runat="server" Text="ID must be unique by type and program"
                                        Visible="False" Class="Validator"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
                                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCompanies" runat="server"
                                        Skin="Default"
                                        NoWrap="true" Height="300px" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed"
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="ddlCompanies"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvCompanyName" runat="server" ControlToValidate="ddlCompanies"
                                        ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                    </asp:CustomValidator>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDescription" runat="server" MaxLength="500"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="trCurrency">
                                <td class="labelWidth">
                                    <div style="float: left">
                                        <asp:Label runat="server" CssClass="Link" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                    </div>
                                    <div style="float: right">
                                        <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                                    <span class="Icon"></span>                                                              
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" Height="300px"></telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlTypes" AllowCustomText="true" runat="server" Skin="Default" MarkFirstMatch="true" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true" runat="server" Skin="Default">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                        CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
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
                                    <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:CostManagement, Label_StatusRevision %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table id="tblStatus" runat="server" width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td style="width: 182px; padding-right: 8px;">
                                                <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default">
                                                </telerik:RadComboBox>
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
                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDate" runat="server" Text="<%$ Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_txtRevisionDate" style="display: block">
                                        <telerik:RadDatePicker ID="txtRevisionDate" runat="server" MinDate="1901-01-01"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                            Skin="Default" Culture="English (United States)"
                                            EnableTyping="False" DatePopupButton-Visible="false">
                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                        </telerik:RadDatePicker>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEffectiveDate" runat="server" Text="Effective Date" meta:ResourceKey="lblEffectiveDate"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_txtEffectiveDate" style="display: block">
                                        <telerik:RadDatePicker ID="txtEffectiveDate" runat="server"
                                            Culture="English (United States)" Skin="Default">
                                            <Calendar ID="Calendar1" Skin="Default" runat="server" UseColumnHeadersAsSelectors="False"
                                                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDatePicker>
                                    </span>
                                    <asp:RequiredFieldValidator ID="rfvEffectiveDate" ControlToValidate="txtEffectiveDate"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDays" meta:resourcekey="lblDays" runat="server" Text="Days"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDays" runat="server" CssClass="Double" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDays" ControlToValidate="txtDays"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_txtFrom" style="display: block">
                                        <telerik:RadDatePicker ID="txtFrom" runat="server" MinDate="1901-01-01"
                                            MaxDate="2100-01-01"
                                            Width="100%" Skin="Default">
                                            <DateInput ID="rdiFrom" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        </telerik:RadDatePicker>
                                    </span>
                                    <asp:RequiredFieldValidator ID="rfvFromDate" ControlToValidate="txtFrom"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblTo" runat="server" Text="To" meta:resourcekey="lblTo"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_txtTo" style="display: block">
                                        <telerik:RadDatePicker ID="txtTo" runat="server" MinDate="1901-01-01"
                                            MaxDate="2100-01-01"
                                            Width="100%" Skin="Default">
                                            <DateInput ID="rdiTo" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        </telerik:RadDatePicker>
                                    </span>
                                    <asp:CompareValidator meta:resourcekey="cmpFromToDates" ID="cmpFromToDates" runat="server" ControlToValidate="txtTo" ControlToCompare="txtFrom" Type="Date"
                                        CssClass="Validator" ErrorMessage="Finish Date should be greater than Start Date" Display="Dynamic" ValidationGroup="Save"
                                        ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="rfvToDate" ControlToValidate="txtTo"
                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset runat="server" id="fldsetMasterCommitmentRecap">
                            <legend>
                                <asp:Label ID="lblMasterRecap" meta:resourcekey="lblMasterRecap" runat="server" CssClass="legend" Text="MASTER COMMITMENT RECAP"></asp:Label>
                            </legend>
                            <table class="colTable" runat="server" id="tblRecap">
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth">
                                        <table width="100%" class="TableNoSpacingNoBorder" style="text-align: center; color: #666666; text-transform: uppercase;">
                                            <tr>
                                                <td style="width: 60%;" class="NoWrap">
                                                    <asp:Label ID="lblCosts" meta:resourcekey="lblCosts" runat="server" Text="Costs"></asp:Label>
                                                </td>
                                                <td style="width: 40%;" class="NoWrap">
                                                    <asp:Label ID="lblDaysHeader" meta:resourceKey="lblDays" runat="server" Text="Days"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMasterValue" meta:resourcekey="lblMasterOriginalValue" runat="server"
                                            Text="Master Value"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtMasterValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtMasterValueDays" CssClass="Double" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOriginalValue" meta:resourcekey="lblOriginalValue" runat="server"
                                            Text="Original Commitments"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtOriginalValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtOriginalValueDays" CssClass="Double" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApprovedChanges" meta:resourcekey="lblApprovedChanges"
                                            runat="server" Text="Approved Changes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtApprovedChanges" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtApprovedChangesDays" CssClass="Double" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevisedValue" meta:resourcekey="lblRevisedValue"
                                            runat="server" Text="Revised Value"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtRevisedValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtRevisedValueDays" CssClass="Double" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiced" meta:resourcekey="lblInvoiced" runat="server"
                                            Text="Invoiced"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtInvoiced" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCancelled" meta:resourcekey="lblCancelled" runat="server"
                                            Text="Canceled"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtCancelled" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBalance" meta:resourcekey="lblBalance" runat="server"
                                            Text="Balance"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtBalance" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRetained" meta:resourcekey="lblRetained" runat="server" Text="Retained"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtRetained" runat="server" CssClass="Currency"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPendingChanges" meta:resourcekey="lblPendingChanges" runat="server" Text="Pending Changes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtPendingChanges" runat="server" CssClass="Currency"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtPendingChangesDays" runat="server" CssClass="Double"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProjectedValue" meta:resourcekey="lblProjectedValue"
                                            runat="server" Text="Projected Value"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtProjectedValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtProjectedValueDays" CssClass="Double" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMasterBalance" meta:resourcekey="lblMasterBalance" runat="server" Text="Master Balance"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 60%;">
                                                    <asp:TextBox ID="txtMasterBalance" runat="server" CssClass="Currency"></asp:TextBox>
                                                </td>
                                                <td style="width: 40%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtMasterBalanceDays" runat="server" CssClass="Double"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTaxable" Visible="false" meta:resourcekey="lblTaxable" runat="server" Text="Taxable"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkTaxable" Visible="false" runat="server" Text="" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblEnforceValue" Visible="false" meta:resourcekey="lblEnforceValue" runat="server" Text="Enforce Value"> </asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkEnforceValue" Visible="false" runat="server" Text="" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCopyLines" Visible="false" meta:resourcekey="lblCopyLines" runat="server" Text="Copy Lines"> </asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkCopyLines" Visible="false" runat="server" Text="" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <uc12:assetrotator id="PMrot" runat="server" />
                        <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit">
            <uc1:Commitments ID="Commitments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc3:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc7:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
