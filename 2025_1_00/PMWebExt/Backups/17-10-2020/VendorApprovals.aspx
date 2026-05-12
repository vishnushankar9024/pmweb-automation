<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="VendorApprovals.aspx.vb" Inherits="Website.VendorApprovals" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="VendorApprovalsDetails.ascx" TagName="VendorApprovalsDetails" TagPrefix="uc1" %>
<%@ Register Src="~/VendorApprovalsAddresses.ascx" TagName="VendorApprovalsAddresses" TagPrefix="uc2" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc3" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc4" %>
<%@ Register Src="~/VendorApprovalsContacts.ascx" TagName="VendorApprovalsContacts" TagPrefix="uc5" %>
<%@ Register Src="~/VendorApprovalsDepartments.ascx" TagName="VendorApprovalsDepartments" TagPrefix="uc6" %>
<%@ Register Src="~/VendorApprovalsInsurances.ascx" TagName="VendorApprovalsInsurances" TagPrefix="uc7" %>
<%@ Register Src="~/VendorApprovalApplications.ascx" TagName="VendorApprovalApplications" TagPrefix="uc8" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc13" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc9" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc10" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc12" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc14" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc15" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc16" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Scoring.js" type="text/javascript"></script>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>  
             <telerik:AjaxSetting AjaxControlID="mlpVendorApprovals">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpVendorApprovals" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpVendorApprovals" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style type="text/css">
        .RadWindow .rwWindowContent .radconfirm {
            background-image: url('Images/Global/NoticeIcon.png');
        }
        #dvClear {
            display: none;
        }
    </style>
    <telerik:RadCodeBlock ID="radCode1" runat="server">
        <script type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function ConfirmDeleteLinkedVendorApproval() { radconfirm(unescape(Msg_ConfirmDeleteLinkedVendorApproval), deleteCallbackFunction, 400, 150, null, "PMWeb"); }
            function ConfirmDelete() { return confirm(Msg_ConfirmDeleteDocument); }
            function deleteCallbackFunction(args) {
                if (args) {
                    var btndeleRecord = $("[id$=btndeleRecord]");
                    btndeleRecord.click();
                }
                else {
                    return false;
                }
            }


            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }



            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.VendorApprovalsInfo.HasReports%>';
                var HasMergeTemplate = '<%= PM.VendorApprovalsInfo.HasMergeTemplate%>';
                var ApprovalId = '<%=JSEscape(PM.VendorApprovalsInfo.ApprovalId)%>';
                var Description = '<%=JSEscape(PM.VendorApprovalsInfo.CompanyName)%>';
                var Id = '<%=PM.VendorApprovalsInfo.Id%>';

                switch (Value) {

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=VENDORAPPROVALS&Id=" +
                                 Id + "&Description="
                                 + Description
                                 + "&RecordDescription=" + ApprovalId
                                 + "&EntityId=" + 0 + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=VENDORAPPROVALS&Id=" + Id
                                 + "&RecordDescription=" + Description
                                 + "&EntityId=" + 0 + "&EntityType=0",890,430,false);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=VENDORAPPROVALS&Id=" +
                      Id + "&Description="
                                 + Description
                                 + "&RecordDescription=" + ApprovalId
                                 + "&EntityId=" + 0 + "&EntityType=0", "Notification",900,500,false);
                        break;

                    case "CreateCompany":
                        OpenPOPUp('VendorApprovalsCreateCompanyPopup.aspx', 540, 320, false);
                        break;

                    case 'New':
                        window.location = "VendorApprovals.aspx";
                        break;

                }
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function click_confirm(sender, args) {
                var ApplicationId = '<%=JSEscape(PM.VendorApprovalsInfo.ApplicationId)%>';
                var result;
                if (args.get_item().get_commandName() == "Delete") {
                    if (ApplicationId > 0) {
                        args.set_cancel(true);
                        ConfirmDeleteLinkedVendorApproval();
                        return;
                    }
                    else {
                        result = ConfirmDelete();
                    }


                    args.set_cancel(!result);
                }

                if (args.get_item().get_commandName() == "Print") {
                    window.location = "ReportManager.aspx?ModuleId=8";
                    args.set_cancel(true);
                }

            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=Vendor');
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


            

        </script>
    </telerik:RadCodeBlock>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd ">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=189">
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
            <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlVendorApprovals" runat="server" OnClientTextChange="LOD_DropDownTextChange" meta:Resourcekey="ddlVendorPrequalifications"
                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="false" NoWrap="true"
                    Height="250px" CausesValidation="False" AllowCustomText="true" EmptyMessage="Select Vendor Approval..."
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                    EnableVirtualScrolling="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler" OnClientButtonClicking="click_confirm">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png" Value="Search" NavigateUrl="SearchDocument.aspx?O=189" CausesValidation="false"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                       <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" Visible="true" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbox/Check.png" CommandName="CreateCompany" Value="CreateCompany" PostBack="false" CausesValidation="false" ValidationGroup="CreateCompany" ToolTip="Create Company" CssClass="CheckedIn ToolbarCreateCompany "></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked " OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('VENDORAPPROVALS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="False" Text="" style="display:none !important;" Value="Rating" OuterCssClass="HideOnMobileToolbar" CssClass="Hide">
                            <ItemTemplate>
                                <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                    <table style="padding-right: 20px; width: 100px; height: 100%">
                                        <tr>
                                            <td align="center" style="padding-left: 5px">
                                                <div>
                                                    <span style="padding-bottom: 0px">
                                                    <telerik:RadRating Style="padding-top: 0px" ID="rdrating1" runat="server" ItemCount="5" Value="3" SelectionMode="Continuous" Height="10px" Skin="Default" Precision="half" Orientation="Horizontal" OnClientRated="OnClientRated" />
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
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting"
        runat="server" MultiPageID="mlpVendorApprovals" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Width="100%" EnableViewState="true" CausesValidation="false">
        <%--OnTabClick="tbsDocument_TabClick"--%>
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" TabIndex="1" Visible="false"></telerik:RadTab>
            <telerik:RadTab Text="Addresses" Value="Addresses" TabIndex="1"></telerik:RadTab>
            <telerik:RadTab Text="Departments" Value="Departments" TabIndex="2"></telerik:RadTab>
            <telerik:RadTab Text="Contacts" Value="Contacts" TabIndex="3"></telerik:RadTab>
            <telerik:RadTab Text="Insurance" Value="Insurance" TabIndex="4"></telerik:RadTab>
            <telerik:RadTab Text="Applications" Value="Applications" TabIndex="5"></telerik:RadTab>
            <telerik:RadTab Text="Scoring" Value="Scoring" TabIndex="6"></telerik:RadTab>
            <telerik:RadTab Text="Ratings" Value="Rating" TabIndex="7"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" TabIndex="8"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments" TabIndex="8"></telerik:RadTab>
            <telerik:RadTab Text="Notification" Value="NotificationLog" TabIndex="9"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow" TabIndex="10"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpVendorApprovals" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApprovalId" runat="server" meta:Resourcekey="lblPrequalificationId" Text="Approval ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtApprovalId" Text="" MaxLength="10"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvApprovalId" runat="server" ValidationGroup="Save" ControlToValidate="txtApprovalId"
                                            CssClass="Validator" Display="Dynamic"  meta:Resourcekey="rfv_ApprovalId"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompanyId" runat="server" meta:Resourcekey="lblCompanyId" Text="Company ID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCompanyId"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCompanyId" runat="server" meta:Resourcekey="rfvCompanyId" ValidationGroup="CreateCompany" ControlToValidate="txtCompanyId"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Company ID Already Exists" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCompanyIdValidator" meta:Resourcekey="lblCompanyIdValidator" runat="server" Text="Company ID Already Exists" Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApplicationYear" runat="server" meta:Resourcekey="lblApplicationYear" Text="Application Year"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadNumericTextBox ID="rntApplicationYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                            Label="" runat="server" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>" MaxValue="2100" MinValue="1899">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="rfvApplicationYear" ControlToValidate="rntApplicationYear" runat="server" CssClass="Validator" Visible="false" Display="Dynamic" ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblCompanyName" meta:resourcekey="lblCompanyName" Text="Company Name" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCompanyName" ControlToValidate="txtCompanyName"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblType" meta:resourcekey="lblType" Text="Type" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Skin="Default" Style="font-size: 11px" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblAbbreviation" meta:resourcekey="lblAbbreviation" Text="Abbreviation" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="50" ID="txtAbbreviation" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvAbbreviation" ControlToValidate="txtAbbreviation"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubmitted" meta:resourcekey="lblSubmitted" runat="server" Text="Submitted"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpSubmitted" style="display: block">
                                            <telerik:RadDatePicker ID="dtpSubmitted" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)" EnableTyping="True">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvSubmittedDate" ControlToValidate="dtpSubmitted" runat="server" CssClass="Validator"
                                            Visible="false" Display="Dynamic" ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAccountNumber" runat="server" meta:resourcekey="lblAccountNumber" Text="Account #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAccountNumber" Enabled="false" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvAccountNumber" ControlToValidate="txtAccountNumber"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFederalTaxId" runat="server" meta:resourcekey="lblFederalTaxId" Text="Federal Tax ID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFederalTaxId" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvFederalTaxId" ControlToValidate="txtFederalTaxId"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStateTaxId" runat="server" meta:resourcekey="lblStateTaxId" Text="State Tax ID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtStateTaxId" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvStateTaxId" ControlToValidate="txtStateTaxId"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountry" Text="Country"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountry" runat="server" Skin="Default" Style="font-size: 11px" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true" ></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountry"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCountry" runat="server" ControlToValidate="ddlCountry"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblState" runat="server" meta:resourcekey="lblState" Text="Home State"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlState" runat="server" Skin="Default" Style="font-size: 11px"  AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvState" runat="server" ControlToValidate="ddlState"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillingTerms" runat="server" meta:resourcekey="lblBillingTerms" Text="Billing Terms"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true" Style="font-size: 11px"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPMWebAccountID" runat="server" meta:resourcekey="lblPMWebAccountID" Text="PMWeb Account ID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPMWebAccountID" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" meta:resourcekey="ddlPMWebAccountID"
                                            runat="server" AutoPostBack="false" Skin="Default" NoWrap="true" EmptyMessage="Select Account ID"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPMWebCompany" meta:Resourcekey="hliPMWebCompany" Text="PMWeb Company"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" 
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False" OnItemsRequested="ddl_ItemsRequested"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApprovalStarts" runat="server" meta:resourcekey="lblPrequalificationStarts" Text="Approval Starts"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpApprovalStarts" style="display: block">
                                            <telerik:RadDatePicker ID="dtpApprovalStarts" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)" EnableTyping="True">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvApprovalStarts" ControlToValidate="dtpApprovalStarts" runat="server" CssClass="Validator"
                                            Visible="false" Display="Dynamic" ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApprovalEnds" runat="server" meta:resourcekey="lblPrequalificationEnds" Text="Approval Ends"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpApprovalExpires" style="display: block">
                                            <telerik:RadDatePicker ID="dtpApprovalExpires" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)" EnableTyping="True">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvApprovalExpires" ControlToValidate="dtpApprovalExpires" runat="server" CssClass="Validator"
                                            Visible="false" Display="Dynamic" ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td  style="width:50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" ></asp:TextBox>
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
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc1:VendorApprovalsDetails ID="VendorApprovalsDetails1" runat="server" />
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc16:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDetails" runat="server">
            <uc1:VendorApprovalsDetails ID="VendorApprovalsDetails" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAddresses" runat="server">
            <uc2:VendorApprovalsAddresses ID="VendorApprovalsAddresses1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDepartments" runat="server">
            <uc6:VendorApprovalsDepartments ID="VendorApprovalsDepartments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvContacts" runat="server">
            <uc5:VendorApprovalsContacts ID="VendorApprovalsContacts1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvInsurance" runat="server">
            <uc7:VendorApprovalsInsurances ID="VendorApprovalsInsurances1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvApplication" runat="server">
            <uc8:VendorApprovalApplications ID="VendorApprovalApplications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc4:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvRating" runat="server">
            <uc3:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc9:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc10:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotification" runat="server">
            <uc12:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc13:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc14:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc15:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:Button ID="btndeleRecord" runat="server" CssClass="Hide" />
                       
</asp:Content>

