<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="CompaniesList.aspx.vb" Inherits="Website.CompaniesList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CompanyDetails.ascx" TagName="CompanyDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="CompanyAdresses.ascx" TagName="CompanyAdresses" TagPrefix="uc4" %>
<%@ Register Src="CompanyAddressesContacts.ascx" TagName="CompanyAddressesContacts" TagPrefix="uc5" %>
<%@ Register Src="CompanyDepartments.ascx" TagName="CompanyDepartments" TagPrefix="uc6" %>
<%@ Register Src="CompanyInsurances.ascx" TagName="Insurance" TagPrefix="uc7" %>
<%@ Register Src="CompanyResources.ascx" TagName="CompanyResources" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="CompanyRotator" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc11" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;


            function OpenGoogleCompanyAddressesPicker() {
                var Id = '<%= PM.CompanyInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                   OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=COMPANY&ObjectId=" + Id + "&PickerSender=RecordAddress",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=600,top=' + top + ',left=' + left);
                }
                return false;
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
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
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasPMWebReports = '<%=PM.QueryBuilderPermissionController.HasReports("COMPANY")%>';
                var Id = '<%=PM.CompanyInfo.Id%>';
                var HasReports = '<%= PM.CompanyInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CompanyInfo.CompanyCode & " - " & PM.CompanyInfo.CompanyName)%>';
                switch (Value) {
                    case 'ImportRecords':
                        OpenPOPUp('Companies_Import.aspx?SourceId=Companies_Import', 710, 590);
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=COMPANY&Id=" + Id,
                            'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);

                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COMPANY&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "CompaniesList.aspx";
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
            ///////////////////////contacts
            function ddlDepartment_OnClientSelectedIndexChanged(sender, eventArgs) {
                var ddlAdresses = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlAddress');
                var ddlDepartments = sender;
                var Item = ddlDepartments.get_selectedItem()
                if (Item != null) {
                    var addId = Item._attributes.getAttribute("AddressId");
                    var b = addId;
                    if (addId == "-1")
                        addId = "0"
                    var addresses = ddlAdresses.get_items()._array;
                    var isFound = false;

                    ddlAdresses.clearSelection();
                    ddlAdresses.trackChanges();
                    ddlAdresses.set_value(addId);
                    var selItem = ddlAdresses.findItemByValue(addId);
                    if (selItem != null) {
                        selItem.select();
                        isFound = true;
                        ddlAdresses.set_text(selItem.get_text());
                    }
                    ddlAdresses.commitChanges();
                    if (isFound && b != "-1")
                        ddlAdresses.set_enabled(false);
                    else
                        ddlAdresses.set_enabled(true);

                }
            }
            //////////////////////



            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var ddlProperties = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProperties');
                SelectedValue = ddlProperties.get_value();
                var context = eventArgs.get_context();
                context[combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProperties'] = SelectedValue;
            }

            function ResetCombos(combobox, eventArgs) {
                var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                ddlProjects.clearItems();
                ddlProjects.set_text("");
                ddlProjects.set_value("0");
            }
            function GoToResourceList(sender, eventArgs) {
                window.location = 'LaborResources.aspx?Id=' + eventArgs.getDataKeyValue("Id") + '&ModuleId=7&PageId=307';
            }


            ////////////////////////////// Fill Location From Project ///////////////////////////////////
            function ddlProjects_OnClientSelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                var itemId = item.get_parent()._clientStateFieldID;
                var ddlProperties = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlProperties');
                ddlProperties.clearItems();
                var PropertyId = item.get_attributes().getAttribute("PropertyId");
                if (PropertyId == 0)
                    ddlProperties.clearItems();
                else {
                    ddlProperties.set_text(item.get_attributes().getAttribute("PropertyCode") + ' - ' + item.get_attributes().getAttribute("PropertyName"));
                    ddlProperties.set_value(item.get_attributes().getAttribute("PropertyId"));
                }
            }

        </script>  
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
               <telerik:AjaxSetting AjaxControlID="mlpCompany">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCompany" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCompany" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=19">
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
                            <telerik:RadComboBox ID="ddlCompanies" runat="server" meta:resourcekey="ddlCompanies"
                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..." OnClientTextChange="LOD_DropDownTextChange"
                                AllowCustomText="true" Width="240px" Height="400px" AutoPostBack="False" NoWrap="true"
                                CausesValidation="False" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>


                                   <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/Revision.png"
                                                CommandName="CreateRevision" Visible="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                                        EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint HideOnMobileToolbar">
                                        <Buttons>
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
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Import" Value="Import">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Records" Value="ImportRecords"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('COMPANY');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    

                                    <telerik:RadToolBarSplitButton SecurityButtonType="Add" CommandName="Import" Enabled="true" ImageUrl="Images/ToolBar/Import.gif" CssClass="ToolbarImport" ToolTip="Import"
                                        PostBack="false" EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar">
                                        <Buttons>
                                            <telerik:RadToolBarButton Text="Records" CommandName="ImportRecords" PostBack="false"></telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CssClass="HideOnMobileToolbar"
                                        CommandName="Activation" Value="Activate" CausesValidation="false" ToolTip="Activate">
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpCompany" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" TabIndex="0" />
            <telerik:RadTab Text="Specifications" Value="Spec" TabIndex="1" />
            <telerik:RadTab Text="Addresses" Value="Addresses" TabIndex="2" />
            <telerik:RadTab Text="Departments" Value="Departments" TabIndex="3" />
            <telerik:RadTab Text="Contacts" Value="Contacts" TabIndex="4" />
            <telerik:RadTab Text="Insurance" Value="Insurance" TabIndex="5" />
            <telerik:RadTab Text="Resources" Value="Resources" TabIndex="6" />
            <telerik:RadTab Text="Notes" Value="Notes" TabIndex="7" />
            <telerik:RadTab Text="Attachments" Value="Attachments" TabIndex="8" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpCompany" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompanyId" runat="server" meta:resourcekey="lblCompanyId" Text="Company ID*11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCompanyID" runat="server" MaxLength="50"></asp:TextBox>
                                        <asp:Label runat="server" CssClass="Validator" ID="lblCodesUnique" Text="<%$Resources:WarningMsg_CompanyCodeIsUnique %>"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvCompanyID" runat="server" ErrorMessage="<br>Enter the Company id"
                                            meta:resourcekey="rfvCompanyIDRequired" ControlToValidate="txtCompanyID" ValidationGroup="Save" Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName" Text="Name*11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtName" runat="server" MaxLength="100"></asp:TextBox>
                                        <asp:Label runat="server" CssClass="Validator" ID="lblNameUnique" Text="<%$Resources:WarningMsg_CompanyNameIsUnique %>"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvNameRequired" runat="server" ErrorMessage="Enter the name"
                                            ControlToValidate="txtName" ValidationGroup="Save" Display="Dynamic" CssClass="Validator" meta:resourcekey="rfvNameRequired">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type11" meta:resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" EmptyMessage="Select Type..." Filter="Contains" MarkFirstMatch="true"
                                            AllowCustomText="true" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAbbreviation" runat="server" meta:resourcekey="lblAbbreviation" Text="Abbreviation11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtShortName" runat="server" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" meta:Resourcekey="lblReference" runat="server" Text="Reference11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" runat="server" MaxLength="255"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:LinkButton runat="server" ID="btnAccountId" meta:resourcekey="btnAccountId" Text="PMWeb Account ID11" Style="color:#666666 !important;"></asp:LinkButton>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAccountId" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAccountNumber" meta:resourcekey="lblAccountNumber" runat="server" Text="Account #11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAccount" runat="server" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFedTaxId" meta:resourcekey="lblFedTaxId" runat="server" Text="Fedral Tax ID11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFedTax" runat="server" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="display:none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStateTaxId" meta:resourcekey="lblStateTaxId" runat="server" Text="State Tax ID11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtStateTax" runat="server" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountry" Text="country11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountries" runat="server" Width="100%" meta:resourcekey="ddlCountry"
                                            Height="200px" Skin="Default" EmptyMessage="Select Country..." MarkFirstMatch="true"
                                            AllowCustomText="true" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillingTerms" meta:resourcekey="lblBillingTerms" runat="server" Text="Billing Terms11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBillingTerms" AllowCustomText="true" Filter="Contains"
                                            Height="200px" Skin="Default" MarkFirstMatch="true" runat="server" Width="100%">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trApprovalExpires" runat="server" >
                                    <td class="labelWidth">
                                        <asp:LinkButton ID="lbtnApprovalExpires" runat="server" meta:resourceKey="lbtnApprovalExpires" Visible="false"
                                            Enabled="false" Text="Approval Expires11" Style="text-decoration: underline;color:#666666;"></asp:LinkButton>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpApprovalExpires" runat="server" Visible="False" MinDate="1901-01-01"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default"
                                            Culture="English (United States)" EnableTyping="True">
                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOccupant" meta:Resourcekey="lblOccupant" runat="server" Text="Occupant11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox runat="server" ID="chkOccupant" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblApprovedBidder" runat="server" Text="Approved Bidder11" meta:Resourcekey="lblApprovedBidder"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkApprovedBidder" runat="server" Checked="true" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblPrimary" runat="server" Text="Primary (From Addresses Tab)11" meta:Resourcekey="lblPrimary"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPrimaryAddress" meta:resourcekey="lblPrimaryAddress" runat="server" Text="Address11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPrimaryAddress" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress" runat="server" BackColor="#EDEDED" TextMode="MultiLine" Height="82px" Rows="3" Style="box-sizing: border-box; width: 100%;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPhone" meta:resourcekey="lblPhone" runat="server" Text="Phone11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadMaskedTextBox ID="txtPhone" runat="server" DisplayMask="###-###-####" BackColor="#EDEDED"
                                                Mask="###-###-####" TextWithLiterals="--" Width="100%">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblExt" meta:resourcekey="lblExt" runat="server" Text="Ext11" Width="99%"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadMaskedTextBox ID="txtExt" Width="100%" runat="server" DisplayMask="#####-####" BackColor="#EDEDED"
                                                Mask="#####-####">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFax" meta:resourcekey="lblFax" runat="server" Text="Fax11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadMaskedTextBox ID="txtFax" runat="server" DisplayMask="###-###-####" Mask="###-###-####" BackColor="#EDEDED"
                                                TabIndex="2" TextWithLiterals="--" Width="100%">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEmail" meta:resourcekey="lblEmail" runat="server" Text="Email11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEmail" runat="server" BackColor="#EDEDED"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblWebsite" meta:resourcekey="lblWebsite" runat="server" Text="Website11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtWebsite" runat="server" BackColor="#EDEDED"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label runat="server" ID="lblTags" meta:resourcekey="lblTags" Text="Tags11"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="btnlatitude" CssClass="Link" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnlatitude" Text="Latitude11"></asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtlatitude" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="btnLongitude" CssClass="Link" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnLongitude" Text="Longitude11"></asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtLongitude" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="btnElevation" CssClass="Link" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnElevation" Text="Elevation11"></asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtElevation" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                 <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Geolocation"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                  <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleCompanyAddressesPicker();">
                                                                                                <span class="Icon"></span>
                                                                    </asp:LinkButton>
                                            </div>
                                         
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc9:CompanyRotator ID="PMrot" runat="server" />
                            <uc10:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc11:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAddresses" runat="server">
            <uc4:CompanyAdresses ID="CompanyAdresses" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDepartments" runat="server">
            <uc6:CompanyDepartments ID="CompanyDepartments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvContacts" runat="server">
            <uc5:CompanyAddressesContacts ID="CompanyAddressesContacts" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvInsurance" runat="server">
            <uc7:Insurance ID="Insurance" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvResources" runat="server">
            <uc8:CompanyResources ID="CompanyResources" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <telerik:RadAjaxLoadingPanel ID="ldpCompany" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center" Skin="Default" />
</asp:Content>
