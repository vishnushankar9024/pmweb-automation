<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master" CodeBehind="Spaces.aspx.vb" Inherits="Website.Spaces" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="SpaceDetails.ascx" TagName="SpaceDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="AssetTypeEquipments.ascx" TagName="AssetTypeEquipments" TagPrefix="uc8" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc9" %>
<%@ Register Src="SpaceOccupant.ascx" TagName="SpaceOccupant" TagPrefix="uc2" %>
<%@ Register Src="SpaceLeases.ascx" TagName="SpaceLeases" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="AssetComponents.ascx" TagName="AssetComponents" TagPrefix="uc7" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc8" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc13" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ACPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Asset/Components.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function OpenComponentItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580, true);
            }

            function OpenGoogleSpaceAddressesPicker() {
                var Id = '<%= PM.Asset.SpaceInfo.Id%>';
                if (Id > 0) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=SPACE&ObjectId=" + Id + "&PickerSender=RecordAddress&ShowLinearTab=1");
                }
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var Id = '<%= PM.Asset.SpaceInfo.Id%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.SpaceInfo.Name)%>';
                var HasReports = '<%= PM.Asset.SpaceInfo.HasReports%>';
                var Description = '<%=JSEscape(PM.Asset.SpaceInfo.Name)%>';
                switch (Value) {

                    case 'ViewReports':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=SPACE&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Asset.SpaceInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':
                        window.location ="ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=SPACE&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Asset.SpaceInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    default:
                        break;
                }
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                if (args.get_item().get_value() != null && args.get_item().get_value().indexOf("Generate_") == 0) {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value(), args)
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    return;
                }
                args.set_cancel(true);
            }

            function AssetEquipmentRowClick(sender, eventArgs) {
                window.location = "Equipments.aspx?Id=" + eventArgs.getDataKeyValue("Id");

            }

            function AssetWorkOrderRowClick(sender, eventArgs) {
                window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            var currentTextBox = null;
            var currentDatePicker = null;
            function showPopup(sender, e) {
                currentTextBox = sender;
                var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
                currentDatePicker = datePicker;
                datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
                var position = datePicker.getElementPosition(sender);
                datePicker.showPopup(position.x, position.y + sender.offsetHeight);
            }

            function dateSelected(sender, args) {
                if (currentTextBox != null) {

                    currentTextBox.value = args.get_newValue();
                }
            }

            function OpenSpaceMove(URL, Width, Height, AddClose) {
                var updatePanel = $find($("[id$=occupantPanel]")[0].id);
                if (updatePanel) { __doPostBack("ctl00_ctl00_CPH1_ACPH1_SpaceOccupant_occupantPanel") }
                var wnd = window.radopen(URL);
                wnd.setSize(Width, Height);
                if (AddClose == true) {
                    wnd.add_close(WindowClosed);
                }
                wnd.Center();
                return false;
            }

            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();
                if (combobox.get_id().indexOf('ddlType') > 0) {
                    var ddlLOccupant = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLOccupant');
                    ddlLOccupant.clearItems();
                    ddlLOccupant.set_text("");
                    ddlLOccupant.set_value("");
                    var txtnbrOfOccupants = $("[id$=" + combobox.get_id().substring(0, combobox.get_id().lastIndexOf('_ddlType')) + '_txtnbrOfOccupants' + "]")[0];
                    if (item.get_value() == "Contact") {
                        txtnbrOfOccupants.value = 1;
                        txtnbrOfOccupants.disabled = true;
                    }
                    else
                        txtnbrOfOccupants.disabled = false;
                }
            }

            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlType');
                SelectedValue = ddlResources.get_value();
                var context = eventArgs.get_context();
                context[combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlType'] = SelectedValue;


            }
            var currFloorId = '<%= PM.Asset.SpaceInfo.FloorId %>';
            function OpenRedliningMeasuresLogPopup2(sender) {
                OpenRedliningMeasuresLogPopup(sender.id, sender.id.replace('txtArea', 'ddlUOM'), 'TELERIK', currFloorId);
            }

            function VisualCalculator(Gross, Rentable, Usable) {
                $("input[id$=txtActualRentable]").val(FPrec(Rentable));
                $("input[id$=txtActualGrossArea]").val(FPrec(Gross));
                $("input[id$=txtActualUsable]").val(FPrec(Usable));

            }
        </script>


    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpSpaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSpaces" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSpaces" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>

                <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr valign="top">
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>


                                    <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CausesValidation="False" CommandName="New"
                                        EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Print" CssClass="Print" EnableImageSprite="true">
                                                                <Items>
                                                                       <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                       <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Generate" Value="Generate" CssClass="Generate" EnableImageSprite="true">
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('SPACE');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Generate.png" CommandName="Generate" SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#Spaces"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
                    runat="server" MultiPageID="mlpSpaces"
                    OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
                    <Tabs>
                        <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
                        <telerik:RadTab Text="Details" Value="Details" Visible="false" />
                        <telerik:RadTab Text="Specifications" Value="Spec" />
                        <telerik:RadTab Text="Components" Value="Components" />
                        <telerik:RadTab Text="Occupants" Value="Occupants" />
                        <telerik:RadTab Text="Leases" Value="Leases" />
                        <telerik:RadTab Text="Work Orders" Value="WorkOrders" />
                        <telerik:RadTab Text="Equipment" Value="Equipment" />
                        <telerik:RadTab Text="Notes" Value="Notes" />
                        <telerik:RadTab Text="Attachments" Value="Attachments" />
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
    </table>
    <telerik:RadMultiPage ID="mlpSpaces" runat="server" SelectedIndex="0" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" HorizontalAlign="NotSet" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" CloseDropDownOnBlur="true" AllowCustomText="true" NoWrap="true"
                                            Height="300px" CausesValidation="False" AutoPostBack="true" EmptyMessage="<%$Resources:Asset, ddlLocation_EmptyMsg %>" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="reqfvProperties"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="reqfvProperties">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuilding" Text="Building" runat="server" meta:resourcekey="lblBuilding" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBuildings" runat="server" Filter="Contains" MarkFirstMatch="true" CloseDropDownOnBlur="true"
                                            Height="340px" AutoPostBack="true" NoWrap="true" CausesValidation="False" EnableItemCaching="false" EmptyMessage="Select"
                                            AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvBuildingId" runat="server" ControlToValidate="ddlBuildings"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="reqfvBuildings" Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvBuildingId" runat="server" ControlToValidate="ddlBuildings"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="reqfvBuildings">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFloor" Text="Floor*" runat="server" meta:resourcekey="lblFloor" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFloors" runat="server"
                                            CloseDropDownOnBlur="true" Filter="Contains" MarkFirstMatch="true"
                                            Height="340px" NoWrap="true" CausesValidation="False" AutoPostBack="true"
                                            EnableItemCaching="false" EmptyMessage="Select" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvFloorId" runat="server" ControlToValidate="ddlFloors"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="reqfvFloors"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvFloorId" runat="server" ControlToValidate="ddlFloors"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="reqfvFloors">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSpaceID" Text="Space ID*" runat="server" meta:resourcekey="lblSpaceID" /></td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server"
                                            ControlToValidate="txtCode" CssClass="Validator" ValidationGroup="Save"
                                            ErrorMessage="&lt;br&gt;Enter the code" meta:resourcekey="reqfvCode" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblSpaceCodeUnique" meta:resourcekey="lblSpaceCodeUnique" Text="<br> Space ID should be unique by location,building & floor." CssClass="Validator" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" Text="Name*" runat="server" meta:resourcekey="lblName" /></td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtName" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                            ControlToValidate="txtName" CssClass="Validator" ValidationGroup="Save"
                                            ErrorMessage="&lt;br&gt;Enter the name" meta:resourcekey="reqfvName" Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSpaceType" runat="server" meta:resourcekey="lblSpaceType" Text="Space Type"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSpaceType" runat="server" Filter="Contains" AllowCustomText="True"
                                            MarkFirstMatch="true" CloseDropDownOnBlur="true" Height="500px"
                                            AutoPostBack="false" NoWrap="true"
                                            CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubType" runat="server" Text="Sub-Type" meta:resourcekey="lblSubType"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSubType" Height="400px" Filter="Contains" AllowCustomText="true" runat="server" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOperatingProject" runat="server" Text="Operating Project" meta:resourcekey="lblOperatingProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOperatingProject" runat="server" ReadOnly="true" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliComponentof" meta:Resourcekey="hliComponentof" Text="hliComponentof11"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtComponentof" runat="server" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlComponentType" runat="server" AllowCustomText="true"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServiceInterval" runat="server" meta:resourcekey="lblServiceInterval" Text="Service Interval"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtServiceInterval" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInServiceDate" runat="server" Text="In Service Date" meta:resourcekey="lblInServiceDate" />
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpServiceDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpServiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategory"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" AllowCustomText="true" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCondition" runat="server" meta:resourcekey="lblCondition"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlConditions" runat="server" Filter="Contains" AllowCustomText="True"
                                            MarkFirstMatch="true" CloseDropDownOnBlur="true" Height="200px"
                                            AutoPostBack="false" NoWrap="true" Width="100%"
                                            CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblConditionDate" runat="server" meta:resourcekey="lblConditionDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                         <span runat="server" id="rmd_dtpConditionDate" style="display: block">
                                        <telerik:RadDatePicker ID="dtpConditionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                            Width="100%" Culture="English (United States)"
                                            EnableTyping="true">
                                            <DateInput ID="DateInput1" runat="server"></DateInput>
                                        </telerik:RadDatePicker>
                                             </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtPMbarcode">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </div>
                                    </td>
                                </tr>

                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server">
                                <legend>
                                    <asp:Label runat="server" meta:resourcekey="lblWeather" ID="lblWeather" Text="SPACE PLANNING" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable" width="100%">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCapacity" runat="server" Text="Capacity" meta:resourcekey="lblCapacity"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table style="width: 100%; color: #666666;" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 80px">
                                                        <asp:TextBox ID="txtCapacity" runat="server" Width="100%" CssClass="PositiveInteger" MaxLength="9"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 80px; padding-left: 30px">
                                                        <asp:Label ID="lblOccupied" Text="Occupied" runat="server" meta:resourcekey="lblOccupied" Width="100%"></asp:Label>
                                                    </td>
                                                    <td style="width: 50px" align="right">
                                                        <img runat="server" id="imgOccupied" src="" alt="" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOccupancy" runat="server" Text="Occupancy" meta:resourcekey="lblOccupancy"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table style="width: 100%; color: #666666;" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 80px">
                                                        <asp:TextBox ID="txtOccupancy" ReadOnly="true" runat="server" Width="100%" CssClass="PositiveInteger" MaxLength="9"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 80px; padding-left: 30px">
                                                        <asp:Label ID="lblLeased" Text="Leased" runat="server" meta:resourcekey="lblLeased"></asp:Label>
                                                    </td>
                                                    <td style="width: 50px" align="right">
                                                        <img runat="server" id="imgLeased" src="" alt="" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAvailable" Text="Available" runat="server" meta:resourcekey="lblAvailable"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table style="width: 100%; color: #666666;" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 80px">
                                                        <asp:TextBox ID="txtAvailable" ReadOnly="true" runat="server" Width="100%" CssClass="Integer" MaxLength="9"></asp:TextBox></td>
                                                    <td style="width: 80px; padding-left: 30px">
                                                        <asp:Label ID="lblVacant" Text="Vacant" runat="server" meta:resourcekey="lblVacant"></asp:Label></td>
                                                    <td style="width: 50px" align="right">
                                                        <img runat="server" id="ImgVacant" src="" alt="" /></td>
                                                </tr>
                                            </table>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblArea" runat="server" Text="Area" meta:resourcekey="lblArea"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtArea" runat="server" CssClass="PositiveDouble" MaxLength="15" Ondblclick="OpenRedliningMeasuresLogPopup2(this)"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset runat="server" id="fldsetAddress">
                                <legend>
                                    <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" runat="server" Text="Address" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address 2"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity" Text="City"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblState" meta:resourcekey="lblState" Text="State /Zip"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="49%" style="padding-right: 5px;">
                                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="100%"
                                                            Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td width="49%" style="padding-left: 5px;">
                                                        <asp:TextBox ID="txtZip" runat="server" Width="99%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>

                                        </td>



                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblCountry" meta:resourcekey="lblCountry" Text="Country"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCountries" runat="server" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                Style="font-size: 11px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblPhone" meta:resourcekey="lblPhone" Text="Phone"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblFax" meta:resourcekey="lblFax" Text="Fax"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="OpenGoogleSpaceAddressesPicker();">
                                                                                                <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset runat="server">
                                <legend>
                                    <asp:Label ID="lblLeasing" runat="server" Text="Leasing" meta:resourcekey="lblLeasing" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                                align="left" class="SearchButton">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth" style="text-align: center; text-transform: uppercase; color: #666666;">
                                            <asp:Label ID="lblActual" runat="server" Text="Actual" meta:resourcekey="lblActual"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblGrossArea" runat="server" Text="Gross Area" meta:resourcekey="lblGrossArea"></asp:Label></td>
                                        <td class="controlwidth">
                                            <asp:TextBox ID="txtActualGrossArea" CssClass="Double" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentable" runat="server" Text="Rentable" meta:resourcekey="lblRentable"></asp:Label></td>
                                        <td class="controlwidth">
                                            <asp:TextBox ID="txtActualRentable" CssClass="Double" runat="server"></asp:TextBox> </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUsable" runat="server" Text="Usable" meta:resourcekey="lblUsable"></asp:Label>

                                        </td>
                                        <td class="controlwidth">
                                            <asp:TextBox ID="txtActualUsable" CssClass="Double" runat="server"></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUOM" Text="UOM" Width="100%" runat="server" meta:resourcekey="lblUOM"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlUOM" Filter="Contains" Height="400px" AllowCustomText="true" runat="server">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <fieldset runat="server">
                                <legend>
                                    <asp:Label ID="lblLinearDefinition" runat="server" Text="Linear Definition" meta:resourcekey="lblLinearDefinition" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="lbtLinearAssets" runat="server" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td style="text-align: center; color: #666666; text-transform: uppercase" class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="45%"></td>
                                                    <td style="padding-left: 10px; width: 45%; padding-right: 4px;">

                                                        <asp:Label ID="lblDirection" runat="server" Text="Direction" meta:resourcekey="lblDirection"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBegin" runat="server" Text="Begin" meta:resourcekey="lblBegin"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="45%">
                                                        <asp:TextBox ID="txtBegin" runat="server" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 10px; width: 45%;">
                                                        <telerik:RadComboBox ID="ddlBeginDirection" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Style="font-size: 11px" CssClass="linearAssetButton">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEnd" runat="server" Text="End" meta:resourcekey="lblEnd"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="45%">
                                                        <asp:TextBox ID="txtEnd" runat="server" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 10px; width: 45%;">
                                                        <telerik:RadComboBox ID="ddlEndDirection" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Style="font-size: 11px">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblApproxLength" runat="server" Text="Approx. Length" meta:resourcekey="lblApproxLength"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="45%">
                                                        <asp:TextBox ID="txtLength" CssClass="Double" runat="server" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 10px; width: 45%;">
                                                        <telerik:RadComboBox ID="ddlLengthUOM" Filter="Contains" AllowCustomText="true" runat="server" Width="100%"
                                                            Style="font-size: 11px" OnClientSelectedIndexChanging="LinearLengthUOMChanging">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLinearArea" runat="server" Text="Area" meta:resourcekey="lblLinearArea"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="45%">
                                                        <asp:TextBox ID="txtLinearArea" CssClass="PositiveDouble" runat="server" Width="100%"></asp:TextBox></td>
                                                    <td style="padding-left: 10px; width: 45%;">
                                                        <telerik:RadComboBox ID="ddlLinearAreaUOM" Filter="Contains" AllowCustomText="true" runat="server" Width="100%"
                                                            Style="font-size: 11px" OnClientSelectedIndexChanging="LinearAreaUOMChanging">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <uc8:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server">
            <uc1:SpaceDetails ID="SpaceDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc13:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpaceComponents" runat="server">
            <uc7:AssetComponents ID="AssetComponents1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvOccupants" runat="server">
            <uc2:SpaceOccupant ID="SpaceOccupant" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvLeases" runat="server">
            <uc10:SpaceLeases ID="SpaceLeases1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkOrders" runat="server">
            <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
        </telerik:RadPageView>
        <%--       <telerik:RadPageView ID="pvDocumentInspections" runat="server">
            <uc12:DocumentInspection ID="DocumentInspection1" runat="server" />
        </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvEquipment" runat="server">
            <uc8:AssetTypeEquipments ID="AssetTypeEquipments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <asp:HiddenField runat="server" ID="hdnCurrentUsage" Value="0"></asp:HiddenField>
    <telerik:RadAjaxLoadingPanel ID="ldpSpaces" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" />
    <asp:Button runat="server" ID="btnSwitchComponents" CssClass="Hide" />
</asp:Content>
